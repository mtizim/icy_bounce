trail_pixelClass = Class("trail_pixel")

function trail_pixelClass:init(x,y,scale,time,movements)
    self.x = x
    self.y = y
    self.scale = scale
    self.time = time
    self.in_time = time
    self.movements = {}
    self.movements[1] = movements[1] * (math.random() - 0.5) * 2
    self.movements[2] = movements[2] * (math.random() - 0.5) * 2
end
function trail_pixelClass:update(dt) -- movements
    self.time = self.time - dt
    if self.time < 0 then
        self:destroy()
    end
    -- moves from 0 to movements[i] left or right,framerate independent
    self.x = self.x + self.movements[1] * dt
    self.y = self.y + self.movements[2] * dt
end

function trail_pixelClass:draw(args) -- size,color
    local alpha = (self.time / self.in_time)
    love.graphics.setColor(args[2][1],args[2][2],args[2][3],alpha)
    love.graphics.rectangle("fill",self.x-args[1]/2,self.y-args[1]/2,
        args[1],args[1])
end
function trail_pixelClass:destroy()
    self.destroyed = true
end