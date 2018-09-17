class Review < ApplicationRecord
  validates :content, presence: true
  validates :star, presence: true

  belongs_to :user
  belongs_to :teacher
end
