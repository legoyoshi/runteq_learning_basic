class BoardsController < ApplicationController
  before_action :login_check
  def index
    @boards = Board.all.includes(:user)
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_back_or_to(boards_path, success: (t 'flash.board_create_success'))
    else
      flash.now[:danger] = (t 'flash.board_create_failed')
      render 'new'
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body).merge(user_id: current_user.id)
  end

  def login_check
    return unless current_user.nil?

    redirect_back_or_to(login_path, danger: (t 'flash.login_request'))
  end
end
