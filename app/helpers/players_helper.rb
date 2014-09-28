module PlayersHelper
  require 'nokogiri'
  require 'open-uri'
  require 'json'

  class Player
    attr_accessor :name, :pos, :salary, :status, :fixture, :fppg

    def initialize(opts = {})
      @name = opts[:name]
      @pos = opts[:pos]
      @salary = opts[:salary]
      @status = opts[:status]
      @fppg = opts[:fppg]
      @fixture = opts[:fixture]
    end

  end

  def pick_players(opts = {})
    opts.each { |key, value| make_selection(key,value) }
  end

  def make_selection(position, picks)
    picks.times do
      pick = rand(0..@players.length-1)
      until (@players[pick].pos == position.to_s && @players[pick].name[-1..-1] !~ /O|Q|A/)
        pick = rand(0..@players.length-1)
      end
      @playlist.push(@players[pick])
      @total_salary += @players[pick].salary
      @total_fppg += @players[pick].fppg
    end
  end

  def simulate_lineup
    f = File.open("files/fanduel.html")
    page = Nokogiri::HTML(f)
    f.close
    @players = []
    @playlist = []
    @total_salary = 0
    @total_fppg = 0
    @salary_limit = 60000
    @pppg_target = 90

    page.css("tr[id*='playerListPlayerId']").each do |tr|
      pos, name, fppg, played, fixture, salary = tr.xpath('./td')
      salary = salary.text.gsub(/\D/,'').to_i
      fppg = fppg.text.to_i
      p = Player.new(name: name.text, pos: pos.text, fppg: fppg, fixture: fixture.text, salary: salary)
      @players.push(p)
    end

    loop do
      @total_salary = 0
      @total_fppg = 0
      @playlist = []
      pick_players(QB: 1, RB: 2, WR: 3, TE: 1, K: 1, D: 1)
      break if ((@total_salary == @salary_limit) && ( (@total_fppg > @pppg_target) && (@total_fppg <= @pppg_target + 10) ))
    end

    results = {}
    results = {list: @playlist, fppg: @total_fppg, salary: @total_salary}
    results
  end

end
