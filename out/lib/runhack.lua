local tickRate = 1 / 60

return function()
  if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
  if love.timer then love.timer.step() end
  local lag = 0
  return function()
    if love.event then
      love.event.pump()
      for name, a,b,c,d,e,f in love.event.poll() do
        if name == 'quit' then if not love.quit or not love.quit() then return a or 0 end end
        love.handlers[name](a,b,c,d,e,f)
      end
    end
    if love.timer then lag = math.min(lag + love.timer.step(), tickRate * 25) end
    while lag >= tickRate do
      if love.update then love.update(tickRate) end
      lag = lag - tickRate
    end
    if love.graphics and love.graphics.isActive() then
      love.graphics.origin()
      love.graphics.clear(love.graphics.getBackgroundColor())
      if love.draw then love.draw() end
      love.graphics.present()
    end
    if love.timer then love.timer.sleep(0.001) end
  end
end