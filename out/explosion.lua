local function _0_(self, explosion)
  do end (self.quad):setViewport(explosion.flags["t-x"], explosion.flags["t-y"], self.size, self.size, (self.image):getDimensions())
  return love.graphics.draw(self.image, self.quad, explosion.pos.x, explosion.pos.y, 0, explosion.flags["f-x"], explosion.flags["f-y"], (self.size / 2), (self.size / 2))
end
local function _1_(self)
  self.image = love.graphics.newImage("img/explosions.png")
  do end (self.image):setFilter("nearest", "nearest")
  self.quad = love.graphics.newQuad(0, 0, self.size, self.size, self.image)
  return nil
end
local function _2_(self, explosion)
  explosion["draw-level"] = 5
  explosion.flags["t-x"] = 0
  explosion.flags["t-y"] = 0
  if (math.random() < 0.5) then
    explosion.flags["f-x"] = 1
  else
    explosion.flags["f-x"] = -1
  end
  if (math.random() < 0.5) then
    explosion.flags["f-y"] = 1
  else
    explosion.flags["f-y"] = -1
  end
  if explosion.flags.big then
    explosion.flags["f-x"] = (explosion.flags["f-x"] * 2)
    explosion.flags["f-y"] = (explosion.flags["f-y"] * 2)
  end
  if explosion.flags.small then
    explosion.flags["f-x"] = (explosion.flags["f-x"] / 2)
    explosion.flags["f-y"] = (explosion.flags["f-y"] / 2)
    return nil
  end
end
local function _3_(self, explosion)
  local interval = 5
  local frame = 0
  if (explosion.clock >= interval) then
    frame = 1
  end
  if (explosion.clock >= (interval * 2)) then
    frame = 2
  end
  if (explosion.clock >= (interval * 3)) then
    frame = 3
  end
  if (explosion.clock >= (interval * 4)) then
    frame = 4
  end
  if (explosion.clock >= (interval * 5)) then
    explosion.active = false
  end
  explosion.flags["t-x"] = (self.size * frame)
  explosion.flags["t-y"] = (self.size * (explosion.flags.color - 1))
  return nil
end
return {draw = _0_, image = nil, load = _1_, quad = nil, size = 32, spawn = _2_, update = _3_}
