require 'sinatra'
require 'rom'
require 'rom-sql'
require_relative 'helpers'
require_relative './serializers/ranking_serializer'
require_relative './serializers/cutoffs_serializer'

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

get '/rankings/:edition/global/names/:name' do
  players = ranking_repo(rom).by_name(params[:name], params[:edition].to_i)
  halt_if_not_found(players)
  data = []
  players.each do |player|
    json = RankingSerializer.new(player, true).as_json
    data.push(json)
  end
  data.to_json
end

get '/rankings/:edition/:day/:id' do
  day = parse_day(params[:day])
  player = ranking_repo(rom).by_id_and_day(params[:id].to_i, params[:edition].to_i, day)
  halt_if_not_found(player)
  data = RankingSerializer.new(player, false).as_json
  data.to_json
end

get '/cutoffs/newest' do
  cutoffs = CutoffsSerializer.new(cutoffs_repo(rom).most_recent).as_json
  halt_if_not_found(cutoffs)
  cutoffs.to_json
end
