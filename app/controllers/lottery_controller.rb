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

end
