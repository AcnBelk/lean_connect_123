

def prices : List Float := [45.0, 48.0, 52.0, 49.0, 55.0]

-- Helper function: carry cash and position through the list
def tradeStrategyHelper : List Float → (Float × Float) → Float → (Float × Float)
  | [], acc, _ => acc
  | price::rest, acc@(cash, position), _ =>
    if price < 50 then
      -- Buy 1 unit
      tradeStrategyHelper rest (cash - price, position + 1) price
    else if price > 50 then

      tradeStrategyHelper rest (cash + position * price, 0) price
    else
      tradeStrategyHelper rest acc price

-- Functional simulation of a simple trading strategy
def tradeStrategy : List Float → Float
  | [] => 0.0
  | price::rest =>
    let result := tradeStrategyHelper rest (0.0, 0.0) price
    result.1 + result.2 * price  -- result.1 = cash, result.2 = position

#eval tradeStrategy prices
