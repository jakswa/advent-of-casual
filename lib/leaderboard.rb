require 'httparty'

class Leaderboard
  AOC_COOKIE = "session=#{ENV.fetch('AOC_SESSION')}".freeze
  CACHE_AGE = 900 # seconds
  URL = 'https://adventofcode.com/%s/leaderboard/private/view/29193.json'.freeze
  @cache = {}
  @responses = {}

  def self.api_response(year: Time.now.year)
    return @responses[year] if use_cache?(year)

    @cache[year] = Time.now.to_i
    @responses[year] = HTTParty.get(format(URL, year), headers: headers).body
  end

  def self.headers
    { 'Cookie' => AOC_COOKIE }
  end

  def self.use_cache?(year)
    @cache[year] && @cache[year] > (Time.now.to_i - CACHE_AGE)
  end
end
