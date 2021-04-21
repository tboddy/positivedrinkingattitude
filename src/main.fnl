; -----------------------------------
; import
; -----------------------------------

(global maid64 (require "lib.maid"))
(global hex (require "lib.hex"))
(global hc (require "lib.hc"))
(global gradient (require "lib.gradient"))
(global g3d (require "lib.g3d"))
(global runhack (require "lib.runhack"))
(global g (require "_globals"))
(global saveload (require "saveload"))
(global controls (require "controls"))
(global start (require "start"))
(global background (require "background"))
(global player (require "player"))
(global ent (require "entities"))
(global level (require "level"))
(global chrome (require "chrome"))


; -----------------------------------
; load
; -----------------------------------

(fn love.load []
 (math.randomseed 1419)
 (love.window.setTitle "AHHHH!!! ARGHHHH!!!! AHHHHHHHH!!!!!!")
 (love.window.setMode (* g.width g.scale) (* g.height g.scale) {:vsync false :x 0 :y 0 :minwidth g.width :minheight g.height :resizable true})
 (maid64.setup g.width g.height)
 (love.graphics.setFont g.font)
 (love.graphics.setLineStyle "rough")
 (love.graphics.setLineWidth 1)
 (saveload:load)
 (controls:load)
 (start:load))


; -----------------------------------
; loop
; -----------------------------------


(fn update-game []
 (player:update)
 (background:update)
 (ent:update)
 (level:update)
 (saveload:update)
 (when (> g.kill-bullet-clock 0) (set g.kill-bullet-clock (- g.kill-bullet-clock 1))))

(fn love.update [dt]
 (controls:update)
 (if g.started (update-game) (start:update)))

(fn draw-game []
 (background:draw)
 (ent:draw)
 (player:draw)
 (chrome:draw))

(fn love.draw []
 (maid64.start)
 (if g.started (draw-game) (start:draw))
 (maid64.finish))


; -----------------------------------
; hacks
; -----------------------------------

(fn love.resize [width height]
 (maid64.resize width height))

(fn love.run []
 (runhack))
