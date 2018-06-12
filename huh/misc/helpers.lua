-- The whole class is needed so that i can iterate and add
-- lasers to the active lasers list
-- it might be easily used for any other enemy should i add them

function isin(a,b)
    if not a then return false end
    if not b then return false end
    for e,l in pairs(b) do
        if l == a then
            return true
        end
    end
    return false
end

function randrange(range)
    return math.random() * (range[2] - range[1]) + range[1]
end

node = Class("node")

function node:init(value,next)
    self.value ,self.next = value,next
end

-- values need to have .destroyed, #update(dt),#draw

linked_listClass = Class("linked list")


function linked_listClass:init(value)
    if value then
        self.head = node(value,nil) 
        self.tail = self.head
        self.length = 1
    end
    self.length = 0
end

function linked_listClass:at(i)
    local current = self.head
    for i=1,(i-1) do
        current = current.next
    end
    return current
end

-- calls #update on all values which are not destroyed 
--  and removes the destroyed nodes from the list
function linked_listClass:update_all(dt,args)
    local current
    local before
    if self.head then
        current = self.head
        while current do
            local altbefore = nil
            if args then 
                current.value:update(dt,args)
            else
                current.value:update(dt)
            end
            if current.value.destroyed then
                if current == self.head then
                    self.head = self.head.next
                    current.value = nil
                else 
                    before.next = current.next
                    current.value = nil
                    altbefore = before
                end
                self.length = self.length - 1
            end
            before = altbefore or current
            current = current.next
        end
    end
end

function linked_listClass:calc_len()
    local i = 0
    local current = self.head
    while current do
        current = current.next
         i = i + 1
    end
    return i
end

function linked_listClass:remove(i)
    if i == 1 then
        self.head = self:at(2)
        return
    end
    local before = self:at(i-1)
    -- so it skips the ith node
    before.next = before.next.next
    self.length = self.length -1
end

function linked_listClass:draw_all(args)
    if self.head then
        local current = self.head
        while current do
            if args then 
                current.value:draw(args)
            else
                current.value:draw()
            end
            current = current.next
        end
    end
end

function linked_listClass:add(value)
    if not self.head then
        self.head = node(value,nil)
        self.tail = self.head
        self.length = 1
        return
    end
    self.tail.next = node(value,nil)
    self.tail = self.tail.next
    self.length = self.length + 1
end

-- Love2d doesn't have this for some reason
-- so i needed to write one myself
-- x and y are center
function rotated_rectangle(mode, x, y, w, h, r)
    
    local r = r
    local ox = x
    local oy = y

    love.graphics.push()
      love.graphics.translate(ox,oy)
      love.graphics.push()
        love.graphics.rotate( -r )
        -- love.graphics.rectangle( mode, -w/2, -h/2, w, h)
        love.graphics.rectangle( mode, -w/2, -h/2, w, h)
      love.graphics.pop()
    love.graphics.pop()
end
