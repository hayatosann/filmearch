class User < ApplicationRecord
  validates :nickname, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews

  has_one_attached :avatar
  has_many :likes
  has_many :products, through: :likes
end
