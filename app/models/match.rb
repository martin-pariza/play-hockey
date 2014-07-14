class Match < ActiveRecord::Base

  # Validations -------------------------
  validates :date_of_play, presence: true
  validates :category_id, presence: true
  validate :nr_of_players
  # Validations ------------------------- (end)

  # DB asociations ------------------
  has_many :match_subscriptions, dependent: :destroy
  has_many :users, through: :match_subscriptions
  belongs_to :category
  # DB asociations ------------------ (end)


  def passed?
    return self.date_of_play < Date.current()
  end


  def full_caption
    full_caption = self.formatted_date
    
    if self.category_id == 1
      full_caption += " - #{self.name}" unless self.name.blank?
    else
      full_caption += " - Tréning"
    end

    return full_caption
  end


  def formatted_date
    return self.date_of_play.to_formatted_s(:rfc822)
  end


  private

    def nr_of_players
      if max_num_of_players && max_num_of_players < self.users.count
        errors[:base] << "Maximálny počet hráčov nesmie byť menší ako počet aktuálne prihlásených."
      end

      if max_num_of_players && min_num_of_players && max_num_of_players < min_num_of_players
        errors[:base] << "Minimálny počet hráčov je vyšší ako ich maximálny počet."
      end
    end

end
