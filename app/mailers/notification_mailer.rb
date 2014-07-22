class NotificationMailer < ActionMailer::Base
  
  default from: "notifikacie@hrajhokej.sk"


  # Sends email notifying new profile to all admin users
  def notify_new_profile(user)
    @user = user
    
    admins = User.admins.pluck(:email)
    #admins = User.where(email: 'tomas.radic@gmail.com').pluck(:email) # temporary, later uncomment the line above
    
    mail(to: admins, subject: "Nový profil na hrajhokej.sk") if admins.count > 0
  end


  # Sends email notifying new match to all active users
  def notify_new_match(match)
    @match = match

    active_users = User.where(status_id: 2).pluck(:email)
    mail(to: active_users, subject: "Nové stretnutie na hrajhokej.sk") if active_users.count > 0
  end


  # Sends email notifying a change of match to users
  # Parameters:
  #   match: affected match
  #   notify_others: if value is 1, also users not subscribed to this match will be notified
  def notify_match_changed(match, notify_others)
    @match = match
    
    users_to_notify = notify_others ? User.where(status_id: 2).pluck(:email) : match.users.pluck(:email)
    mail(to: users_to_notify, subject: "Zmena plánovaného stretnutia na hrajhokej.sk") if users_to_notify.count > 0
  end


  # Sends email notifying cancellation of match to subscribed users.
  def notify_match_cancelled(match_name, subscribed_users)
    @match_name = match_name
    mail(to: subscribed_users, subject: "Zrušenie plánovaného stretnutia na hrajhokej.sk") if subscribed_users.count > 0
  end


  # Sends email to given player being subscribed or unsubscribed from/to a given match.
  # Parameters:
  #   user_id: id of player
  #   match_id: id of match
  #   is_being_subscribed: true when player is being subscribed, false if unsubscribed
  def notify_match_subscription_change(user_id, match_id, is_being_subscribed)

  end

end
