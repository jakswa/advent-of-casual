require 'roda'
require './lib/leaderboard'

class App < Roda
  plugin :public

  route do |r|
    r.public

    r.root do
      r.redirect '/leaderboard.html'
    end

    r.get 'leaderboard' do
      response['Content-Type'] = 'application/json'
      year = r.params.fetch('year', Time.now.year.to_s)
      board = r.params.fetch('board', '29193')
      Leaderboard.api_response(year: year, board: board) 
    end
  end
end

run App.freeze.app
