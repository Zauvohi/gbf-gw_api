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
    if @key == :day
      list_by_day
    else
      list_by_edition
    end
  end

  def ranking_data(ranking)
    {
      position: ranking.position,
      points: ranking.points,
      total_battles: ranking.total_battles
    }
  end

  def list_by_day
    data = {}
    @data.each do |ranking|
      data[ranking[@key]] = ranking_data(ranking)
    end
    data
  end

  def list_by_edition
    data = {}
    @data.each do |ranking|
      data[ranking.edition[@key]] = ranking_data(ranking)
    end
    data
  end
end
