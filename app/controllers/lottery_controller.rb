include LotteryHelper
include ActionView::Helpers::NumberHelper

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
    balls = params[:balls].to_i
    highest = params[:highest].to_i
    tries=try_to_match(balls, highest)
    winmsg = "It took #{tries} days to win. That's about #{number_with_precision(tries/365, :precision => 1)} years."
    respond_to do |format|
      format.text { render :text => winmsg}
    end
  end

end
