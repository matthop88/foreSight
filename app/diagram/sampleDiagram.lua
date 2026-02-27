return {
    nodes = {
        { id = "input",     label = "Input\nComponent",      x =  60, y = 300, w = 240, h = 120, color = { 0.3,  0.55, 1.0  } },
        { id = "processor", label = "Processor",  x = 380, y = 300, w = 240, h = 120, color = { 0.9,  0.55, 0.2  } },
        { id = "output",    label = "Output\nComponent",     x = 700, y = 300, w = 240, h = 120, color = { 0.25, 0.75, 0.45 } },
    },
    edges = {
        { from = "input",     to = "processor" },
        { from = "processor", to = "output"    },
    },
}
