class LotteryController < ApplicationController

  def index
  end

  def pick4
  end

  def pick4results
  end

  def combo
  end

  def comboresults
  end

  def simulate
    respond_to do |format|
      format.json { render :json => params[:balls].to_json }
    end
  end

end
