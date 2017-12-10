require 'rails_helper'

describe NightlyDepositJob, type: :job do
  it "deposits 10_000 in player's account" do
    player = spy("player", money: 0)
    allow(Player).to receive(:find).and_return(player)

    NightlyDepositJob.perform_now(player_id: 1)

    expect(player).to have_received(:update!).with(money: 10_000).once
  end
end
