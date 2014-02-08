$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "angular_blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "angular_blog"
  s.version     = AngularBlog::VERSION
  s.authors     = ["Brook Williams"]
  s.email       = ["brookwilliams@laborvoices.com"]
  s.homepage    = "http://laborvoices.com"
  s.summary     = "A blogging engine using AngularJS and Rails"
  s.description = "A blogging engine using AngularJS and Rails"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_development_dependency "pg"

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "sass-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "haml-rails"
  s.add_dependency "coffee-rails"
  
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "database_cleaner"
end

