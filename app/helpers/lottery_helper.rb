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

  def seven_or_remainder(num_weeks, days, week_num)
    leftover = days % 7
    if week_num == num_weeks
      if leftover==0
        return 7
      else
        return leftover
      end
    else
      return 7
    end
  end

  def generate_ball_combo(balls, highest)
    ball_arr = []
    (1..highest).each do |n|
      ball_arr.push(n)
    end
    ball_arr.combination(balls).to_a.length
  end

  def generate_odds_from_ball_combo(balls, highest)
    numerator = (1..highest).inject(:*) || 1
    diff = highest - balls
    denominator_part = (1..diff).inject(:*) || 1
    denominator_multiplier = (1..balls).inject(:*) || 1
    odds = numerator / (denominator_multiplier * denominator_part)
    odds
  end

end
