class Player < ActiveRecord::Base
  validates :money, numericality: { greater_than_or_equal_to: 0 }
end
