class UsersController < ApplicationController

  before_action :sign_somebody_in,             only: [:edit, :update, :destroy]
  before_action :verify_user_now_signed_in,    only: [:edit, :update, :destroy]
  #before_action :redirect_away_nonadmin_users, only: :destroy
  before_action :sign_out_current_user,        only: [ :new, :create ]


  def index
    @users = User.order(lastname: :asc).paginate(page: params[:page], per_page: 10) # params[:page] - parameter generated by will_paginate on view
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Vitaj v hokejovej lige! Tu si môžeš pozrieť zoznam zápasov."
      redirect_to matches_path
    else
      render 'new'
    end
  end


  def show
    @user = User.find(params[:id])
    
    @next_matches = @user.matches.where('date_of_play > (?)', Date.current())
    @past_matches = @user.matches.where('date_of_play <= (?)', Date.current()).paginate(page: params[:page], per_page: 5)
  end


  def edit
    # Next line no more needed, commented out, due to @user variable is defined in
    # verify_user_now_signed_in method called right before edit action is fired (see before_action on the top)
    #@user = User.find(params[:id])
  end


  def update
    # Next line no more needed, commented out, due to @user variable is defined in
    # verify_user_now_signed_in method called right before edit action is fired (see before_action on the top)
    #@user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Profil bol upravený."
      redirect_to @user
    else
      render 'edit'
    end
  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Profil bol vymazaný."
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(
        :firstname,
        :lastname,
        :name_suffix,
        :email,
        :password,
        :password_confirmation,
        :phone_nr,
        :year_of_birth,
        :residence
      )
    end

    def user_params_without_password
      params.require(:user).permit(
        :firstname,
        :lastname,
        :name_suffix,
        :email,
        :phone_nr,
        :year_of_birth,
        :residence
      )
    end



    # Before filters

    # If there is no user signed in, this method redirects to sign-in page
    # while it also stores the requested url location.
    def sign_somebody_in
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Je potrebné sa prihlásiť." 
        # NOTE: notice: "Please sign in." is a shortcut parameter of redirect_to.
        # It could be 
        #  flash[:notice] = "Please sign in."
        #  redirect_to signin_url
        # too.
      end
    end


    # Redirects to root unless user with id specified in request's params is the one 
    # currently signed in.
    def verify_user_now_signed_in
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end


    # Redirects to root unless user currently logged in is an admin user.
=begin
    def redirect_away_nonadmin_users
      redirect_to(root_url) unless current_user.admin?
    end
=end


    def sign_out_current_user
      if signed_in?
        sign_out
      end
    end
  
end
