blockClass = Class("block")

function blockClass:init(x,y,w,h,r,parent,name,mode)
    if not mode then mode = "fill" end
    if not name then name = nil end
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.r = r
    self.mode = mode
    self.parent = parent
    self.col_obj = parent.collider:rectangle(x-w/2,y-h/2,w,h)
    self.col_obj.name = name
    self:rotate(r)
end

function blockClass:update(dt)
end

function blockClass:draw(color)
    if color then
        love.graphics.setColor(color)
    end
    -- rotated_rectangle(self.mode,self.x,self.y,self.w,self.h,self.r)
    self.col_obj:draw()
end

function blockClass:move_to(x,y,r)
    self.x = x
    self.y = y
    self.col_obj:moveTo(x,y)
    self:rotate(r - self.r)
end

function blockClass:rotate(r)
    self.col_obj:rotate( - r)
    self.r = self.r + r
end

function blockClass:destroy()
    self.parent.collider:remove(self.col_obj)
end

