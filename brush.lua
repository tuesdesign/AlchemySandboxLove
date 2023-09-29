-- selection
local BrushSelection = {"Sand", "Water", "Metal", "Gas"} -- Your list of values
local currentIndex = 1

SELECTED_ELEMENT = "null"

function love.mousewheel(x, y)
    -- Update the currentIndex based on the mouse scroll direction
    if y > 0 then
        currentIndex = currentIndex % #values + 1 -- Cycle up
    elseif y < 0 then
        currentIndex = (currentIndex - 2 + #values) % #values + 1 -- Cycle down
    end

    SELECTED_ELEMENT = BrushSelection[currentIndex]
end