(. {

 ; ----------------------------------
 ; hud
 ; ----------------------------------

 :images nil

 :load (fn [self]
  (set self.images (g.images "chrome" ["heart" "cardwide" "cardstraight" "cardshield"])))


 ; ----------------------------------
 ; hud
 ; ----------------------------------

 :hud-y 0

 :boss-health 0
 :boss-max-health 100
 :pattern-name nil

 :draw-score (fn [self]
  (local y self.hud-y)
  (g:label (.. "Sc " (g.process-score g.current-score)) 4 y nil nil :white :yellow)
  (g:label (.. "Hi " (g.process-score g.high-score)) nil y :right (- g.width 3) :white :yellow))

 :draw-lives (fn [self]
  (var y (+ self.hud-y 16))
  (var x 3)
  ; (g:label "1P" 4 y nil nil :yellow :yellow-dark)
  (when (> player.lives 0)
   (for [i 1 player.lives]
    (love.graphics.draw self.images.heart x y)
    (set x (+ x 16)))))

 :card-width 15
 :card-height 20

 :draw-card (fn [self x y card-type]
  (g:set-color :black)
  (love.graphics.rectangle :fill (- x 1) (- y 1) (+ self.card-width 2) (+ self.card-height 2))
  (g:set-color :white)
  (love.graphics.rectangle :fill x y self.card-width self.card-height)
  (g:set-color :yellow)
  (love.graphics.rectangle :fill x (+ y (/ self.card-height 2)) self.card-width (+ (/ self.card-height 4) 2))
  (love.graphics.rectangle :fill x (+ y (* (/ self.card-height 4) 3) 2) self.card-width (- (/ self.card-height 4) 2))
  (love.graphics.rectangle :fill x (+ y (- self.card-height 1)) self.card-width 1)
  (g.reset-color)
  (local img (. self.images card-type))
  (love.graphics.draw img x (+ y 1)))

 :draw-cards (fn [self]
  (local y (+ self.hud-y 14))
  (var x (- g.width self.card-width 4))
  (for [i 1 3]
   (self:draw-card x y (if (= i 3) :cardwide (if (= i 1) :cardshield :cardstraight)))
   (set x (- x self.card-width 3))))


 ; ----------------------------------
 ; boss
 ; ----------------------------------

 :boss-gradient (gradient [g.colors.yellow-dark g.colors.red-light])
 :draw-boss-health (fn [self]
  (set self.hud-y 12)
  (local width (- g.width 8))
  (local b-width (* (/ self.boss-health self.boss-max-health) width))
  (g:set-color :black)
  (love.graphics.rectangle :fill 3 3 (+ b-width 2) 10)
  (g:set-color :yellow)
  (love.graphics.rectangle :fill 4 4 b-width 1)
  (g:set-color :yellow-dark)
  (love.graphics.rectangle :fill 4 5 b-width 3)
  (g:set-color :red-light)
  (love.graphics.rectangle :fill 4 8 b-width 3)
  (g:set-color :red)
  (love.graphics.rectangle :fill 4 11 b-width 1)
  (g.reset-color))

 :draw-boss (fn [self]
  (when (> self.boss-health 0) (self:draw-boss-health))
  (when self.pattern-name (g:label self.pattern-name 0 self.hud-y :center nil :white :yellow)))


 ; ----------------------------------
 ; game over
 ; ----------------------------------

 :draw-game-over (fn [self]
  (g:set-color :black)
  (g.mask :most #(love.graphics.rectangle :fill 0 0 g.width g.height))
  (g.reset-color)
  (var y (- (/ g.height 2) 31))
  (g:label "GAME OVER" 0 y :center nil :yellow :yellow-dark true)
  (set y (+ y 16 4))
  (g:label "FINAL" 0 y :center nil :white :yellow true)
  (set y (+ y 16))
  (g:label (g.process-score g.current-score) 0 y :center nil :white :yellow true)
  (when (>= g.current-score g.high-score)
   (set y (+ y 16 4))
   (g:label "NEW HIGH SCORE!" 0 y :center nil :yellow :yellow-dark true)))


 ; ----------------------------------
 ; debug
 ; ----------------------------------

 :draw-debug (fn [self]
  (var fps (math.floor (love.timer.getFPS)))
  (when (> fps 60) (set fps 60))
  (g:label (.. ent.entity-count " Entities") 4 (- g.height 7 4) nil nil :red :red-dark)
  (g:label (.. ent.enemy-bullet-count " Bullets") 4 (- g.height 7 4 10) nil nil :red-light :red)
  (g:label (.. ent.enemy-count " Enemies") 4 (- g.height 7 4 10 10) nil nil :yellow-dark :red-light)
  (g:label (if g.hard-mode "Hard" "Easy") 0 (- g.height 7 4 10) :right (- g.width 4) :red-light :red)
  (g:label (.. (tostring fps) " FPS") 0 (- g.height 7 4) :right (- g.width 4) :red :red-dark)
  )

 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :draw (fn [self]
  (when (not g.game-over) 
   (set self.hud-y 0)
   (self:draw-boss)
   (self:draw-score)
   (self:draw-lives)
   ; (self:draw-cards)
   )
  ; (self:draw-debug)
  (when g.game-over (self:draw-game-over)))


 })