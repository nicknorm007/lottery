module LotteryHelper

  def generate_pick_combo(balls)
  end

  def number_of_days_to_play(end_date)
    date_end = Date.strptime(end_date, "%Y-%m-%d")
    number_of_days = (date_end - Date.today).to_i
    number_of_days
  end
end
