class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[edit update destroy]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.order(id: 'DESC').includes(:user)
  end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_back_or_to(admin_board_path(@board), success: (t 'flash.board_update_success'))
    else
      flash.now[:danger] = (t 'flash.board_update_failed')
      render 'edit'
    end
  end

  def destroy
    @board.destroy!
    redirect_back_or_to(admin_boards_path, success: (t 'flash.board_destroy_success'))
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
