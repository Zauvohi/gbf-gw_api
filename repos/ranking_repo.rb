require 'rom-repository'

class RankingRepo < ROM::Repository[:rankings]
  def by_id(id, edition)
    rankings.where(player_id: id, edition: edition).to_a
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

  def by_id_and_day(id, edition, day)
    data = rankings.where(player_id: id, edition: edition, day: day).first
    data.nil? ? nil : [data]
  end
end
