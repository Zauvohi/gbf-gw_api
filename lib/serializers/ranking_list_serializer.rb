class RankingListSerializer
  def initialize(data, key)
    @data = data # an array, already sorted
    @key = key # symbol, :day or :number
  end

  def to_h
    last = @data.last
    {
      name: last.player.name,
      id: last.player.id,
      rank: last.player_rank,
      list: rankings_list
    }
  end

  def as_json
    self.to_h.to_json
  end

  private

  def rankings_list
    data = {}
    @data.each do |ranking|
      data[ranking[@key]] = {
        position: ranking.position,
        points: ranking.points,
        total_battles: ranking.total_battles
      }
    end
    data
  end
end
