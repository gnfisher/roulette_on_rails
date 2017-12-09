class PlayerRoundJob < ActiveJob::Base
  def perform(player_id:, round_id:)
    @player_id = player_id
    @round_id = round_id

    perform_player_round
  end

  private

  def perform_player_round
    PlayerRound.new(player: player, round: round).place_wager
  end

  def player
    Player.find(@player_id)
  end

  def round
    Round.find(@round_id)
  end
end
