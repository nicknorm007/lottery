module PlayersHelper
  require 'nokogiri'
  require 'open-uri'
  require 'json'
  require 'csv'

  class SportsLineup
    attr_accessor :players, :min_salary

    def initialize(players, min_salary, limit, target)
      @players = players
      @min_salary = min_salary
      @salary_limit = limit
      @pppg_target = target
      @total_salary = 0
      @total_fppg = 0
      @playlist = []
    end

    def simulate_lineup(lineup, players)
      results = {}
      lineup.optimize_lineup
      results = {list: @playlist, fppg: @total_fppg, salary: @total_salary}
      results
    end

    def pick_players(opts = {})
      opts.each { |key, value| make_selection(key,value) }
    end

    def make_selection(position, picks)
      picks.times do
        pick = rand(0..@players.length-1)
        until (@players[pick][:pos] == positions[position] && @players[pick][:injury] == "" && @players[pick][:salary] > @min_salary )
          pick = rand(0..@players.length-1)
        end
        @playlist.push(@players[pick])
        @total_salary += @players[pick][:salary]
        @total_fppg += @players[pick][:fppg]
      end
    end

  end

  class BaseballLineup < SportsLineup
    
    def positions
      {B1: '1B', B2: '2B', B3: '3B', SS: 'SS', C: 'C', P: 'P', OF: 'OF'}
    end

    def optimize_lineup
      loop do
        pick_players(P: 1, B2: 1, SS: 1, B1: 1, B3: 1, C: 1, OF: 3)
        break if (((@total_salary > (@salary_limit - 1000) && (@total_salary <= @salary_limit))) && ((@total_fppg > @pppg_target) &&
            (@total_fppg <= @pppg_target + 30)) && (@playlist.uniq.length == @playlist.length))
      end
    end 
  end

  class FootballLineup < SportsLineup

    def positions
      {QB: 'QB', RB: 'RB', WR: 'WR', TE: 'TE', K: 'K', D: 'D'}
    end

    def optimize_lineup
      loop do
        pick_players(QB: 1, WR: 3, RB: 2, TE: 1, K: 1, D: 1)
        break if (((@total_salary > (@salary_limit - 1000) && (@total_salary <= @salary_limit))) && ((@total_fppg > @pppg_target) &&
            (@total_fppg <= @pppg_target + 30)) && (@playlist.uniq.length == @playlist.length))
      end
    end
  end
end