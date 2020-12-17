require 'roda'
require './lib/leaderboard'

class App < Roda
  plugin :public

  route do |r|
    r.public

    r.root do
      r.redirect '/leaderboard.html'
    end

    r.get 'leaderboard.json' do
      response['Content-Type'] = 'application/json'
      Leaderboard.api_response
    end

  end
end

run App.freeze.app
