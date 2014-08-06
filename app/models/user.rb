class User < ActiveRecord::Base

  # DB asociations -----------------
  has_many :match_subscriptions, dependent: :destroy
  has_many :matches, through: :match_subscriptions
  belongs_to :status
  # DB asociations ----------------- (end)

  before_save { self.email = email.downcase } # always lowercase the email before saving
  before_save { self.firstname = firstname.split.map(&:capitalize).join(' ') } # capitalize name
  before_save { self.lastname = lastname.split.map(&:capitalize).join(' ') }
  before_create :create_remember_token # create token when creating new user

  
  # Validations --------------------
  # name validation
  validates :firstname,  presence: true, length: { maximum: 50 }
  validates :lastname,  presence: true, length: { maximum: 50 }
  validates :year_of_birth, :numericality => { :greater_than => Date.today.year - 100, :less_than_or_equal_to => Date.today.year - 10 }
  validates :plays_since, :numericality => { :greater_than_or_equal_to => :year_of_birth }, :if => :year_of_birth
  
  # email validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
    format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 4 }, :if => :password
  # Validations -------------------- (end)

  
  scope :admins, -> { where(admin: true) }


  has_secure_password # covers password management functionality


  def fullname
    fullname = self.lastname + " " + self.firstname
    fullname += " #{self.name_suffix}" unless self.name_suffix.blank?

    return fullname
  end


  def is_subscribed_to(match)
    return !self.matches.find_by(id: match.id).nil?
  end


  # Evaluates whether this user can be subscribed to given match, returns true if so.
  def can_be_subscribed_to(match)
    
    result = false # expect false
    return result if match.nil?

    found_match = self.matches.find_by(id: match.id) # search for this match in this user's matches
    
    if found_match.nil? # if not found
      # Switch result to true, if no limit is specified or the limit has not been reached
      result = true if match.max_num_of_players.nil? || match.users.count < match.max_num_of_players
    end

    return result
  end



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
