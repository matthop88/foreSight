return {
    init = function(self, params)
        self.gfx   = params.gfx
        self.nodes = params.nodes
        return self
    end,

    draw = function(self)
        for _, node in ipairs(self.nodes) do
            node:draw(self.gfx)
        end
    end,

    update = function(self, dt)
        local wx, wy = self.gfx:screenToImageCoordinates(love.mouse.getPosition())
        for _, node in ipairs(self.nodes) do
            node.hovered = node:containsPoint(wx, wy)
        end
    end,

    handleMousepressed = function(self, mx, my, params)
        local wx, wy = self.gfx:screenToImageCoordinates(mx, my)
        local hit = false
        for _, node in ipairs(self.nodes) do
            node.selected = node:containsPoint(wx, wy)
            if node.selected then hit = true end
        end
        if hit then return true end
    end,
}
