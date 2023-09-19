require ("test_automata")

local width = 192
local height = 108
local scalingFactor = 5

local Particles = {}
function drawParticle(x,y,r,g,b)
    love.graphics.setColor(r,g,b,255)
    love.graphics.rectangle("fill",descaleVal(x),descaleVal(y),scalingFactor,scalingFactor)
    
end
function love.load()
    local dispWidth = width * scalingFactor
    local dispHeight = height * scalingFactor
    love.window.setMode(dispWidth,dispHeight)
    love.window.setTitle("does this work lol")
    
    drawParticle(50,100,255,255,255)
    
    table.insert(Particles,InstantiateTest(50,50))
    table.insert(Particles,TestParticle:new(50, 100, 255, 255, 255, 0, 1))
end

function descaleVal(val)
    return val * scalingFactor
end


function love.draw()
    mouseX,mouseY = love.mouse.getPosition()
    localMouseX = math.floor(mouseX / scalingFactor)
    localMouseY = math.floor(mouseY / scalingFactor)
    love.graphics.print(localMouseX.." | "..localMouseY.."p: "..#Particles, 400, 300)
    
    if(love.mouse.isDown(1)) then
         -- love.graphics.rectangle("fill",descaleVal(localMouseX),descaleVal(localMouseY),scalingFactor,scalingFactor)
          drawParticle(localMouseX,localMouseY,255,255,255)
         table.insert(Particles,InstantiateTest(localMouseX,localMouseY))
         table.insert(Particles,TestParticle:new(localMouseX, localMouseY, 255, 255, 255, 0, 1))
    end

    for _, particle in pairs(Particles) do
        drawParticle(particle.x, particle.y, particle.AlbedoR, particle.AlbedoG, particle.AlbedoB)
    end
end