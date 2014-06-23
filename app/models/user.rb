class User < ActiveRecord::Base

  before_save { self.email = email.downcase } # always lowercase the email before saving
  before_create :create_remember_token # create token when creating new user

  
  # Validations --------------------
  # name validation
  validates :name,  presence: true, length: { maximum: 50 }
  
  # email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
    format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  # Validations -------------------- (end)

  
  has_secure_password # covers password management functionality


  # Token functionality ----------------------
  
  # Creates a random string, used as a token.
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  
  # Hashes given token to make it secure.
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private

    # Creates new token and stores it hashed to self.remember_token.
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
  # Token functionality ---------------------- (end)
end
