module WagerHelper
  def outcome_for(wager)
    if wager.winnings > 0
      "Win! (+#{ wager.winnings })"
    else
      "Lose! (-#{ wager.amount })"
    end
  end
end
