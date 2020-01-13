Workarea.configure do |config|
  config.salesforce = ActiveSupport::Configurable::Configuration.new
  config.salesforce.default_list = '' # required, default list to add new email signups to.
  config.salesforce.token_endpoint = nil # required, URL endpoint to get an auth token.
  config.salesforce.account_id = nil # optional, target account ID, optional
end
