slime_king = Monster:new("Slime King", 10)

slime_king:set_hp(500) -- current health
slime_king:set_maximum_health(500) -- health limit
slime_king:set_attack(11) -- attack power
slime_king:set_defense(18) -- defense
slime_king:set_magic(2) -- magic power
slime_king:set_resistance(10) -- magic resistance

slime_king:set_boss(true)

-- drops 
slime_king:set_exp_drop(10, 20)
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
end
end
slime_king:load("monster/slime_king.png")

function slime_king:on_kill( player )
    self:check( player )
    -- drop items
	self:drop( player )
	player:level_up()
end

function slime_king:on_draw( player )
		if not self:is_dead() then
		    -- If player is not dead
			if not player:is_dead() then		
		        -- on collision with a player
if dokun then				
		        if Sprite.collide( self, player ) then
			        self:fight( player ) -- fight to the death	
			    end
end				
		        -- detect a nearby player (150 units far)
		        if self:detect( player, 150 ) then 
				    -- player is the new target
					self:set_target( player )
				    -- follow the player
				    self:follow( player )
					--print("Boss incoming!")
				else self:set_target( nil ) -- target is lost when distance is too far
				end --print("Boss nearby!") 
		    end
if dokun then
            -- retrieve size and position
            slime_king.width, slime_king.height = Sprite.get_texture(slime_king):get_size()
            slime_king.x, slime_king.y          = Sprite.get_position(slime_king)
            -- update healthbar
			slime_king.health_bar:set_size(slime_king.width, 5)
			slime_king.health_bar:set_position(slime_king.x, slime_king.y + slime_king.height + -15)  -- +?? spacing -- update slimehbar position in loop
	        slime_king.health_bar:set_range(slime_king:get_health(), slime_king:get_maximum_health())
			slime_king.health_bar:set_value(slime_king:get_health()) -- update slimehbar value in loop
	        slime_king.health_bar:draw() -- draw slimehbar
end	
		end
			-- if its health is lower than its max_health
			-- as long as not dead, regenerate health at all times
			-- regenerate slime_king health (0.5 HP per sec)
			self:regen( 0.5, 1 ) 		
end