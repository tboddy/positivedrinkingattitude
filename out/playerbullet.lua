local function _0_(self, bullet)
  return (bullet.model):draw()
end
local function _1_(self, bullet)
  bullet.pos = {x = player.pos.x, y = player.pos.y}
  local scale = 1
  bullet.model = g3d.newModel("models/plane.obj", "img/player/bullet.png", {0, 0, 0}, {0, math.pi, 0}, {scale, 1, scale})
  do end (bullet.model):setTransform({bullet.pos.x, self["z-index"], bullet.pos.y})
  bullet.speed = 1
  bullet.seen = true
  bullet.angle = (math.pi * 1.5)
  bullet.velocity = {x = (math.cos(bullet.angle) * bullet.speed), y = (math.sin(bullet.angle) * bullet.speed)}
  return nil
end
local function _2_(self, bullet)
  bullet.pos.x = (bullet.pos.x + bullet.velocity.x)
  bullet.pos.y = (bullet.pos.y - bullet.velocity.y)
  do end (bullet.model):setTransform({bullet.pos.x, self["z-index"], bullet.pos.y})
  for i, enemy_index in ipairs(ent["enemy-entities"]) do
    local enemy = ent.entities[enemy_index]
    if (enemy.active and enemy.seen) then
      local distance = g["get-distance"](bullet.pos, enemy.pos)
      if (distance <= 1) then
        enemy.flags.hit = true
        bullet.active = false
        bullet.model = false
      end
    end
  end
  if (bullet.pos.y > 4.5) then
    bullet.active = false
    bullet.model = false
    return nil
  end
end
return {["z-index"] = -10.2, draw = _0_, spawn = _1_, update = _2_}
