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

 :spawn (fn [self entity]
  (set entity.draw-level 5)
  (set entity.flags.t-x 0)
  (set entity.flags.t-y 0)
  (set entity.flags.f-x (if (< (math.random) 0.5) 1 -1))
  (set entity.flags.f-y (if (< (math.random) 0.5) 1 -1))
  (when entity.flags.big
   (set entity.flags.f-x (* entity.flags.f-x 2))
   (set entity.flags.f-y (* entity.flags.f-y 2)))
  (when entity.flags.small
   (set entity.flags.f-x (/ entity.flags.f-x 2))
   (set entity.flags.f-y (/ entity.flags.f-y 2))))


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self entity]
  )

 :draw (fn [self entity]
  (self.quad:setViewport entity.flags.t-x entity.flags.t-y self.size self.size (self.image:getDimensions))
  (love.graphics.draw self.image self.quad entity.pos.x entity.pos.y 0 entity.flags.f-x entity.flags.f-y (/ self.size 2) (/ self.size 2)))


 })