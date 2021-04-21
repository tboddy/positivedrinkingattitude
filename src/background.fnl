(. {


 ; ----------------------------------
 ; load
 ; ----------------------------------

 :bottom-models []

 :bottom-start 7
 :bottom-width 18
 :bottom-limit -7

 :z-index -15.5

 :clock 0

 :bg-color :black

 :load (fn [self]
  (for [i 1 312] (tset self.bottom-models i {:model false :transform false}))
  (for [i 1 13] (self:spawn-row i)))


 ; ----------------------------------
 ; spawn bottom tiles
 ; ----------------------------------

 :spawn-row (fn [self ?offset]
  (local offset (if ?offset ?offset 0))
  (var x (- 0 (/ self.bottom-width 2)))
  (for [i 1 self.bottom-width]
   (var index 0)
   (for [j 1 (length self.bottom-models)]
    (when (= index 0)
     (local b-model (. self.bottom-models j))
     (when (not b-model.model) (set index j))))
   (when (> index 0)
    (local t-model (. self.bottom-models index))
    (local scale 1)
    (set t-model.model (g3d.newModel "models/bg/ground.obj" "models/bg/ground1.png" [x 0 (- self.bottom-start offset)] [0 0 0] [scale 1 scale]))
    (set t-model.transform [x self.z-index (- self.bottom-start offset)])
    (set x (+ x 1)))))


 ; ----------------------------------
 ; loop
 ; ----------------------------------

 :update-b-model (fn [self b-model]
  (tset b-model.transform 3 (- (. b-model.transform 3) 0.05))
  (b-model.model:setTransform [(. b-model.transform 1) (. b-model.transform 2) (. b-model.transform 3)])
  (when (< (. b-model.transform 3) self.bottom-limit)
   (set b-model.model false)))

 :update (fn [self]
  (when (= (% self.clock 20) 0) (self:spawn-row))
  (for [i 1 (length self.bottom-models)]
   (local b-model (. self.bottom-models i))
   (when b-model.model (self:update-b-model b-model)))
  (set self.clock (+ self.clock 1)))

 :draw (fn [self]
  (for [i 1 (length self.bottom-models)]
   (local b-model (. self.bottom-models i))
   (when b-model.model (b-model.model:draw))))


  })