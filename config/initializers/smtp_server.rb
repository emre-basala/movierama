Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              ENV.fetch("SMTP_ADDRESS"),
    port:                 ENV.fetch("SMTP_PORT", 587).to_i,
    domain:               ENV.fetch("SMTP_DOMAIN"),
    user_name:            ENV.fetch("SMTP_USERNAME"),
    password:             ENV.fetch("SMTP_PASSWORD"),
    authentication:       'plain',
    enable_starttls_auto: true
  }
end