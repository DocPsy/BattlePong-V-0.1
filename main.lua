-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


H = display.contentHeight
W = display.contentWidth

--Int
display.setStatusBar(display.HiddenStatusBar)
local background = display.newImage("background.jpg")
local sound = media.playSound( "background.mp3") 
system.activate("multitouch")
physics = require('physics')
physics.start()
physics.setGravity(0,0)
playing = false
local life1 = 100
local life2 = 100



-- Game-Area physikalische Eigenschaften
leftwall = display.newRect(0,0, 10, 320)
leftwall.name = "leftwall"
physics.addBody(leftwall, "static", {bounce=1, density=1})
  
rightwall = display.newRect(470, 0, 10, 320)
rightwall.name = "rightwall"
physics.addBody(rightwall, "static", {bounce=1, density=1})
  
floor = display.newRect(0,310, 480, 10)
physics.addBody(floor, "static", {bounce=1, density=1})
top = display.newRect(0,0, 480, 10)
physics.addBody(top, "static", {bounce=1, density=1})

--Scoreanzeige
life1text = display.newText("100", W/12, H/2 - 150, "Helvetica", 20)
life1text:setTextColor(178,34,34)
life2text = display.newText("100", W/10*9, H/2 - 150, "Helvetica", 20)
life2text:setTextColor(107,142,35)


-- Scoreverhalten bei Kollision mit linker oder rechter Begrenzung
function onPostCollision(e)
  if (e.other.name == "leftwall") then
    life1 = life1 -10 
    life1text.text = life1
    transition.to(ball, {x = W/2, y= H/2, time=0})
    playing = false
    ball:setLinearVelocity(0,0)
  elseif (e.other.name == "rightwall") then
    life2 = life2 - 10
    life2text.text = life2
    transition.to(ball, {x = W/2, y= H/2, time=0})
    playing = false
    ball:setLinearVelocity(0,0)
  end
end




-- Kollisionsaktion und Ballverhalten
local function onCollision(e)
end
  ball = display.newCircle(250,165,10)
  ball.name = "ball"
  physics.addBody(ball, {bounce=1.4, density=10, radius=10})
  ball:addEventListener("postCollision", onPostCollision)
  ball:addEventListener("collision", onCollision)

--Paddelsteuerung
function movePad(e)
  if not (e.target.name == "pad1" or e.target.name == "pad2") then
    return false
  end
  local touchObject = e.target
  if e.phase == "moved" then
    touchObject.y = e.y
  end
end

--Paddeleigenschaften 
pad1 = display.newRect(30, 115, 20, 90)
pad1.name = "pad1"
physics.addBody(pad1, "static", {bounce=1, density=1})
pad1:addEventListener("touch", movePad)
  
pad2 = display.newRect(430, 115, 20, 90)
pad2.name = "pad2"
physics.addBody(pad2, "static", {bounce=1, density=1})
pad2:addEventListener("touch", movePad)


--Pause und Startbutton 
local pause = display.newRect(W/2, 280, 20,20)
function pause:tap(e)
  playing = not playing
  if (playing) then
    ball:applyLinearImpulse(10,10, ball.x, ball.y)
  else
  	ball:setLinearVelocity(0,0)
  	end
end
pause:addEventListener("tap", pause)

