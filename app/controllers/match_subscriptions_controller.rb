class MatchSubscriptionsController < ApplicationController
  

=begin
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy


=end
  before_action :sign_somebody_in
  before_action :verify_account_active, only: [ :create ]


  def create
    match_subscription = MatchSubscription.new(match_subscription_params)
    if match_subscription.save

      user = User.where(id: match_subscription.user_id).first
      match = Match.where(id: match_subscription.match_id).first
      flash_message = "Prihlásenie na stretnutie bolo úspešné."

      begin  
        NotificationMailer.notify_match_subscription_change(user, match, true).deliver
      rescue  
        flash_message += " Notifikačný email sa nepodarilo odoslať."
      end

      flash[:success] = flash_message
      redirect_to match_url(params[:match_subscription][:match_id])
    end
  end

  def destroy
    match_subscription = MatchSubscription.find params[:id]
    match_subscription.destroy

    user = User.where(id: match_subscription.user_id).first
    match = Match.where(id: match_subscription.match_id).first
    flash_message = "Odhlásenie zo stretnutia bolo úspešné."
    
    begin
      NotificationMailer.notify_match_subscription_change(user, match, false).deliver
    rescue
      flash_message += " Notifikačný email sa nepodarilo odoslať."
    end

    flash[:success] = flash_message
    redirect_to match_url(match_subscription.match_id)
  end


  
  def create_more
    
    new_subscribed_player_ids = params[:available_players] ? params[:available_players][:id] : []
    match_id = params[:match_id]
    match = Match.find(match_id)

    new_subscribed_player_ids.each do |nspid|

      player = User.find(nspid)

      ms = MatchSubscription.new
      ms.user_id = nspid
      ms.match_id = match_id
      if ms.save
        flash_message = "Vybraní hráči boli úspešne prihlásení na stretnutie."
        
        begin
          NotificationMailer.notify_match_subscription_change(
              player, 
              match, 
              true
          ).deliver
        rescue
          flash_message += " Notifikačný email sa nepodarilo odoslať."
        end

        flash[:success] = flash_message

      else
        flash[:error] = "Chyba: hráčov sa nepodarilo prihlásiť."
        render 'more_new'
      end
    end

    redirect_to match_path(match_id)
  end


  private

    def match_subscription_params
      params.require(:match_subscription).permit(:user_id, :match_id)
    end



    def verify_account_active
      user = User.find_by(id: params[:match_subscription][:user_id])
      unless current_user.admin? || user.status_id == 2
        flash[:error] = "Tento profil nie je aktívny."
        sign_out
        redirect_to root_url
      end
    end

end
