(local binser (require "lib.binser"))


(. {


 ; ----------------------------------
 ; load
 ; ----------------------------------

 :filename "savedata.lua"

 :load (fn [self]
  (local save-data (love.filesystem.read self.filename))
  (when save-data
   (set g.save-table (. (binser.deserialize save-data) 1))
   (when g.save-table.high-score (set g.high-score g.save-table.high-score))
   (when (and g.save-table.fullscreen (or (= g.save-table.fullscreen true) (= g.save-table.fullscreen :true))) (love.window.setFullscreen true)))
  (when (not save-data) (set g.save-table {})))


 ; ----------------------------------
 ; high score
 ; ----------------------------------

 :saved-score false

 :save-score (fn [self]
  (when (>= g.current-score g.high-score) (set g.high-score g.current-score))
  (when (and g.game-over (not self.saved-score) (>= g.current-score g.high-score))
   (set g.save-table.high-score g.current-score)
   (local save-data (binser.serialize g.save-table))
   (love.filesystem.write self.filename save-data)
   (set self.saved-score true)))


 ; ----------------------------------
 ; fullscreen
 ; ----------------------------------

 :save-fullscreen (fn [self])
 

 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update (fn [self]
  (self:save-score))


 })