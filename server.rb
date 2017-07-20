require 'sinatra'
require 'rom'
require 'rom-sql'
require_relative './lib/helpers'
require_relative './lib/serializers/ranking_serializer'
require_relative './lib/serializers/cutoffs_serializer'
require_relative './lib/serializers/edition_serializer'

rom = create_container

# Endpoints
before do
  content_type 'application/json', charset: 'utf-8'
  headers 'Access-Control-Allow-Origin' => '*'
end

get '/' do
  'Hello there!'
end

get '/rankings/list/:edition/:id' do
  id = params[:id].to_i
  edition = params[:edition].to_i
  data = ranking_repository(rom).list_by_id(player_id: id, edition_id: edition)
  halt_if_not_found(data)
  RankingListSerializer.new(data).as_json
end

get '/rankings/global/:id' do
  # gets all the last standings (day 5) from a player
end

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
  edition = edition_repo(rom).by_number(params[:number].to_i)
  halt_if_not_found(edition)
  EditionSerializer.new(edition).as_json
end

get '/editions' do
  editions = edition_repo(rom).all
  halt_if_not_found(editions)
  editions_list = []
  editions.each do |edition|
    editions_list << RankingSerializer.new(edition).to_h
  end
  editions_list.to_json
end

get '/cutoffs/newest' do
  cutoffs = CutoffsSerializer.new(cutoffs_repo(rom).most_recent).as_json
  halt_if_not_found(cutoffs)
  cutoffs.to_json
end
