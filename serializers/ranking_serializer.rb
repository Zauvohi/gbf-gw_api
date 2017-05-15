class RankingSerializer
  def initialize(player_data)
    @player_data = player_data
    @player_info = player_data.last
    @total_battles = 0
  end

  def as_json
    return { errors: "No data." } if @player_data.nil?
    {
      name: @player_info.player_name,
      id: @player_info.player_id,
      rank: @player_info.player_rank,
      position: final_position,
      ranking_points: ranking_data,
      total_battles: @total_battles
    }
  end

  private

  def final_position
    last_day = @player_data[6]
    last_day.nil? ? nil : last_day.position
  end

  def ranking_data
    days = %w(prelims interlude 1 2 3 4 5)
    rankings = []
    days.each_with_index do |day, i|
      if @player_data[i].nil?
        rankings << 0
      else
        rankings << @player_data[i].points
        @total_battles += @player_data[i].total_battles
      end
    end
    rankings
  end
end
