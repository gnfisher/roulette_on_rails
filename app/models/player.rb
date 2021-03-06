class Player < ActiveRecord::Base
  validates :name, presence: true
  validates :money, numericality: { greater_than_or_equal_to: 0 }

  def self.active
    where(money: 1..Float::INFINITY)
  end

  def self.by_money
    all.order(money: :desc)
  end
end
