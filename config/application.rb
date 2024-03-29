require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module GtdNew
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(
      #{config.root}/lib
    )

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.locale = config.i18n.default_locale = "zh-CN"
    I18n.default_locale = 'zh-CN'

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.logger = Logger.new(config.paths.log.first, 'weekly')


    #config.cache_store = :redis_store, ‘redis://xx.xx.xx.xx:6379’
    ActiveSupport::XmlMini.backend = 'Nokogiri'
    ActiveSupport::JSON.backend = 'Yajl'


    config.generators do |g|
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end


    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
          :address => "smtp.qq.com",
          :port => 25,
          :authentication => :plain,
          :user_name => '137518792',
          :password => 'hyp123'
    }


    config.middleware.use ExceptionNotifier,
                    :email_prefix => "[Whatever] ",
                    :sender_address => %{"137518792" <137518792@qq.com>},
                    :exception_recipients => %w{122755990@qq.com}

  end
end

