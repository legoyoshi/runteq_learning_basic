class BoardsController < ApplicationController
  before_action :login_check, only: [:index]
  def index
    @boards = Board.all.includes(:user)
  end

  private

  def login_check
    return unless current_user.nil?
      redirect_back_or_to(login_path, danger: (t 'flash.login_request'))
  end
end
