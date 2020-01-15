module Workarea
  module SalesforceEsp
    class Gateway
      class SalesforceEspSubscriptionError < StandardError; end
      class SalesforceEspEmailError < StandardError; end
      class SalesforceEspListError < StandardError; end

      def initialize(options = {})
        @client = MarketingCloudSDK::Client.new(
          'client' => {
            'id' => options[:client_id],
            'secret' => options[:secret],
            'account_id' => options[:account_id],
            'use_oAuth2_authentication' => true,
            'request_token_url' => options[:request_token_url]
          }
        )
      end

      def subscribe(email, attrs, list_id)
        raise SalesforceEspListError, 'No List ID error' unless list_id.present?

        subscriber = build_subscriber(email, "Active", attrs, list_id)
        response = perform_api_call(subscriber, "post")

        if response.failure?
          if response.subscriber_already_exists?
            response = update_subscriber(email, "Active", attrs, list_id)
          end
        end

        response
      end

      def unsubscribe(email, list_id)
        subscriber = build_subscriber(email, "Unsubscribed", {}, list_id)
        response = perform_api_call(subscriber, "patch")

        if response.failure? && !response.user_not_found?
          raise SalesforceEspSubscriptionError, response.status_message
        end

        response
      end

      def update_subscriber(email, status, attrs, list_id)
        subscriber = build_subscriber(email, status, attrs, list_id)
        response = perform_api_call(subscriber, "patch")

        if response.failure? && !response.subscriber_already_exists?
          raise SalesforceEspSubscriptionError, response.status_message
        end

        response
      end

      def write_to_data_extension(data_extension, attrs)
        ex = ET_DataExtension::Row.new
        ex.authStub = @client
        ex.Name = data_extension
        ex.props = attrs

        perform_api_call(ex, 'post')
      end

      def send_triggered_email(email_key, email, attrs = {})
        triggered_send = MarketingCloudSDK::TriggeredSend.new
        triggered_send.authStub = @client
        triggered_send.props = {
          "CustomerKey" => email_key
        }
        triggered_send.subscribers = [
          {
            "EmailAddress" => email,
            "SubscriberKey" => email,
            "Attributes" => build_subscriber_attributes(attrs)
          }
        ]

        response = Response.new(triggered_send.send)

        raise SalesforceEspEmailError, response.status_message unless response.success?

        response
      end

      private

      def build_subscriber(email, status, attrs, list_id)
        subscriber = MarketingCloudSDK::Subscriber.new
        subscriber.authStub = @client
        subscriber.props = {
          "EmailAddress" => email,
          "SubscriberKey" => email,
          "Status" => "Active",
          "Attributes" => build_subscriber_attributes(attrs),
          "Lists" => { "ID" => list_id, "Status" => status }
        }
        subscriber
      end

      def build_subscriber_attributes(attrs)
        attributes = []
        attrs.each do |key, value|
          attributes.push({ "Name" => key, "Value" => value })
        end
        attributes
      end

      def perform_api_call(obj, method)
        results = obj.send(method.to_sym)
        SalesforceEsp::Response.new(results)
      end
    end
  end
end
