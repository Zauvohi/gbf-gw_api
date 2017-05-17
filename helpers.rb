require_relative './repos/ranking_repo'

helpers do
  def ranking_repo
    container = ROM.container(:sql, "#{ENV['DB_CONN']}", username: "#{ENV['DB_USER']}", password: "#{ENV['DB_PASS']}")
    RankingRepo.new(container)
  end

  def halt_if_not_found(obj)
    halt(404, { message: 'No found' }.to_json) if (obj.nil? || obj.empty?)
  end
end
