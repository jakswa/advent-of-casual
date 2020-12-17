require 'roda'
require './lib/leaderboard'

class App < Roda
  plugin :public

  route do |r|
    r.public

    r.root do
      r.redirect '/leaderboard.html'
    end

    r.get 'leaderboard', [Integer, true] do |year|
      response['Content-Type'] = 'application/json'
      Leaderboard.api_response(year: year || 2020)
    end

  end
end

run App.freeze.app
