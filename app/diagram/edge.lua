local Edge = {}

local ARROW_LENGTH = 16
local ARROW_WIDTH  =  8

function Edge.new(params, nodeMap)
    return {
        from  = nodeMap[params.from],
        to    = nodeMap[params.to],
        color = params.color or { 0.7, 0.7, 0.7 },

        draw = function(self, gfx)
            if not self.from or not self.to then return end

            -- Connection points: right-center of source, left-center of target
            local x1 = self.from.x + self.from.w
            local y1 = self.from.y + self.from.h / 2
            local x2 = self.to.x
            local y2 = self.to.y + self.to.h / 2

            -- Unit vector along the edge
            local dx  = x2 - x1
            local dy  = y2 - y1
            local len = math.sqrt(dx * dx + dy * dy)
            if len == 0 then return end
            local ux =  dx / len
            local uy =  dy / len
            local px = -uy       -- perpendicular
            local py =  ux

            -- Line runs up to the base of the arrowhead
            local bx = x2 - ux * ARROW_LENGTH
            local by = y2 - uy * ARROW_LENGTH

            local r, g, b = self.color[1], self.color[2], self.color[3]
            gfx:setColor(r, g, b, 0.85)
            gfx:line(x1, y1, bx, by)

            -- Filled arrowhead triangle
            gfx:polygon("fill",
                x2,                          y2,
                bx + px * ARROW_WIDTH,       by + py * ARROW_WIDTH,
                bx - px * ARROW_WIDTH,       by - py * ARROW_WIDTH)
        end,
    }
end

return Edge
