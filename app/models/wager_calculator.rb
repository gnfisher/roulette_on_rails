class WagerCalculator
  def initialize(player:, round:)
    @player = player
    @round = round
  end

  def calculate
    if money < 1_001
      money
    elsif @round.raining
      between_4_and_10_percent
    else
      between_8_and_15_percent
    end
  end

  private

  def money
    @player.money
  end

  def between_4_and_10_percent
    start_value = (money * 0.04).ceil
    end_value = (money * 0.10).ceil
    Array(start_value..end_value).sample
  end

  def between_8_and_15_percent
    start_value = (money * 0.08).ceil
    end_value = (money * 0.15).ceil
    Array(start_value..end_value).sample
  end
end
