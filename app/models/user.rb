class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar_image, AvatarImageUploader

  has_many :boards, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board
  has_many :comments, dependent: :destroy
  validates :last_name,  presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true
  enum status: {
    general: 0,
    admin: 1
  }

  def own_board?(board)
    id == board.user_id
  end

  def own_comment?(comment)
    id == comment.user_id
  end

  def bookmark(board)
    bookmark_boards << board
  end

  #  ブックマークを解除する
  def unbookmark(board)
    bookmark_boards.destroy(board)
  end
end
