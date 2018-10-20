
Object = 
{}
--------------
Object_mt = 
{ 
    __index = Object,
	__gc    = 
	function(self)
	    print(self:get_name(), " deleted")
	end
}
--------------
if(dokun) then
    object_factory = Factory:new()
end
------------------
-- ENVIRONMENTAL OBJECTS 
-- Objects are meant to be non-collidable sprites
function Object.new(name)
    local object
    if dokun then  
        object = Sprite:new()
    else
        object = {}
    end
 	object.name = name
    object.type = "Environmental"
    
	if not Object.id then 
	    Object.id = 0 
	end
    Object.id = Object.id + 1
    if name == nil then
        object.name = string.format("%s%s", "Object", Object.id)
    end
    -- mt
	object.mt = {__index = object}
    -- copy function
	object.new = function()
        local new_object
        if dokun then	
	        new_object = Sprite:new()
	    else
	        new_object = {}
	    end
	    setmetatable(new_object, object.mt)
	    return new_object
    end
    if (dokun) then
	    object_factory:store(object)
	end
    setmetatable(object, Object_mt)
    return object
end
--------------
function Object:load(file_name)
 if dokun then
	return Sprite.load(self, file_name)
 end	
end
--------------
function Object:draw(x, y)
 if dokun then
  if not x and not y then
   Sprite.draw(self)
  else
   Sprite.draw(self, x, y)
  end
 end
end
--------------
function Object:move(x, y)
    if dokun then
	    Sprite.move(self, x, y)
	end
end
--------------
function Object:rotate(degree) 
    if dokun then
	    Sprite.rotate(self, degree)
	end
end
--------------
function Object:scale(sx, sy)
    if dokun then
	    Sprite.scale(self, sx, sy)
	end
end
--------------
function Object:animate(player)
    -- custom animation function
	if type(self.on_animate) == "function" then
        self:on_animate(player)
	end
end
--------------
-- SETTERS
--------------
function Object:set_position(x, y)
    if dokun then
        Sprite.set_position(self, x, y)
	end
end
--------------
function Object:set_texture(texture)
    if dokun then
	   Sprite.set_texture(self, texture)
	end
end -- set movable, fixed, etc
--------------
-- GETTERS
--------------
function Object:get_position()
    if dokun then
	    return Sprite.get_position(self)
	end
end
--------------
function Object:get_parent()
    -- object of Item
    if getmetatable(self) == Object_mt then return Object end
	-- clone of Item object
	local _G = _G
	for _, object in pairs(_G) do
	    if type(object) == "table" then
		    if getmetatable(object) == Object_mt then
		        if getmetatable(self) == object.mt then
			        return object
			    end
		    end
		end
	end
end
--------------
-- BOOLEAN
--------------
function Object:is_object()
    -- Is it a table?
    if type(self) ~= "table" then
	    return false
	end    
	if getmetatable(self) == Object_mt then 
	    return true 
	end
	if (dokun) then
	for i = 0, object_factory:get_size() do
	    if getmetatable(object_factory:get_object(i)) == Player_mt then
            if getmetatable(self) == object_factory:get_object(i).mt then
		        return true
		    end
        end		
	end
	else
	    if is_copy(self) then 
		    return true 
		end
	end
    return false
end
--------------
is_object = Object.is_object
--------------
function Object:is_collidable()
    return self.collidable
end
--------------
--------------
-- EVENT
--------------
function Object:is_copy() 
    local _G = _G
    for _, object in pairs(_G) do
	    if type(object) == "table" then
		    if getmetatable(object) == Object_mt then
                if getmetatable(self) == object.mt then
			        return true
			    end
			end
		end
	end
	return false
end
--------------
function Object:draw_event(player) -- draws all created objects
    for _, object in pairs(_G) do
	    if type(object) == "table" then
	 	    if getmetatable(object) == Object_mt  then-- object is an object (Item base mt)
			        -- animate the object
			        object:animate(player)
					-- draw the object
					object:draw()
		        if getmetatable(object) == object.mt then
				    -- animate the object
				    object:animate(player)   
                    -- draw the object
                    object:draw()	
				end
			end
		end
	end
end
--------------
function object_event_handler()
    local g = _G
	for _, obj in pairs(g) do
	    if is_object(obj) then
		end
	end
end
--------------
dofile("object/tree.lua")
--dofile("object/fence.lua")
dofile("object/chest.lua")