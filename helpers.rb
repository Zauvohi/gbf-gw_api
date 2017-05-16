require 'dotenv'
require_relative './repos/ranking_repo'
Dotenv.load

helpers do
  def ranking_repo
    container = ROM.container(:sql, "#{ENV['DB_CONN']}" + '/gw_rankings')
    RankingRepo.new(container)
  end

  def halt_if_not_found(obj)
    halt(404, { message: 'No found' }.to_json) if (obj.nil? || obj.empty?)
  end
end
