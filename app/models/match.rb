class Match < ActiveRecord::Base

  # Validations -------------------------
  validates :date_of_play, presence: true
  # Validations ------------------------- (end)

  # DB asociations ------------------
  has_many :match_subscriptions, dependent: :destroy
  has_many :users, through: :match_subscriptions
  # DB asociations ------------------ (end)


  def passed?
    return self.date_of_play < Date.current()
  end


  def full_caption
    full_caption = self.date_of_play.to_formatted_s(:rfc822)
    full_caption += " - #{self.name}" if !self.name.blank?
    return full_caption
  end
end
