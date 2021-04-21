local function _0_(self, bullet)
  local distance = g["get-distance"](bullet.pos, player.pos)
  if (distance < bullet.flags.radius) then
    bullet.active = false
    bullet.model = false
    return nil
  end
end
local function _1_(self, bullet)
  return (bullet.model):draw()
end
local function _2_(self)
  self.images = g.images("sprites/bullets", self["bullet-images"], true)
  return nil
end
local function _3_(self, bullet)
  local scale = 1
  local img = nil
  local sz = nil
  local function s_bullet(b_type, b_scale, b_img, b_sz, does_rotate)
    if (bullet.flags.type == b_type) then
      scale = b_scale
      img = b_img
      sz = b_sz
      if does_rotate then
        bullet.flags["does-rotate"] = true
        return nil
      end
    end
  end
  s_bullet(1, 0.25, "blue-small-1", 8)
  s_bullet(2, 0.25, "red-small-1", 8)
  s_bullet(3, 0.25, "blue-small-2", 8)
  s_bullet(4, 0.25, "red-small-2", 8)
  s_bullet(5, 0.25, "blue-small-3", 6, true)
  s_bullet(6, 0.25, "red-small-3", 6, true)
  s_bullet(7, 0.5, "blue-big-1", 16)
  s_bullet(8, 0.5, "red-big-1", 16)
  s_bullet(9, 0.5, "blue-big-2", 8, true)
  s_bullet(10, 0.5, "red-big-2", 8, true)
  s_bullet(11, 0.5, "blue-big-3", 14, true)
  s_bullet(12, 0.5, "red-big-3", 14, true)
  s_bullet(13, 0.5, "blue-big-4", 8, true)
  s_bullet(14, 0.5, "red-big-4", 8, true)
  s_bullet(15, 0.5, "blue-big-5", 14, true)
  s_bullet(16, 0.5, "red-big-5", 14, true)
  s_bullet(17, 0.5, "blue-big-6", 8, true)
  s_bullet(18, 0.5, "red-big-6", 8, true)
  s_bullet(19, 0.5, "blue-big-7", 16, true)
  s_bullet(20, 0.5, "red-big-7", 16, true)
  s_bullet(21, 0.75, "blue-bigger-1", 8, true)
  s_bullet(22, 0.75, "red-bigger-1", 8, true)
  s_bullet(23, 1, "blue-biggest-1", 28, true)
  s_bullet(24, 1, "red-biggest-1", 28, true)
  local s_img = self.images[img]
  bullet.model = g3d.newModel("models/plane.obj", s_img, {0, 0, 0}, {0, 0, 0}, {scale, 1, scale})
  do end (bullet.model):setTransform({bullet.pos.x, self["z-index"], bullet.pos.y})
  if (bullet.flags["does-rotate"] == true) then
    do end (bullet.model):setRotation(0, bullet.angle, 0)
  end
  bullet.velocity = {x = (math.cos(bullet.angle) * bullet.speed), y = (math.sin(bullet.angle) * bullet.speed)}
  bullet.flags.radius = ((sz / 2) / 32)
  bullet.seen = true
  return nil
end
local function _4_(self, bullet)
  bullet.pos.x = (bullet.pos.x + bullet.velocity.x)
  bullet.pos.y = (bullet.pos.y - bullet.velocity.y)
  do end (bullet.model):setTransform({bullet.pos.x, self["z-index"], bullet.pos.y})
  if bullet.flags["does-rotate"] then
    do end (bullet.model):setRotation(0, bullet.angle, 0)
  end
  self["check-collision"](self, bullet)
  if (bullet.active and bullet.seen and ((bullet.pos.x > 6) or (bullet.pos.x < -6) or (bullet.pos.y > 4.5) or (bullet.pos.y < -4.5))) then
    bullet.active = false
    bullet.model = false
    return nil
  end
end
return {["bullet-images"] = {"blue-small-1", "red-small-1", "blue-small-2", "red-small-2", "blue-small-3", "red-small-3", "blue-big-1", "red-big-1", "blue-big-2", "red-big-2", "blue-big-3", "red-big-3", "blue-big-4", "red-big-4", "blue-big-5", "red-big-5", "blue-big-6", "red-big-6", "blue-big-7", "red-big-7", "blue-bigger-1", "red-bigger-1", "blue-biggest-1", "red-biggest-1"}, ["check-collision"] = _0_, ["z-index"] = -10, draw = _1_, images = nil, load = _2_, spawn = _3_, update = _4_}
