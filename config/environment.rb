# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.1.1' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "fastercsv"
  config.gem 'rubyist-aasm', :lib => 'aasm', :source => 'http://gems.github.com'
  #config.gem 'mojombo-grit', :lib => 'grit', :source => 'http://gems.github.com'
  
  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_berris-fueller_session',
    :secret      => 'a4ac75932a62c3e6fb9dbe92dfb35d8b2ede1d9149b08aa0ab24b94d739173ff53ab64e15a96312d2709bc4cea98bf926f4bbc3f2bdadfe5cf60e56f8afd3319'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  
  config.active_record.observers = :user_observer
end

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  msg = instance.error_message
  first_whitespace = html_tag =~ /\s/
  html_tag[first_whitespace] = " class=\"fieldWithErrors\" "
  html_tag
end

module ActionView
  module Helpers
    module TextHelper
      module_function :pluralize, :truncate
    end
  end
end

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :default            => "%m/%d/%Y",
  :date_time12        => "%m/%d/%Y %I:%M%p",
  :date_time24        => "%m/%d/%Y %H:%M",
  :iso_8601_date_only => "%Y-%m-%d",
  :iso_8601_time_only => "%H:%M:%S%z"
)


