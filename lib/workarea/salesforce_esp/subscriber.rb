module Workarea
  module SalesforceEsp
    class Subscriber
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def subscriber_key
        data[:subscriber_key]
      end
    end
  end
end
