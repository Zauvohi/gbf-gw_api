require_relative './repos/ranking_repo'
require_relative './repos/cutoffs_repo'
require 'dotenv'

Dotenv.load

helpers do
  def create_container
    ROM.container(
      :sql,
      "#{ENV['DB_CONN']}",
      username: "#{ENV['DB_USER']}",
      password: "#{ENV['DB_PASS']}"
    )
  end

  def ranking_repo
    container = create_container
    RankingRepo.new(container)
  end

  def cutoffs_repo
    container = create_container
    CutoffsRepo.new(container)
  end

  def halt_if_not_found(obj)
    halt(404, { message: 'No found' }.to_json) if (obj.nil? || obj.empty?)
  end
end
