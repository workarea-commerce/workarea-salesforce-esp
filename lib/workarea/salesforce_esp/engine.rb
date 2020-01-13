require 'workarea/salesforce_esp'

module Workarea
  module SalesforceEsp
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::SalesforceEsp
    end
  end
end
