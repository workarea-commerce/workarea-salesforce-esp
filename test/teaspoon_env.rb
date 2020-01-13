require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::SalesforceEsp::Engine.root
  Workarea::Teaspoon.apply(config)
end
