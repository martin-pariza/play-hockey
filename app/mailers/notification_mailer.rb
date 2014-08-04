class NotificationMailer < ActionMailer::Base
  
  default from: "notifikacie.hrajhokej@gmail.com"


  # Sends email notifying new profile to all admin users
  def notify_new_profile(user)
    @user = user
    
    admins = User.admins.pluck(:email)
    #admins = User.where(email: 'tomas.radic@gmail.com').pluck(:email) # temporary, later uncomment the line above
    
    admins.each do |a|
      mail(to: a, subject: "Nový profil na HK Slovan Trstená")
    end
  end


  # Sends email notifying new match to all active users
  def notify_new_match(match)
    @match = match

    active_users = User.where(status_id: 2).pluck(:email)

    active_users.each do |au|
      mail(to: au, subject: "Nové stretnutie HK Slovan Trstená")
    end
  end


  # Sends email notifying a change of match to users
  # Parameters:
  #   match: affected match
  #   notify_others: if value is 1, also users not subscribed to this match will be notified
  def notify_match_changed(match, notify_others)
    @match = match
    
    users_to_notify = notify_others ? User.where(status_id: 2).pluck(:email) : match.users.pluck(:email)
    
    users_to_notify.each do |utn|
      mail(to: utn, subject: "Zmena plánovaného stretnutia HK Slovan Trstená")
    end
  end


  # Sends email notifying cancellation of match to subscribed users.
  def notify_match_cancelled(match_name, subscribed_users)
    @match_name = match_name

    subscribed_users.each do |su|
      mail(to: subscribed_users, subject: "Zrušenie plánovaného stretnutia HK Slovan Trstená")
    end
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
