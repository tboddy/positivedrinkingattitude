(. {


 :z-index -10.2


 ; ----------------------------------
 ; spawn
 ; ----------------------------------

 :spawn (fn [self bullet]
  (set bullet.pos {:x player.pos.x :y player.pos.y})
  (local scale 1)
  (set bullet.model (g3d.newModel "models/plane.obj" "img/player/bullet.png" [0 0 0] [0 math.pi 0] [scale 1 scale]))
  (bullet.model:setTransform [bullet.pos.x self.z-index bullet.pos.y])
  (set bullet.speed 1)
  (set bullet.seen true)
  (set bullet.angle (* math.pi 1.5))
  (set bullet.velocity {:x (* (math.cos bullet.angle) bullet.speed) :y (* (math.sin bullet.angle) bullet.speed)}))


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self bullet]
  (set bullet.pos.x (+ bullet.pos.x bullet.velocity.x))
  (set bullet.pos.y (- bullet.pos.y bullet.velocity.y))
  (bullet.model:setTransform [bullet.pos.x self.z-index bullet.pos.y])
  (each [i enemy-index (ipairs ent.enemy-entities)]
   (local enemy (. ent.entities enemy-index))
   (when (and enemy.active enemy.seen)
    (local distance (g.get-distance bullet.pos enemy.pos))
    (when (<= distance 1)
     (set enemy.flags.hit true)
     (set bullet.active false)
     (set bullet.model false))))
  (when (> bullet.pos.y 4.5)
   (set bullet.active false)
   (set bullet.model false)))

 :draw (fn [self bullet]
  (bullet.model:draw))


 })