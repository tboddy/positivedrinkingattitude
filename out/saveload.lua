local binser = require("lib.binser")
local function _0_(self)
end
local function _1_(self)
  if (g["current-score"] >= g["high-score"]) then
    g["high-score"] = g["current-score"]
  end
  if (g["game-over"] and not self["saved-score"] and (g["current-score"] >= g["high-score"])) then
    g["save-table"]["high-score"] = g["current-score"]
    local save_data = binser.serialize(g["save-table"])
    love.filesystem.write(self.filename, save_data)
    self["saved-score"] = true
    return nil
  end
end
local function _2_(self)
  local save_data = love.filesystem.read(self.filename)
  if save_data then
    g["save-table"] = binser.deserialize(save_data)[1]
    if g["save-table"]["high-score"] then
      g["high-score"] = g["save-table"]["high-score"]
    end
    if (g["save-table"].fullscreen and ((g["save-table"].fullscreen == true) or (g["save-table"].fullscreen == "true"))) then
      love.window.setFullscreen(true)
    end
  end
  if not save_data then
    g["save-table"] = {}
    return nil
  end
end
local function _3_(self)
  return self["save-score"](self)
end
return {["save-fullscreen"] = _0_, ["save-score"] = _1_, ["saved-score"] = false, filename = "savedata.lua", load = _2_, update = _3_}
