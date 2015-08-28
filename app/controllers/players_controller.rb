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
    @results = simulate_lineup(params[:file], params[:game], params[:limit])
    respond_to do |format|
      format.html { render :partial => 'baseball'}
    end
  end

  def fantasybaseball
    @results = simulate_lineup(params[:file], params[:game], params[:limit])
    respond_to do |format|
      format.html { render :partial => 'baseball'}
    end
  end

end
