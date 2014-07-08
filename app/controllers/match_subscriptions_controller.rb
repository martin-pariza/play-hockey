class MatchSubscriptionsController < ApplicationController
  

=begin
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy


=end



  def create
    match_subscription = MatchSubscription.new(match_subscription_params)
    if match_subscription.save
      flash[:success] = "Prihlásenie na zápas bolo úspešné."
      redirect_to match_url(params[:match_subscription][:match_id])
    end
  end

  def destroy
    match_subscription = MatchSubscription.find_by(
            id: params[:id]) # QUESTION: ako je mozne, ze tu nemozem pristupovat 
                             # k params[:match_subscription][:match_id]  ???

    if match_subscription
      unsubscribed_match_id = match_subscription.match_id
      match_subscription.destroy
      flash[:success] = "Odhlásenie zo zápasu bolo úspešné."
    else
      flash[:error] = "Odhlásenie zo zápasu sa nepodarilo."
    end

    if unsubscribed_match_id
      redirect_to match_url(unsubscribed_match_id)
    else
      redirect_to matches_url
    end
    
  end


  
  # this action is to be deleted since "Pridat dalsich" link has been moved to match.show action
  def more_new # QUESTION: link_to, ktory vedie na tuto action ma href=more_new_match_subscriptions_path.
           # Preco sa "musi" tato action volat 'show' a nie 'more_new'?
    
    @match_id = session[:match_id]
    @match = Match.find_by(id: @match_id)
    
    if @match.users.count > 0
      @available_players = User.where('id not in (?)', @match.users.ids)
    else
      @available_players = User.all
    end
  end

  
  def create_more
    
    new_subscribed_player_ids = params[:available_players][:id]
    match_id = params[:match_id]

    new_subscribed_player_ids.each do |nspid|
      ms = MatchSubscription.new
      ms.user_id = nspid
      ms.match_id = match_id
      if ms.save
        flash[:success] = "Vybraní hráči boli úspešne prihlásení na zápas."
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
end
