class NotificationMailer < ActionMailer::Base
  
  default from: "notifikacie.hrajhokej@gmail.com"


  # Sends email notifying new profile to all admin users
  def notify_new_profile(recipient, user)
    @user = user
    mail(to: recipient, subject: "Nový profil na HK Slovan Trstená")
  end


  # Sends email notifying new match to all active users
  def notify_new_match(recipient, match)
    @match = match
    mail(to: recipient, subject: "Nové stretnutie HK Slovan Trstená")
  end


  # Sends email notifying a change of match to users
  # Parameters:
  #   match: affected match
  #   notify_others: if value is 1, also users not subscribed to this match will be notified
  def notify_match_changed(recipient, match)
    @match = match
    mail(to: recipient, subject: "Zmena plánovaného stretnutia HK Slovan Trstená")
  end


  # Sends email notifying cancellation of match to subscribed users.
  def notify_match_cancelled(recipient, match_name)
    @match_name = match_name
    mail(to: recipient, subject: "Zrušenie plánovaného stretnutia HK Slovan Trstená")
  end


  # Sends email to given player being subscribed or unsubscribed from/to a given match.
  # Parameters:
  #   user_id: id of player
  #   match_id: id of match
  #   is_being_subscribed: true when player is being subscribed, false if unsubscribed
  def notify_match_subscription_change(user, match, is_being_subscribed)
    @first_line = ""
    @user = user
    @match = match
    
    case is_being_subscribed
      when true
        @first_line = "Potvrdenie prihlásenia na stretnutie"
      else
        @first_line = "Potvrdenie odhlásenia zo stretnutia"
    end

    mail(to: user.email, subject: @first_line)
  end


  
  def notify_profile_changed(user)
    @user = user
    mail(to: user.email, subject: "Zmena profilu hráča HK Slovan Trstená")
  end


  def notify_profile_deleted(name, email)
    @name = name
    @email = email
    mail(to: email, subject: "Zrušenie profilu hráča HK Slovan Trstená")
  end

end
