
=begin
SessionsController handles sessions, meaning singin and signout
=end

class SessionsController < ApplicationController

  before_action :verify_account_active, only: [ :create ]

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      sign_in user
      default_path = user.admin? ? users_path : matches_path
      redirect_back_or default_path
    else
      flash.now[:error] = 'Neplatná kombinácia emailu a hesla.' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end


  private

    def verify_account_active
      user = User.find_by(email: params[:session][:email])
      unless user && user.status_id == 2
        flash[:error] = "Tento profil nie je aktívny."
        sign_out
        redirect_to root_url
      end
    end


end
