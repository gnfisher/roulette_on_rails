require "rails_helper"

describe RouletteRound do
  context ".play" do
    it "fetches the current weather in santiago" do
      active_players = [spy("player")]
      player_wager = spy("player_wager")
      round = spy(round)
      allow(Round).to receive(:create!).and_return(round)
      allow(PlayerRoundJob).to receive(:perform_later)
      allow(WeatherChecker).to receive(:raining?)

      RouletteRound.new(active_players).play

      expect(WeatherChecker).to have_received(:raining?)
    end

    it "schedules a PlayerRoundJob for each player" do
      player = spy("player")
      active_players = [player]
      allow(WeatherChecker).to receive(:raining?).and_return(true)
      round = spy("round")
      allow(Round).to receive(:create!).and_return(round)
      allow(PlayerRoundJob).to receive(:perform_later)

      RouletteRound.new(active_players).play

      expect(PlayerRoundJob).
        to have_received(:perform_later).
        with(player_id: player.id, round_id: round.id)
    end
  end
end
