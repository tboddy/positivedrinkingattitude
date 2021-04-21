local function _0_(self, _3foffset)
  local offset = nil
  if _3foffset then
    offset = _3foffset
  else
    offset = 0
  end
  local x = (0 - (self["bottom-width"] / 2))
  for i = 1, self["bottom-width"] do
    local index = 0
    for j = 1, #self["bottom-models"] do
      if (index == 0) then
        local b_model = (self["bottom-models"])[j]
        if not b_model.model then
          index = j
        end
      end
    end
    if (index > 0) then
      local t_model = (self["bottom-models"])[index]
      local scale = 1
      t_model.model = g3d.newModel("models/bg/ground.obj", "models/bg/ground1.png", {x, 0, (self["bottom-start"] - offset)}, {0, 0, 0}, {scale, 1, scale})
      t_model.transform = {x, self["z-index"], (self["bottom-start"] - offset)}
      x = (x + 1)
    end
  end
  return nil
end
local function _1_(self, b_model)
  b_model.transform[3] = (b_model.transform[3] - 0.05)
  do end (b_model.model):setTransform({b_model.transform[1], b_model.transform[2], b_model.transform[3]})
  if (b_model.transform[3] < self["bottom-limit"]) then
    b_model.model = false
    return nil
  end
end
local function _2_(self)
  for i = 1, #self["bottom-models"] do
    local b_model = (self["bottom-models"])[i]
    if b_model.model then
      do end (b_model.model):draw()
    end
  end
  return nil
end
local function _3_(self)
  for i = 1, 312 do
    self["bottom-models"][i] = {model = false, transform = false}
  end
  for i = 1, 13 do
    self["spawn-row"](self, i)
  end
  return nil
end
local function _4_(self)
  if ((self.clock % 20) == 0) then
    self["spawn-row"](self)
  end
  for i = 1, #self["bottom-models"] do
    local b_model = (self["bottom-models"])[i]
    if b_model.model then
      self["update-b-model"](self, b_model)
    end
  end
  self.clock = (self.clock + 1)
  return nil
end
return {["bg-color"] = "black", ["bottom-limit"] = -7, ["bottom-models"] = {}, ["bottom-start"] = 7, ["bottom-width"] = 18, ["spawn-row"] = _0_, ["update-b-model"] = _1_, ["z-index"] = -15.5, clock = 0, draw = _2_, load = _3_, update = _4_}
