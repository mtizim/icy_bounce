gameClass = Class("game")

function gameClass:init()
    self.collider = Hc.new() -- has to be above player
    self.player = playerClass(self)
    self.game_objects = linked_listClass()
    self.game_objects:add(self.player)
    --temp
    self.game_objects:add(blockClass(25,H/2,50,1000,0,"line",self.collider,"wall",self))
    self.game_objects:add(blockClass(W/2,25,1000,50,0,"line",self.collider,"wall",self))
    self.game_objects:add(blockClass(W/2, H - 25,1000,50,0,"line",self.collider,"wall",self))
    self.game_objects:add(blockClass(W-25,H/2,50,1000,0,"line",self.collider,"wall",self))
    self.game_objects:add(placerClass(self))
end

function gameClass:update(dt)
    self.game_objects:update_all(dt)
end

function gameClass:draw()
    self.game_objects:draw_all()
end

function gameClass:destroy()

end