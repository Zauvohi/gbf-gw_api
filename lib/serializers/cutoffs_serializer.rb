class CutoffsSerializer
  def initialize(cutoffs_data)
    @cutoffs = cutoffs_data
  end

  def as_json
    return { errors: "No data." } if @cutoffs.nil?
    {
      top20k: @cutoffs[:top20k],
      top30k: @cutoffs[:top30k],
      top40k: @cutoffs[:top40k],
      top80k: @cutoffs[:top80k],
      created_at: parse_timestamp(@cutoffs[:timestamp])
    }
  end

  private

  def parse_timestamp(time)
    time.getlocal("+09:00")
  end
end
