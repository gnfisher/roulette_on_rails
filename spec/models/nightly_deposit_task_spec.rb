require 'rails_helper'

describe NightlyDepositTask do
  describe "#peform" do
    it "schedules a NightlyDepositJob for every player" do
      first_player = Player.create(name: "Darth Vader")
      second_player = Player.create(name: "Luke Skywalker")
      allow(NightlyDepositJob).to receive(:perform_later)

      NightlyDepositTask.new.perform

      expect(NightlyDepositJob).to have_received(:perform_later).with(player_id: first_player.id).once
      expect(NightlyDepositJob).to have_received(:perform_later).with(player_id: second_player.id).once
    end
  end
end
