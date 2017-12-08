class Player < ActiveRecord::Base
  validates :money, numericality: { greater_than_or_equal_to: 0 }

  def self.active
    where(money: 1..Float::INFINITY)
  end
end
