local Graphics = require("app/lib/graphics")
local Node     = require("app/diagram/node")

local gfx = Graphics:create()

local nodes = {
    Node.new({ id = "power",   label = "Power System",   x =  60, y = 100, w = 200, h = 110, color = { 0.3,  0.55, 1.0  } }),
    Node.new({ id = "control", label = "Control System", x = 340, y = 100, w = 200, h = 110, color = { 0.2,  0.75, 0.5  } }),
    Node.new({ id = "sensors", label = "Sensors",        x =  60, y = 290, w = 200, h = 110, color = { 0.9,  0.55, 0.2  } }),
    Node.new({ id = "actuate", label = "Actuators",      x = 340, y = 290, w = 200, h = 110, color = { 0.85, 0.3,  0.3  } }),
    Node.new({ id = "ui",      label = "User Interface", x = 620, y = 195, w = 200, h = 110, color = { 0.7,  0.4,  0.9  } }),
}

love.draw = function()
    gfx:clear(0.12, 0.12, 0.14, 1)

    for _, node in ipairs(nodes) do
        node:draw(gfx)
    end

    -- HUD: help text fixed to screen position (10, 10)
    local hx, hy = gfx:screenToImageCoordinates(10, 10)
    gfx:setColor(0.6, 0.6, 0.6, 1)
    gfx:setFontSize(12)
    gfx:printf("arrows: pan    Z/A: zoom", hx, hy, 400, "left")
end

-- Require engine AFTER love.draw is defined so the engine captures it as oldDraw.
local engine = require("app/plugins/engine")
engine:add("scrolling", { imageViewer = gfx })
engine:add("zooming",   { imageViewer = gfx })
