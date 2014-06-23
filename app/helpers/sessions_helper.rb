module SessionsHelper

  
  # Signs in the given user.
  def sign_in(user)
    remember_token = User.new_remember_token # create new token
    cookies.permanent[:remember_token] = remember_token # set newly created token to browser's cookies
    user.update_attribute(:remember_token, User.digest(remember_token)) # hash the token and set to DB for the given user
    self.current_user = user # set the given user as a @current_user (using current_user method)
  end

  
  # Sets given user to @current_user.
  def current_user=(user)
    @current_user = user
  end


  # Sets a new @current_user in case it is nil currently.
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  
  # Returns true if given user is the one currently signed in, false otherwise.
  def current_user?(user)
    user == current_user
  end

  
  # Returns true if there is a user signed in currently, false otherwise.
  def signed_in?
    !current_user.nil?
  end

  
  # Signes out the user currently signed in. 
  # Additionally it changes user's remember token stored in DB (in case the cookie has been stolen)
  # and also deletes the cookie from users browser.
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end


  # Redirects to either: url stored in session, or given url if there is no url to go to in session.
  # Additionally deletes the url to go to stored in session.
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end


  # Stores location to go to from request to session for later use.
  # Applies only for get requests.
  def store_location
    session[:return_to] = request.url if request.get?
  end

end
