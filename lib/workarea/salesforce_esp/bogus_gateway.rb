module Workarea
  module SalesforceEsp
    class BogusGateway
      @@supported_methods = SalesforceEsp::Gateway.public_instance_methods


      def subscribe(email, attrs, list_id)
        bogus_response
      end

      def unsubscribe(email, list_id)
        bogus_response
      end

      def send_triggered_email(email_key, email, attrs = {})
        bogus_response
      end

      def method_missing(method, *args)
        return true if @@supported_methods.include? method
        super
      end

      private

      def bogus_response
        response = OpenStruct.new()
        response["success?"] = true
        Workarea::SalesforceEsp::Response.new(response)
      end
    end
  end
end
