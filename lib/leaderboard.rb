require 'httparty'

class Leaderboard
  AOC_COOKIE = "session=#{ENV.fetch('AOC_SESSION')}".freeze
  CACHE_AGE = 900 # seconds
  URL = 'https://adventofcode.com/%s/leaderboard/private/view/%s.json'.freeze
  @cache = {}
  @responses = {}

  def self.api_response(year: , board: )
    cache_key = [year, board]
    return @responses[cache_key] if use_cache?(cache_key)

    @cache[cache_key] = Time.now.to_i
    @responses[cache_key] = HTTParty.get(format(URL, year, board), headers: headers).body
  end

  def self.headers
    { 'Cookie' => AOC_COOKIE }
  end

  def self.use_cache?(key)
    @cache[key] && @cache[key] > (Time.now.to_i - CACHE_AGE)
  end
end
