playerClass = Class("player")

function playerClass:init(game)
    self.game = game
    self.x = c.game.player.start.x
    self.y = c.game.player.start.y
    self.vx = c.game.player.start.vx
    self.vy = c.game.player.start.vy
    self.gravity = c.game.player.start.gravity
    self.col_obj = 
        self.game.collider:circle(self.x,self.y,c.game.player.size.collision)
    self.col_obj.name = "player"
end

function playerClass:update(dt)
    self:collisions()
    self.vy = self.vy + self.gravity * dt
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
    self.col_obj:moveTo(self.x,self.y)
end

-- collision and handling
function playerClass:collisions()
    local col = self.game.collider:collisions(self.col_obj)
    for object,vector in pairs(col) do
        -- bounces
        if isin(object.name,c.game.player.collisions.bounces) then
            self:bounce(vector,c.game.player.collisions.bounce_loss)
        end
        if isin(object.name,c.game.player.collisions.boosty_bounces) then
            self:boosty_bounce(vector)
        end
        -- others
    end
end

-- bouncing off a vector
function playerClass:bounce(vector,loss)
    if not vector then return nil end
    if not loss then loss = 0 end
    -- | ||
    -- || |_
    -- bouncing off a vector
    local v = math.sqrt(self.vx*self.vx + self.vy*self.vy) * (1-loss)
    local t_vec = math.atan2(vector[1], vector[2]) - math.pi/2
    local t = math.atan2(self.vx, self.vy)
    local t_new = 2*t_vec - t
    -- clearing the collision
    self.x = self.x + 1.1*vector[1]
    self.y = self.y + 1.1*vector[2]
    self.vx = math.sin(t_new) * v
    self.vy = math.cos(t_new) * v 
    self.vector = {math.sin(t_vec)*3,3*math.cos(t_vec)}
end

function playerClass:boosty_bounce(vector)
    self:bounce(vector)
    local boost = c.game.placer.boost
    local vt = math.atan2(self.vx,self.vy)
    local v = math.sqrt(self.vx*self.vx + self.vy*self.vy)
    self.vx = math.sin(vt) * (v + boost)
    self.vy = math.cos(vt) * (v + boost)
end

function playerClass:draw()
    love.graphics.circle("fill",self.x,self.y,c.game.player.size.normal)
    -- self.col_obj:draw()
end

function playerClass:destroy()

end