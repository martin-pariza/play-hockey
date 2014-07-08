class MatchSubscription < ActiveRecord::Base

  # Validations -------------------------
  validates :user_id, presence: true
  validates :match_id, presence: true
  # Validations ------------------------- (end)

  
  # DB asociations ----------------------
  belongs_to :user
  belongs_to :match
  # DB asociations ---------------------- (end)
end
