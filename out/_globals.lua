local masks = {half = love.graphics.newImage("img/masks/half.png"), least = love.graphics.newImage("img/masks/least.png"), most = love.graphics.newImage("img/masks/most.png")}
local mask_shader = require("lib.maskshader")
local function _0_(img, x, y, w, h, r, ox, oy, kx, ky)
  return love.graphics.draw(img, x, y, r, (w / img:getWidth()), (h / img:getHeight()), ox, oy, kx, ky)
end
local function _1_(a, b)
  return math.abs(math.atan2((b.y - a.y), (b.x - a.x)))
end
local function _2_(a, b)
  return math.sqrt((((a.x - b.x) * (a.x - b.x)) + ((a.y - b.y) * (a.y - b.y))))
end
local function _3_(vector, angle, speed)
  vector.x = (vector.x + (math.cos(angle) * speed))
  vector.y = (vector.y + (math.sin(angle) * speed))
  return vector
end
local function _4_(input)
  local score = tostring(input)
  for i = 1, (8 - #score) do
    score = ("0" .. score)
  end
  return score
end
local function _5_()
  return love.graphics.setColor(hex.rgb("ffffff"))
end
local function _6_(self, color)
  return love.graphics.setColor(self.colors[color])
end
local function _7_()
  return print("fullscreen")
end
local function _8_(entity)
  entity.velocity = {x = (math.cos(entity.angle) * entity.speed), y = (math.sin(entity.angle) * entity.speed)}
  return nil
end
local function _9_(dir, files, sprite)
  local arr = {}
  for i, file in ipairs(files) do
    local img = nil
    local _10_
    if sprite then
      _10_ = ""
    else
      _10_ = "img/"
    end
    img = love.graphics.newImage((_10_ .. dir .. "/" .. file .. ".png"))
    img:setFilter("nearest", "nearest")
    arr[file] = img
  end
  return arr
end
local function _10_(self, input, _3fx, y, _3falign, _3flimit, _3fcolor, shadow)
  local x = nil
  if _3fx then
    x = _3fx
  else
    x = 0
  end
  local align = nil
  if _3falign then
    align = _3falign
  else
    align = "left"
  end
  local limit = nil
  if _3flimit then
    limit = _3flimit
  else
    limit = self.width
  end
  local color = nil
  if _3fcolor then
    color = _3fcolor
  else
    color = "white"
  end
  self["set-color"](self, "black")
  love.graphics.printf(input, x, (y + 1), limit, align)
  love.graphics.printf(input, (x + 1), y, limit, align)
  love.graphics.printf(input, x, (y - 1), limit, align)
  love.graphics.printf(input, (x - 1), y, limit, align)
  love.graphics.printf(input, (x - 1), (y - 1), limit, align)
  love.graphics.printf(input, (x + 1), (y - 1), limit, align)
  love.graphics.printf(input, (x - 1), (y + 1), limit, align)
  love.graphics.printf(input, (x + 1), (y + 1), limit, align)
  self["set-color"](self, color)
  love.graphics.printf(input, x, y, limit, align)
  if shadow then
    local function _15_()
      self["set-color"](self, shadow)
      love.graphics.setScissor(x, (y + 9), g.width, 7)
      love.graphics.printf(input, x, y, limit, align)
      return love.graphics.setScissor()
    end
    self.mask("half", _15_)
  end
  return self["reset-color"]()
end
local function _11_(mask, callback)
  return callback()
end
return {["current-score"] = 0, ["draw-gradient"] = _0_, ["game-over"] = false, ["game-over-clock"] = 0, ["get-angle"] = _1_, ["get-distance"] = _2_, ["hard-mode"] = false, ["high-score"] = 0, ["kill-bullet-clock"] = 0, ["kill-bullet-limit"] = (60 * 2), ["move-vector"] = _3_, ["process-score"] = _4_, ["reset-color"] = _5_, ["save-table"] = nil, ["set-color"] = _6_, ["toggle-fullscreen"] = _7_, ["update-velocity"] = _8_, colors = {["blue-dark"] = hex.rgb("32535f"), ["blue-light"] = hex.rgb("74adbb"), ["brown-dark"] = hex.rgb("4f2b24"), ["brown-light"] = hex.rgb("c59154"), ["red-dark"] = hex.rgb("7d3840"), ["red-light"] = hex.rgb("e89973"), ["yellow-dark"] = hex.rgb("f0bd77"), black = hex.rgb("0d080d"), blue = hex.rgb("4180a0"), brown = hex.rgb("825b31"), gray = hex.rgb("bebbb2"), green = hex.rgb("7bb24e"), purple = hex.rgb("2a2349"), red = hex.rgb("c16c5b"), white = hex.rgb("fff9e4"), yellow = hex.rgb("fbdf9b")}, font = love.graphics.newFont("font/Natural Pro.ttf", 16), grid = 16, height = 240, images = _9_, label = _10_, mask = _11_, phi = 1.61803398875, scale = 3, started = false, tau = (math.pi * 2), width = 320}
