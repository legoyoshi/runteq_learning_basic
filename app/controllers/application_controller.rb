class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end

  def render_500(error)
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))
    ExceptionNotifier.notify_exception(error, env: request.env, data: { message: 'error' })
    render file: Rails.root.join('public', '500.html'), status: :internal_server_error, layout: false
  end
end
