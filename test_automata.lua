function howdy()
    return "howdy"
end

local DefaultParticle = {
    x = 0,
    y = 0,
    AlbedoR = 255,
    AlbedoG = 255,
    AlbedoB = 255,
    viscosity = 0.999,
    gravity = 1
}

local Sand = {
    x = 0,
    y = 0,
    AlbedoR = 224,
    AlbedoG = 192,
    AlbedoB = 61,
    viscosity = 0.999,
    gravity = 1
}

local Water = {
    x = 0,
    y = 0,
    AlbedoR = 29,
    AlbedoG = 89,
    AlbedoB = 209,
    viscosity = -1,
    gravity = 1
}

function InstantiateParticle(x,y)
    local newParticle = {}



    for key, value in pairs(Water) do newParticle[key] = value end
    newParticle.x = x or Water.x
    newParticle.y = y or Water.y

    -- Check if a particle with the same x and y values already exists
    for _, particle in ipairs(Particles) do
        if particle.x == x and particle.y == y then
            return -- Don't add a new particle if one already exists at this position
        end
    end

    table.insert(Particles, newParticle)
end


function Iterate (particle, pN,pW,pS,pE,FloorY)
    --[[
    
    if pS and pW and pE then return end -- do not iterate if there are particles surrounding this one.
    if particle.y >= FloorY then return end -- do not iterate if the particle is on the floor.
    if ( (math.random() < particle.viscosity) and pS ) then return end -- do not iterate if viscosity prevents spread.
    if ( (math.random() < math.abs(particle.gravity)) and not pS ) then return end -- do not iterate if the particle shouldn't fall.
    -- The particle should move.
    if not pS and particle.gravity > 0 then particle.y = particle.y + 1 return end
    if not pS and particle.gravity < 0 then particle.y = particle.y - 1 return end
    if pS and pW and not pE then particle.x = particle.x + 1 return end -- move right
    if pS and not pW and pE then particle.x = particle.x - 1 return end -- move left
    if pS and not pW and not pE and math.random() > 0.5 then particle.x = particle.x + 1 else particle.x = particle.x - 1 return end -- move left or right randomly
    ]]--
    if (pS) then 
        vR = math.random()
        if (not pN) then vR = vR - 0.5 end
        if (not pW and not pE) then vR = vR - 0.5 end
        if  vR < particle.viscosity then return end
        if( pW and not pE ) then particle.x = particle.x + 1 end
        if( pE and not pW ) then particle.x = particle.x - 1 end
        if( pW and pE ) then return end -- do not move
        if( not pW and not pE) then 
            if(math.random() < 0.5) then particle.x = particle.x + 1
            else particle.x = particle.x - 1 end
        end
    return
    end

    --if (particle.y >= FloorY) then return end
    --if pS == false then particle.y = particle.y + 1 return end
    if particle.y < FloorY then particle.y = particle.y + 1 end
end

