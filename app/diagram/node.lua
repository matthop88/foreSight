local Node = {}

function Node.new(params)
    return {
        id       = params.id       or "node",
        label    = params.label    or "",
        title    = params.title,
        x        = params.x        or 0,
        y        = params.y        or 0,
        w        = params.w        or 200,
        h        = params.h        or 120,
        color    = params.color    or { 0.3, 0.55, 1.0 },
        children = {},
        edges    = {},
        hovered  = false,
        selected = false,

        containsPoint = function(self, wx, wy)
            return wx >= self.x and wx < self.x + self.w
               and wy >= self.y and wy < self.y + self.h
        end,

        drawTitle = function(self, gfx)
            if not self.title then return end

            local r, g, b = self.color[1], self.color[2], self.color[3]
            local px, py  = 10, 4

            gfx:setFontSize(11)
            local tw = gfx:getFontWidth(self.title) + px * 2
            local th = gfx:getFontHeight()          + py * 2
            local tx = self.x + (self.w - tw) / 2
            local ty = self.y - th / 2   -- top edge of node bisects the title

            gfx:setColor(r, g, b, 0.9)
            gfx:rectangle("fill", tx, ty, tw, th)
            gfx:setColor(r, g, b, 1)
            gfx:rectangle("line", tx, ty, tw, th)
            gfx:setColor(1, 1, 1, 1)
            gfx:printf(self.title, tx + px, ty + py, tw - px * 2, "left")
        end,

        drawLabel = function(self, gfx)
            gfx:setFontSize(14)
            local lineHeight = gfx:getFontHeight()
            local numLines   = select(2, self.label:gsub("\n", "\n")) + 1
            local textY      = self.y + (self.h - numLines * lineHeight) / 2
            gfx:setColor(1, 1, 1, 1)
            gfx:printf(self.label, self.x + 8, textY, self.w - 16, "center")
        end,

        draw = function(self, gfx)
            local r, g, b = self.color[1], self.color[2], self.color[3]

            -- Fill: more opaque when hovered or selected
            local fillAlpha = 0.18
            if     self.selected then fillAlpha = 0.45
            elseif self.hovered  then fillAlpha = 0.30
            end
            gfx:setColor(r, g, b, fillAlpha)
            gfx:rectangle("fill", self.x, self.y, self.w, self.h)

            -- Border: white when selected, node color otherwise
            if self.selected then
                gfx:setColor(1, 1, 1, 1)
            else
                gfx:setColor(r, g, b, 1)
            end
            gfx:setLineWidth(self.selected and 2 or 1)
            gfx:rectangle("line", self.x, self.y, self.w, self.h)
            gfx:setLineWidth(1)

            self:drawLabel(gfx)
            self:drawTitle(gfx)
        end,
    }
end

return Node
