trailClass = Class("trail")


function trailClass:init()
    self.pixels = linked_listClass()
    self.time_to_next = -1
end
function trailClass:update(dt,args) -- current x,current y
    self.time_to_next = self.time_to_next - dt
    if self.time_to_next < 0 then
        self.time_to_next = randrange(c.game.trail.every)
        self.pixels:add(
            trail_pixelClass(args[1] + randrange(c.game.trail.random_place),
                args[2] + randrange(c.game.trail.random_place),
                randrange(c.game.trail.scale),randrange(c.game.trail.time),
                c.game.trail.movements))
    end
    self.pixels:update_all(dt)
end
function trailClass:draw()
    self.pixels:draw_all({c.game.trail.size,c.game.trail.color})
end
function trailClass:destroy()

end