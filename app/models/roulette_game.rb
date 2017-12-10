class RouletteGame
  include Delayed::RecurringJob

  run_every 3.minutes

  def self.pick_color
    case Array(1..100).sample
    when 1..2
      "green"
    when 3..51
      "red"
    when 52..100
      "black"
    end
  end

  def self.calculate_winnings(round:, color_guessed:, wager:)
    return 0 unless color_guessed == round.result

    if color_guessed == "green"
      wager * 15
    else
      wager * 2
    end
  end

  def perform
    active_players = Player.active
    RouletteRound.new(active_players).play
  end
end
