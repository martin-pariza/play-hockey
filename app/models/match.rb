class Match < ActiveRecord::Base

  # Validations -------------------------
  validates :date_of_play, presence: true
  validate :max_nr_of_players_not_under_subscribed
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


  private

    def max_nr_of_players_not_under_subscribed
      if max_num_of_players && max_num_of_players < self.users.count
        errors[:base] << "Maximálny počet hráčov nesmie byť menší ako počet aktuálne prihlásených."
      end
    end

end
