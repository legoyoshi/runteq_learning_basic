class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def check_admin
    redirect_back_or_to root_path, warning: '権限がありません' unless !current_user.nil? && current_user.admin?
  end
end
