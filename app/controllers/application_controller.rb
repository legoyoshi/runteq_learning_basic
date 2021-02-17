class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end

  def render_500(e)
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    ExceptionNotifier.notify_exception(e, :env => request.env, :data => {:message => "error"})
    render file: Rails.root.join('public', '500.html'), status: :internal_server_error, layout: false
  end
end
