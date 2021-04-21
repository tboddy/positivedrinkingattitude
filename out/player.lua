local function _0_(self)
  local x_limit = 5.2
  local y_limit = 3.8
  if (self.pos.x <= (0 - x_limit)) then
    self.pos.x = (0 - x_limit)
  elseif (self.pos.x >= x_limit) then
    self.pos.x = x_limit
  end
  if (self.pos.y <= (0 - y_limit)) then
    self.pos.y = (0 - y_limit)
    return nil
  elseif (self.pos.y >= y_limit) then
    self.pos.y = y_limit
    return nil
  end
end
local function _1_(self, input)
  self["current-angle"] = (math.pi * input)
  return nil
end
local function _2_(self)
  local mod = (math.pi / 25)
  local count = nil
  if (self.power < 25) then
    count = 1
  elseif (self.power < 50) then
    count = 3
  elseif (self.power >= 50) then
    count = 5
  else
  count = nil
  end
  local angle = ((1.5 * math.pi) - (mod * math.floor((count / 2))))
  for i = 1, count do
    local function _4_(bullet)
      bullet.type = "player-bullet"
      return nil
    end
    ent:spawn(_4_)
    angle = (angle + mod)
  end
  return nil
end
local function _3_(self)
end
local function _4_(self)
  self["current-angle"] = -1
  if ((controls.input):get("up") == 1) then
    self["set-angle"](self, 1.5)
  elseif ((controls.input):get("down") == 1) then
    self["set-angle"](self, 0.5)
  end
  if ((controls.input):get("left") == 1) then
    self["set-angle"](self, 1)
    if ((controls.input):get("up") == 1) then
      self["set-angle"](self, 1.25)
    elseif ((controls.input):get("down") == 1) then
      self["set-angle"](self, 0.75)
    end
  end
  if (((controls.input):get("left") == 0) and ((controls.input):get("right") == 1)) then
    self["set-angle"](self, 0)
    if ((controls.input):get("up") == 1) then
      self["set-angle"](self, 1.75)
    elseif ((controls.input):get("down") == 1) then
      self["set-angle"](self, 0.25)
    end
  end
  if (self["current-angle"] > -1) then
    local function _8_()
      if ((controls.input):get("focus") == 1) then
        return self["focus-speed"]
      else
        return self.speed
      end
    end
    self.pos.x = (self.pos.x + (math.cos(self["current-angle"]) * _8_()))
    local function _9_()
      if ((controls.input):get("focus") == 1) then
        return self["focus-speed"]
      else
        return self.speed
      end
    end
    self.pos.y = (self.pos.y - (math.sin(self["current-angle"]) * _9_()))
    do end (self.model):setTransform({self.pos.x, self["z-index"], self.pos.y})
    return (self["hitbox-model"]):setTransform({self.pos.x, self["hitbox-z-index"], self.pos.y})
  end
end
local function _5_(self)
  if (self["can-shoot"] and ((controls.input):get("shot") == 1)) then
    self["can-shoot"] = false
    self["shot-clock"] = 0
  end
  local interval = 10
  if (not self["can-shoot"] and ((self["shot-clock"] % interval) == 0)) then
    self["spawn-bullets-regular"](self)
  end
  self["shot-clock"] = (self["shot-clock"] + 1)
  if (self["shot-clock"] >= interval) then
    self["can-shoot"] = true
    return nil
  end
end
local function _6_(self)
  if not g["game-over"] then
    local interval = 15
    if ((self["invincible-clock"] <= 0) or ((self["invincible-clock"] % (interval * 2)) < interval)) then
      do end (self.model):draw()
    end
  end
  if ((controls.input):get("focus") == 1) then
    return (self["hitbox-model"]):draw()
  end
end
local function _7_(self, bullet_type)
end
local function _8_(self)
  self.pos = {x = self["init-pos"].x, y = self["init-pos"].y}
  local scale = 1.75
  self.model = g3d.newModel("models/plane.obj", "img/player/player.png", {0, 0, 0}, {0, math.pi, 0}, {scale, 1, scale})
  self["hitbox-model"] = g3d.newModel("models/plane.obj", "img/player/hitbox.png", {0, 0, 0}, {0, math.pi, 0}, {scale, 1, scale})
  do end (self.model):setTransform({self.pos.x, self["z-index"], self.pos.y})
  return (self["hitbox-model"]):setTransform({self.pos.x, self["hitbox-z-index"], self.pos.y})
end
local function _9_(self)
  if (not g["game-over"] and (self.clock > 5)) then
    self["update-move"](self)
    self["check-bounds"](self)
    self["update-shot"](self)
    if (self["invincible-clock"] > 0) then
      self["invincible-clock"] = (self["invincible-clock"] - 1)
    end
  end
  if g["game-over"] then
    self.pos = {x = (g.width * 2), y = 0}
  end
  self.clock = (self.clock + 1)
  return nil
end
return {["can-move"] = true, ["can-shoot"] = true, ["check-bounds"] = _0_, ["current-angle"] = -1, ["focus-speed"] = 0.03, ["hitbox-model"] = nil, ["hitbox-z-index"] = -10, ["init-pos"] = {x = 0, y = -2.75}, ["invincible-clock"] = 0, ["invincible-limit"] = (60 * 3), ["set-angle"] = _1_, ["shot-clock"] = 0, ["spawn-bullets-regular"] = _2_, ["spawn-bullets-wide"] = _3_, ["update-move"] = _4_, ["update-shot"] = _5_, ["z-index"] = -10.1, bombs = 2, clock = 0, collider = nil, draw = _6_, hit = _7_, lives = 2, load = _8_, model = nil, pos = nil, power = 0, speed = 0.065, update = _9_}
