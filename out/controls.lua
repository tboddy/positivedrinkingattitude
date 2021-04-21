local baton = require("lib.baton")
local function _0_(self)
  if (((self.input):get("fullscreen") == 1) and not self["doing-fullscreen"]) then
    return g["toggle-fullscreen"]()
  elseif ((self.input):get("fullscreen") == 0) then
    self["doing-fullscreen"] = false
    return nil
  end
end
local function _1_(self)
  if (((self.input):get("pause") == 1) and not self.pausing) then
    self.pausing = true
    if g.paused then
      g.paused = false
    else
      g.paused = true
    end
  end
  if ((self.input):get("pause") == 0) then
    self.pausing = false
    return nil
  end
end
local function _2_(self)
  if ((g["game-over-clock"] >= 60) and self.shot()) then
    love.event.quit("restart")
  end
  if ((self.input):get("reload") == 1) then
    return love.event.quit("restart")
  end
end
local function _3_(self)
  local baton_config = {controls = {down = {"key:down", "axis:lefty+", "button:dpdown", "key:s"}, focus = {"key:x", "button:x", "key:lshift"}, fullscreen = {"key:f"}, left = {"key:left", "axis:leftx-", "button:dpleft", "key:a"}, pause = {"key:escape", "button:start"}, reload = {"key:r", "button:back"}, right = {"key:right", "axis:leftx+", "button:dpright", "key:d"}, shot = {"key:z", "button:a", "key:space"}, up = {"key:up", "axis:lefty-", "button:dpup", "key:w"}}}
  local joysticks = love.joystick.getJoysticks()
  if joysticks[1] then
    baton_config.joystick = joysticks[1]
  end
  self.input = baton.new(baton_config)
  return nil
end
local function _4_(self)
  do end (self.input):update()
  self["update-fullscreen"](self)
  self["update-restart"](self)
  if not g["game-over"] then
    return self["update-pause"](self)
  end
end
return {["update-fullscreen"] = _0_, ["update-pause"] = _1_, ["update-restart"] = _2_, load = _3_, update = _4_}
