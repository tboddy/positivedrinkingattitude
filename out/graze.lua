local function _0_(self, graze)
  local function _1_()
    return love.graphics.draw(self.image, self.quad, graze.pos.x, graze.pos.y, graze.rotation, 1, 1, ((self.image):getWidth() / 2), ((self.image):getHeight() / 2))
  end
  return g.mask("half", _1_)
end
local function _1_(self)
  self.image = love.graphics.newImage("img/player/graze.png")
  do end (self.image):setFilter("nearest", "nearest")
  self.quad = love.graphics.newQuad(0, 0, (self.image):getWidth(), (self.image):getHeight(), self.image)
  return nil
end
local function _2_(self, graze)
  graze["draw-level"] = 5
  local angle = g["get-angle"](player.pos, graze.pos)
  local speed = 1
  graze.velocity = {x = (math.cos(angle) * speed), y = (math.sin(angle) * speed)}
  graze.flags.direction = (math.random() < 0.5)
  g["current-score"] = (g["current-score"] + 10)
  return nil
end
local function _3_(self, graze)
  graze.pos.x = (graze.pos.x + graze.velocity.x)
  graze.pos.y = (graze.pos.y + graze.velocity.y)
  if (graze.clock >= 15) then
    graze.active = false
    return nil
  end
end
return {draw = _0_, image = nil, load = _1_, quad = nil, spawn = _2_, update = _3_}
