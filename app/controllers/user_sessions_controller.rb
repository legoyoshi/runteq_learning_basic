class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(boards_path, success: (t 'flash.login_success'))
    else
      redirect_back_or_to(login_path, danger: (t 'flash.login_failed'))
      # flash.now[:danger] = t 'flash.login_failed'
      # render 'new'
    end
  end

  def destroy
    logout
    redirect_back_or_to(root_path, success: (t 'flash.logout_success'))
  end
end
