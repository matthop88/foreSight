local Graphics = require("app/lib/graphics")

local gfx = Graphics:create()

love.draw = function()
    gfx:clear(0.12, 0.12, 0.14, 1)
end

-- Require engine AFTER love.draw is defined so the engine captures it as oldDraw.
require("app/plugins/engine")
    :add("doubleClick", { accessorFnName = "getDoubleClick" })
    :add("scrolling",   { imageViewer = gfx })
    :add("zooming",     { imageViewer = gfx })
    :add("nodeManager", {
        gfx   = gfx,
        nodes = {
            { id = "power",   label = "Power System",   x =  60, y = 100, w = 200, h = 110, color = { 0.3,  0.55, 1.0  } },
            { id = "control", label = "Control System", x = 340, y = 100, w = 200, h = 110, color = { 0.2,  0.75, 0.5  } },
            { id = "sensors", label = "Sensors",        x =  60, y = 290, w = 200, h = 110, color = { 0.9,  0.55, 0.2  } },
            { id = "actuate", label = "Actuators",      x = 340, y = 290, w = 200, h = 110, color = { 0.85, 0.3,  0.3  } },
            { id = "ui",      label = "User Interface", x = 620, y = 195, w = 200, h = 110, color = { 0.7,  0.4,  0.9  } },
        },
    })
    :add("questionBox",
        {   x                = 1150,
            useDoubleClick   = true,
            getDoubleClickFn = getDoubleClick,
            lines = {
                { "Arrows", "Pan"         },
                { "Z/A",    "Zoom In/Out" },
            },
        })
