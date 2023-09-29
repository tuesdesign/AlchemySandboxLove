require ( "test_automata" )
require ( "config" )
require ( "draw" )

Particles = {}
Positions = {}

Selected = "null"

function love.load()
    apply_window_parameters() -- set window size, state, name etc
    
    drawParticle(50,100,255,255,255)
    
    --table.insert(Particles,InstantiateTest(50,50))
    --table.insert(Particles,TestParticle:new(50, 100, 255, 255, 255, 0, 1))
end

function love.draw()
    updateEverything()
    mouseX,mouseY = love.mouse.getPosition()
    localMouseX = math.floor(mouseX / scalingFactor)
    localMouseY = math.floor(mouseY / scalingFactor)

    local count = 0

    for key, value in pairs(Positions) do
        count = count + 1
    end

    love.graphics.print(localMouseX.." | "..localMouseY.."p: "..#Particles.." | "..count, 400, 300)
    
    if(love.mouse.isDown(1)) then
         -- love.graphics.rectangle("fill",descaleVal(localMouseX),descaleVal(localMouseY),scalingFactor,scalingFactor)
          drawParticle(localMouseX,localMouseY,255,255,255)
          --print(InstantiateTest(localMouseX,localMouseY))

          InstantiateParticle(localMouseX,localMouseY)
         --table.insert(Particles,InstantiateTest(localMouseX,localMouseY))
         --table.insert(Particles,TestParticle:new(localMouseX, localMouseY, 255, 255, 255, 0, 1))
    end

    for _, particle in pairs(Particles) do
        drawParticle(particle.x, particle.y, particle.AlbedoR, particle.AlbedoG, particle.AlbedoB)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        updateEverything()
    end
end

function ParticleExistsAt(x,y)
    local key = x .. "," .. y
    return Positions[key] == true
end

function AddParticleToPositions(particle)
    local key = particle.x..","..particle.y
    Positions[key] = true
end

function UpdatePositions()
    Positions = {}
    for _, particle in ipairs(Particles) do
        AddParticleToPositions( particle )
    end
end

function updateEverything()
    UpdatePositions()
    for _, particle in ipairs(Particles) do
        pN = false
        pW = false
        pS = false
        pE = false

        if ParticleExistsAt(particle.x + 1 , particle.y) then pE = true end
        if ParticleExistsAt(particle.x - 1 , particle.y) then pW = true end
        if ParticleExistsAt(particle.x, particle.y + 1) then pS = true end
        if ParticleExistsAt(particle.x, particle.y - 1) then pN = true end
        
        --if pS then particle.AlbedoR = 30 end
        --if pW then particle.AlbedoG = 30 end
        --if pE then particle.AlbedoB = 30 end
        if pS and pW and pE and pN then particle.AlbedoB = 100 end


        Iterate(particle, pN,pW,pS,pE,floor)
    end
end