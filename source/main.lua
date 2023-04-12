local gfx = playdate.graphics
local geom = playdate.geometry
import 'CoreLibs/graphics'

local input_vector = geom.vector2D.new(0, 0)

-- load images
local background = gfx.image.new('back')
local mask = gfx.image.new(400, 240, gfx.kColorBlack)
local canvas = gfx.image.new(400, 240)
canvas:setMaskImage(mask)

-- starting positions for lights and background
local light_a = {x = 300, y = 120}
local light_b = {x = 100, y = 120}
local background_pos = {x = -300, y = 0}

function playdate.update()
    
    gfx.fillRect(0, 0, 400, 240)
    
    -- update light position
    if aDown then 
        light_a.x += input_vector.dx * 2
        light_a.y -= input_vector.dy * 2
    elseif bDown then
        light_b.x += input_vector.dx * 2
        light_b.y -= input_vector.dy * 2
    else
        background_pos.x -= input_vector.dx * 2
        background_pos.y += input_vector.dy * 2
    end
    
    -- draw the background to the canvas
    gfx.lockFocus(canvas)
    background:draw(background_pos.x, background_pos.y)
    
    -- update the canvas mask
    local frame_mask = canvas:getMaskImage()
    gfx.lockFocus(frame_mask)
    gfx.fillRect(0, 0, 400, 240)
    gfx.setColor(gfx.kColorWhite)
    gfx.setDitherPattern(0.8)
    gfx.fillCircleAtPoint(light_a.x, light_a.y, 80)
    gfx.fillCircleAtPoint(light_b.x, light_b.y, 80)
    gfx.setColor(gfx.kColorWhite)
    gfx.setDitherPattern(0.4)
    gfx.fillCircleAtPoint(light_a.x, light_a.y, 70)
    gfx.fillCircleAtPoint(light_b.x, light_b.y, 70)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(light_a.x, light_a.y, 50)
    gfx.fillCircleAtPoint(light_b.x, light_b.y, 50)
    gfx.unlockFocus()
    
    -- draw canvas to screen
    canvas:draw(0, 0)
    
end

-- input callbacks
function playdate.leftButtonDown() input_vector.dx = -1 end
function playdate.leftButtonUp() input_vector.dx = 0 end
function playdate.rightButtonDown() input_vector.dx = 1 end
function playdate.rightButtonUp() input_vector.dx = 0 end
function playdate.upButtonDown() input_vector.dy = 1 end
function playdate.upButtonUp() input_vector.dy = 0 end
function playdate.downButtonDown() input_vector.dy = -1 end
function playdate.downButtonUp() input_vector.dy = 0 end
function playdate.AButtonDown() aDown = true end
function playdate.AButtonHeld() aHeld = true end
function playdate.AButtonUp() aDown = false aHeld = false end
function playdate.BButtonDown() bDown = true end
function playdate.BButtonHeld() bHeld = true end
function playdate.BButtonUp() bDown = false bHeld = false end