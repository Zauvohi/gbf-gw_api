require 'dotenv'
require_relative './repos/ranking_repo'
Dotenv.load

helpers do
  def ranking_repo
    container = ROM.container(:sql, "#{ENV['DB_CONN']}" + '/gw_rankings')
    RankingRepo.new(container)
  end

end
