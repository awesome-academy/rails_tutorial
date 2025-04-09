class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: {maximum: 140} #digit_140: 140
  scope :newest, -> { order(created_at: :desc) }
  scope :relate_post, ->(user_ids) { where(user_id: user_ids) }
end
