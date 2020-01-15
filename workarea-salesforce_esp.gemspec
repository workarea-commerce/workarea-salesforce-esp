$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "workarea/salesforce_esp/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "workarea-salesforce_esp"
  spec.version     = Workarea::SalesforceEsp::VERSION
  spec.authors     = ["Jeff Yucis"]
  spec.email       = ["jyucis@workarea.com"]
  spec.homepage    = "https://www.workarea.com/"
  spec.summary     = "Sales force cloud marketing integration"
  spec.description = "Integration with sales force cloud marketing."
  spec.license     = "Business Software License"


  spec.files = `git ls-files`.split("\n")

  spec.add_dependency 'workarea', '~> 3.x'
  spec.add_dependency 'sfmc-fuelsdk-ruby', '1.3.0'
end
