local Node = require("app/diagram/node")
local Edge = require("app/diagram/edge")

return {
    init = function(self, params)
        self.gfx   = params.gfx
        self.nodes = {}
        self.edges = {}

        -- Build nodes and an id→node map for edge wiring
        local nodeMap = {}
        for _, nodeParams in ipairs(params.diagram.nodes or {}) do
            local node = Node.new(nodeParams)
            table.insert(self.nodes, node)
            nodeMap[nodeParams.id] = node
        end

        for _, edgeParams in ipairs(params.diagram.edges or {}) do
            table.insert(self.edges, Edge.new(edgeParams, nodeMap))
        end

        return self
    end,

    draw = function(self)
        for _, edge in ipairs(self.edges) do
            edge:draw(self.gfx)
        end
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
