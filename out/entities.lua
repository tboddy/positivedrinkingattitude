local systems = {["enemy-bullet"] = require("enemybullet"), ["player-bullet"] = require("playerbullet"), enemy = require("enemy"), explosion = require("explosion"), graze = require("graze")}
local function _0_(self, x, y, explosion_type, big)
  local function _1_(explosion)
    explosion.type = "explosion"
    explosion.pos = {x = x, y = y}
    explosion.flags.color = explosion_type
    if big then
      explosion.flags.big = true
    else
      explosion.flags.big = false
    end
    return nil
  end
  return ent:spawn(_1_)
end
local function _1_(self, x, y)
  local function _2_(graze)
    graze.type = "graze"
    graze.pos = {x = x, y = y}
    return nil
  end
  return ent:spawn(_2_)
end
local function _2_(self)
  for i, entity in ipairs(self.entities) do
    if (entity.active and entity.type and entity.seen) then
      for entity_type, system in pairs(systems) do
        if (entity_type == entity.type) then
          system:draw(entity)
        end
      end
    end
  end
  return nil
end
local function _3_(self)
  for i = 1, 3072 do
    self.entities[i] = {}
  end
  for entity_type, system in pairs(systems) do
    if system.load then
      system:load()
    end
  end
  return nil
end
local function _4_(self, spawner, updater)
  local index = 1
  for i, item in ipairs(self.entities) do
    if (not item.active and (index == 1)) then
      index = i
    end
  end
  local entity = self.entities[index]
  entity.active = true
  entity["entity-index"] = index
  entity.seen = false
  entity.model = false
  entity.transform = false
  entity.pos = {}
  entity.size = {}
  entity.velocity = {}
  entity.flags = {}
  entity.rotation = 0
  entity.clock = 0
  entity.invincible = false
  entity.health = 0
  entity.hit = false
  entity.collider = nil
  spawner(entity)
  entity["max-health"] = entity.health
  for entity_type, system in pairs(systems) do
    if (entity_type == entity.type) then
      system:spawn(entity)
    end
  end
  if updater then
    entity.updater = updater
  else
    entity.updater = nil
  end
  return nil
end
local function _5_(self)
  self["entity-count"] = 0
  self["enemy-count"] = 0
  self["enemy-bullet-count"] = 0
  for i, entity in ipairs(self.entities) do
    if (entity.active and entity.type) then
      if (entity.type == "enemy") then
        self["enemy-count"] = (self["enemy-count"] + 1)
        local found = false
        for j, enemy_index in ipairs(self["enemy-entities"]) do
          if (enemy_index == i) then
            found = true
          end
        end
        if not found then
          table.insert(self["enemy-entities"], i)
        end
      end
      if (entity.type == "enemy-bullet") then
        self["enemy-bullet-count"] = (self["enemy-bullet-count"] + 1)
      end
      self["entity-count"] = (self["entity-count"] + 1)
      if (entity.updater and entity.seen) then
        entity.updater(entity)
      end
      for entity_type, system in pairs(systems) do
        if (entity_type == entity.type) then
          system:update(entity)
        end
      end
      if (not entity.seen and entity.pos.x and entity.size.x and (entity.pos.x >= (0 - (entity.size.x / 2))) and (entity.pos.x <= (g.width + (entity.size.x / 2))) and (entity.pos.y >= (0 - (entity.size.y / 2))) and (entity.pos.y <= (g.height + (entity.size.y / 2)))) then
        entity.seen = true
      end
      entity.clock = (entity.clock + 1)
    end
  end
  return nil
end
return {["enemy-bullet-count"] = 0, ["enemy-count"] = 0, ["enemy-entities"] = {}, ["entity-count"] = 0, ["spawn-explosion"] = _0_, ["spawn-graze"] = _1_, draw = _2_, entities = {}, load = _3_, spawn = _4_, update = _5_}
