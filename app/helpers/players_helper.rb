module PlayersHelper
  require 'nokogiri'
  require 'open-uri'
  require 'json'
  require 'csv'

  class SportsPlayer
    attr_accessor :name, :pos, :salary, :status, :fixture, :fppg, :next_opp, :injury

    def initialize(opts = {})
      @name = opts[:name]
      @pos = opts[:pos]
      @salary = opts[:salary]
      @status = opts[:status]
      @fppg = opts[:fppg]
      @fixture = opts[:fixture]
      @next_opp = opts[:next_opp]
      @injury = opts[:injury]
    end

    def self.baseball_pos
      {B1: '1B', B2: '2B', B3: '3B', SS: 'SS', C: 'C', P: 'P', OF: 'OF'}
    end

  end

  def pick_players(opts = {})
    opts.each { |key, value| make_selection(key,value) }
  end

  def make_selection(position, picks)
    picks.times do
      pick = rand(0..@players.length-1)
      until (@players[pick].pos == SportsPlayer.baseball_pos[position] && @players[pick].injury == "" && @players[pick].salary > @min_salary )
        pick = rand(0..@players.length-1)
      end
      @playlist.push(@players[pick])
      @total_salary += @players[pick].salary
      @total_fppg += @players[pick].fppg
    end
  end

  def simulate_lineup(file, game, limit)
    results = {}
    rowArray = Array.new
    myFile = params[:file]
    CSV.foreach(myFile.path) do |row|
      rowArray << row
      @row_data = rowArray
    end

    @players = []
    @playlist = []
    @total_salary = 0
    @total_fppg = 0
    @salary_limit = limit.to_i

    collect_players(game, @row_data)
    optimize_lineup(game)

    results = {list: @playlist, fppg: @total_fppg, salary: @total_salary}
    results
  end

  def optimize_lineup(game)
    loop do
      @total_salary = 0
      @total_fppg = 0
      @playlist = []
      if game == 'baseball'
        @pppg_target = 25
        @min_salary = 2900
        pick_players(P: 1, B2: 1, SS: 1, B1: 1, B3: 1, C: 1, OF: 3)
        break if (((@total_salary > (@salary_limit - 1000) && (@total_salary <= @salary_limit))) && ((@total_fppg > @pppg_target) &&
            (@total_fppg <= @pppg_target + 30)) && (@playlist.uniq.length == @playlist.length))
      end
    end
  end

  def collect_players(game, rows)
    rows.each do |row|
      p = SportsPlayer.new(name: row[1] + ' ' + row[2], pos: row[0], fppg: row[3].to_i, fixture: row[6], salary: row[5].to_i,
                              next_opp: row[8], injury: row[9])
      @players.push(p)
    end
    @players
  end

end
