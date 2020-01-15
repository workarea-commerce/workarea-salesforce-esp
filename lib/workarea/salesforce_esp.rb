require 'workarea'
require 'workarea/storefront'
require 'workarea/admin'

require 'workarea/salesforce_esp/version'
require 'workarea/salesforce_esp/engine'
require 'workarea/salesforce_esp/gateway'
require 'workarea/salesforce_esp/bogus_gateway'
require 'workarea/salesforce_esp/response'
require 'workarea/salesforce_esp/subscriber'

require 'marketingcloudsdk'

module Workarea
  module SalesforceEsp
    def self.gateway
      if credentials.present?
        options = {
          client_id: client_id,
          secret: secret,
          account_id: account_id,
          request_token_url: token_endpoint
        }

        Workarea::SalesforceEsp::Gateway.new(options)
      else
        Workarea::SalesforceEsp::BogusGateway.new
      end
    end

    def self.credentials
      (Rails.application.secrets.salesforce || {}).deep_symbolize_keys
    end

    def self.config
      Workarea.config.salesforce
    end

    def self.account_id
      Workarea.config.salesforce.account_id
    end

    def self.token_endpoint
      Workarea.config.salesforce.token_endpoint
    end

    def self.client_id
      credentials[:client_id]
    end

    def self.secret
      credentials[:secret]
    end
  end
end
