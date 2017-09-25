$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "seedog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "seedog"
  s.version     = Seedog::VERSION
  s.authors     = ["Shota Iguchi"]
  s.email       = ["shota-iguchi@cookpad.com"]
  s.summary     = "Hyper master data manager for activerecord."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2"

  s.add_development_dependency "pry"
  s.add_development_dependency "pry-doc"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec-rails"
end
