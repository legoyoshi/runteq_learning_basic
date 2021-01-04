class Board < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  mount_uploader :board_image, BoardImageUploader

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
  
end
