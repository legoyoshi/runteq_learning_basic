class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_back_or_to(login_path, success: (t 'flash.register_success'))
    else
      flash.now[:danger] = t 'flash.register_failed'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation)
  end
end
