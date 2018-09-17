class User < ApplicationRecord

  validates :name, presence: true,length: { maximum: 8 }
  validates :email, presence: true
  validates :image, presence: true

  has_secure_password

  has_many :likes
  has_many :requets
  has_many :reviews
  has_one :room

  mount_uploader :image, ImageUploader

end
