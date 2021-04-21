(. {


 :z-index -10
 :images nil


 ; ----------------------------------
 ; load
 ; ----------------------------------
 :bullet-images [
   :blue-small-1     :red-small-1
   :blue-small-2     :red-small-2
   :blue-small-3     :red-small-3
   :blue-big-1       :red-big-1
   :blue-big-2       :red-big-2
   :blue-big-3       :red-big-3
   :blue-big-4       :red-big-4
   :blue-big-5       :red-big-5
   :blue-big-6       :red-big-6
   :blue-big-7       :red-big-7
   :blue-bigger-1    :red-bigger-1
   :blue-biggest-1   :red-biggest-1]
 :load (fn [self] (set self.images (g.images "sprites/bullets" self.bullet-images true)))


 ; ----------------------------------
 ; spawn
 ; ----------------------------------


 :spawn (fn [self bullet]
  (var scale 1)
  (var img nil)
  (var sz nil)
  (fn s-bullet [b-type b-scale b-img b-sz does-rotate]
   (when (= bullet.flags.type b-type)
    (set scale b-scale) (set img b-img) (set sz b-sz) (when does-rotate (set bullet.flags.does-rotate true))))

  (s-bullet 1  0.25 :blue-small-1   8)
  (s-bullet 2  0.25 :red-small-1    8)

  (s-bullet 3  0.25 :blue-small-2   8)
  (s-bullet 4  0.25 :red-small-2    8)

  (s-bullet 5  0.25 :blue-small-3   6  true)
  (s-bullet 6  0.25 :red-small-3    6  true)

  (s-bullet 7  0.5  :blue-big-1     16)
  (s-bullet 8  0.5  :red-big-1      16)

  (s-bullet 9  0.5  :blue-big-2     8  true)
  (s-bullet 10 0.5  :red-big-2      8  true)

  (s-bullet 11 0.5  :blue-big-3     14 true)
  (s-bullet 12 0.5  :red-big-3      14 true)

  (s-bullet 13 0.5  :blue-big-4     8  true)
  (s-bullet 14 0.5  :red-big-4      8  true)

  (s-bullet 15 0.5  :blue-big-5     14 true)
  (s-bullet 16 0.5  :red-big-5      14 true)

  (s-bullet 17 0.5  :blue-big-6     8  true)
  (s-bullet 18 0.5  :red-big-6      8  true)

  (s-bullet 19 0.5  :blue-big-7     16 true)
  (s-bullet 20 0.5  :red-big-7      16 true)

  (s-bullet 21 0.75 :blue-bigger-1  8  true)
  (s-bullet 22 0.75 :red-bigger-1   8  true)

  (s-bullet 23 1    :blue-biggest-1 28 true)
  (s-bullet 24 1    :red-biggest-1  28 true)

  (local s-img (. self.images img))
  (set bullet.model (g3d.newModel "models/plane.obj" s-img [0 0 0] [0 0 0] [scale 1 scale]))
  (bullet.model:setTransform [bullet.pos.x self.z-index bullet.pos.y])
  (when (= bullet.flags.does-rotate true) (bullet.model:setRotation 0 bullet.angle 0))
  (set bullet.velocity {:x (* (math.cos bullet.angle) bullet.speed) :y (* (math.sin bullet.angle) bullet.speed)})
  (set bullet.flags.radius (/ (/ sz 2) 32))
  (set bullet.seen true))


 ; ----------------------------------
 ; collision
 ; ----------------------------------

 :check-collision (fn [self bullet]
  (local distance (g.get-distance bullet.pos player.pos))
  (when (< distance bullet.flags.radius)
   (set bullet.active false)
   (set bullet.model false)))


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self bullet]
  (set bullet.pos.x (+ bullet.pos.x bullet.velocity.x))
  (set bullet.pos.y (- bullet.pos.y bullet.velocity.y))
  (bullet.model:setTransform [bullet.pos.x self.z-index bullet.pos.y])
  (when bullet.flags.does-rotate
   (bullet.model:setRotation 0 bullet.angle 0))
  (self:check-collision bullet)
  (when (and bullet.active bullet.seen (or (> bullet.pos.x 6) (< bullet.pos.x -6) (> bullet.pos.y 4.5) (< bullet.pos.y -4.5)))
   (set bullet.active false)
   (set bullet.model false)))

 :draw (fn [self bullet]
  (bullet.model:draw))


 })