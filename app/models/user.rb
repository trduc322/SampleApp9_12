class User < ApplicationRecord
  has_secure_password
  attr_accessor :remember_token
  validates :name, presence:true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },uniqueness: true

  validates :password, presence: true,length: {minimum:6},allow_nil:true,
    confirmation:true

  def forget
    update_attribute :remember_digest, nil
  end
  
  def remember
    self.remember_token = SecureRandom.urlsafe_base64 
    update_attribute :remember_digest, User.digest(remember_token)
  end
  def authenticate? token
    BCrypt::Password.new(remember_digest).is_password?(token)
    
  end
  
  class<<self
      def digest token
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost 
        BCrypt::Password.create(token, cost: cost)
      
      end
      
  end  
end
