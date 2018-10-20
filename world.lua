
World =
{
    name = "Unknown";
	players =     {};
	monsters =    {};
	npcs =        {};
	items =       {};
	objects =     {};
}
---------------
World_mt =
{
    __index = World,
	__gc    =
	function(self)
	    print(self:get_name(), " deleted")
	end
}
---------------
DISTRICT = "DISTRICT"; -- city
CAPITOL = "CAPITOL"; -- capital(city)
STATELAND = "STATELAND"; -- state

REGION =  -- continent
{
    "Calim", "Nekta"
}
---------------
function World.new(name, type, region)
    local area
    if (dokun) then
        area = {} -- make a new area
    else
	    area = Level:new()
	end
    area.name = name
    area.division = type
    area.region = region
    area.entity = {}
 
    if not World.id then 
	    World.id = 0 
	end
	World.id = World.id + 1
    area.id = World.id	
 
    setmetatable(area, World_mt)
    return area
end
---------------
function World:add(entity)
end
---------------
function World:show() -- show entities
end
---------------
---------------
-- SETTERS
---------------
function World:set_name(name)
    self.name = name
end
---------------
function World:set_area(area)
end
---------------
---------------
-- GETTERS
---------------
function World:get_name()
 return self.name
end
---------------
---------------
function World:get_world_by_name()
end
---------------
get_world_by_name = World.get_world_by_name
---------------
function World:get_world_by_id()
end
---------------
get_world_by_id = World.get_world_by_id
---------------
function World:get_entity_at(x, y)
end
---------------
---------------
-- BOOLEAN
---------------
function World:in_world(object)
end
---------------
function World:is_world()
    if type(self) ~= "table" then
	    return false
	end
    if getmetatable(self) == World_mt then 
	    return true 
	end
	local g = _G
	for _, area in pairs(g) do
	    if getmetatable(area) == World_mt then
		    if getmetatable(self) == area.mt then
			    return true
			end
		end
	end	
end
---------------
is_world = World.is_world
---------------
function world_event_handler()
end

--[[

-- WORLD
-- the doll_world is represented by the World base class
--doll_world = World.new("Doll World", "Home of the Dolls")


doll_island = World.new("Doll Island",  CAPITOL) -- "Capitol of the Doll World, Home of the Doll King"
healing_spring = World.new("Healing Springs", PLACE) -- "A Safe Haven for Good Health"

elaris = World.new("Elaris", STATELAND)--nature wood village
alfadel = World.new("Alfadel", STATELAND)--the ice dessert
zeion = World.new("Zeion", "Sand Kingdom") -- sand kingdom
darkos = World.new("Darkos", "The Dark City") -- the dark city
cliass = World.new("Cliass", STATELAND) --elegant city of wonders, clee-as
marlana = World.new("Marlana", STATELAND) -- similar to venice, the new venice
gumbelore = World.new("Gumbelore", STATELAND) -- kingdom of gums
besoney = World.new("Besoney", DISTRICT) -- bee world

yanchu = World.new("Yanchu",  STATELAND) -- the "red" lantern city

ranalup = World.new("Ranalup City")
gnathostome = World.new("Gnathostome", "Home of The Gnomes") -- home of the gnomes


thaem = World.new("Thaem") -- (tay -uhm), named after a legendary titan
domoki_village = World.new("Domoki Village", DISTRICT)
ardust = World
deloom = World
--dradel 
--vespaar

]]--