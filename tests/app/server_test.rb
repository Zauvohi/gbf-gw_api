require File.expand_path '../../test_helper.rb', __FILE__

class ServerTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    # Random player, shares name with another one.
    @player =  {  name: "Tori",
                  id: 6180448,
                  rank: 149,
                  position: 39945,
                  ranking_points: [
                    6721494,
                    6721494,
                    13530084,
                    23632376,
                    26808000,
                    29375762,
                    49550812
                  ],
                  total_battles: 248
                }
    @day = "prelims" # days are prelims and from 1 to 5
    @edition = 29 # currenly only 29 is fully added in the DB
  end

  def test_hello_world
    get '/'
    assert last_response.ok?
    assert_equal "Hello there!", last_response.body
  end

  def test_get_player_by_id_single_day
    get "/rankings/#{@edition}/#{@day}/#{@player[:id]}"
    assert last_response.ok?
    parsed_response = JSON.parse(last_response.body)
    assert_equal @player[:id], parsed_response['id'], "Player ID did not match."
  end

  def test_get_player_by_id_global_results
    get "/rankings/#{@edition}/global/#{@player[:id]}"
    assert last_response.ok?
    parsed_response = JSON.parse(last_response.body)
    response_points = parsed_response['ranking_points'].inject(:+)
    player_points = @player[:ranking_points].inject(:+)
    assert_equal response_points, player_points, "Points did not match."
  end

  def test_get_players_by_name
    get "/rankings/#{@edition}/global/names/#{@player[:name]}"
    assert last_response.ok?
    parsed_response = JSON.parse(last_response.body)
    assert parsed_response.size == 2, "Response did not equal 2."
  end

  def test_get_lastest_cutoffs
    get '/cutoffs/newest'
    assert last_response.ok?
    parsed_response = JSON.parse(last_response.body)
    assert parsed_response['top20k'] > 0, "Did not bring any points."
  end
end
