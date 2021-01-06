class BookmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
    # redirect_back_or_to(request.referer, success: t('flash.bookmarked'))
  end

  def destroy
    @board = current_user.bookmark_boards.find(params[:board_id])
    current_user.unbookmark(@board)
    # redirect_back_or_to(request.referer, success: t('flash.unbookmarked'))
  end
end
