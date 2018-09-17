class Topic < ApplicationRecord
  validates :teacher_id, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image, presence: true
  #
  belongs_to :teacher
  has_many :likes
  has_many :requets

  mount_uploader :image, ImageUploader

end
