include PlayersHelper
class PlayersController < ApplicationController

  def fantasy
    @lineup_msg = "Generate a fanduel fantasy football lineup!"
  end

  def basketball
    @lineup_basket = "Generate a fanduel fantasy basketball lineup!"
  end

  def fantasybasketball
    @results = simulate_lineup(params[:myurl], params[:game])
    respond_to do |format|
      format.html { render :partial => 'basket'}
    end
  end

  def fantasyresults
    @results = simulate_lineup(params[:myurl], params[:game])
    respond_to do |format|
      format.html { render :partial => 'lineup'}
    end
  end

end
