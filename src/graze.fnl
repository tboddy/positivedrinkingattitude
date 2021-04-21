(. {


 ; ----------------------------------
 ; load
 ; ----------------------------------

 :image nil
 :quad nil

 :load (fn [self]
  (set self.image (love.graphics.newImage "img/player/graze.png"))
  (self.image:setFilter :nearest :nearest)
  (set self.quad (love.graphics.newQuad 0 0 (self.image:getWidth) (self.image:getHeight) self.image)))


 ; ----------------------------------
 ; spawn
 ; ----------------------------------

 :spawn (fn [self graze]
  (set graze.draw-level 5)
  (local angle (g.get-angle player.pos graze.pos))
  (local speed 1)
  (set graze.velocity {:x (* (math.cos angle) speed) :y (* (math.sin angle) speed)})
  (set graze.flags.direction (< (math.random) 0.5))
  (set g.current-score (+ g.current-score 10)) )


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self graze]
  (set graze.pos.x (+ graze.pos.x graze.velocity.x))
  (set graze.pos.y (+ graze.pos.y graze.velocity.y))
  (when (>= graze.clock 15) (set graze.active false)))

 :draw (fn [self graze]
  (g.mask :half #(love.graphics.draw self.image self.quad graze.pos.x graze.pos.y graze.rotation 1 1 (/ (self.image:getWidth) 2) (/ (self.image:getHeight) 2))))


 })