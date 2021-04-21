local function _0_()
  g:label("2021 T. BODDY NO RIGHTS RESERVED", 0, (g.height - 7 - 8 - 8 - 2 - 2), "center", nil, "yellow", "yellow-dark")
  return g:label("TOUHOU \194\169 ZUN/TEAM SHANGHAI ALICE", 0, (g.height - 7 - 8 - 2), "center", nil, "yellow-dark", "red-light")
end
local function _1_(self)
  return love.graphics.draw(self.images.logo, (g.width / 2), ((g.height / 2) - 16 - 4), 0, 1, 1, ((self.images.logo):getHeight() / 2), ((self.images.logo):getWidth() / 2))
end
local function _2_()
  return g:label("PRESS ANY BUTTON", nil, (((g.height / 4) * 3) + 8), "center", nil, "white", "yellow")
end
local function _3_()
  g.started = true
  background:load()
  ent:load()
  player:load()
  return chrome:load()
end
local function _4_(self)
  g["set-color"](g, "black")
  love.graphics.rectangle("fill", 0, 0, g.width, g.height)
  g["reset-color"]()
  self["draw-logo"](self)
  self["draw-prompt"]()
  return self["draw-credits"]()
end
local function _5_(self)
  self.images = g.images("start", {"logo"})
  return nil
end
local function _6_(self)
  self["load-game"]()
  if ((controls.input):get("shot") == 1) then
    return self["load-game"]()
  end
end
return {["draw-credits"] = _0_, ["draw-logo"] = _1_, ["draw-prompt"] = _2_, ["load-game"] = _3_, draw = _4_, images = nil, load = _5_, update = _6_}
