require "spec_helper"

describe "activating code" do
  let(:cs_premium_ids) { CSPremiumIDs.new(event_store, time_now_proc) }

  let(:time_now) { Time.new(2000, 1, 1, 0, 0, 0, 0).utc }

  let(:event_store) { EventStoreFake.new }

  let(:time_now_proc) { proc { time_now } }

  it "activates code" do
    cs_premium_ids.exec([
      CSPremiumIDs::Commands::ChangeActivationCode.new(
        premium_id: "1000",
        code:       "code",
      ),
      CSPremiumIDs::Commands::ActivateCard.new(
        premium_id:   "1000",
        code:         "code",
        activator_id: "activator-id",
      )
    ])

    expect(event_store).to have_event(
      CSPremiumIDs::Events::CardActivated.new(
        data: {
          premium_id:   "1000",
          activator_id: "activator-id",
          activated_at: time_now,
        }
      )
    )
  end

  it "raises invalid code for card with no activation code" do
    expect do
      cs_premium_ids.exec(
        CSPremiumIDs::Commands::ActivateCard.new(
          premium_id:   "1000",
          code:         "code",
          activator_id: "activator-id",
        )
      )
    end.to raise_exception CSPremiumIDs::Errors::InvalidCode
  end

  it "raises invalid code for already activated card" do
    cs_premium_ids.exec([
      CSPremiumIDs::Commands::ChangeActivationCode.new(
        premium_id: "1000",
        code:       "code",
      ),
      CSPremiumIDs::Commands::ActivateCard.new(
        premium_id:   "1000",
        code:         "code",
        activator_id: "activator-id",
      )
    ])

    expect do
      cs_premium_ids.exec(
        CSPremiumIDs::Commands::ActivateCard.new(
          premium_id:   "1000",
          code:         "code",
          activator_id: "activator-id",
        )
      )
    end.to raise_exception CSPremiumIDs::Errors::InvalidCode
  end
end
