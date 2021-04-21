(. {


 ; ----------------------------------
 ; load
 ; ----------------------------------

 :image nil
 :quad nil
 :size 32

 :load (fn [self]
  (set self.image (love.graphics.newImage "img/explosions.png"))
  (self.image:setFilter :nearest :nearest)
  (set self.quad (love.graphics.newQuad 0 0 self.size self.size self.image)))


 ; ----------------------------------
 ; spawn
 ; ----------------------------------

 :spawn (fn [self explosion]
  (set explosion.draw-level 5)
  (set explosion.flags.t-x 0)
  (set explosion.flags.t-y 0)
  (set explosion.flags.f-x (if (< (math.random) 0.5) 1 -1))
  (set explosion.flags.f-y (if (< (math.random) 0.5) 1 -1))
  (when explosion.flags.big
   (set explosion.flags.f-x (* explosion.flags.f-x 2))
   (set explosion.flags.f-y (* explosion.flags.f-y 2)))
  (when explosion.flags.small
   (set explosion.flags.f-x (/ explosion.flags.f-x 2))
   (set explosion.flags.f-y (/ explosion.flags.f-y 2))))


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self explosion]
  (local interval 5)
  (var frame 0)
  (when (>= explosion.clock interval) (set frame 1))
  (when (>= explosion.clock (* interval 2)) (set frame 2))
  (when (>= explosion.clock (* interval 3)) (set frame 3))
  (when (>= explosion.clock (* interval 4)) (set frame 4))
  (when (>= explosion.clock (* interval 5)) (set explosion.active false))
  (set explosion.flags.t-x (* self.size frame))
  (set explosion.flags.t-y (* self.size (- explosion.flags.color 1))))

 :draw (fn [self explosion]
  (self.quad:setViewport explosion.flags.t-x explosion.flags.t-y self.size self.size (self.image:getDimensions))
  (love.graphics.draw self.image self.quad explosion.pos.x explosion.pos.y 0 explosion.flags.f-x explosion.flags.f-y (/ self.size 2) (/ self.size 2)))


 })