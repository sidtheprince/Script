-- slime.lua
slime = Monster:new("Slime", 1) 

-- set properties here
slime:set_hp(100) -- current health
slime:set_maximum_health(100) -- health limit
slime:set_attack(2) -- attack power
slime:set_defense(7) -- defense
slime:set_magic(0) -- magic power
slime:set_resistance(5) -- magic resistance

slime:set_boss(false)
slime:set_max_instance(20)

-- drops 
slime:set_exp_drop(5, 7)
slime:set_item_drop(potion, 50) -- 50% chance to drop this item
slime:set_item_drop(sword,  10) -- 20% chance to drop this item
slime:set_gold_drop(1, 5)

-- skills (abilities)
slime:set_skill(nil)
slime:set_skill(nil)
slime:set_skill(nil)

-- set user-defined functions here
function slime:on_load()
if dokun then
	Sprite.set_position(slime, 500, 20)
    -- setup slime healthbar
    slime.health_bar = Progressbar:new()
    slime.health_bar:set_foreground_color(255, 51, 51)
    slime.health_bar:set_outline(true)
    slime.health_bar:set_outline_width(2.0)	
end	
end
-- load sprite (Monster.load will call on_load first)
slime:load("monster/slime.png")

-- on attacking a slime
function slime:on_attack(player)
 --slime:follow(player)
 -- slime is at a certain distance to the player
 -- distance formula, at least 1 point or less away from player,
 -- then monster can fight player
 
    --[[
	if Mouse:is_over(self) then
	    if Mouse:is_pressed(LEFT_MOUSE) then
		    -- walk towards monster until distance is 1 or close enough to attack
			player:fight(self)
		end
	end
	]]--
 
 --slime:fight(player)
end

-- on defeating a slime
function slime:on_defeat(player)
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


-- on drawing a slime
function slime:on_draw()	
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