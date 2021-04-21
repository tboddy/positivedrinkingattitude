local function _0_(self)
  if (self["boss-health"] > 0) then
    self["draw-boss-health"](self)
  end
  if self["pattern-name"] then
    return g:label(self["pattern-name"], 0, self["hud-y"], "center", nil, "white", "yellow")
  end
end
local function _1_(self)
  self["hud-y"] = 12
  local width = (g.width - 8)
  local b_width = ((self["boss-health"] / self["boss-max-health"]) * width)
  g["set-color"](g, "black")
  love.graphics.rectangle("fill", 3, 3, (b_width + 2), 10)
  g["set-color"](g, "yellow")
  love.graphics.rectangle("fill", 4, 4, b_width, 1)
  g["set-color"](g, "yellow-dark")
  love.graphics.rectangle("fill", 4, 5, b_width, 3)
  g["set-color"](g, "red-light")
  love.graphics.rectangle("fill", 4, 8, b_width, 3)
  g["set-color"](g, "red")
  love.graphics.rectangle("fill", 4, 11, b_width, 1)
  return g["reset-color"]()
end
local function _2_(self, x, y, card_type)
  g["set-color"](g, "black")
  love.graphics.rectangle("fill", (x - 1), (y - 1), (self["card-width"] + 2), (self["card-height"] + 2))
  g["set-color"](g, "white")
  love.graphics.rectangle("fill", x, y, self["card-width"], self["card-height"])
  g["set-color"](g, "yellow")
  love.graphics.rectangle("fill", x, (y + (self["card-height"] / 2)), self["card-width"], ((self["card-height"] / 4) + 2))
  love.graphics.rectangle("fill", x, (y + ((self["card-height"] / 4) * 3) + 2), self["card-width"], ((self["card-height"] / 4) - 2))
  love.graphics.rectangle("fill", x, (y + (self["card-height"] - 1)), self["card-width"], 1)
  g["reset-color"]()
  local img = self.images[card_type]
  return love.graphics.draw(img, x, (y + 1))
end
local function _3_(self)
  local y = (self["hud-y"] + 14)
  local x = (g.width - self["card-width"] - 4)
  for i = 1, 3 do
    local function _4_()
      if (i == 3) then
        return "cardwide"
      else
        if (i == 1) then
          return "cardshield"
        else
          return "cardstraight"
        end
      end
    end
    self["draw-card"](self, x, y, _4_())
    x = (x - self["card-width"] - 3)
  end
  return nil
end
local function _4_(self)
  local fps = math.floor(love.timer.getFPS())
  if (fps > 60) then
    fps = 60
  end
  g:label((ent["entity-count"] .. " Entities"), 4, (g.height - 7 - 4), nil, nil, "red", "red-dark")
  g:label((ent["enemy-bullet-count"] .. " Bullets"), 4, (g.height - 7 - 4 - 10), nil, nil, "red-light", "red")
  g:label((ent["enemy-count"] .. " Enemies"), 4, (g.height - 7 - 4 - 10 - 10), nil, nil, "yellow-dark", "red-light")
  local _6_
  if g["hard-mode"] then
    _6_ = "Hard"
  else
    _6_ = "Easy"
  end
  g:label(_6_, 0, (g.height - 7 - 4 - 10), "right", (g.width - 4), "red-light", "red")
  return g:label((tostring(fps) .. " FPS"), 0, (g.height - 7 - 4), "right", (g.width - 4), "red", "red-dark")
end
local function _5_(self)
  g["set-color"](g, "black")
  local function _6_()
    return love.graphics.rectangle("fill", 0, 0, g.width, g.height)
  end
  g.mask("most", _6_)
  g["reset-color"]()
  local y = ((g.height / 2) - 31)
  g:label("GAME OVER", 0, y, "center", nil, "yellow", "yellow-dark", true)
  y = (y + 16 + 4)
  g:label("FINAL", 0, y, "center", nil, "white", "yellow", true)
  y = (y + 16)
  g:label(g["process-score"](g["current-score"]), 0, y, "center", nil, "white", "yellow", true)
  if (g["current-score"] >= g["high-score"]) then
    y = (y + 16 + 4)
    return g:label("NEW HIGH SCORE!", 0, y, "center", nil, "yellow", "yellow-dark", true)
  end
end
local function _6_(self)
  local y = (self["hud-y"] + 16)
  local x = 3
  if (player.lives > 0) then
    for i = 1, player.lives do
      love.graphics.draw(self.images.heart, x, y)
      x = (x + 16)
    end
    return nil
  end
end
local function _7_(self)
  local y = self["hud-y"]
  g:label(("Sc " .. g["process-score"](g["current-score"])), 4, y, nil, nil, "white", "yellow")
  return g:label(("Hi " .. g["process-score"](g["high-score"])), nil, y, "right", (g.width - 3), "white", "yellow")
end
local function _8_(self)
  if not g["game-over"] then
    self["hud-y"] = 0
    self["draw-boss"](self)
    self["draw-score"](self)
    self["draw-lives"](self)
  end
  if g["game-over"] then
    return self["draw-game-over"](self)
  end
end
local function _9_(self)
  self.images = g.images("chrome", {"heart", "cardwide", "cardstraight", "cardshield"})
  return nil
end
return {["boss-gradient"] = gradient({g.colors["yellow-dark"], g.colors["red-light"]}), ["boss-health"] = 0, ["boss-max-health"] = 100, ["card-height"] = 20, ["card-width"] = 15, ["draw-boss"] = _0_, ["draw-boss-health"] = _1_, ["draw-card"] = _2_, ["draw-cards"] = _3_, ["draw-debug"] = _4_, ["draw-game-over"] = _5_, ["draw-lives"] = _6_, ["draw-score"] = _7_, ["hud-y"] = 0, ["pattern-name"] = nil, draw = _8_, images = nil, load = _9_}
