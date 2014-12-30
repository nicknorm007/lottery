module PlayersHelper
  require 'nokogiri'
  require 'open-uri'
  require 'json'

  class SportsPlayer
    attr_accessor :name, :pos, :salary, :status, :fixture, :fppg, :next_opp, :opp_ypl, :la_ypl,
                  :opp_ypr, :la_ypr, :opp_ypp, :la_ypp

    def initialize(opts = {})
      @name = opts[:name]
      @pos = opts[:pos]
      @salary = opts[:salary]
      @status = opts[:status]
      @fppg = opts[:fppg]
      @fixture = opts[:fixture]
      @next_opp = opts[:next_opp]
      @opp_ypl = opts[:opp_ypl]
      @la_ypl = opts[:la_ypl]
      @opp_ypr = opts[:opp_ypr]
      @la_ypr = opts[:la_ypr]
      @opp_ypp = opts[:opp_ypp]
      @la_ypp = opts[:la_ypp]
    end

    def self.abbreviations
      abbrev = {NE: 'New England', BUF: 'Buffalo', MIA: 'Miami', NYJ: 'NY Jets',
                SD: 'San Diego', DEN: 'Denver', KC: 'Kansas City', OAK: 'Oakland',
                CIN: 'Cincinnati', CLE: 'Cleveland', BAL: 'Baltimore', PIT: 'Pittsburgh',
                IND: 'Indianapolis', HOU: 'Houston', TEN: 'Tennessee', JAC: 'Jacksonville',
                PHI: 'Philadelphia', NYG: 'NY Giants', WAS: 'Washington', DAL: 'Dallas',
                ARI: 'Arizona', SEA: 'Seattle', SF: 'San Francisco', STL: 'St. Louis',
                DET: 'Detroit', GB: 'Green Bay', MIN: 'Minnesota', CHI: 'Chicago',
                CAR: 'Carolina', ATL: 'Atlanta', TB: 'Tampa Bay', NO: 'New Orleans'}
      abbrev
    end

    def self.basketball
      abbrev = {OKC: 'Oklahoma City', NO: 'New Orleans', PHO: 'Phoenix', CLE: 'Cleveland',
                ATL: 'Atlanta', PHI: 'Philadelphia', GS: 'Golden State', TOR: 'Toronto',
                POR: 'Portland', BOS: 'Boston', WAS: 'Washington', CHI: 'Chicago',
                BKN: 'Brooklyn', SA: 'San Antonio', MEM: 'Memphis', DET: 'Detroit',
                ORL: 'Orlando', LAL: 'LA Lakers', LAC: 'LA Clippers', MIN: 'Minnesota',
                HOU: 'Houston', MIA: 'Miami', MIL: 'Milwaukee', IND: 'Indiana',
                NY: 'New York', DET: 'Detroit', CHA: 'Charlotte', UTA: 'Utah',
                DAL: 'Dallas', SAC: 'Sacramento'}
      abbrev
    end

  end

  def collect_defensive_league_averages
    league_averages = []
    oddshark_url = 'http://www.oddsshark.com/nfl/defensive-stats'
    page = Nokogiri::HTML(open(oddshark_url))
    page.css("#chalk > tbody > tr:nth-child(18) > td").each do |node|
      text = node.text
      league_averages.push(text.to_f.round(2) == 0.0 ? text : text.to_f.round(2))
    end
    league_averages
  end

  def collect_team_defensive_stats
    team_averages = []
    oddshark_url = 'http://www.oddsshark.com/nfl/defensive-stats'
    page = Nokogiri::HTML(open(oddshark_url))
    page.css("#chalk tr > td > a[href*='stats/team/football']").each do |node|
      team = node.text
      team_averages.push(team.strip!)
      ele = node.parent
      until (ele.next_element.nil?) do
        tmp = ele.next_element
        team_averages.push(tmp.text)
        ele = tmp
      end
    end
    team_averages
  end

  def pick_players(opts = {})
    opts.each { |key, value| make_selection(key,value) }
  end

  def make_selection(position, picks)
    picks.times do
      pick = rand(0..@players.length-1)
      until (@players[pick].pos == position.to_s && @players[pick].name[-1..-1] !~ /O|Q|A|R|D/ && @players[pick].salary > 4500 )
        pick = rand(0..@players.length-1)
      end
      @playlist.push(@players[pick])
      @total_salary += @players[pick].salary
      @total_fppg += @players[pick].fppg
    end
  end

  def open_from_file
    f = File.open("files/fanduel.html")
    page = Nokogiri::HTML(f)
    f.close
    page
  end

  def simulate_lineup(my_url, game)
    page = nil
    results = {}
    if my_url == ""
      page = open_from_file
    else
      fanduel_url = my_url
      begin
        page = Nokogiri::HTML(open(fanduel_url))
      rescue
        results = {errors: "There was a problem reading the URL you entered."}
        return results
      end
    end
    @players = []
    @playlist = []
    @total_salary = 0
    @total_fppg = 0
    @salary_limit = 60000
    @pppg_target = 90

    unless game
      dla = collect_defensive_league_averages
      tds = collect_team_defensive_stats
    end
    page.css("tr[id*='playerListPlayerId']").each do |tr|
      pos, name, fppg, played, fixture, salary = tr.xpath('./td')
      salary = salary.text.gsub(/\D/,'').to_i
      fppg = fppg.text.to_i
      opposing_team = fixture.to_html.split("@")
      if (opposing_team[1] =~ /<b>/)
        opp = opposing_team[0].split(">")[1]
      else
        opp = opposing_team[1].split("<")[0]
      end
      team_opp = game ? SportsPlayer.basketball[opp.to_sym] : SportsPlayer.abbreviations[opp.to_sym]

      if game.nil?
        index = tds.index(team_opp)
        pl, pr, pp = 2, 6, 9
        ypl, ypr, ypp = (index + pl), (index + pr), (index + pp)
        la_ypl, la_ypr, la_ypp = dla[pl], dla[pr], dla[pp]
        opp_ypl, opp_ypr, opp_ypp = tds[ypl], tds[ypr], tds[ypp]
        p = SportsPlayer.new(name: name.text, pos: pos.text, fppg: fppg, fixture: fixture.text, salary: salary,
                            next_opp: opp, opp_ypl: opp_ypl, la_ypl: la_ypl, opp_ypr: opp_ypr, la_ypr: la_ypr,
                            opp_ypp: opp_ypp, la_ypp: la_ypp)
        @players.push(p)
      else
        p = SportsPlayer.new(name: name.text, pos: pos.text, fppg: fppg, fixture: fixture.text, salary: salary,
                             next_opp: opp)
        @players.push(p)
      end
    end

    loop do
      @total_salary = 0
      @total_fppg = 0
      @playlist = []
      pick_players(QB: 1, RB: 2, WR: 3, TE: 1, K: 1, D: 1)
      break if ( ((@total_salary > (@salary_limit - 1000) && (@total_salary <= @salary_limit) )) && ( (@total_fppg > @pppg_target) &&
          (@total_fppg <= @pppg_target + 20) ) && (@playlist.uniq.length == @playlist.length))
    end

    results = {list: @playlist, fppg: @total_fppg, salary: @total_salary}
    results
  end

end
