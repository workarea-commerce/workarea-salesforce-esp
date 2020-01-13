module Workarea
  module SalesforceEsp
    class Response
      attr_reader :success, :message, :status_message, :results

      def initialize(response)
        @success = response.success?
        @message = response.message
        @results = response.results
        @status_message = results.first[:status_message] if results.present?
      end

      def subscriber_already_exists?
        message == 'Error' && status_message == 'The subscriber is already on the list'
      end

      def user_not_found?
        message == 'Error' && status_message == 'The subscriber was not found.'
      end

      def excluded_by_list_detective?
        message == 'Error' && results.first[:subscriber_failures][:error_description] == 'Error Code: 24 - Subscriber was excluded by List Detective.'
      end

      def success?
        success
      end

      def failure?
        !success
      end
    end
  end
end
