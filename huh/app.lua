app = {}

function app:init()
    self.scene = gameClass()
end

function app:change_scene_to(scene)
    self.scene:destroy()
    self.scene = nil
    collectgarbage()
    self.scene = scene
end

function app:update(dt)
    self.scene:update(dt)
end

function app:draw()
    self.scene:draw()
end