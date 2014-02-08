module AngularBlog
  class Engine < ::Rails::Engine
    isolate_namespace AngularBlog

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.to_prepare do
      Dir.glob(AngularBlog::Engine.root + "app/concerns/**/*.rb").each do |c|
        require_dependency(c)
      end
    end

    initializer :survey_base_init do |app|
      AngularBlog.config = YAML.load(File.read(File.expand_path('config/angular_blog.yml',app.root)))
    end
  end
end
