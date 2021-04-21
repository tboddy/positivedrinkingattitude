(. {

 :z-index -13

 ; ----------------------------------
 ; spawn
 ; ----------------------------------

 :spawn (fn [self enemy]
  (local scale (if enemy.flags.scale enemy.flags.scale 1))
  (set enemy.model
   (g3d.newModel
    (.. "models/enemies/" enemy.model-type ".obj")
    (.. "models/enemies/" enemy.skin-type ".png")
    [0 0 0]
    [(/ math.pi 2) 0 0]
    [scale scale scale]))
  (enemy.model:setTransform [enemy.pos.x self.z-index enemy.pos.y])
  (set enemy.velocity {:x (* (math.cos enemy.angle) enemy.speed) :y (* (math.sin enemy.angle) enemy.speed)})
  (local rotate-mod 0.005)
  (set enemy.flags.rotate-mod (if (< (math.random) 0.5) rotate-mod (* rotate-mod -1)))
  (set enemy.flags.rotate 0)
  (set enemy.shot-clock 0))


 ; ----------------------------------
 ; collision
 ; ----------------------------------

 :get-hit (fn [self enemy]
  (set enemy.health (- enemy.health 1))
  (set enemy.flags.hit false)
  (when (< enemy.health 0)
   (set enemy.model false)
   (set enemy.active false)
   (var remove-index 1)
   (each [i enemy-index (ipairs ent.enemy-entities)] (when (= enemy-index enemy.entity-index) (set remove-index i)))
   (table.remove ent.enemy-entities remove-index)))


 :animate (fn [self enemy]
  (enemy.model:setRotation (/ math.pi 2) enemy.flags.rotate (/ (- 0 math.pi) 8))
  (set enemy.flags.rotate (+ enemy.flags.rotate enemy.flags.rotate-mod))
  )


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self enemy]
  (when (> enemy.speed 0)
   (set enemy.pos.x (+ enemy.pos.x enemy.velocity.x))
   (set enemy.pos.y (- enemy.pos.y enemy.velocity.y))
   (enemy.model:setTransform [enemy.pos.x self.z-index enemy.pos.y]))
  (when (and (not enemy.seen) (<= enemy.pos.y 5))
   (set enemy.seen true))
  (when (and enemy.seen (<= enemy.pos.y -5))
   (set enemy.model false)
   (set enemy.active false))
  (when (and enemy.seen enemy.model enemy.active)
   (self:animate enemy)
   (when enemy.flags.hit (self:get-hit enemy)))
  (if enemy.seen (set enemy.shot-clock (+ enemy.shot-clock 1)) (set enemy.clock -1)))
  
 :draw (fn [self enemy]
  (when enemy.seen (enemy.model:draw)))


 })









 ; ----------------------------------
 ; magic circle
 ; ----------------------------------

 ; (when enemy.flags.magic (self:update-magic))
 ; :magic-rotation 0
 ; :magic-scale 0
 ; :magic-clock 0

 ; :update-magic (fn [self]
 ;  (set self.magic-rotation (+ self.magic-rotation 0.0025))
 ;  (when (>= self.magic-rotation g.tau) (set self.magic-rotation 0))
 ;  (set self.magic-scale (+ self.magic-scale (/ (/ (math.cos (/ self.magic-clock 60)) 60) 8)))
 ;  (set self.magic-clock (+ self.magic-clock 1)))

 ; :draw-magic (fn [self enemy]
 ;  (g:set-color enemy.flags.magic)
 ;  (g.mask :most #(love.graphics.draw self.images.magic enemy.pos.x enemy.pos.y self.magic-rotation (+ 1 self.magic-scale) 1
 ;   (/ (self.images.magic:getWidth) 2) (/ (self.images.magic:getHeight) 2)))
 ;  (g:reset-color)
 ;  )

  ; (when enemy.flags.magic (self:draw-magic enemy))