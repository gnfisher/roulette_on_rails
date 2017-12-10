namespace :recurring do
  task init: :environment do
    RouletteGame.schedule!
    NightlyDepositTask.schedule!
  end
end
