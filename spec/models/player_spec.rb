require 'rails_helper'

describe Player do
  it do
    is_expected.
      to validate_numericality_of(:money).
      is_greater_than_or_equal_to(0)
  end

  it "sets money to 1_000 if not value passed" do
    player = Player.create(name: "Darth Vader")

    result = player.money

    expect(result).to eq(10_000)
  end

  context ".active" do
    it "returns only players with funds greater than 0" do
      Player.create(name: "Darth Vader", money: 100)
      Player.create(name: "Luke Skywalker", money: 0)

      result = Player.active

      expect(result.size).to eq 1
    end
  end
end
