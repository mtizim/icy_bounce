Class = require("dependencies.30log")
Hc = require("dependencies.hardoncollider")
Polygon = require("dependencies.hardoncollider.polygon")
osString = love.system.getOS()

require("constants")
require("settings")
require("misc.helpers")
require("app")
require("trails.trail")
require("trails.pixel")
require("game.game")
require("game.player")
require("game.placer")
require("game.block")

function love.load()
    app:init()
end

function love.update(dt)
    app:update(dt)
end

function love.draw()
    app:draw()
end

--I only ever need the first touch
-- so this function gives me the fist touch 
-- as a global first
touch = nil
function love.touchpressed(id, x, y)
  if not touch then touch = id end
end
function love.touchreleased(id, x, y)
  if id == touch then touch = nil end
end

function love.mousepressed(x, y,button,istouch)
    if istouch then return nil end
    touch = true
end
function love.mousereleased(x,y,button,istouch)
    if istouch then return nil end
    touch = false
end


function get_press()
    local press_bool = nil
    local x = nil
    local y = nil
    if osString == "Windows" or osString =="Linux" or osString =="OS X" then
        press_bool = love.mouse.isDown(1)
        if press_bool then
            x,y = love.mouse.getPosition()
        end
    else
        if touch then press_bool = true else press_bool = false end
        if press_bool then
            x,y = love.touch.getPosition(touch)
        end
    end
    return x,y,press_bool
end
