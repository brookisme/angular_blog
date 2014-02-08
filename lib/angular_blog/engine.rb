module AngularBlog
  class Engine < ::Rails::Engine
    isolate_namespace AngularBlog

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
