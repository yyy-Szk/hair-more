class Teacher < ApplicationRecord

  # validates :name, presence: true,length: { maximum: 8 }
  # validates :email, presence: true
  # validates :image, presence: true

  has_secure_password

  has_many :topics
  has_many :reviews
  has_one :room

  mount_uploader :image, ImageUploader

end
