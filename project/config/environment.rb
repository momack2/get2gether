# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Test1::Application.initialize!


#Hope this is useful
Test1::Application.config.action_mailer.delivery_method = :smtp
ActionMailer::Base.smtp_settings = YAML.load_file(
    Rails.root.join('config', 'mailers.yml'))[Rails.env].try(:to_options)