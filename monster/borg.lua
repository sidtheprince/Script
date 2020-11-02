-- borg.lua
borg = Monster:new("Borg", 2)
-- set properties here
borg:set_health(130) -- current health
borg:set_maximum_health(130)--(203) -- health limit
borg:set_attack(5) -- attack power
borg:set_defense(10) -- defense
borg:set_magic(0) -- magic power
borg:set_resistance(8) -- magic resistance

borg:set_boss(false)
borg:set_max_instance(20)

-- set drops here
borg:set_exp_drop(10, 13)
borg:set_item_drop(health_potion, 30) -- x% chance to drop this item
borg:set_gold_drop(3, 7)

function borg:on_load()
if dokun then--borg:scale(2, 2)
    Sprite.set_position(self, math.random(0, 1280), math.random(0, 700))
    -- setup slime healthbar
    self.health_bar = Progressbar:new()
    self.health_bar:set_foreground_color(255, 51, 51)
    self.health_bar:set_outline(true)
    self.health_bar:set_outline_width(2.0)	    
end
end
borg:load("monster/borg.png")

function borg:on_draw()	
    if not self:is_dead() then
    --[[
	if not player:is_dead() then	
    if player:get_target() == self then -- if player attacks first (will only attack if player attacks first)
        -- set player as new target and follow target
		self:set_target( player )       --print("You are now in combat with Slime")
		self:follow()                   -- slime will follow its target 
		if collide then self:hit( player ) end-- slime can only attack when close enough to attack player (at a distance of 1)
	end
    end
	if (distance_from_target >= 200) then player:set_target(nil) self:set_target(nil) end --print("Target lost")--print("No target found")  -- stop chasing player if he runs to a distance of 200 or more	-- lose target when player runs or is at a certain distance-- distance is more than or equal to specified distance(300)
	]]--
	end
	self:regen(math.random(1), 1) -- regenerates 1 health per second
end

function borg:on_defeat(player)
	if self:is_dead() then	
if dokun then
        -- hide health_bar
	    --if self.health_bar then 
	    --    if self.health_bar:is_visible() then self.health_bar:hide() end
	    --end
end	
	    -- check for quests in player.quest
        player:check(self)
        -- drop item from self.item_drop_list
        -- drop exp from self.exp_drop
        -- drop gold from self.gold_drop
	    self:drop(player)
    end	
end
-- create some clones
for i=1, 4 do
    local borg_inst = borg:new()--clones will inherit the slime's attributes
    borg_inst:load("monster/borg.png")
    borg_inst:set_hp(borg:get_maximum_health())
--[[    
    print("slime copy's name:", slime_inst.name)
    print("slime copy's level:", slime_inst.level)
    print("slime copy's health:", slime_inst.health)
]]--
end
