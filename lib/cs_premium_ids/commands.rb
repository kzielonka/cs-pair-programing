require 'dry-struct'
require 'dry-types'

class CSPremiumIDs
  module Types
    include Dry::Types.module
  end
  private_constant :Types

  module Commands
    class Command < Dry::Struct::Value
      Invalid = Class.new(StandardError)

      def self.new(*)
        super
      rescue Dry::Struct::Error => doh
        raise Invalid, doh
      end
    end
    private_constant :Command

    class ChangeActivationCode < Command
      attribute :premium_id, Types::String
      attribute :code, Types::String
    end

    class ActivateCard < Command
      attribute :premium_id, Types::String
      attribute :code, Types::String
      attribute :activator_id, Types::String
    end
  end
end
