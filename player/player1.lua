-- player1.lua
player = Player:new("Siddy")
player:set_level(1)
player:set_exp(0)
player:set_maximum_health(10000)
player:set_maximum_mana(1000)
player:set_health(player:get_maximum_health()) -- initial hp
player:set_mana(player:get_maximum_mana()) -- initial mp
player:set_power(5) -- player.power
player:set_magic(0)
player:set_defense(10)
player:set_magic_defense(1)
player:set_attack_speed(0.1)
player:set_movement_speed(10)
player:set_level_capacity(90)
player:set_health_regeneration(2.5, 1) -- +2.5hp each second

if not player:load("player/naked.png") then--("res/ch003.png", 0, 0, 32, 32) then--("player/hero.png", 0,0,32,32) then
    print("Error loading "..player:get_name())
end -- "../dokun/res/ch003.png"
if dokun then
player_alive = Texture:new("player/naked.png")
player_dead  = Texture:new("player/naked_dead.png")
Sprite.set_size(player, 32, 32)
end

-- while player is outside loop
function player:on_load()
if dokun then
--[[
	local quest = get_quest_by_name("A New Beginning") -- first quest in game
	if not is_quest(quest) then
	    return
	end
	if not quest:in_log(self) then
        -- add quest to log
		player:set_quest( quest )
	end
]]--
    Sprite.set_size(player, 64, 64)	
end	
end

-- while player is being drawn in loop
function player:on_draw(frame)
if dokun then
    local player_x, player_y            = Sprite.get_position(player)
    -- as long as player is not dead
	if not self:is_dead() then
	--[[
	local mouse_x, mouse_y = Mouse:get_position(window)
	local target_x, target_y = 0, 0
	local direction_x, direction_y = target_x - player_x, target_y - player_y
	-- normalize direction
	local length = math.sqrt(direction_x * direction_x + direction_y * direction_y)
	local direction_x_norm, direction_y_norm 
	if length ~= 0 then
	    direction_x_norm, direction_y_norm = direction_x /  length, direction_y / length
	end
	local move = false
	-----------------------------------
	if Mouse:is_released(1) then
	    target_x, target_y = Mouse:get_position(window)
		move = true
	end
    local distance = Math.distance(target_x, target_y, player_x, player_y)	
	if distance > 3 and move then
	   Sprite.translate(self, 1 * 0.5, 0)
	   --Sprite.translate(self, 0, 1 * 5)
	   else move = false
	end 
	]]--
	-----------------------------------
	if window:is_focused() then
	    local speed = 2
	    if Keyboard:is_pressed("up", 0) then
	        Sprite.translate(self, 0, -speed)
	    end
	    if Keyboard:is_pressed("down", 0) then
	        Sprite.translate(self, 0, speed)
	    end
	    if Keyboard:is_pressed("left", 0) then
	        Sprite.translate(self, -speed, 0)
	    end
	    if Keyboard:is_pressed("right", 0) then
	        Sprite.translate(self, speed, 0)
	    end	
	end	
		-- check experience points
		self:level_up()
		-- draw the player
        Sprite.draw(self, frame)
	end	
	start_time = os.clock()
    -- collision with other entities
	local player_width, player_height   = Sprite.get_size(player)
	local monster_x, monster_y          = Sprite.get_position(slime)
	local monster_width, monster_height = Sprite.get_size(slime)
	if((monster_x < player_x + player_width) and (player_x < monster_x) and (monster_y < player_y + player_height) and (player_y < monster_y)) then
	    --player:set_health(player:get_health() - 0.001 * os.clock()-start_time)
		--player:set_exp(player:get_exp() +   0.01 * os.clock()-start_time)
		--player:set_health(0) 
		-- change to dead texture
		--player_dead = Texture:new("player/naked_dead.png")
		--Sprite.set_texture(player, player_dead)		
	end 
	----
	if is_monster(player:get_target()) then
	   -- follow target
	   
	end
	
    player:on_basic_attack()
	player:on_item_use()
	player:on_item_equipped()
		-- if player dies, set visiblity off
	player:on_dead()
	-- if player dies, restore health, set respawn point, and set visible
	player:on_respawn() 
end
end

function player:on_dead()
if dokun then
    -- if player is visible and is dead
    if Sprite.is_visible(self) then
	if self:is_dead() then
	    Sprite.set_texture( self, player_dead )
		print("You are dead")
			-- lose some exp (1%)
            local current_exp = self:get_exp()
	        local one_percent = percent_of(1, current_exp) -- one percent of current_exp
            if one_percent > 0 then
			    self:set_exp(current_exp - one_percent)
                print("You have lost "..one_percent.." exp")
	        end        
	        -- wait 2 secs			
			sleep(2)
			-- set visible to false
			Sprite.set_visible(player, false) 
	end
	end
end	
end

function player:on_basic_attack()
    if player:has_target() then player:hit() end --player will attack its target with weapon hitpower
end
function player:on_item_equipped()
    local item = self:get_weapon() -- equipment
	--[[if not self.equipment then self.equipment = {} end
	for i = 0, #self.equipment do
	    item = self.get_equipment(i)
		print(item)
	end]]--
	if not item then return end -- if nil exit this function
	-- if an item is equipped by a player make sure its positioned on the player's body
	if (string.find(item:get_type(), nocase("Equipment")) and player:is_equipped(item)) then
	    -- if item is a weapon
		if string.find(item:get_subtype(), nocase("Weapon")) or string.find( item:get_subtype(), nocase("Smasher") ) or string.find(item:get_subtype(), nocase("Blaster")) or string.find(item:get_subtype(), nocase("Explosive")) then
if dokun then		    
            local player_x, player_y            = Sprite.get_position(self)
			local player_width, player_height   = Sprite.get_size(self)
			Sprite.set_position(item, player_x-10, player_y+10)
end			
		end
	end
end

function player:on_item_use() 
	-- USE ITEMS 0-9
	if Keyboard:is_pressed(KEY_1) then
	    local item = Bag:get_item_in_slot(1)
		if not item then return end
	    if is_item(item) then item:use(self) end
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_2) then
	    local item = Bag:get_item_in_slot(2)
		if not item then return end
	    if is_item(item) then item:use(self) end
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_3) then
	    local item = Bag:get_item_in_slot(3)
		if not item then return end
	    if is_item(item) then item:use(self) end
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_4) then
	    local item = Bag:get_item_in_slot(4)
		if not item then return end
	    if is_item(item) then item:use(self) end
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_5) then
	    local item = Bag:get_item_in_slot(5)
		if not item then return end
	    if is_item(item) then item:use(self) end
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_6) then
	    local item = Bag:get_item_in_slot(6)
		if not item then return end
	    if is_item(item) then item:use(self) end
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_7) then
	    local item = Bag:get_item_in_slot(7)
		if not item then return end
	    if is_item(item) then item:use(self) end
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_8) then
	    local item = Bag:get_item_in_slot(8)
		if not item then return end
	    item:use(self)
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_9) then
	    local item = Bag:get_item_in_slot(9)
		if not item then return end
	    item:use(self)
	    --Bag:open()
	end
	if Keyboard:is_pressed(KEY_0) then
	    local item = Bag:get_item_in_slot(10)
		if not item then return end
	    item:use(self)
	    --Bag:open()
	end
end

function player:on_respawn()
if dokun then
    if not Sprite:is_visible(self) then
        if self:is_dead() then
            sleep(0.5)
			Sprite.set_position(self, 0, 0)
			self:set_health(self:get_maximum_health())
			Sprite.set_texture(self, player_alive)
			Sprite.set_visible(self, true)
			print("You have been revived")
		end
	end
end
end