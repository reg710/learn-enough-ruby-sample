class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image # relates to Active Storage API
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
