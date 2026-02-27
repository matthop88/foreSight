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
        gfx     = gfx,
        diagram = require("app/diagram/sampleDiagram"),
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
