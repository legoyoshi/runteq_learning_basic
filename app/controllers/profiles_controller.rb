class ProfilesController < ApplicationController
  before_action :login_check

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_back_or_to(profile_path, success: (t 'flash.user_update_success'))
    else
      redirect_back_or_to(profile_path, danger: @user.errors.full_messages.first )
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :avatar_image, :avatar_image_cache)
  end

  def login_check
    return unless current_user.nil?

    redirect_back_or_to(login_path, danger: (t 'flash.login_request'))
  end
end
