class WagersSortedByRoundQuery
  def initialize(page)
    @page = page
  end

  def run
    sorted_query.page(@page)
  end

  private

  def sorted_query
    Wager.
      all.
      includes(:round, :player).
      order(round_id: :desc, created_at: :desc)
  end
end
