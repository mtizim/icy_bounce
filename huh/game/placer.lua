placerClass = Class("placer")

function placerClass:init(parent)
    self.parent = parent
    self.midpoint = {}
    self.start = {
        bool = false
    }
    self.ende = {}
    self.time_since_press = 0
    self.block = nil
end
function placerClass:update(dt)

    if self.block then self.block:update(dt) end
    local press = {}
    press.x,press.y,press.bool = get_press()
    if (not self.start.bool) and press.bool and touch then
        self:start_block(press)
        return
    end
    if self.start.bool then
        self.time_since_press = self.time_since_press + dt
        if press.bool then
            self.ende.x,self.ende.y = press.x,press.y
        end
        if  (self.time_since_press > c.game.placer.time_to_place or 
            (not press.bool)) then
            self:end_block()
        end
    end
end

function placerClass:start_block(press)
    self:reset()
    self.start.x,self.start.y = press.x,press.y
    self.start.bool = true
end

function placerClass:end_block(press)
    self.start.bool = false
    self.ende.bool = true
    self.block = blockClass(0,0,
                    c.game.placer.block.length,
                    c.game.placer.block.width,0,
                    c.game.placer.block.mode,
                    self.parent.collider,
                    "placer",
                    self)
    self:calculate_block_midpoint()
    touch = nil
end

function placerClass:calculate_block_midpoint()
    local x = nil
    local y = nil
    local r = 0
    if not self.ende.x then
        x = -500
        y = -500
    else
        local t = math.atan2(self.start.x - self.ende.x,
                            self.start.y - self.ende.y) + math.pi
        r = t + math.pi/2
        x = 0.5 * math.sin(t) * c.game.placer.block.length *
             (1-c.game.placer.offset)
        y = 0.5 * math.cos(t) * c.game.placer.block.length *
             (1-c.game.placer.offset)
        x = x + self.start.x
        y = y + self.start.y
    end
    self.block:move_to(x,y,r)
end

function placerClass:reset()
    if self.block then self.block:destroy() end
    self:init(self.parent)
end

function placerClass:get_hit()
end

function placerClass:draw(color)
    if self.ende.bool and self.block then
        local col = c.game.placer.color
        love.graphics.setColor(col[1],col[2],col[3],1)
        self.block:draw({1,0,0})
    end
end
function placerClass:destroy()

end
