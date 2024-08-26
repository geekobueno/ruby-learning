def stock_picker(prices)
    best_buy = 0
    best_sell = 0
    max_profit = 0
  
    prices.each_with_index do |buy_price, buy_day|
      (buy_day + 1...prices.length).each do |sell_day|
        sell_price = prices[sell_day]
        profit = sell_price - buy_price
        
        if profit > max_profit
          max_profit = profit
          best_buy = buy_day
          best_sell = sell_day
        end
      end
    end
  
    [best_buy, best_sell]
  end
  
  # Test the method
  puts stock_picker([17,3,6,9,15,8,6,1,10]).inspect