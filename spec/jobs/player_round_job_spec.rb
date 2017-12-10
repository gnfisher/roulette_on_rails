require 'rails_helper'

describe PlayerRoundJob, type: :job do
  describe "#perform" do
    it "plays the round for specified player" do
      player = Player.create(name: "Darth Vader")
      round = Round.create!(result: "green", raining: false)
      player_round = spy("player_round")
      allow(PlayerRound).to receive(:new).and_return(player_round)

      PlayerRoundJob.perform_now(player_id: player.id, round_id: round.id)

      expect(PlayerRound).to have_received(:new).with(
        player: player,
        round: round
      )
      expect(player_round).to have_received(:place_wager)
    end
  end
end
