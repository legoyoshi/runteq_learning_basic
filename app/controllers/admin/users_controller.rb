class Admin::UsersController < Admin::BaseController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_back_or_to(admin_user_path(@user), success: (t 'flash.user_update_success'))
    else
      flash.now[:danger] = (t 'flash.user_update_failed')
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_back_or_to(admin_users_path, success: (t 'flash.user_destroy_success'))
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :avatar_image, :avatar_image_cache)
  end
end
