local Graphics = require("app/lib/graphics")

local gfx = Graphics:create()

-- Draw a simple test scene in world coordinates.
-- Pan with arrow keys, zoom in/out with Z/A.
love.draw = function()
    gfx:clear(0.12, 0.12, 0.14, 1)

    -- Grid of rectangles to make pan/zoom visible
    gfx:setColor(0.3, 0.55, 1, 1)
    for row = 0, 4 do
        for col = 0, 5 do
            gfx:rectangle("line", col * 180, row * 140, 140, 100)
        end
    end

    -- A filled marker at the world origin
    gfx:setColor(1, 0.4, 0.4, 1)
    gfx:rectangle("fill", -10, -10, 20, 20)

    -- Label
    gfx:setColor(1, 1, 1, 1)
    gfx:setFontSize(14)
    gfx:printf("ForeSight  |  arrows: pan    Z/A: zoom", 0, -40, 600, "left")
end

-- Require engine AFTER love.draw is defined so the engine captures it as oldDraw.
local engine = require("app/plugins/engine")
engine:add("scrolling", { imageViewer = gfx })
engine:add("zooming",   { imageViewer = gfx })
