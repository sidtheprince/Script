slime_king = Monster:new("Slime King", 10)

slime_king:set_hp(500) -- current health
slime_king:set_maximum_health(500) -- health limit
slime_king:set_attack(11) -- attack power
slime_king:set_defense(18) -- defense
slime_king:set_magic(2) -- magic power
slime_king:set_resistance(10) -- magic resistance

slime_king:set_boss(true)       -- boss monster
slime_king:set_aggressive(true) -- that is also aggressive
-- sounds
slime_king:set_sound("monster/sounds/slime-movement.ogg") -- adds a sound to sound_list--print("Sound of slime_king: ", slime_king:get_sound(1))
-- speak(index) --index = 1, 2, 3, etc.

-- drops 
slime_king:set_exp_drop(9, 14)
slime_king:set_item_drop(potion, 50) -- 50% chance to drop this item
slime_king:set_item_drop(sword, 20) -- 20% chance to drop this item
slime_king:set_gold_drop(9, 21)

function slime_king:on_load()
if dokun then
	Sprite.set_position(self, 300, 200)
    -- slime health bar
    slime_king.health_bar = Progressbar:new()
    slime_king.health_bar:set_foreground_color(255, 51, 51)
    slime_king.health_bar:set_outline(true)
	slime_king.health_bar:set_outline_width(2.0)
	-- slime sounds
	--slime:get_sound(1):set_loop(true) -- a string cannot call Sound::set_loop
	slime_king:speak(1, 10, true)
end
end
slime_king:load("monster/slime_king32x.png")

function slime_king:on_defeat( player )--change to on_defeat  since self (monster) gets defeated by you (player)
    if self:is_dead() then	
	-- stop noise
if dokun then	
	    --self.voice:stop()
end	
	    -- check for quests in player.quest
        player:check(self)
        -- drop item from self.item_drop_list
        -- drop exp from self.exp_drop
        -- drop gold from self.gold_drop
	    self:drop(player)	
    end	
end

function slime_king:on_draw( player )
	if not self:is_dead() then --if self is not dead
		    -- If player is not dead
		if not player:is_dead() then --Monsters live to kill players which is their only purpose--Monster:find_nearest_player()--use this instead for multiple global players later. For now focus on single player
		    -- if monster is aggressive -- Think about it..not all bosses are aggressive and not all aggressives are bosses. But aggressive mobs will always attack nearby players automatically    
			if self:is_aggressive() then
				-- if detect a nearby player (150- units away)
				if self:detect( player, 150 ) then --melee/spell_attack distance=90
				    -- player is the new target the moment he is detected by an aggressive monster = only for aggressive mobs
				    self:set_target( player )--setting the target does not mean you are in combat. It only means you are a focused on a potential foe
				    --print(self:get_target(), self:get_target():get_name())
				    -- follow the player (target)  = only for aggressive mobs
				    self:follow( player )
				    --print("Boss incoming!")
			    else self:set_target( nil ) -- target is lost when distance is too wide
			    end--end_of_aggressive_monster
			end --print("Boss nearby!") 
		    ---------------------------------------
		    -- on collision with a player   
if dokun then-- target is whomever monster_self is nearest to it
			if self:has_target() then	
				if Sprite.collide( self, self:get_target() ) then self:hit( self:get_target() ) -- fight to the death	
				end
			end	 -- when player kills monster
end			
		end	-- end of player not dead yet				
	end
	-- if its health is lower than its max_health
	-- as long as not dead, regenerate health at all times
	-- regenerate slime_king health (0.5 HP per sec)
	self:regen(math.random(2), 1) -- regenerates 1-2 health per second--( 0.5, 1 ) 		
	------------------------------
end