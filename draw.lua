function drawParticle(x,y,r,g,b)
    love.graphics.setColor(r/255,g/255,b/255,255)
    love.graphics.rectangle("fill",descaleVal(x),descaleVal(y),scalingFactor,scalingFactor) 
end

function descaleVal(val) -- convert position from position to coordinate space
    return val * scalingFactor
end