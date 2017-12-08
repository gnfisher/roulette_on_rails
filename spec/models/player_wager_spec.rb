require "rails_helper"

describe PlayerWager do
  describe "#place_wager" do
    it "updates player money" do
      round = double("round").as_null_object
      player = spy("player")
      allow(player).to receive(:with_lock).and_yield
      allow(Wager).to receive(:create!)

      PlayerWager.new(player: player, raining: true, round: round).place_wager

      expect(player).to have_received(:with_lock)
      expect(player).to have_received(:update!).with(money: player.money)
    end

    it "saves the wager" do
      round = double("round").as_null_object
      player = Player.create(name: "Darth Vader")
      allow(Wager).to receive(:create!)

      PlayerWager.new(player: player, raining: true, round: round).place_wager

      expect(Wager).to have_received(:create!).once
    end
  end

  describe "#wager_amount" do
    context "player has 1_000 or less money" do
      it "goes all in if player has 1_000 or less money" do
        raining = false
        round = double("round")
        player = Player.new(name: "Darth Vader", money: 1_000)
        player_wager = PlayerWager.new(player: player, raining: raining, round: round)

        result = player_wager.wager_amount

        expect(result).to eq(player.money)
      end
    end

    context "player has more than 1_000 money" do
      it "wagers between 8 and 15 percent of money if not raining" do
        raining = false
        round = double("round")
        player = Player.new(name: "Darth Vader", money: 10_000)
        player_wager = PlayerWager.new(player: player, raining: raining, round: round)

        result = player_wager.wager_amount

        expect(between_8_and_15_percent_of(player.money)).to cover(result)
      end

      it "wagers between 4 and 10 percent of money if raining" do
        raining = true
        round = double("round")
        player = Player.new(name: "Darth Vader", money: 10_000)
        player_wager = PlayerWager.new(player: player, raining: raining, round: round)

        result = player_wager.wager_amount

        expect(between_4_and_10_percent_of(player.money)).to cover(result)
      end
    end

    describe "#winner?" do
      it "returns true if the player guess is a winner" do
        winning_result = "green"
        round = double("round", result: winning_result)
        player = Player.new(name: "Darth Vader", money: 10_000)
        allow(RouletteGame).to receive(:pick_color).and_return(winning_result)
        player_wager= PlayerWager.new(player: player, raining: false, round: round)

        result = player_wager.winner?

        expect(result).to be true
      end
    end
  end

  def between_8_and_15_percent_of(value)
    starting_value = (value * 0.08).ceil
    ending_value = (value * 0.15).ceil
    (starting_value..ending_value)
  end

  def between_4_and_10_percent_of(value)
    starting_value = (value * 0.04).ceil
    ending_value = (value * 0.10).ceil
    (starting_value..ending_value)
  end
end
