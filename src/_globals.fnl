; -----------------------------------
; masks
; -----------------------------------

(local masks {
 :half (love.graphics.newImage "img/masks/half.png")
 :most (love.graphics.newImage "img/masks/most.png")
 :least (love.graphics.newImage "img/masks/least.png")})
(local mask-shader (require "lib.maskshader"))


(. {


 ; ----------------------------------
 ; metrics
 ; ----------------------------------

 :width 320
 :height 240
 :scale 3
 :grid 16
 

 ; ----------------------------------
 ; state
 ; ----------------------------------

 :started false
 :hard-mode false

 :game-over false
 :game-over-clock 0

 :toggle-fullscreen (fn [] (print "fullscreen"))

 :current-score 0
 :high-score 0

 :process-score (fn [input]
		(var score (tostring input))
		(for [i 1 (- 8 (length score))] (set score (.. "0" score)))
		(. score))

 :kill-bullet-clock 0
 :kill-bullet-limit (* 60 2)
 :save-table nil


 ; ----------------------------------
 ; colors
 ; ----------------------------------

 :colors {
		:black (hex.rgb :0d080d)
		:brown-dark (hex.rgb :4f2b24)
		:brown (hex.rgb :825b31)
		:brown-light (hex.rgb :c59154)
		:yellow-dark (hex.rgb :f0bd77)
		:yellow (hex.rgb :fbdf9b)
		:gray (hex.rgb :bebbb2)
		:green (hex.rgb :7bb24e)
		:blue-light (hex.rgb :74adbb)
		:blue (hex.rgb :4180a0)
		:blue-dark (hex.rgb :32535f)
		:purple (hex.rgb :2a2349)
		:red-dark (hex.rgb :7d3840)
		:red (hex.rgb :c16c5b)
		:red-light (hex.rgb :e89973)
		:white (hex.rgb :fff9e4)
		}

 :set-color (fn [self color] (love.graphics.setColor (. self.colors color)))

 :reset-color (fn [] (love.graphics.setColor (hex.rgb :ffffff)))
 

 ; ----------------------------------
 ; helpers
 ; ----------------------------------

 :phi 1.61803398875
 :tau (* math.pi 2)

 :images (fn [dir files sprite]
		(local arr {})
		(each [i file (ipairs files)]
		 (local img (love.graphics.newImage (.. (if sprite "" "img/") dir "/" file ".png")))
		 (img:setFilter :nearest :nearest)
		 (tset arr file img))
		(. arr))

 :move-vector (fn [vector angle speed]
		(set vector.x (+ vector.x (* (math.cos angle) speed)))
		(set vector.y (+ vector.y (* (math.sin angle) speed)))
		(. vector))

 :update-velocity (fn [entity]
		(set entity.velocity {:x (* (math.cos entity.angle) entity.speed) :y (* (math.sin entity.angle) entity.speed)}))

 :get-angle (fn [a b] (. (math.abs (math.atan2 (- b.y a.y) (- b.x a.x)))))

 :get-distance (fn [a b] (. (math.sqrt (+ (* (- a.x b.x) (- a.x b.x)) (* (- a.y b.y) (- a.y b.y))))))

 :draw-gradient (fn [img x y w h r ox oy kx ky]
 		(. (love.graphics.draw img x y r (/ w (img:getWidth)) (/ h (img:getHeight)) ox oy kx ky))
 	)
 

 ; ----------------------------------
 ; masks
 ; ----------------------------------

 :mask (fn [mask callback]
		; (love.graphics.stencil (fn []
		;  (love.graphics.setShader mask-shader)
		;  (love.graphics.draw (. masks mask) 0 0)
		;  (. (love.graphics.setShader))) :replace 1)
		; (love.graphics.setStencilTest :greater 0)
		(callback)
		; (love.graphics.setStencilTest)
		)


 ; ----------------------------------
 ; label
 ; ----------------------------------

 :font (love.graphics.newFont "font/Natural Pro.ttf" 16)
 ; :font (love.graphics.newFont "font/small.ttf" 8)

 :label (fn [self input ?x y ?align ?limit ?color shadow]
		(local x (if ?x ?x 0))
		(local align (if ?align ?align :left))
		(local limit (if ?limit ?limit self.width))
		(local color (if ?color ?color :white))
		(self:set-color :black)
		(love.graphics.printf input x (+ y 1) limit align)
		(love.graphics.printf input (+ x 1) y limit align)
		(love.graphics.printf input x (- y 1) limit align)
		(love.graphics.printf input (- x 1) y limit align)
		(love.graphics.printf input (- x 1) (- y 1) limit align)
		(love.graphics.printf input (+ x 1) (- y 1) limit align)
		(love.graphics.printf input (- x 1) (+ y 1) limit align)
		(love.graphics.printf input (+ x 1) (+ y 1) limit align)
		(self:set-color color)
		(love.graphics.printf input x y limit align)
		(when shadow (self.mask :half (fn []
			(self:set-color shadow)
			(love.graphics.setScissor x (+ y 9) g.width 7)
			(love.graphics.printf input x y limit align)
			(love.graphics.setScissor))))
		(self.reset-color))


 })