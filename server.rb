require 'sinatra'
require 'rom'
require 'rom-sql'
require_relative './lib/helpers'
require_relative './lib/serializers/ranking_serializer'
require_relative './lib/serializers/cutoffs_serializer'

rom = create_container

# Endpoints
before do
  content_type 'application/json', charset: 'utf-8'
  headers 'Access-Control-Allow-Origin' => '*'
end

get '/' do
  'Hello there!'
end

get '/rankings/:edition/global/:id' do
  player = ranking_repo(rom).by_id(params[:id].to_i, params[:edition].to_i)
  halt_if_not_found(player)
  data = RankingSerializer.new(player, true).as_json
  data.to_json
end

# get '/rankings/:edition/global/names/:name' do
#   players = ranking_repo(rom).by_name(params[:name], params[:edition].to_i)
#   halt_if_not_found(players)
#   data = []
#   players.each do |player|
#     json = RankingSerializer.new(player, true).as_json
#     data.push(json)
#   end
#   data.to_json
# end

# optional query params: day (integer, from 0 to 5)
get '/rankings/:edition/:id' do
  data = {}
  if params[:day].nil?
    data[:day] = 5
  else
    data[:day] = params[:day].to_i
  end
  data[:player_id] = params[:id].to_i
  data[:edition_id] = params[:edition].to_i
  player = ranking_repo(rom).by_id(data)
  halt_if_not_found(player)
  RankingSerializer.new(player).as_json
end

get '/editions/:number' do
  # get an edition by its number
end

get '/editions' do
  # get a list of all editions
end

get '/cutoffs/newest' do
  cutoffs = CutoffsSerializer.new(cutoffs_repo(rom).most_recent).as_json
  halt_if_not_found(cutoffs)
  cutoffs.to_json
end
