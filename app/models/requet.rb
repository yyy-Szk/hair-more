class Requet < ApplicationRecord
  validates :description, presence: true

  belongs_to :topic
  belongs_to :user
end
