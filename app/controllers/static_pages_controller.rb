class StaticPagesController < ApplicationController

  def home
    @closest_match = nil
    @closest_training = nil
    closest_events = Match.where('date_of_play > ?', Date.today)

    if closest_events
      @closest_match = (closest_events.where('category_id = ?', 1).order(date_of_play: :asc)).first
      @closest_training = (closest_events.where('category_id = ?', 2).order(date_of_play: :asc)).first
    end
  end

  def help

  end

  def about

  end

  def contact

  end
end
