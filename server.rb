require 'sinatra'
require 'rom'
require 'rom-sql'
require_relative 'helpers'
require_relative './serializers/ranking_serializer'

# Endpoints
before do
  content_type 'application/json', charset: 'utf-8'
  # headers 'Access-Control-Allow-Origin' => '*'
end

get '/' do
  'Hello there!'
end

get '/rankings/:edition/global/:id' do
  player = ranking_repo.by_id(params[:id].to_i, params[:edition].to_i)
  halt_if_not_found(player)
  data = RankingSerializer.new(player, true).as_json
  data.to_json
end

get '/rankings/:edition/global/names/:name' do
  players = ranking_repo.by_name(params[:name], params[:edition].to_i)
  halt_if_not_found(players)
  data = []
  players.each do |player|
    json = RankingSerializer.new(player, true).as_json
    data.push(json)
  end
  data.to_json
end

get '/rankings/:edition/:day/:id' do
  player = ranking_repo.by_id_and_day(params[:id].to_i, params[:edition].to_i, params[:day])
  halt_if_not_found(player)
  data = RankingSerializer.new(player, false).as_json
  data.to_json
end
