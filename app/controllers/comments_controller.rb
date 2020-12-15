class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_back_or_to(board_path(id: @comment.board_id), success: (t 'flash.comment_create_success'))
    else
      redirect_back_or_to(board_path(id: @comment.board_id), danger: (t 'flash.comment_create_failed'))
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :board_id).merge(user_id: current_user.id)
  end

end
