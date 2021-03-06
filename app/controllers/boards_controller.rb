class BoardsController < ApplicationController
  before_action :login_check
  before_action :set_board, only: %i[edit update destroy]

  PER = 20

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result.includes(:user).page(params[:page]).per(PER)
    # @boards = Board.all.includes(:user).page(params[:page]).per(PER)
  end

  def new
    @board = Board.new
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.order(id: 'DESC').includes(:user)
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

  def edit; end

  def update
    if @board.update(board_params)
      redirect_back_or_to(board_path(@board), success: (t 'flash.board_update_success'))
    else
      flash.now[:danger] = (t 'flash.board_update_failed')
      render 'edit'
    end
  end

  def destroy
    @board.destroy!
    redirect_back_or_to(boards_path, success: (t 'flash.board_destroy_success'))
  end

  def bookmarks
    @q = current_user.bookmark_boards.ransack(params[:q])
    @boards = @q.result.includes(:user).page(params[:page]).per(PER)
  end

  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache).merge(user_id: current_user.id)
  end

  def login_check
    return unless current_user.nil?

    redirect_back_or_to(login_path, danger: (t 'flash.login_request'))
  end
end
