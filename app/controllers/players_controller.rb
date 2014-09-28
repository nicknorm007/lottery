include PlayersHelper
class PlayersController < ApplicationController

  def fantasy
    @lineup_msg = "Generate a fanduel fantasy football lineup!"
  end

  def fantasyresults
    @results = simulate_lineup
    respond_to do |format|
      format.html { render :partial => 'lineup'}
    end
  end

end
