class Array 
  def stock_picker
    highest_profit = 0 
    best_sell_period = nil

    each_with_index do |price1, day1|
      ((day1 + 1)...length).each do |day2|
        price2 = self[day2]
        profit = price2 - price1

        if profit > highest_profit
          highest_profit, best_sell_period = profit, [day1, day2]
        end
      end
    end

    best_sell_period
  end
end

if $PROGRAM_NAME == __FILE__
  p [1, 3, 10, 2, -4, 9].stock_picker == [4, 5]
end
