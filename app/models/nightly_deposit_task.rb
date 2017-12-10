class NightlyDepositTask
  include Delayed::RecurringJob

  run_every 1.day
  run_at '00:01am'
  timezone 'Santiago'

  def perform
    players.each do |player|
      NightlyDepositJob.perform_later(player_id: player.id)
    end
  end

  private

  def players
    Player.all
  end
end

