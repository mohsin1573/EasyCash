class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_one_attached :image
  validates :phone, uniqueness: true
end
