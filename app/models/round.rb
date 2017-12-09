class Round < ActiveRecord::Base
  has_many :wagers

  validates :result, presence: true, inclusion: { in: %w(red green black) }
  validates :raining, inclusion: { in: [true, false] }
end
