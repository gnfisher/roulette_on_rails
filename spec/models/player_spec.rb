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
end
