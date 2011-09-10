source 'http://rubygems.org'

gem 'rails', '3.0.9'

#database engine
gem "pg", "~> 0.11.0"

#resque
gem 'resque', '~> 1.18.6'
gem 'resque-scheduler', '~> 1.9.9'
gem 'resque_mailer', '~> 2.0.2'
gem "resque-status", "~> 0.2.3"

#auth
gem 'devise', '~> 1.4.4'
gem 'cancan', "~> 1.6.4"
gem 'easy_roles', '~> 1.2.0' #rails 3.1 use "rolify"

#template engine
gem 'haml-rails', '~> 0.3.4'

#jquery
gem "jquery-rails", "~> 1.0.14"

#config
gem "rails_config", "~> 0.2.4"

#model
gem 'paperclip', '~> 2.3.11'
gem "carrierwave", "~> 0.5.7", :git => "https://github.com/jnicklas/carrierwave.git"
gem 'meta_search', '~> 1.0.6' #rails 3.1 use 'ransack'
gem "meta_where", "~> 1.0.4"  #rails 3.1 use 'squeel'
gem 'symbolize', '~> 3.3.0pre'
gem 'aasm', '~> 2.2.0'
gem 'ancestry', '~> 1.2.4'

#controller
gem 'inherited_resources', '~> 1.2.2'
gem 'has_scope', '~> 0.5.1'
gem "show_for", "~> 0.2.4", :git => "http://github.com/plataformatec/show_for.git"

#template
gem 'simple_form', '~> 1.5.0'
gem 'kaminari', '~> 0.12.4'
gem "rails_kindeditor", "~> 0.1.0", :git => "https://github.com/Macrow/rails_kindeditor.git"
gem 'client_side_validations', '~> 3.0.4'

##tag
#gem 'acts-as-taggable-on', '~> 2.0.6'

#exception
gem "vidibus-routing_error", "~> 0.2.1"
gem "exception_notification", "~> 2.5.2", :git => "https://github.com/smartinez87/exception_notification.git"

#roo
gem 'rubyzip', '~> 0.9.4', :require => 'zip/zipfilesystem'
gem 'nokogiri', '~> 1.4.4'
gem 'spreadsheet', '~> 0.6.5.4'
gem 'google-spreadsheet-ruby', '~> 0.1.2', :require => 'google_spreadsheet'
gem 'roo', '~> 1.9.3'

#other
gem "hz2py", "~> 0.0.4"


group :development, :test do
  gem "factory_girl_rails", "~> 1.2.0"
  gem 'factory_seed', '~> 0.1.1'

  gem 'rspec-rails', '~> 2.6.1'
  gem "capybara", '~> 1.0.1'
  gem "launchy", "~> 2.0.5"
  gem 'database_cleaner', '~> 0.6.7'
  gem "guard-rspec", "~> 0.4.4"

  gem 'ffaker', '~> 1.4.0'
  gem 'timecop', '~> 0.3.5'
end

group :development do
#  gem 'therubyracer', :require => 'v8' #rails 3.1 use
  gem "foreman", "~> 0.20.0"
  gem "pry", "~> 0.9.2"
  gem "pry-padrino", "~> 0.1.2"
  gem 'thin', "~> 1.2.11"
  gem "curb", "~> 0.7.15"
  gem 'annotate', :git => 'git://github.com/jeremyolliver/annotate_models.git', :branch => 'rake_compatibility'
end

group :test do
  gem 'turn', "~> 0.8.2", :require => false
  case RUBY_PLATFORM
  when /darwin/i
    gem 'rb-fsevent', :require => false
    gem 'growl_notify'
  when /linux/i
    gem "libnotify", "~> 0.5.7"
  end
end

