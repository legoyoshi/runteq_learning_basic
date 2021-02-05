class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :check_admin, only: %i[new create]
  layout 'admin/layouts/admin_login'

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(admin_root_path, success: 'ログインしました')
    else
      redirect_back_or_to(admin_login_path, danger: 'ログインに失敗しました')
    end
  end

  def destroy
    logout
    redirect_back_or_to admin_login_path, success: 'ログアウトしました'
  end
end
