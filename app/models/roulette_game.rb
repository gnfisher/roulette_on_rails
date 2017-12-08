class RouletteGame
  def self.pick_color
    case Array(1..100).sample
    when 1..2
      "green"
    when 3..51
      "red"
    when 52..100
      "black"
    end
  end
end
