
Magic = 
{ 
    name      = "", 
	type      = "", 
	require   = 1, 
    mana      = 0, 
	cool_down = 0, 
	effect    = 0,
	activated = false,
	min_dist  =  9, -- minimum distance that player can use spell
}
----------------
Magic_mt = 
{
    __index = Magic,
	__gc    =
    function(self)
        print(self:get_name().." deleted")
    end	
}
----------------
function Magic:new(name, type, require, mana, cool_down, effect)
    local spell = {}
 
    if self == Magic then
        spell.name      = name
        spell.type      = type
        spell.require   = require -- required level
        spell.mana      = mana -- mana usage
        spell.cool_down = cool_down
        spell.effect    = effect
	else
        spell.name      = self
        spell.type      = name
        spell.require   = type
        spell.mana      = require
        spell.cool_down = mana
        spell.effect    = cool_down	
    end
	
	if not Magic.id then Magic.id = 0 end
	Magic.id = Magic.id + 1
	spell.id = Magic.id
 
    setmetatable(spell, {__index = Magic})
    return spell
end
----------------
function Magic:cast(player, target)
    --if Keyboard:is_pressed(KEY_T) then 
	    --if distance_from_target > 150 then print("Target is too far") return end --target is nil when you are 150 units too far
	    --player:set_target(self) print("Fire ball has been cast") print("Player target set to "..self:get_name()) 
	--end --TEMPORARY-- player target is slime
end
----------------
function Magic:wait() end -- wait for spell to cast
----------------
function Magic:animate() end
----------------
-- SETTERS
----------------
function Magic:set_name(name) end
function Magic:set_type(type) end
function Magic:set_require(level) end
function Magic:set_mana(mana) end
----------------
Magic.set_mana_usage = Magic.set_mana
----------------
function Magic:set_cooldown(cool_down) end
function Magic:set_effect(effect) end
function Magic:set_() end
function Magic:set_() end
function Magic:set_() end
function Magic:set_() end
----------------
-- GETTERS
----------------
function Magic:get_name() end
function Magic:get_type() end
function Magic:get_require() end
function Magic:get_mana() end
----------------
Magic.get_mana_usage = Magic.get_mana
----------------
function Magic:get_cooldown() end
function Magic:get_effect() end
function Magic:get_() end
function Magic:get_() end
function Magic:get_() end
function Magic:get_() end
function Magic:get_() end
----------------
-- BOOLEAN
----------------
function Magic:is_spell() 
    if getmetatable(self) == Magic_mt then 
	    return true 
	end
    return false	
end
----------------
is_spell = Magic.is_spell
----------------
function Magic:is_activated() end
function Magic:is_() end
function Magic:is_() end
function Magic:is_() end
----------------
-- LOAD SPELLS HERE