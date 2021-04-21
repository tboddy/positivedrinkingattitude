; -----------------------------------
; systems
; -----------------------------------

(local systems {
	:enemy (require "enemy")
	:enemy-bullet (require "enemybullet")
	:explosion (require "explosion")
 :player-bullet (require "playerbullet")
 :graze (require "graze")})


(. {


 ; ----------------------------------
 ; load
 ; ----------------------------------

 :entities []
 :enemy-entities []
 :entity-count 0
 :enemy-count 0
 :enemy-bullet-count 0

 :load (fn [self]
  (for [i 1 3072] (tset self.entities i {}))
  (each [entity-type system (pairs systems)]
   (when system.load (system:load))))


 ; ----------------------------------
 ; spawn
 ; ----------------------------------

 :spawn (fn [self spawner updater]
  (var index 1)
  (each [i item (ipairs self.entities)]
   (when (and (not item.active) (= index 1)) (set index i)))
  (local entity (. self.entities index))
  (set entity.active true)
  (set entity.entity-index index)
  (set entity.seen false)
  (set entity.model false)
  (set entity.transform false)
  (set entity.pos {})
  (set entity.size {})
  (set entity.velocity {})
  (set entity.flags {})
  (set entity.rotation 0)
  (set entity.clock 0)
  (set entity.invincible false)
  (set entity.health 0)
  (set entity.hit false)
  (set entity.collider nil)
  (spawner entity)
  (set entity.max-health entity.health)
  (each [entity-type system (pairs systems)] (when (= entity-type entity.type) (system:spawn entity)))
  (set entity.updater (if updater updater nil)))

 :spawn-explosion (fn [self x y explosion-type big]
  (ent:spawn (fn [explosion]
   (set explosion.type :explosion)
   (set explosion.pos {:x x :y y})
   (set explosion.flags.color explosion-type)
   (set explosion.flags.big (if big true false)))))

 :spawn-graze (fn [self x y]
  (ent:spawn (fn [graze]
   (set graze.type :graze)
   (set graze.pos {:x x :y y}))))


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self]
  (set self.entity-count 0)
  (set self.enemy-count 0)
  (set self.enemy-bullet-count 0)
  (each [i entity (ipairs self.entities)]
   (when (and entity.active entity.type)
    (when (= entity.type :enemy)
     (set self.enemy-count (+ self.enemy-count 1))
     (var found false)
     (each [j enemy-index (ipairs self.enemy-entities)]
      (when (= enemy-index i) (set found true)))
     (when (not found) (table.insert self.enemy-entities i)))
    (when (= entity.type :enemy-bullet) (set self.enemy-bullet-count (+ self.enemy-bullet-count 1)))
    (set self.entity-count (+ self.entity-count 1))
    (when (and entity.updater entity.seen) (entity.updater entity))
		  (each [entity-type system (pairs systems)] (when (= entity-type entity.type) (system:update entity)))
    (when (and (not entity.seen) entity.pos.x entity.size.x
     (>= entity.pos.x (- 0 (/ entity.size.x 2)))
     (<= entity.pos.x (+ g.width (/ entity.size.x 2)))
     (>= entity.pos.y (- 0 (/ entity.size.y 2)))
     (<= entity.pos.y (+ g.height (/ entity.size.y 2))))
     (set entity.seen true))
    (set entity.clock (+ entity.clock 1)))))

 :draw (fn [self]
  (each [i entity (ipairs self.entities)]
   (when (and entity.active entity.type entity.seen)
    (each [entity-type system (pairs systems)] (when (= entity-type entity.type) (system:draw entity))))))

 })