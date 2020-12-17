require 'httparty'

class Leaderboard
  AOC_COOKIE = "session=#{ENV.fetch('AOC_SESSION')}".freeze
  CACHE_AGE = 900 # seconds
  URL = 'https://adventofcode.com/2020/leaderboard/private/view/29193.json'.freeze

  def self.api_response
    return @response if use_cache?
    @cached_at = Time.now.to_i
    @response = HTTParty.get(URL, headers: headers).body
  end

  def self.headers
    { 'Cookie' => AOC_COOKIE }
  end

  def self.use_cache?
    @cached_at && @cached_at > (Time.now.to_i - CACHE_AGE)
  end
end
