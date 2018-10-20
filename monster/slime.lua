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
	Sprite.set_position(slime, 600, 0)
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
function slime:on_kill(player)
	-- check for quests in player.quest
    self:check(player)
    -- drop item from self.item_drop_list
    -- drop exp from self.exp_drop
    -- drop gold from self.gold_drop
    self:drop(player)	
end


-- on drawing a slime
function slime:on_draw( player )		
    -- IF MONSTER IS AGGRESSIVE
	if self:is_aggressive() then 
	    -- detect a nearby enemy at distance of 10
        if self:detect(player, 10) then
	        -- set enemy as target (target found)
		    self:set_target( player )
			if not self:in_combat() then
			    -- follow enemy while not in combat or not being attacked
		        self:follow( player );
			end
	    else
	        -- no target found
	        self:set_target(nil)
		end
		
		--if distance is 1 or less from enemy (monster is close enough to the enemy)
	    if self:detect( player, 1) then
		-- if monster's target is enemy
		-- and engage in battle with enemy
		    if self:get_target() == player then 
			    self:fight( player ) 
		    end
        end			
	end
if dokun then
    -- update slime healthbar
    slime.width, slime.height = Sprite.get_texture (slime):get_size() -- 24,20
    slime.x, slime.y          = Sprite.get_position(slime)
	slime.health_bar:set_size(slime.width, 5)
    slime.health_bar:set_position(slime.x, slime.height + slime.y) -- update slimehbar position in loop
	slime.health_bar:set_range(slime:get_health(), slime:get_maximum_health())
	slime.health_bar:set_value(slime:get_health()) -- update slimehbar value in loop
	slime.health_bar:draw() -- draw slimehbar
end	
	--------------------------
	--------------------------
	-- IF MONSTER IS ALIVE
	--[[
	if not self:is_dead() then
if dokun then
	    Sprite.draw(self) -- call in loop in order to update drawing
end	
	end ]]--
end