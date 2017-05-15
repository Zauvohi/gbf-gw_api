require 'sinatra'
require 'rom'
require 'rom-sql'
require_relative './helpers/helpers'
require_relative './repos/ranking_repo'
require_relative './serializers/ranking_serializer'
# DB setup
Dotenv.load

container = ROM.container(:sql, ENV['DB_CONN'] + '/gw_rankings')
@ranking_repo = RankingRepo.new(container)


def half_if_too_many

end

# Endpoints
before do
  content_type 'application/json'
end
get '/' do
  'Hello there!'
end

get 'rankings/:edition/global/:ids' do

  ids = params['ids'].map(&:to_i).keep_if { |id| id != 0 }
end

get 'rankings/:edition/global/:name' do

end

get 'rankings/:edition/:day/:id' do

end
