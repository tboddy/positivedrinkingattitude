(. {


 ; ----------------------------------
 ; load
 ; ----------------------------------

 :clock 0

 :init-pos {:x 0 :y -2.75}
 :pos nil
 :speed 0.065
 :focus-speed 0.03

 :power 0

 :shot-clock 0
 :can-shoot true
 :can-move true

 :collider nil
 :invincible-clock 0
 :invincible-limit (* 60 3)

 :lives 2
 :bombs 2

 :model nil
 :hitbox-model nil

 :z-index -10.1
 :hitbox-z-index -10

 :load (fn [self]
  (set self.pos {:x self.init-pos.x :y self.init-pos.y})
  (local scale 1.75)
  (set self.model (g3d.newModel "models/plane.obj" "img/player/player.png" [0 0 0] [0 math.pi 0] [scale 1 scale]))
  (set self.hitbox-model (g3d.newModel "models/plane.obj" "img/player/hitbox.png" [0 0 0] [0 math.pi 0] [scale 1 scale]))
  (self.model:setTransform [self.pos.x self.z-index self.pos.y])
  (self.hitbox-model:setTransform [self.pos.x self.hitbox-z-index self.pos.y]))


 ; ----------------------------------
 ; move
 ; ----------------------------------

 :current-angle -1
 :set-angle (fn [self input] (set self.current-angle (* math.pi input)))

 :update-move (fn [self]
  (set self.current-angle -1)
  (if (= (controls.input:get :up) 1)
   (self:set-angle 1.5)
   (= (controls.input:get :down) 1)
   (self:set-angle 0.5))
  (when (= (controls.input:get :left) 1)
   (self:set-angle 1)
   (if (= (controls.input:get :up) 1)
    (self:set-angle 1.25)
    (= (controls.input:get :down) 1)
    (self:set-angle 0.75)))
  (when (and (= (controls.input:get :left) 0) (= (controls.input:get :right) 1))
   (self:set-angle 0)
   (if (= (controls.input:get :up) 1)
    (self:set-angle 1.75)
    (= (controls.input:get :down) 1)
    (self:set-angle 0.25)))
  (when (> self.current-angle -1)
   (set self.pos.x (+ self.pos.x (* (math.cos self.current-angle) (if (= (controls.input:get :focus) 1) self.focus-speed self.speed))))
   (set self.pos.y (- self.pos.y (* (math.sin self.current-angle) (if (= (controls.input:get :focus) 1) self.focus-speed self.speed))))
   (self.model:setTransform [self.pos.x self.z-index self.pos.y])
   (self.hitbox-model:setTransform [self.pos.x self.hitbox-z-index self.pos.y])
   ))

 :check-bounds (fn [self]
  (local x-limit 5.2)
  (local y-limit 3.8)
  (if (<= self.pos.x (- 0 x-limit))
   (set self.pos.x (- 0 x-limit))
   (>= self.pos.x x-limit)
   (set self.pos.x x-limit))
  (if (<= self.pos.y (- 0 y-limit))
   (set self.pos.y (- 0 y-limit))
   (>= self.pos.y y-limit)
   (set self.pos.y y-limit)))


 ; ----------------------------------
 ; shoot
 ; ----------------------------------

 :spawn-bullets-regular (fn [self]
  (local mod (/ math.pi 25))
  (local count (if (< self.power 25) 1
   (< self.power 50) 3
   (>= self.power 50) 5))
  (var angle (- (* 1.5 math.pi) (* mod (math.floor (/ count 2)))))
  (for [i 1 count]
   (ent:spawn (fn [bullet]
    (set bullet.type :player-bullet)))
   (set angle (+ angle mod))))

 :spawn-bullets-wide (fn [self]
  ; (var angle math.pi)
  ; (local count 12)
  ; (for [i 0 count]
  ;  (when (and (> i 0) (< i count))
  ;   (ent:spawn (fn [bullet]
  ;   (set bullet.type :player-bullet)
  ;   (set bullet.pos {:x (+ self.pos.x (* (math.cos angle) 8)) :y (+ self.pos.y (* (math.sin angle) 8))})
  ;   (set bullet.speed 8)
  ;    (set bullet.angle angle)
  ;   (set bullet.flags.type :wide))))
  ;  (set angle (+ angle (/ math.pi count))))
  )

 :update-shot (fn [self]
 	(when (and self.can-shoot (= (controls.input:get :shot) 1))
 		(set self.can-shoot false)
 		(set self.shot-clock 0))
 	(local interval 10)
 	(when (and (not self.can-shoot) (= (% self.shot-clock interval) 0)) (self:spawn-bullets-regular))
 	(set self.shot-clock (+ self.shot-clock 1))
 	(when (>= self.shot-clock interval) (set self.can-shoot true)))


 ; ----------------------------------
 ; get shot
 ; ----------------------------------

 :hit (fn [self bullet-type]
  ; (ent:spawn-explosion self.pos.x self.pos.y bullet-type true)
  ; (set g.kill-bullet-clock g.kill-bullet-limit)
  ; (set self.invincible-clock self.invincible-limit)
  ; (set self.lives (- self.lives 1))
  ; (set self.pos {:x self.init-pos.x :y self.init-pos.y})
  ; (when (< self.lives 0)
  ;  (set g.game-over true))
  )


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self]
  (when (and (not g.game-over) (> self.clock 5))
   (self:update-move)
   (self:check-bounds)
   (self:update-shot)
   (when (> self.invincible-clock 0) (set self.invincible-clock (- self.invincible-clock 1))))
  (when g.game-over (set self.pos {:x (* g.width 2) :y 0}))
  (set self.clock (+ self.clock 1)))

 :draw (fn [self]
  (when (not g.game-over)
   (local interval 15)
   (when (or (<= self.invincible-clock 0) (< (% self.invincible-clock (* interval 2)) interval))
    (self.model:draw)))
   (when (= (controls.input:get :focus) 1) (self.hitbox-model:draw))
  )


 })