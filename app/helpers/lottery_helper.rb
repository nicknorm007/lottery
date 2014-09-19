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
    combo_arr = ball_arr.combination(balls).to_a
    selection = rand(0..combo_arr.length-1)
    combo_arr[selection]
  end

  def try_to_match(balls, highest)
    ball_arr = []
    count=0
    (1..highest).each do |n|
      ball_arr.push(n)
    end
    combo_arr = ball_arr.combination(balls).to_a
    selection = rand(0..combo_arr.length-1)
    match_selection = rand(0..combo_arr.length-1)
    until (match_selection == selection)
      match_selection = rand(0..combo_arr.length-1)
      count +=1
    end
    count
  end

  def generate_odds_from_ball_combo(balls, highest)
    numerator = (1..highest).inject(:*) || 1
    diff = highest - balls
    denominator_part = (1..diff).inject(:*) || 1
    denominator_multiplier = (1..balls).inject(:*) || 1
    odds = numerator / (denominator_multiplier * denominator_part)
    odds
  end

  def do_coin_sim numflips
    total_heads,total_tails,previous,streak_count,high_row=0,0,0,1,0
    numflips.times do
      coinflip = rand(1..2)
      if coinflip==Coin::HEADS
        total_heads += 1
        if previous==Coin::HEADS
          streak_count += 1
          if high_row < streak_count
            high_row = streak_count
          end
        else
          streak_count=1
        end
        previous=Coin::HEADS
      else
        total_tails += 1
        if previous==Coin::TAILS
          streak_count += 1
          if high_row < streak_count
            high_row = streak_count
          end
        else
          streak_count=1
        end
        previous=Coin::TAILS
      end
    end
  end

end
