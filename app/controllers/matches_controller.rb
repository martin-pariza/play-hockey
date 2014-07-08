class MatchesController < ApplicationController

  before_action :verify_user_is_admin, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @matches = Match.order(date_of_play: :desc).paginate(page: params[:page], per_page: 5)
  end


  def show
    @match = Match.find(params[:id])
    @players = @match.users


    # Count maximum number of players that can be added to the match
    # Value -1 means there is no limit for this match
    @max_players_to_add = @match.max_num_of_players.nil? ? -1 : @match.max_num_of_players - @players.count

    
    # Select players available to be added to this match
    if @match.users.count > 0
      @available_players = User.where('id not in (?)', @match.users.ids)
    else
      @available_players = User.all
    end


    #session[:match_id] = @match.id # to be deleted since "Pridat dalsich" link is on "show" 
                                    # action directly
  end


  def new
    @match = Match.new
    now = DateTime.now
    @next_sunday = now + 7 - now.wday
  end

  
  def create
    @match = Match.new(match_params)
    if @match.save
      flash[:success] = "Nový zápas bol vytvorený."
      redirect_to matches_url
    else
      render 'new'
    end
  end


  def edit
    @match = Match.find(params[:id])
  end


  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(match_params)
      flash[:success] = "Zmeny sa úspešne uložili."
      redirect_to @match
    else
      render 'edit'
    end
  end


  def destroy
    @match = Match.find(params[:id]).destroy
    flash[:success] = "Zápas bol zrušený."
    redirect_to matches_url
  end


  private

    def match_params
      params.require(:match).permit(
        :date_of_play,
        :name,
        :note,
        :min_num_of_players,
        :max_num_of_players
      )
    end


    def verify_user_is_admin
      if current_user.nil? || !current_user.admin?
        flash[:error] = "Nepovolená akcia."
        redirect_to root_url
      end
    end

end
