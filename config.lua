width = 192
height = 108
scalingFactor = 5
floor = 107;

function apply_window_parameters()
    local dispWidth = width * scalingFactor
    local dispHeight = height * scalingFactor
    love.window.setMode(dispWidth,dispHeight)
    love.window.setTitle("Particles")
end