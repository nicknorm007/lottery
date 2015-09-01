include PlayersHelper
class PlayersController < ApplicationController

  def fantasy
    @lineup_msg = "Generate a fanduel fantasy football lineup!"
  end

  def basketball
    @lineup_basket = "Generate a fanduel fantasy basketball lineup!"
  end

  def baseb
    @lineup_baseball = "Generate a fanduel fantasy baseball lineup!"
  end

  def fantasybasketball
    @results = {}
    @results[:errors] = "placeholder for now"
    respond_to do |format|
      format.html { render :partial => 'basket'}
    end
  end

  def fantasyresults
    row_data = read_row_data
    players = build_players_list row_data
    player = SportsLineup.new(players, params[:minsalary], params[:limit], params[:target])
    football_lineup = FootballLineup.new(player.players)
    @results = player.simulate_lineup(football_lineup, players)
    respond_to do |format|
      format.html { render :partial => 'lineup'}
    end
  end

  def fantasybaseball
    row_data = read_row_data
    players = build_players_list row_data
    player = SportsLineup.new(players,  params[:minsalary], params[:limit], params[:target])
    baseball_lineup  = BaseballLineup.new(player.players)
    @results =  player.simulate_lineup(baseball_lineup, players)
    respond_to do |format|
      format.html { render :partial => 'lineup'}
    end
  end

  def read_row_data
    rowArray = Array.new
    myFile = params[:file]
    CSV.foreach(myFile.path) do |row|
      rowArray << row
      @row_data = rowArray
    end
    @row_data
  end

  def build_players_list(row_data)
    players = Array.new
    row_data.each do |row|
      players.push({name: row[2] + ' ' + row[3], pos: row[1], fppg: row[4].to_i, fixture: row[7], 
        salary: row[6].to_i, next_opp: row[9], injury: row[10]})
    end
    players
  end

end
