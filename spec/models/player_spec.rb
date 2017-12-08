require 'rails_helper'

describe Player do
  it "sets money to 1_000 if not value passed" do
    player = Player.create(name: "Darth Vader")

    result = player.money

    expect(result).to eq(1_000)
  end
end
