class MatchesController < ApplicationController

  
  

  def index
    @matches = Match.order(date_of_play: :desc).paginate(page: params[:page], per_page: 5)
    @class_badge = "badge"
    @class_badge_full = "badge full"
  end


  def show
    @match = Match.find(params[:id])
    @players = @match.users


    # Count maximum number of players that can be added to the match
    # Value -1 means there is no limit for this match
    @max_players_to_add = @match.max_num_of_players.nil? ? -1 : @match.max_num_of_players - @players.count

    
    # Select players available to be added to this match
    if @match.users.count > 0
      @available_players = User.where('id not in (?)', @match.users.ids).where(status_id: 2)
    else
      @available_players = User.where(status_id: 2)
    end


    #session[:match_id] = @match.id # to be deleted since "Pridat dalsich" link is on "show" 
                                    # action directly
  end


  def new
    @match = Match.new
    now = DateTime.now
    @next_sunday = now + 7 - now.wday
    @category_names = Category.all
  end

  
  def create
    @match = Match.new(match_params)
    notify_others = params[:send_notification]
    
    if @match.save
      flash[:success] = "Nové stretnutie bolo úspešne vytvorené."
      NotificationMailer.notify_new_match(@match).deliver if notify_others == "1"
      redirect_to matches_url
    
    else
      render 'new'
    
    end
  end


  def edit
    @match = Match.find(params[:id])
    @category_names = Category.all
  end


  def update
    @match = Match.find(params[:id])
    @category_names = Category.all
    notify_subscribed = params[:send_notification_to_subscribed]
    notify_others = params[:send_notification_to_others] == "1"

    if @match.update_attributes(match_params)
      flash[:success] = "Zmeny sa úspešne uložili."
      NotificationMailer.notify_match_changed(@match, notify_others).deliver if notify_subscribed == "1"
      redirect_to @match
    else
      render 'edit'
    end
  end


  def destroy
    match = Match.find(params[:id])
    match_name = match.full_caption
    passed = match.passed?
    subscribed_users = match.users.pluck(:email)

    if match.destroy
      flash[:success] = "Stretnutie bolo zrušené."
      NotificationMailer.notify_match_cancelled(match_name, subscribed_users).deliver if !passed && subscribed_users.count > 0
    else
      flash[:error] = "Stretnutie sa nepodarilo zrušiť."
    end
    
    redirect_to matches_url
  end


  private

    def match_params
      result = params.require(:match).permit(
        :date_of_play,
        :time_of_play,
        :name,
        :note,
        :min_num_of_players,
        :max_num_of_players,
        :category_id
      )

      return result
    end


    def verify_user_is_admin
      if current_user.nil? || !current_user.admin?
        flash[:error] = "Nepovolená akcia."
        redirect_to root_url
      end
    end

end
