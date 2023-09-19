TestParticle = 
{
    x = 0,
    y = 0,
    AlbedoR = 255,
    AlbedoG = 255,
    AlbedoB = 255,
    viscosity = 0, -- 0 to 1, chance for iteration to pass due to surface friction
    gravity = 1 -- -1 to 1, |chance for gravity to cause the particle to move| sign is direction 
}

function TestParticle:create (o)
    o.parent = self
    return o
end

function howdy()
    return "howdy"
end

function TestParticle:new(x, y, albedoR, albedoG, albedoB, viscosity, gravity)
    local newParticle = 
    {
        x = x or 0,
        y = y or 0,
        AlbedoR = albedoR or 255,
        AlbedoG = albedoG or 255,
        AlbedoB = albedoB or 255,
        viscosity = viscosity or 0,
        gravity = gravity or 1
    }
    setmetatable(newParticle,self)
    self.__index = self
    return newObj
end

function InstantiateTest(x,y)
    return TestParticle:new(x,y,100,255,100,0,1)
end

function TestParticle:Iterate(pN,pW,pS,pE,FloorY)
    if pS and pW and pE then return end -- do not iterate if there are particles surrounding this one.
    if self.PosY >= FloorY then return end -- do not iterate if the particle is on the floor.
    if ( (math.random() < viscosity) and pS ) then return end -- do not iterate if viscosity prevents spread.
    if ( (math.random() < math.abs(gravity)) and not pS ) then return end -- do not iterate if the particle shouldn't fall.
    -- The particle should move.
    if not pS and self.gravity > 1 then self.y = self.y + 1 return end
    if not pS and self.gravity < 1 then self.y = self.y - 1 return end
    if pS and pW and not pE then self.x = self.x + 1 return end -- move right
    if pS and not pW and pE then self.x = self.x - 1 return end -- move left
    if pS and not pW and not pE and math.random() > 0.5 then self.x = self.x + 1 else self.x = self.x - 1 return end -- move left or right randomly
end