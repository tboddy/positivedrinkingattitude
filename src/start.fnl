(. {


 ; ----------------------------------
 ; load
 ; ----------------------------------

 :images nil

 :load (fn [self]
  (set self.images (g.images "start" ["logo"])))


 ; ----------------------------------
 ; text
 ; ----------------------------------

 :draw-logo (fn [self]
  (love.graphics.draw self.images.logo (/ g.width 2) (- (/ g.height 2) 16 4) 0 1 1 (/ (self.images.logo:getHeight) 2) (/ (self.images.logo:getWidth) 2)))

 :draw-prompt (fn []
  (g:label "PRESS ANY BUTTON" nil (+ (* (/ g.height 4) 3) 8) :center nil :white :yellow))

 :draw-credits (fn []
  (g:label "2021 T. BODDY NO RIGHTS RESERVED" 0 (- g.height 7 8 8 2 2) :center nil :yellow :yellow-dark)
  (g:label "TOUHOU © ZUN/TEAM SHANGHAI ALICE" 0 (- g.height 7 8 2) :center nil :yellow-dark :red-light))
  

 ; ----------------------------------
 ; start game
 ; ----------------------------------

 :load-game (fn []
  (set g.started true)
  (background:load)
  (ent:load)
  (player:load)
  (chrome:load))


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self]
  (self.load-game)
  (when (= (controls.input:get :shot) 1) (self.load-game)))

 :draw (fn [self]
  (g:set-color :black)
  (love.graphics.rectangle :fill 0 0 g.width g.height)
  (g.reset-color)
  (self:draw-logo)
  (self.draw-prompt)
  (self.draw-credits))


 })