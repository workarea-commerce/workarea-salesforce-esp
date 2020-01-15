require 'test_helper'

module Workarea
  class GatewayTest < TestCase
    setup :set_gateway
    setup :set_list_id

    def set_gateway
      @gateway = Workarea::SalesforceEsp.gateway
    end

     def set_list_id
      @list_id = 856
    end

    def test_subscribe
      email = 'uniquetest@weblinc.com'
      Workarea.with_config do |config|
        config.salesforce.default_list = '90'
        config.salesforce.token_endpoint = 'https://mc2j61z17stbfqsy1m5qdm9x8rn4.auth.marketingcloudapis.com'

        response = @gateway.subscribe(email, {}, @list_id)
        assert_instance_of(SalesforceEsp::Response, response)
        assert(response.success?)
      end
    end

    def test_unsubscribe
      email = 'unsubscribetest@weblinc.com'

      subscribe = @gateway.subscribe(email, {}, @list_id)
      assert(subscribe.success?)

      unsubscribe = @gateway.unsubscribe(email, @list_id)
      assert(unsubscribe.success?)
    end
  end
end
