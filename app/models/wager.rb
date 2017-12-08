class Wager < ActiveRecord::Base
  belongs_to :player
  belongs_to :round

  validates :player, presence: true
  validates :round, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :color_guessed,
    presence: true,
    inclusion: {
      in: %w(red green black),
      message: "%{value} is not a valid color"
    }
  validates :winnings, presence: true
end
