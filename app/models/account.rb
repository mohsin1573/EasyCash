class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :phone, uniqueness: true
end
