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
    @tries=try_to_match(balls, highest)
    respond_to do |format|
      format.html { render :partial => 'results'}
    end
  end

  def lifedeath
    @simmsg="Simulate"
  end

  def lifesimulate
    odds = params[:odds].to_i
    selection = rand(0..(odds-1))
    attempt = rand(0..(odds-1))
    @msg = "This event did NOT occur in your lifetime."
    if(selection == attempt)
      @msg = "This event occurred at some point in your life."
    end
    respond_to do |format|
      format.html { render :partial => 'simresults'}
    end
  end

end
