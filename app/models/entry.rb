class Entry < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: {maximum: Settings.max_title_leng}
  validates :user_id, presence: true

  default_scope ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader
end
