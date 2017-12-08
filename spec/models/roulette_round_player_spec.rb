require "rails_helper"

describe RouletteRoundPlayer do
  context ".play" do
    it "fetches the current weather in santiago" do
      active_players = [spy("player")]
      player_wager = spy("player_wager")
      allow(PlayerWager).to receive(:new).and_return(player_wager)
      allow(WeatherChecker).to receive(:raining?)

      RouletteRoundPlayer.new(active_players).play

      expect(WeatherChecker).to have_received(:raining?)
    end

    it "creates a round and places wager for each player" do
      player = spy("player")
      active_players = [player]
      allow(WeatherChecker).to receive(:raining?).and_return(true)
      round = spy("round")
      allow(Round).to receive(:create!).and_return(round)
      player_wager = spy("player_wager")
      allow(PlayerWager).to receive(:new).and_return(player_wager)

      RouletteRoundPlayer.new(active_players).play

      expect(PlayerWager).
        to have_received(:new).
        with(player: player, raining: true, round: round)
      expect(player_wager).to have_recieved(:place_wager)
    end
  end
end
