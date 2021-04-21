local binser = require("lib.binser")
local function _0_(self)
  local save_data = love.filesystem.read(self.filename)
  if save_data then
    g["save-table"] = binser.deserialize(save_data)
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
local function _1_(self)
  if (g["current-score"] >= g["high-score"]) then
    g["high-score"] = g["current-score"]
  end
  if (g["game-over"] and not self.saved) then
    if (g["current-score"] >= g["high-score"]) then
      print("yeeee")
      g["save-table"]["high-score"] = g["current-score"]
    end
    local save_data = binser.serialize(g["save-table"])
    love.filesystem.write(self.filename, save_data)
    print("saved")
    self.saved = true
    return nil
  end
end
return {filename = "savedata.lua", load = _0_, saved = false, update = _1_}
