class RankingSerializer
  def initialize(data)
    @data = data
  end

  def as_json
    {
      name: @data.player.name,
      id: @data.player.id,
      rank: @data.player_rank,
      position: @data.position,
      points: @data.points,
      total_battles: @data.total_battles
    }.to_json
  end
end
