module LotteryHelper

  def generate_pick_combo(balls)
    ball_str=''
    balls.times do
      ball_str += rand(0..9).to_s
    end
    ball_str
  end

  def number_of_days_to_play(end_date)
    date_end = Date.strptime(end_date, "%Y-%m-%d")
    number_of_days = (date_end - Date.today).to_i
    number_of_days
  end

  def weeks_to_play(number_of_days)
    (number_of_days / 7.0).ceil
  end


end
