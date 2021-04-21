local function _0_(self, enemy)
  enemy.health = (enemy.health - 1)
  enemy.flags.hit = false
  if (enemy.health < 0) then
    enemy.model = false
    enemy.active = false
    local remove_index = 1
    for i, enemy_index in ipairs(ent["enemy-entities"]) do
      if (enemy_index == enemy["entity-index"]) then
        remove_index = i
      end
    end
    return table.remove(ent["enemy-entities"], remove_index)
  end
end
local function _1_(self, enemy)
  do end (enemy.model):setRotation((math.pi / 2), enemy.flags.rotate, ((0 - math.pi) / 8))
  enemy.flags.rotate = (enemy.flags.rotate + enemy.flags["rotate-mod"])
  return nil
end
local function _2_(self, enemy)
  if enemy.seen then
    return (enemy.model):draw()
  end
end
local function _3_(self, enemy)
  local scale = nil
  if enemy.flags.scale then
    scale = enemy.flags.scale
  else
    scale = 1
  end
  enemy.model = g3d.newModel(("models/enemies/" .. enemy["model-type"] .. ".obj"), ("models/enemies/" .. enemy["skin-type"] .. ".png"), {0, 0, 0}, {(math.pi / 2), 0, 0}, {scale, scale, scale})
  do end (enemy.model):setTransform({enemy.pos.x, self["z-index"], enemy.pos.y})
  enemy.velocity = {x = (math.cos(enemy.angle) * enemy.speed), y = (math.sin(enemy.angle) * enemy.speed)}
  local rotate_mod = 0.005
  if (math.random() < 0.5) then
    enemy.flags["rotate-mod"] = rotate_mod
  else
    enemy.flags["rotate-mod"] = (rotate_mod * -1)
  end
  enemy.flags.rotate = 0
  enemy["shot-clock"] = 0
  return nil
end
local function _4_(self, enemy)
  if (enemy.speed > 0) then
    enemy.pos.x = (enemy.pos.x + enemy.velocity.x)
    enemy.pos.y = (enemy.pos.y - enemy.velocity.y)
    do end (enemy.model):setTransform({enemy.pos.x, self["z-index"], enemy.pos.y})
  end
  if (not enemy.seen and (enemy.pos.y <= 5)) then
    enemy.seen = true
  end
  if (enemy.seen and (enemy.pos.y <= -5)) then
    enemy.model = false
    enemy.active = false
  end
  if (enemy.seen and enemy.model and enemy.active) then
    self:animate(enemy)
    if enemy.flags.hit then
      self["get-hit"](self, enemy)
    end
  end
  if enemy.seen then
    enemy["shot-clock"] = (enemy["shot-clock"] + 1)
    return nil
  else
    enemy.clock = -1
    return nil
  end
end
return {["get-hit"] = _0_, ["z-index"] = -13, animate = _1_, draw = _2_, spawn = _3_, update = _4_}
