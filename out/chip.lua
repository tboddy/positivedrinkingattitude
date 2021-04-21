local function _0_(self, entity)
  do end (self.quad):setViewport(entity.flags["t-x"], entity.flags["t-y"], self.size, self.size, (self.image):getDimensions())
  return love.graphics.draw(self.image, self.quad, entity.pos.x, entity.pos.y, 0, entity.flags["f-x"], entity.flags["f-y"], (self.size / 2), (self.size / 2))
end
local function _1_(self)
  self.image = love.graphics.newImage("img/explosions.png")
  do end (self.image):setFilter("nearest", "nearest")
  self.quad = love.graphics.newQuad(0, 0, self.size, self.size, self.image)
  return nil
end
local function _2_(self, entity)
  entity["draw-level"] = 5
  entity.flags["t-x"] = 0
  entity.flags["t-y"] = 0
  if (math.random() < 0.5) then
    entity.flags["f-x"] = 1
  else
    entity.flags["f-x"] = -1
  end
  if (math.random() < 0.5) then
    entity.flags["f-y"] = 1
  else
    entity.flags["f-y"] = -1
  end
  if entity.flags.big then
    entity.flags["f-x"] = (entity.flags["f-x"] * 2)
    entity.flags["f-y"] = (entity.flags["f-y"] * 2)
  end
  if entity.flags.small then
    entity.flags["f-x"] = (entity.flags["f-x"] / 2)
    entity.flags["f-y"] = (entity.flags["f-y"] / 2)
    return nil
  end
end
local function _3_(self, entity)
end
return {draw = _0_, image = nil, load = _1_, quad = nil, size = 32, spawn = _2_, update = _3_}
