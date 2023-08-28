class User < ApplicationRecord
  has_one :account
  has_many :transactions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  attribute :authenticated_from_google, :boolean, default: false

  before_create :set_default_role

  enum role: { user: "user", admin: "admin", superadmin: "superadmin" }
  
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20],
           authenticated_from_google: true
        )
    end
    user
  end
  
  
  private

  def set_default_role
    self.role ||= 'user'
  end
end
