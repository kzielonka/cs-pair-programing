require 'aggregate_root'

class CSPremiumIDs
  class PremiumCard
    include AggregateRoot
    include ValueObjects

    UpdateFrobiddenError = Class.new(RuntimeError)

    CardAlreadyAssignedError = Class.new(RuntimeError)
    InvalidCodeError = Class.new(RuntimeError)

    def initialize(premium_id, time_now_proc = proc { Time.now.utc })
      @time_now_proc = time_now_proc
      @premium_id = PremiumId(premium_id)

      @assigned = false

      @code = Code(:not_set)
    end

    def validate_code(code)
      !@assigned && @code == Code(code)
    end

    def activate_card(code, activator_id)
      code = Code(code)
      activator_id = UserId(activator_id)
      raise CardAlreadyAssignedError if @assigned
      raise InvalidCodeError unless validate_code(code)

      apply(
        Events::CardActivated.new(
          data: {
            premium_id:   @premium_id.to_s,
            activator_id: activator_id.to_s,
            activated_at: @time_now_proc.call,
          }
        )
      )
    end

    def change_activation_code(code)
      code = Code(code)
      raise UpdateFrobiddenError if @assigned
      return if @code == code
      apply(
        Events::CardActivationCodeChanged.new(
          data: {
            premium_id: @premium_id.to_s,
            code:       code.to_s,
            changed_at: @time_now_proc.call,
          }
        )
      )
    end

    on(Events::CardActivated) do |_|
      @assigned = true
    end

    on(Events::CardActivationCodeChanged) do |event|
      @code = Code(event.data[:code])
    end
  end
  private_constant :PremiumCard
end
