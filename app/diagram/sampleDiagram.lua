-- Source → Publisher → N Subscribers (fan-out pattern)
local SUBSCRIBER_TYPES = { "type-a", "type-b", "type-c", "type-d", "type-e", "type-f", "type-g", "type-h" }

local nodes = {
    { id = "source",    label = "Source",    title = "Input",     x =  50, y = 435, w = 230, h = 90, color = { 0.9,  0.45, 0.1 } },
    { id = "publisher", label = "Publisher", title = "Messaging", x = 340, y = 435, w = 250, h = 90, color = { 0.75, 0.2,  0.6 } },
}

local edges = {
    { from = "source", to = "publisher" },
}

for i, subType in ipairs(SUBSCRIBER_TYPES) do
    local id = "subscriber_" .. subType
    table.insert(nodes, {
        id    = id,
        label = "subscriber-" .. subType,
        title = "Queue",
        x     = 650,
        y     = 50 + (i - 1) * 110,
        w     = 260,
        h     = 90,
        color = { 0.2, 0.65, 0.7 },
    })
    table.insert(edges, { from = "publisher", to = id })
end

return { nodes = nodes, edges = edges }
