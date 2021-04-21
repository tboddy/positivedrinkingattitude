(local baton (require "lib.baton"))


(. {


 ; ----------------------------------
 ; load
 ; ----------------------------------

 :load (fn [self]
  (local baton-config {
   :controls {
    :left [:key:left :axis:leftx- :button:dpleft :key:a]
    :right [:key:right :axis:leftx+ :button:dpright :key:d]
    :up [:key:up :axis:lefty- :button:dpup :key:w]
    :down [:key:down :axis:lefty+ :button:dpdown :key:s]
    :shot [:key:z :button:a :key:space]
    :focus [:key:x :button:x :key:lshift]
    :pause [:key:escape :button:start]
    :reload [:key:r :button:back]
    :fullscreen [:key:f]
   }})
  (local joysticks (love.joystick.getJoysticks))
  (when (. joysticks 1) (set baton-config.joystick (. joysticks 1)))
  (set self.input (baton.new baton-config)))


 ; ----------------------------------
 ; state stuff
 ; ----------------------------------

 :update-pause (fn [self]
  (when (and (= (self.input:get :pause) 1) (not self.pausing))
   (set self.pausing true)
   (set g.paused (if g.paused false true)))
  (when (= (self.input:get :pause) 0) (set self.pausing false)))

 :update-fullscreen (fn [self]
  (if (and (= (self.input:get :fullscreen) 1) (not self.doing-fullscreen))
   (g.toggle-fullscreen)
   (= (self.input:get :fullscreen) 0)
   (set self.doing-fullscreen false)))

 :update-restart (fn [self]
  (when (and (>= g.game-over-clock 60) (self.shot)) (love.event.quit :restart))
  (when (= (self.input:get :reload) 1) (love.event.quit :restart)))


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self]
  (self.input:update)
  (self:update-fullscreen)
  (self:update-restart)
  (when (not g.game-over) (self:update-pause)))


 })