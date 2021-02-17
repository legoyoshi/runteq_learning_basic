if Rails.env.production?
  require 'exception_notification/rails'

  ExceptionNotification.configure do |config|

    config.add_notifier :slack,
      webhook_url: Rails.application.credentials[:webhook_url],
      channel: "#基礎編通知"
  end
end
