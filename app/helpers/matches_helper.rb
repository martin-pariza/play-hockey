module MatchesHelper

  def get_match_subscription_id(player, match)
    MatchSubscription.where(user_id: player.id).where(match_id: match.id).first.id
  end
end
