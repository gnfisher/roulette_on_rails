require 'rails_helper'

describe RouletteGame do
  describe ".calculate_winnings" do
    let(:wager_amount) { 100 }

    context "player didn't guess correctly" do
      it "returns 0 if the player has not guessed correctly" do
        guessed_color = "black"
        result_color = "red"
        round = double("round", result: result_color)

        result = RouletteGame.calculate_winnings(
          round: round,
          color_guessed: guessed_color,
          wager: wager_amount
        )

        expect(result).to eq 0
      end
    end

    context "player guessed correctly" do
      it "returns 15 times the wager amount if green is color" do
        guessed_color = "green"
        result_color = "green"
        round = double("round", result: result_color)

        result = RouletteGame.calculate_winnings(
          round: round,
          color_guessed: guessed_color,
          wager: wager_amount
        )

        expect(result).to eq(wager_amount * 15)
      end

      it "returns 2 times the wager amount if color is red or black" do
        guessed_color = "red"
        result_color = "red"
        round = double("round", result: result_color)

        result = RouletteGame.calculate_winnings(
          round: round,
          color_guessed: guessed_color,
          wager: wager_amount
        )

        expect(result).to eq(wager_amount * 2)
      end
    end
  end
end
