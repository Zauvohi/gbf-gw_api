require_relative './lib/repositories/ranking_repository'
require_relative './lib/repositories/cutoffs_repository'

helpers do
  def create_container
    ROM.container(
      :sql,
      "#{ENV['DB_CONN']}",
      username: "#{ENV['DB_USER']}",
      password: "#{ENV['DB_PASS']}"
    )
  end

  def ranking_repo(container)
    RankingRepository.new(container)
  end

  def cutoffs_repo(container)
    CutoffsRepository.new(container)
  end

  def halt_if_not_found(obj)
    halt(404, { message: 'Not found' }.to_json) if (obj.nil? || obj.empty?)
  end
end
