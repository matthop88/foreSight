local Node = {}

function Node.new(params)
    return {
        id       = params.id       or "node",
        label    = params.label    or "",
        x        = params.x        or 0,
        y        = params.y        or 0,
        w        = params.w        or 200,
        h        = params.h        or 120,
        color    = params.color    or { 0.3, 0.55, 1.0 },
        children = {},
        edges    = {},

        draw = function(self, gfx)
            local r, g, b = self.color[1], self.color[2], self.color[3]

            -- Fill
            gfx:setColor(r, g, b, 0.18)
            gfx:rectangle("fill", self.x, self.y, self.w, self.h)

            -- Border
            gfx:setColor(r, g, b, 1)
            gfx:rectangle("line", self.x, self.y, self.w, self.h)

            -- Label, vertically centered
            gfx:setFontSize(14)
            local textY = self.y + (self.h - gfx:getFontHeight()) / 2
            gfx:setColor(1, 1, 1, 1)
            gfx:printf(self.label, self.x + 8, textY, self.w - 16, "center")
        end,
    }
end

return Node
