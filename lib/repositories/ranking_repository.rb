require 'rom-repository'

class RankingRepository < ROM::Repository[:rankings]
  relations :players, :editions

  def by_id(**args)
    rankings.where(
      player_id: args[:player_id],
      edition_id: args[:edition_id],
      day: args[:day]
    ).wrap(
      player: [players, id: args[:player_id]]
    ).one
  end

  def list_by_id(player_id:, edition_id:)
    rankings.where(
      player_id: player_id,
      edition_id: edition_id
    ).order { day.asc }
    .wrap(
      player: [players, id: player_id]
    ).to_a
  end

  def global_by_id(player_id:)
    rankings.where(
      player_id: player_id,
      day: 5
    ).wrap_parent(
      edition: editions
    ).order { edition_id.asc }
    .wrap(
      player: [players, id: player_id]
    ).to_a
  end

  def by_name(name, edition)
    players = []
    ids = rankings.select(:player_id)
                  .where(player_name: name, edition: edition)
                  .order(:player_id)
                  .distinct(:player_id)
                  .pluck(:player_id)
    ids.each { |id| players.push(self.by_id(id, edition)) }
    players
  end
end
