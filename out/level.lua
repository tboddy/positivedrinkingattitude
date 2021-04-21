local levels = nil
local function _0_()
end
levels = {_0_}
local bosses = nil
local function _1_()
  local patterns = nil
  local function _2_(enemy)
    local function sides()
      local function spawn_bullets(opposite)
        local count = 2
        local angle = nil
        if opposite then
          angle = enemy.flags["bullet-angle-1"]
        else
          angle = enemy.flags["bullet-angle-2"]
        end
        local bullet_x = nil
        local function _4_()
          if opposite then
            return 3
          else
            return -3
          end
        end
        bullet_x = (enemy.pos.x + _4_())
        for i = 1, count do
          local function _5_(bullet)
            bullet.type = "enemy-bullet"
            bullet.pos = {x = bullet_x, y = enemy.pos.y}
            bullet.angle = angle
            bullet.speed = 0.1
            bullet.flags.limit = 0.05
            if opposite then
              bullet.flags.opposite = true
            else
              bullet.flags.opposite = false
            end
            if opposite then
              bullet.flags.mod = 0.01
            else
              bullet.flags.mod = -0.01
            end
            bullet.flags.type = 5
            return nil
          end
          local function _6_(bullet)
            if (bullet.speed > bullet.flags.limit) then
              bullet.speed = (bullet.speed - 0.001)
            end
            if (bullet.speed <= bullet.flags.limit) then
              bullet.angle = (bullet.angle + bullet.flags.mod)
            end
            return g["update-velocity"](bullet)
          end
          ent:spawn(_5_, _6_)
          angle = (angle + (g.tau / count))
        end
        local a_mod = (g.phi / 7)
        if opposite then
          enemy.flags["bullet-angle-1"] = (enemy.flags["bullet-angle-1"] + a_mod)
          return nil
        else
          enemy.flags["bullet-angle-2"] = (enemy.flags["bullet-angle-2"] - a_mod)
          return nil
        end
      end
      local interval = 2
      local limit = (interval * 50)
      local max = (limit + (interval * 40))
      if (((enemy["shot-clock"] % interval) == 0) and ((enemy["shot-clock"] % max) <= limit)) then
        return spawn_bullets(((enemy["shot-clock"] % (max * 2)) < max))
      end
    end
    local function center()
      local function spawn_bullets()
        local mod = (math.pi / 12)
        local function _3_(bullet)
          bullet.type = "enemy-bullet"
          bullet.pos = {x = enemy.pos.x, y = enemy.pos.y}
          bullet.angle = (mod + ((math.pi - (mod * 2)) * math.random()))
          bullet.speed = 0.07
          bullet.flags.limit = 0.03
          bullet.flags.type = 8
          return nil
        end
        local function _4_(bullet)
          if (bullet.speed > bullet.flags.limit) then
            bullet.speed = (bullet.speed - 0.001)
            return g["update-velocity"](bullet)
          end
        end
        return ent:spawn(_3_, _4_)
      end
      local interval = 2
      local limit = (interval * 50)
      local max = (limit + (interval * 40))
      if (((enemy["shot-clock"] % (interval * 4)) == 0) and ((enemy["shot-clock"] % max) > limit)) then
        return spawn_bullets()
      end
    end
    sides()
    center()
    chrome["pattern-name"] = "poop"
    return nil
  end
  local function _3_(enemy)
    local function center()
      local function spawn_bullets()
        local angle = enemy.flags["bullet-angle-1"]
        local count = 3
        local s_count = 5
        local distance = 1
        local s_distance = 0.65
        for i = 1, count do
          local x = (enemy.pos.x + (math.cos(angle) * distance))
          local y = (enemy.pos.y - (math.sin(angle) * distance))
          local s_angle = (angle + (math.pi / 2))
          local diff = (s_distance * math.floor((s_count / 2)))
          x = (x - (math.cos(s_angle) * diff))
          y = (y + (math.sin(s_angle) * diff))
          for j = 1, s_count do
            local function _4_(bullet)
              bullet.type = "enemy-bullet"
              bullet.pos = {x = x, y = y}
              bullet.angle = angle
              bullet.speed = 0.075
              bullet.flags.type = 9
              return nil
            end
            local function _5_(bullet)
            end
            ent:spawn(_4_, _5_)
            x = (x + (math.cos(s_angle) * s_distance))
            y = (y - (math.sin(s_angle) * s_distance))
          end
          angle = (angle + (g.tau / count))
        end
        enemy.flags["bullet-angle-1"] = (enemy.flags["bullet-angle-1"] + (g.phi / 2))
        return nil
      end
      local interval = 15
      if ((enemy["shot-clock"] % interval) == 0) then
        return spawn_bullets()
      end
    end
    local function sides()
      local x_mod = 4
      local function spawn_bullet(opposite)
        local bullet_x = nil
        local function _4_()
          if opposite then
            return x_mod
          else
            return (0 - x_mod)
          end
        end
        bullet_x = (enemy.pos.x + _4_())
        local angle = nil
        if opposite then
          angle = enemy.flags["bullet-angle-3"]
        else
          angle = enemy.flags["bullet-angle-2"]
        end
        local count = 12
        for i = 1, count do
          local function _6_(bullet)
            bullet.type = "enemy-bullet"
            bullet.pos = {x = bullet_x, y = enemy.pos.y}
            bullet.angle = angle
            bullet.speed = 0.1
            bullet.flags.limit = 0.05
            bullet.flags.type = 6
            return nil
          end
          local function _7_(bullet)
            if (bullet.speed > bullet.flags.limit) then
              bullet.speed = (bullet.speed - 0.002)
              return g["update-velocity"](bullet)
            end
          end
          ent:spawn(_6_, _7_)
          angle = (angle + (g.tau / count))
        end
        return nil
      end
      local interval = 6
      local limit = (interval * 5)
      local max = (interval * 7)
      if (((enemy["shot-clock"] % interval) == 0) and ((enemy["shot-clock"] % max) < limit)) then
        if ((enemy["shot-clock"] % max) == 0) then
          local b_mod = 0.05
          enemy.flags["bullet-angle-2"] = (enemy.flags["bullet-angle-2"] - b_mod)
          enemy.flags["bullet-angle-3"] = (enemy.flags["bullet-angle-3"] + (2 * b_mod))
        end
        return spawn_bullet(((enemy["shot-clock"] % (max * 2)) < max))
      end
    end
    center()
    sides()
    chrome["pattern-name"] = ""
    return nil
  end
  local function _4_(enemy)
    local function center()
      local function spawn_bullets()
        local angle = enemy.flags["bullet-angle-1"]
        local count = 16
        for i = 1, count do
          local function _5_(bullet)
            bullet.type = "enemy-bullet"
            bullet.pos = {x = enemy.pos.x, y = enemy.pos.y}
            bullet.angle = angle
            bullet.speed = enemy.flags["bullet-speed-1"]
            bullet.flags.type = 7
            return nil
          end
          local function _6_(bullet)
          end
          ent:spawn(_5_, _6_)
          angle = (angle + (g.tau / count))
        end
        enemy.flags["bullet-speed-1"] = (enemy.flags["bullet-speed-1"] + 0.01)
        return nil
      end
      local interval = 2
      local limit = (interval * 4)
      local max = (limit * 5)
      if (((enemy["shot-clock"] % interval) == 0) and ((enemy["shot-clock"] % max) < limit)) then
        if ((enemy["shot-clock"] % limit) == 0) then
          enemy.flags["bullet-angle-1"] = g["get-angle"](enemy.pos, player.pos)
          enemy.flags["bullet-speed-1"] = 0.05
        end
        return spawn_bullets()
      end
    end
    center()
    chrome["pattern-name"] = "poop"
    return nil
  end
  patterns = {_2_, _3_, _4_}
  local function spawn_enemy()
    local function _5_(enemy)
      enemy.type = "enemy"
      enemy.pos = {x = 0, y = 6}
      enemy.speed = 0.0725
      enemy.health = 100
      enemy.flags["max-health"] = enemy.health
      enemy.flags["current-pattern"] = 2
      enemy.flags["bullet-angle-1"] = 0
      enemy.flags["bullet-angle-2"] = 0
      enemy.flags["bullet-angle-3"] = 0
      enemy.flags["bullet-speed-1"] = 0
      enemy.flags.scale = 6
      enemy["model-type"] = "wine"
      enemy["skin-type"] = "wine-red"
      enemy.angle = (math.pi / 2)
      return nil
    end
    local function _6_(enemy)
      if enemy.flags.ready then
        patterns[enemy.flags["current-pattern"]](enemy)
        chrome["boss-health"] = enemy.health
      end
      if not enemy.flags.ready then
        enemy["shot-clock"] = -1
        enemy.health = enemy.flags["max-health"]
        enemy.speed = (enemy.speed - 0.001)
        if (enemy.speed <= 0) then
          enemy.speed = 0
          enemy.flags.ready = true
        end
        return g["update-velocity"](enemy)
      end
    end
    return ent:spawn(_5_, _6_)
  end
  return spawn_enemy()
end
bosses = {_1_}
local function _2_(self)
  if (self.clock == self["start-time"]) then
    local _3_
    if self["in-boss"] then
      _3_ = bosses
    else
      _3_ = levels
    end
    do end (_3_)[self["current-level"]]()
  end
  self.clock = (self.clock + 1)
  if ((ent["enemy-count"] == 0) and (self.clock > (self["start-time"] * 2))) then
    if self["in-boss"] then
      self["in-boss"] = false
    else
      self["in-boss"] = true
    end
    self.clock = -1
    return nil
  end
end
return {["current-level"] = 1, ["in-boss"] = true, ["start-time"] = 15, clock = 0, update = _2_}
