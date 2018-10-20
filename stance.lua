
Stance = 
{
    name      =    "",
    wep_req   =   nil,
    mana_req  =     0,
    cooldown  =   0.5,
    power     =     0,
 
    activated = false,
	min_dist  =  1, -- minimum distance that player can use stance
}
---------------
Stance_mt = 
{ 
    __index = Stance,
	__gc    = function(self)
	    print(self:get_name(), "deleted")
	end
}
---------------
function Stance.new(name, wep_req, mana_req, cool_down, effect) 
    local stance = {}
 
    stance.name = name
    stance.wep_required = wep_req
    stance.mana_req = mana_req -- mana usage
    stance.cool_down = cool_down
    stance.power = effect
 
    if not Stance.id then Stance.id = 0 end
	Stance.id = Stance.id + 1
	stance.id = Stance.id
	
    setmetatable(stance, Stance_mt)
    return stance
end
---------------
-- API FUNCTIONS
---------------
-- SETTERS
---------------
-- GETTERS
---------------
-- BOOLEAN
---------------
function Stance:is_stance()
    if type(self) ~= "table" then
	    return false
	end
    if getmetatable(self) == Stance_mt then 
	    return true 
	end
	local g = _G
	for _, stance in pairs(g) do
	    if getmetatable(stance) == Stance_mt then
            if getmetatable(self) == stance.mt then
			    return true
			end
        end		
	end
	return false
end
---------------
is_stance = Stance.is_stance
---------------
-- LOAD STANCES HERE.
-- [NOTE]: Stances are used by fighters and spells are used by mages.