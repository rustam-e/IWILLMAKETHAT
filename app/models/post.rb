class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 } # tweets are capped at 140 chars.
  validates :url, presence: true
  default_scope -> { order(created_at: :desc) } # newest tweets / posts first
  has_many :categorizations
  has_many :tags, through: :categorizations
end
