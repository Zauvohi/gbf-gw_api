class RankingSerializer
  def initialize(data)
    @data = data
  end

  def to_h
    {
      name: @data.player.name,
      id: @data.player.id,
      rank: @data.player_rank,
      position: @data.position,
      points: @data.points,
      total_battles: @data.total_battles
    }
  end

  def as_json
    self.to_h.to_json
  end
end
