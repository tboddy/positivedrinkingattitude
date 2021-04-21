(local levels [

 (fn []

  ; (fn spawn-bullets [enemy]
  ;  (local count 32)
  ;  (var angle (+ (g.get-angle enemy.pos player.pos) enemy.flags.bullet-angle))
  ;  (for [i 1 count]
  ;   (ent:spawn (fn [bullet]
  ;    (set bullet.type :enemy-bullet)
  ;    (set bullet.pos {:x enemy.pos.x :y enemy.pos.y})
  ;    (set bullet.angle angle)
  ;    (set bullet.flags.type 1)
  ;    (set bullet.speed 0.05)))
  ;   (set angle (+ angle (/ g.tau count))))
  ;  (set enemy.flags.bullet-angle (+ enemy.flags.bullet-angle 0.1)))

  ; (fn spawn-enemy [offset]
  ;  (ent:spawn (fn [enemy]
  ;   (set enemy.type :enemy)
  ;   (var x (+ -4 (* (math.random) 8)))
  ;   (set enemy.pos {:x x :y (+ (* offset 2) 5)})
  ;   (set enemy.speed 0.02)
  ;   (set enemy.health 10)
  ;   (set enemy.flags.bullet-angle 0)
  ;   (set enemy.angle (/ math.pi 2)))
  ;   (fn [enemy]
  ;    (when (= (% enemy.shot-clock 30) 15) (spawn-bullets enemy)))))

  ; (for [i 1 4] (spawn-enemy (- i 1)))
  )

])

(local bosses [

 (fn []

  (local patterns [

   (fn [enemy]
    (fn sides []
     (fn spawn-bullets [opposite]
      (local count 2)
      (var angle (if opposite enemy.flags.bullet-angle-1 enemy.flags.bullet-angle-2))
      (local bullet-x (+ enemy.pos.x (if opposite 3 -3)))
      (for [i 1 count]
       (ent:spawn (fn [bullet]
        (set bullet.type :enemy-bullet)
        (set bullet.pos {:x bullet-x :y enemy.pos.y})
        (set bullet.angle angle)
        (set bullet.speed 0.1)
        (set bullet.flags.limit 0.05)
        (set bullet.flags.opposite (if opposite true false))
        (set bullet.flags.mod (if opposite 0.01 -0.01))
        (set bullet.flags.type 5))
        (fn [bullet]
         (when (> bullet.speed bullet.flags.limit) (set bullet.speed (- bullet.speed 0.001)))
         (when (<= bullet.speed bullet.flags.limit) (set bullet.angle (+ bullet.angle bullet.flags.mod)))
         (g.update-velocity bullet)))
       (set angle (+ angle (/ g.tau count))))
      (local a-mod (/ g.phi 7))
      (if opposite
       (set enemy.flags.bullet-angle-1 (+ enemy.flags.bullet-angle-1 a-mod))
       (set enemy.flags.bullet-angle-2 (- enemy.flags.bullet-angle-2 a-mod))))
     (local interval 2)
     (local limit (* interval 50))
     (local max (+ limit (* interval 40)))
     (when (and (= (% enemy.shot-clock interval) 0) (<= (% enemy.shot-clock max) limit))
      (spawn-bullets (< (% enemy.shot-clock (* max 2)) max))))
    (fn center []
     (fn spawn-bullets []
      (local mod (/ math.pi 12))
      (ent:spawn (fn [bullet]
       (set bullet.type :enemy-bullet)
       (set bullet.pos {:x enemy.pos.x :y enemy.pos.y})
       (set bullet.angle (+ mod (* (- math.pi (* mod 2)) (math.random))))
       (set bullet.speed 0.07)
       (set bullet.flags.limit 0.03)
       (set bullet.flags.type 8))
       (fn [bullet]
        (when (> bullet.speed bullet.flags.limit)
         (set bullet.speed (- bullet.speed 0.001))
         (g.update-velocity bullet)))))
     (local interval 2)
     (local limit (* interval 50))
     (local max (+ limit (* interval 40)))
     (when (and (= (% enemy.shot-clock (* interval 4)) 0) (> (% enemy.shot-clock max) limit))
      (spawn-bullets)))
    (sides)
    (center)
    (set chrome.pattern-name "poop"))

   (fn [enemy]
    (fn center []
     (fn spawn-bullets []
      (var angle enemy.flags.bullet-angle-1)
      (local count 3)
      (local s-count 5)
      (local distance 1)
      (local s-distance 0.65)
      (for [i 1 count]
       (var x (+ enemy.pos.x (* (math.cos angle) distance)))
       (var y (- enemy.pos.y (* (math.sin angle) distance)))
       (local s-angle (+ angle (/ math.pi 2)))
       (local diff (* s-distance (math.floor (/ s-count 2))))
       (set x (- x (* (math.cos s-angle) diff)))
       (set y (+ y (* (math.sin s-angle) diff)))
       (for [j 1 s-count]
        (ent:spawn (fn [bullet]
         (set bullet.type :enemy-bullet)
         (set bullet.pos {:x x :y y})
         (set bullet.angle angle)
         (set bullet.speed 0.075)
         (set bullet.flags.type 9))
         (fn [bullet]))
        (set x (+ x (* (math.cos s-angle) s-distance)))
        (set y (- y (* (math.sin s-angle) s-distance)))
        )
       (set angle (+ angle (/ g.tau count))))
      (set enemy.flags.bullet-angle-1 (+ enemy.flags.bullet-angle-1 (/ g.phi 2)))
      )
     (local interval 15)
     (when (= (% enemy.shot-clock interval) 0) (spawn-bullets)))
    (fn sides []
     (local x-mod 4)
     (fn spawn-bullet [opposite]
      (local bullet-x (+ enemy.pos.x (if opposite x-mod (- 0 x-mod))))
      (var angle (if opposite enemy.flags.bullet-angle-3 enemy.flags.bullet-angle-2))
      (local count 12)
      (for [i 1 count]
       (ent:spawn (fn [bullet]
        (set bullet.type :enemy-bullet)
        (set bullet.pos {:x bullet-x :y enemy.pos.y})
        (set bullet.angle angle)
        (set bullet.speed 0.1)
        (set bullet.flags.limit 0.05)
        (set bullet.flags.type 6))
        (fn [bullet]
         (when (> bullet.speed bullet.flags.limit)
          (set bullet.speed (- bullet.speed 0.002))
          (g.update-velocity bullet))))
       (set angle (+ angle (/ g.tau count)))))
     (local interval 6)
     (local limit (* interval 5))
     (local max (* interval 7))
     (when (and (= (% enemy.shot-clock interval) 0) (< (% enemy.shot-clock max) limit))
      (when (= (% enemy.shot-clock max) 0)
       (local b-mod 0.05)
       (set enemy.flags.bullet-angle-2 (- enemy.flags.bullet-angle-2 b-mod))
       (set enemy.flags.bullet-angle-3 (+ enemy.flags.bullet-angle-3 (* 2 b-mod))))
      (spawn-bullet (< (% enemy.shot-clock (* max 2)) max))))
    (center)
    (sides)
    (set chrome.pattern-name ""))

   (fn [enemy]
    (fn center []
     (fn spawn-bullets []
      (var angle enemy.flags.bullet-angle-1)
      (local count 16)
      (for [i 1 count]
       (ent:spawn (fn [bullet]
        (set bullet.type :enemy-bullet)
        (set bullet.pos {:x enemy.pos.x :y enemy.pos.y})
        (set bullet.angle angle)
        (set bullet.speed enemy.flags.bullet-speed-1)
        (set bullet.flags.type 7))
        (fn [bullet]))
       (set angle (+ angle (/ g.tau count))))
      (set enemy.flags.bullet-speed-1 (+ enemy.flags.bullet-speed-1 0.01)))
     (local interval 2)
     (local limit (* interval 4))
     (local max (* limit 5))
     (when (and (= (% enemy.shot-clock interval) 0) (< (% enemy.shot-clock max) limit))
      (when (= (% enemy.shot-clock limit) 0)
       (set enemy.flags.bullet-angle-1 (g.get-angle enemy.pos player.pos))
       (set enemy.flags.bullet-speed-1 0.05))
      (spawn-bullets)))
    (center)
    (set chrome.pattern-name "poop"))

   ])

  (fn spawn-enemy []
   (ent:spawn (fn [enemy]
    (set enemy.type :enemy)
    (set enemy.pos {:x 0 :y 6})
    (set enemy.speed 0.0725)
    (set enemy.health 100)
    (set enemy.flags.max-health enemy.health)
    (set enemy.flags.current-pattern 2)
    (set enemy.flags.bullet-angle-1 0)
    (set enemy.flags.bullet-angle-2 0)
    (set enemy.flags.bullet-angle-3 0)
    (set enemy.flags.bullet-speed-1 0)
    (set enemy.flags.scale 6)
    (set enemy.model-type :wine)
    (set enemy.skin-type :wine-red)
    (set enemy.angle (/ math.pi 2)))
    (fn [enemy]
     (when enemy.flags.ready
      ((. patterns enemy.flags.current-pattern) enemy)
      (set chrome.boss-health enemy.health))
     (when (not enemy.flags.ready)
      (set enemy.shot-clock -1)
      (set enemy.health enemy.flags.max-health)
      (set enemy.speed (- enemy.speed 0.001))
      (when (<= enemy.speed 0)
       (set enemy.speed 0)
       (set enemy.flags.ready true))
      (g.update-velocity enemy)))))
  (spawn-enemy))

])

(. {

 :clock 0
 :start-time 15

 :current-level 1
 :in-boss true

 :update (fn [self]
  (when (= self.clock self.start-time) ((. (if self.in-boss bosses levels) self.current-level)))
  (set self.clock (+ self.clock 1))
  (when (and (= ent.enemy-count 0) (> self.clock (* self.start-time 2)))
   (set self.in-boss (if self.in-boss false true))
   (set self.clock -1)))

 })