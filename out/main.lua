maid64 = require("lib.maid")
hex = require("lib.hex")
hc = require("lib.hc")
gradient = require("lib.gradient")
g3d = require("lib.g3d")
runhack = require("lib.runhack")
g = require("_globals")
saveload = require("saveload")
controls = require("controls")
start = require("start")
background = require("background")
player = require("player")
ent = require("entities")
level = require("level")
chrome = require("chrome")
love.load = function()
  math.randomseed(1419)
  love.window.setTitle("AHHHH!!! ARGHHHH!!!! AHHHHHHHH!!!!!!")
  love.window.setMode((g.width * g.scale), (g.height * g.scale), {minheight = g.height, minwidth = g.width, resizable = true, vsync = false, x = 0, y = 0})
  maid64.setup(g.width, g.height)
  love.graphics.setFont(g.font)
  love.graphics.setLineStyle("rough")
  love.graphics.setLineWidth(1)
  saveload:load()
  controls:load()
  return start:load()
end
local function update_game()
  player:update()
  background:update()
  ent:update()
  level:update()
  saveload:update()
  if (g["kill-bullet-clock"] > 0) then
    g["kill-bullet-clock"] = (g["kill-bullet-clock"] - 1)
    return nil
  end
end
love.update = function(dt)
  controls:update()
  if g.started then
    return update_game()
  else
    return start:update()
  end
end
local function draw_game()
  background:draw()
  ent:draw()
  player:draw()
  return chrome:draw()
end
love.draw = function()
  maid64.start()
  if g.started then
    draw_game()
  else
    start:draw()
  end
  return maid64.finish()
end
love.resize = function(width, height)
  return maid64.resize(width, height)
end
love.run = function()
  return runhack()
end
return love.run
