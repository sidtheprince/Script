
Player =
{
    name       = "No Name";
	level      =      1;
	exp        =      0;
	health     =    100;
	mana       =     50;
	power      =      0;
	defense    =      0;
	speed      =      0;
	magic      =      0;
	max_health =    100;
	max_mana   =    100;
	level_cap  =    150;
	spawn_point_x =   0;
	spawn_point_y =   0;
	combat_distance = 20;
	melee_combat_distance = 10;
	magic_combat_distance = 20;
	-- physics attributes
	mass          =   0; -- in kg
}
----------------
if dokun then
   Player.factory = Factory:new()
end
------------------
Player_mt =
{
    __index = Player,
	__gc    =
	function(self)
	    if(dokun) then
		    Sprite.destroy(self)
		end
		print(self:get_name(), "deleted")
	end
}
------------------
function Player:new(name, level)
    local player
if dokun then
	player = Sprite:new()  -- create table with a sprite userdata
else
    player = {}
end
	----------------
	if self == Player then
        player.name = name
		player.level = level
	else
	    player.name = self
		player.level = name
	end
	----------------
    if not Player.id then Player.id = 0 end
    Player.id = Player.id + 1
    player.id = Player.id
    ----------------
    player.mt = { __index = player }
	player.new = function()
        local new_player
        if dokun then new_player = Sprite:new() else
            new_player = {}
        end
        setmetatable(new_player, player.mt)
        return new_player
    end
	--
	if dokun then
	    Player.factory:store(player)
	end
	----------------
    setmetatable(player, Player_mt)
    return player
end
------------------
function Player:load(file_name, x, y, left, top)
if dokun then
    if not Sprite.load(self, file_name, x, y, left, top) then
		return false
	end
end
if love then
	self.udata = love.graphics.newImage(file_name)
	if self.udata then return true end
end
    if self.on_load then self:on_load() end
    return true -- always return true unless doesnt load
end
------------------
function Player:draw(frame)
    if self.on_draw then self:on_draw(frame) end
if dokun then
    if not frame then frame = 0 end
	Sprite.draw(self, frame)
end
if love then
	if type(self.udata) == "userdata" then
		love.graphics.draw(self.udata, self.x, self.y)
	end
end
end
------------------
function Player:move(x, y)
    if dokun then
        Sprite.translate(self, x, y)
    end
end
-- x, y = player:get_position()
-- player:move( x + velocity.x * dt, y + velocity.y * dt )
------------------
function Player:rotate(degree)
    if dokun then
        Sprite.rotate(self, degree)
    end
end
------------------
function Player:scale(sx, sy)
    if dokun then
        Sprite.scale(self, sx, sy)
    end
end
------------------
function Player:shear(shx, shy)
    if (dokun) then
	    Sprite.shear(self, shx, shy)
	end
end
------------------
function Player:reflect(x, y)
    if (dokun) then
	    Sprite.reflect(self, x, y)
	end
end
------------------
function Player:hit(target) -- attack player, monster, or npc
    local damage

	if not target then return end --no target to hit, exit function
	if not is_monster(target) then return end-- target must be a monster
	if self:is_dead() then return end--if self is dead, exit function
	if not self:is_dead() then if target:is_dead() then return end end --if target is dead, exit function
	-- if both self and target are not dead (alive)
	if not self:is_dead() and not target:is_dead() then
    if target:detect(self, self:get_melee_combat_distance()) then --print("You are in combat distance!")-- temp--set player.combat_distance for both melee and magic
        -- calc damage
        damage = self:get_attack() - target:get_defense()    -- Player.get_attack is the same as Player.get_power
		if damage < 0 then
		    -- zero is enough
		    damage = 1
		end
        -- deal damage
		target:set_health( target:get_health() - damage )
		-- the moment you deal damage or are attacked, your target is set as well as your enemy's target
		target:set_target(self)--set monster target to you
		-- show message
        print("You attack "..target:get_name().." +"..damage)
		-- adjust health
		if self:get_health() <= 0 then
			self:set_health(0)
			self:set_target(nil)-- you no longer have a target
			target:set_target(nil)-- monster no longer has a target
			print("You have died")
	        return
		end
        if target:get_health() <= 0 then
			target:set_health(0)
			target:set_target(nil)-- monster no longer has a target
			self:set_target(nil)-- you no longer have a target
			print("You have slain "..target:get_name())
			-- the victor takes all monster drops
			-- call target.on_defeat for drops?
			if type(target.on_defeat) == "function" then target:on_defeat(self) end
			return
		end
    end -- temp
    end
end
------------------
function Player:respawn(x, y)
    local quarter_full_hp
    if self:is_dead() then
        quarter_full_hp = self:get_max_health() / 4
        self:set_health( quarter_full_hp );
        player:set_position( player:get_respawn_point() )
    end
end
------------------
function Player:level_up()
    local req_exp =
    {
        14, 20, 36, 90
    }
    if req_exp[ self:get_level() ] ~= nil then
        if self:get_exp() >= req_exp[ self:get_level() ] then
		    -- upgrade level
            self:set_level( self:get_level() + 1 )
            -- animate player
            -- show message
            print("Your level has been upgraded.")
            print("You are now level "..self:get_level().."!")
            -- increment stats
            self:set_maximum_health( self:get_maximum_health() + 1 )
            self:set_maximum_mana( self:get_maximum_mana() + 1 )
            self:set_power( self:get_power() + 1 )
            self:set_defense( self:get_defense() + 1 )
            self:set_magic( self:get_magic() + 1 )
			self:set_magic_defense( self:get_magic_defense() + 1 )
			-- restore full_health after battle (if not in combat)
			if not self:get_target() then self:set_health(self:get_maximum_health()) self:set_mana(self:get_maximum_mana())end
        end
    end
end
------------------
-- if collide with object(or by pressing a button) then pick up object; can also pick up Monster if they fall
function Player:pickup(item, x, y)
    if (dokun) then
	    -- collide with item
	    if self:collide(item) then
		    -- obtain item
		    self:obtain(item)
		end
	end
end -- dokun required
------------------
-- player kicks at a position
function Player:kick( position) end -- dokun required
------------------
-- player jumps with spacebar
function Player:jump(height) end -- dokun required
------------------
-- player runs in the direction it faces
function Player:run(speed) end -- dokun required(function animate())
------------------
-- player sits to recover health
function Player:sit()
    if (dokun) then
	    if Keyboard:is_pressed( KEY_INSERT ) then
		    self:set_texture({})
		end
	end
end
------------------
-- player teleports if a teleport item is used(ex. Item.use(port_stone))
function Player:teleport(area, x, y, z) end
------------------
-- player drops object after picking it up
function Player:drop(item) end
------------------
-- player gets on a mount
function Player:ride(mount) end -- or player:equip(mount)
------------------
-- player falls down if badly hurt or they fall off something
function Player:fall() end
------------------
-- player throws an object(or monster) towards a direction
function Player:throw(object, angle_of_release) end
------------------
function Player:use(source, target)
    if is_item(source) then
        source:use(self)
	end
	if is_spell(source) then
	    source:cast(target)
	end
end
------------------
function Player:cast(spell, target)
    self:use(spell, target)
end
------------------
function Player:regen(health, seconds)
    if not player:is_dead() then
	    self:set_health( self:get_health() + health / seconds )
    end
end
------------------
-- INTERACTIONS
-- player follows another player or an npc
function Player:follow(target) -- monster must have a "target" to follow
    --if player.nearest_npc then target = player.nearest_npc end
    if type(target) ~= "table" then return end

	local vel = 0.5
	local self_x, self_y     = Sprite.get_position(self)
	local target_x, target_y = Sprite.get_position(target)
    local up, down, left, right

	if self_x >= target_x then -- 600 = end
		right = false
		left = true
	end
	if self_x <= target_x then -- 200 = start
		right = true
		left = false
	end
	if self_y >= target_y then -- 600 = end
		up = false
		down = true
	end
	if self_y <= target_y then -- 200 = start
		up = true
		down = false
	end
    if right and up then self:set_position(self_x + vel, self_y + vel)
    elseif right and down then self:set_position(self_x + vel, self_y - vel)
	elseif left and up then self:set_position(self_x - vel, self_y + vel)
	elseif left and down then self:set_position(self_x - vel, self_y - vel)
    end
end
------------------
function Player:detect(entity, dist)
    if not dist then dist = 118 end
	    -- get position of player and entity
        local entity_x, entity_y
	    entity_x, entity_y = Sprite.get_position(entity)
	    local self_x, self_y
        self_x, self_y = Sprite.get_position(self)
		-- calculate the distance (how far they are from one another)
	    --local distance = math.sqrt( math.pow(self_x - enemy_x, 2) + math.pow(self_y - enemy_y, 2) ) -- math.pow is deprecated in 5.3 **sighs** (-.-)
		local distance = math.sqrt(((self_x - entity_x) * (self_x - entity_x)) + ((self_y - entity_y) * (self_y - entity_y)))
        --print(self:get_name().." distance from player: "..distance) -- temporary
		-- distance from each other is less than
		-- 0 distance = right in each other's face; they are in the same position
		-- 1000 distance = too far from each other
		if (distance <= dist) then
		    return true
		end
	return false
end
------------------
-- player trades with another player(or npc)
function Player:trade(target, item, quantity) end
------------------
-- player sends a party invite to another player
function Player:party(target) end
------------------
-- player sends a duel invite to another player
function Player:duel(target) end
------------------
-- player sends a friend request to another player
function Player:add_friend(target) end
------------------
-- player invites another player to the guild they are in
function Player:send_guild_invite(target, guild_name) end
------------------
-- displays quests
function Player:show_quests()
    if not self.quest then
	    self.quest = {}
	end
    for _, quest in pairs(self.quest) do
	    local statusnum, status = quest:get_status()
        print( quest:get_name(), status, quest:get_objective() )
    end
end
------------------
function Player:check(quest_target) -- checks if a quest in the player's quest log is related to a monster
    if not self.quest then self.quest = {} end
    if not is_monster(quest_target) then return end -- quest_target must be a monster
    for _, quest in pairs(player.quest) do
	    if is_quest(quest) then
		    if quest:in_progress() then
			    local target = quest:get_target()
				if target:get_name() == quest_target:get_name() then --if the name of target and arg match --or getmetatable(quest_target) == quest_target.mt then
				    if target.slain < target.kill_limit then -- not finished yet
					    target.slain = target.slain + 1 -- increment
						print(target:get_name().."s slain: "..target.slain.."/"..target.kill_limit.." ")
						if target.slain == target.kill_limit then
						    --print("Quest complete!")
							--npc must confirm that the quest is 100% completed
						end
					end
				end
			end
		end
	end
end
------------------
-- SETTERS
------------------
function Player:set_level(level)
    self.level = level
end
------------------
function Player:set_exp(exp_)
    self.exp = exp_
end
------------------
function Player:set_health(health)
    self.health = health
end
------------------
function Player:set_mana(mana)
    self.mana = mana
end
------------------
function Player:set_maximum_health(max_health)
    self.max_health = max_health
end
------------------
Player.set_max_health = Player.set_maximum_health
------------------
function Player:set_maximum_mana(max_mana)
    self.max_mana = max_mana
end
------------------
Player.set_max_mana = Player.set_maximum_mana
------------------
function Player:set_level_capacity(level_capacity)
    self.level_cap = level_capacity
end
------------------
function Player:set_power(base_power)
    self.power = base_power
end
------------------
Player.set_attack = Player.set_power
------------------
function Player:set_defense(defense)
    self.defense = defense
end
------------------
function Player:set_magic(magic)
    self.magic = magic
end
------------------
function Player:set_magic_defense(magic_defense)
    self.magic_defense = magic_defense
end
------------------
function Player:set_attack_speed(attack_speed)
    self.attack_speed = attack_speed
end
------------------
function Player:set_movement_speed(move_speed)
    self.move_speed = move_speed
end
------------------
function Player:set_health_regeneration(health_regen, seconds)
    self.health_regen      = health_regen
	self.health_regen_time = seconds
end
------------------
function Player:set_spawn_point(x, y, z, area)
    self.spawn_point_x = x
    self.spawn_point_y = y
    self.spawn_point_z = z
end
------------------
function Player:set_target(target)
    self.target = target
	-- follow target on set
end
------------------
function Player:set_quest(quest)
    if not player.quest then
	    player.quest = {}
	end
	if not is_quest(quest) then
	    print("Not a valid quest")
	    return
	end
	player.quest[#player.quest + 1] = quest
	if quest:get_name() == "A New Beginning" then
	    print("Quest \""..quest:get_name().."\" accepted")
	end
end
------------------
Player.add_quest_to_log = Player.set_quest
------------------
function Player:set_position(x, y)
    if (dokun) then
	    Sprite.set_position(self, x, y)
	end
    self.x = x
	self.y = y
end
------------------
function Player:set_texture(texture)
    if dokun then
	    Sprite.set_texture(self, texture)
	end
end
------------------
function Player:set_melee_combat_distance(mcd)
	self.get_melee_combat_distance = mcd
end
function Player:set_magic_combat_distance(mcd)
	self.magic_combat_distance = mcd
end
------------------
-- GETTERS
------------------
function Player:get_id()
    return self.id
end
------------------
function Player:get_name()
    return self.name
end
------------------
function Player:get_level()
    return self.level
end
------------------
function Player:get_exp()
   return self.exp
end
------------------
function Player:get_exp_table(index)
    local req_exp = {
        14, 20, 36, 90,
		1237, 3234, 5657, 6457,
		9363, }
	return req_exp[index]
end
------------------
function Player:get_health()
   return self.health
end
------------------
function Player:get_mana()
    return self.mana
end
------------------
function Player:get_maximum_health()
    return self.max_health
end
------------------
function Player:get_maximum_mana()
    return self.max_mana
end
------------------
function Player:get_level_capacity()
    return self.level_cap
end
------------------
function Player:get_power()
    return self.power
end
------------------
Player.get_attack = Player.get_power
------------------
function Player:get_defense()
    return self.defense
end
------------------
function Player:get_attack_speed()
   return self.attack_speed
end
------------------
function Player:get_movement_speed()
    return self.move_speed
end
------------------
function Player:get_magic()
    return self.magic
end
------------------
function Player:get_magic_defense()
    return self.magic_defense
end
------------------
function Player:get_health_regeneration()
    return self.health_regen
end
------------------
function Player:get_health_regeneration_time()
    return self.health_regen_time
end -- seconds
------------------
function Player:get_target()
    return self.target
end
------------------
function Player:get_equipment(index)
    if not self.equipment then self.equipment = {} end
	return self.equipment[index]
end
------------------
function Player:get_weapon()
    if not self.equipment then self.equipment = {} end
	return self.equipment[ WEAPON ] ----------------------------------------------------------
end
------------------
Player.get_main_hand = Player.get_weapon
------------------
function Player:get_assist()
    if not self.equipment then
	   self.equipment = {}
	end
	return self.equipment[ AMMO_SHIELD ]
end
------------------
function Player:get_power_up(index)
    if not self.equipment then
	   self.equipment = {}
	end
	if index == 1 then
	    return self.equipment[ POWER_UP1 ]
	end
	if index == 2 then
	    return self.equipment[ POWER_UP2 ]
	end
end
------------------
function Player:get_head()
    if not self.equipment then
	   self.equipment = {}
	end
	return self.equipment[ HEAD ]
end
------------------
function Player:get_body()
    if not self.equipment then
	   self.equipment = {}
	end
	return self.equipment[ BODY ]
end
------------------
function Player:get_leg()
    if not self.equipment then
	   self.equipment = {}
	end
	return self.equipment[ LEG ]
end
------------------
function Player:get_foot()
    if not self.equipment then
	   self.equipment = {}
	end
	return self.equipment[ FEET ]
end
------------------
function Player:get_ride()
    if not self.equipment then
	   self.equipment = {}
	end
	return self.equipment[ RIDE ]
end
------------------
function Player:get_badge()
    if not self.equipment then
	   self.equipment = {}
	end
	return self.equipment[ BADGE ]
end
------------------
function Player:get_unspecified()
    if not self.equipment then
	   self.equipment = {}
	end
	return self.equipment[ UNSPECIFIED ]
end
------------------
function Player:get_player_by_id(id)
    return get_player_by_id(id)
end
------------------
function Player:get_player_by_name(name)
    return get_player_by_name(name)
end
------------------
function get_player_by_id(id)
    for _, player in pairs(_G) do
	    if is_player(player) then
		    if player:get_id() == id then
			    return player
			end
		end
	end
end
------------------
function get_player_by_name(name)
    for _, player in pairs(_G) do
	    if is_player(player) then
		    if player:get_name() == name then
 			    return player
			end
		end
	end
end
------------------
function Player:get_position()
    if dokun then
        return Sprite.get_position(self)
    end
    return self.x, self.y
end
------------------
function Player:get_spawn_point()
    return self.spawn_point_x, self.spawn_point_y
end
------------------
function Player:get_guild()
    return self.guild
end
------------------
function Player:get_guild_id()
    return self:get_guild():get_id()
end
------------------
function Player:get_guild_rank()
    return self:get_guild():get_rank()
end
------------------
function Player:get_guild_position()
    return self:get_guild():get_position()
end
------------------
function Player:get_guild_level()
    return self:get_guild():get_level()
end
------------------
function Player:get_guild_leader()
    return self:get_guild():get_leader()
end
------------------
function Player:get_class()
    return self.class
end
------------------
function Player:get_race()
    return self.race
end
------------------
function Player:get_location()
    return self.location
end
------------------
function Player:get_count()
    return Player.id
end
------------------
function Player:get_player_by_ip(ip)
end
------------------
function Player:get_players_online()
end
------------------
function Player:get_partner()
    return self.partner
end
------------------
function Player:get_gender()
    return self.gender
end
------------------
function Player:get_quest(index)
    if not self.quest then
        self.quest = {}
    end
    if type(index) == "number" then
	    return self.quest[index]
	end
	return self.quest
end
------------------
function Player:get_respawn_point()
    return self.respawn_point_x, self.respawn_point_y
end
------------------
function Player:get_drop_from_monster(monster)
    monster:drop(self)
end
------------------
function Player:get_position()
if dokun then
	return Sprite.get_position(self)
end
    return 0, 0
end
------------------ 07-14-2019
function Player:get_melee_combat_distance()
	return self.melee_combat_distance
end
function Player:get_magic_combat_distance()
	return self.magic_combat_distance
end
------------------
-- BOOLEAN
------------------
function Player:is_player()
    -- Is it a table?
    if type(self) ~= "table" then return false
	end
	-- Original?
    if getmetatable(self) == Player_mt then return true
	end
	-- copy
if not dokun then
	local g = _G
	for _, player in pairs(g) do
	    if getmetatable(player) == Player_mt then
            if getmetatable(self) == player.mt then
		        return true
		    end
        end
	end
end
if dokun then
	for p = 1, Player.factory:get_size() do
	    if self == Player.factory:get_object(p).mt then
			return true
		end
	end
end
    return false
end
------------------
is_player = Player.is_player
------------------
function Player:on_ride()
    return false
end
------------------
function Player:is_resting()
    return false
end
------------------
function Player:is_dead()
    if self:get_health() <= 0 then self:set_health(0) return true
    end
    return false
end
------------------
function Player:in_combat()
    if self:is_dead() then return false end -- cannot be dead and in_combat at the same time
	if self:get_target():is_dead() then return false end --cannot be in_combat with a dead opponent

    if is_monster(self:get_target()) then
	    if self:get_target():get_target() == self then
		    return true
		end
	end
    return false
end
------------------
function Player:is_online()
    return false
end
------------------
function Player:is_equipped(item)
    if not is_item(item) then
	    return false
	end
	if not self.equipment then
        self.equipment = {}
	end
    if self.equipment[HEAD] == item then
	    return true
	end
    if self.equipment[BODY] == item then
	    return true
	end
    if self.equipment[MAIN_HAND] == item then
	    return true
	end
    if self.equipment[AMMO_SHIELD] == item then
	    return true
	end
    if self.equipment[ASSISTANT] == item then
	    return true
	end
    if self.equipment[LEG] == item then
	    return true
	end
    if self.equipment[HAND] == item then
	    return true
	end
    if self.equipment[FEET] == item then
	    return true
	end
    if self.equipment[BACK] == item then
	    return true
	end
    if self.equipment[RIDE] == item then
	    return true
	end
	return false
end
------------------
function Player:has_target()
    return self.target ~= nil
end
------------------
function Player:has_weapon()
    if not self.equipment then
	    self.equipment = {}
	end
	return is_item( self.equipment[ WEAPON ] )
end
------------------
-- searches in quest_log for a specific quest
function Player:has_quest(quest)
    if not self.quest then
	    self.quest = {}
	end
    for _, quest in pairs(self.quest) do
        if self:get_quest(_) == quest then
            return true
        end
    end
    return false
end
------------------
function Player.customize(player)
end
------------------
function Player:show_equipment()
    print("Head", self.equipment[HEAD])
	print("Body", self.equipment[BODY])
	print("Weapon", self.equipment[MAIN_HAND])
	print("Ammo/Shield", self.equipment[ASSISTANT])
	print("Leg", self.equipment[LEG])
	print("Hand", self.equipment[HAND])
	print("Feet", self.equipment[FEET])
	print("Back", self.equipment[BACK])
	print("Ride", self.equipment[RIDE])
end
------------------
function Player:equip(item)
    -- Is there an equipment slot?
	if not self.equipment then self.equipment = {} end
    -- Is the player dead?
    if self:is_dead() then print("You are dead") return end
	-- Is this a valid item?
	if not is_item(item) then print("Not a valid item") return end
	-- Is the item in the bag?
	if not item:in_bag() then print(item:get_name().." not in Bag") return end
	-- Can the item be equipped?
	if not string.find( item:get_type(), nocase("Equipment") ) then print(item:get_name().." cannot be equipped") return end
	-- Does the player meet the requirements?
	if player:get_level() < item:get_require() then print("Your level is too low") return end
	-- weapon
	if string.find( item:get_subtype(), nocase("Weapon") ) or string.find( item:get_subtype(), nocase("Smasher") ) or string.find(item:get_subtype(), nocase("Blaster")) or string.find(item:get_subtype(), nocase("Explosive")) then
		-- If [weapon] slot is taken
		if self.equipment[ WEAPON ] then
		    local weapon = item --new weapon to be equipped
			-- remove effect from old weapon
			self:set_power( self:get_power() - self.equipment[ WEAPON ]:get_effect() )
			print( "-"..self.equipment[ WEAPON ]:get_effect().." power" )
			-- swap weapons
			if dokun then if bag_slots then if Sprite.get_texture(self.equipment[ WEAPON ]):is_texture() then bag_slots[ weapon:get_slot() ]:get_image():copy_texture(Sprite.get_texture(self.equipment[ WEAPON ])) end end end--copy old_weapon's texturedata to bag_slots:image
		    Bag.slots[ weapon:get_slot() ] = self.equipment[ WEAPON ] -- bag slot stores old(already-equipped) weapon
		    self.equipment[ WEAPON ] = weapon  -- new weapon is inserted into the weapon_equip_slot
			-- add effect from new weapon
			self:set_power( self:get_power() + self.equipment[ WEAPON ]:get_effect() )
			print( "+"..self.equipment[ WEAPON ]:get_effect().." power" )
			-- dokun-related stuff
		end
		-- If [weapon] slot is empty
		if not self.equipment[ WEAPON ] then
		    local weapon = item
			-- remove weapon from bag
			weapon:delete(1)
			-- add weapon to slot
            self.equipment[ WEAPON ] = weapon
            print( "Equipped "..self.equipment[ WEAPON ]:get_name() )
			-- add effect from weapon
			self:set_power( self:get_power() + weapon:get_effect() )
			print( "+"..weapon:get_effect().." power" )
		end
	end
	-- assistant
end
------------------
function Player:unequip(item, bag)
    -- Is there an equipment slot?
	if not self.equipment then self.equipment = {} end
    -- Is the player dead?
    if self:is_dead() then print("You are dead") return end
	-- Is this a valid item? -- added 10-25-2018
	if not is_item(item) then print("Not a valid item") return end
	-- what bag you using?
	if not bag then bag = Bag end
	-- make sure there is space in bag first -- added 10-25-2018
	if bag:is_full() then print("Cannot unequip "..item:get_name()..". Your bag is full") return end
	-- Is the item in the slot?
    for slot, equip_ in pairs(self.equipment) do
		if equip_ == item then
			-- delete from slot
			self.equipment[ slot ] = nil
			-- show message
			print( "Unequipped "..item:get_name() )
		    -- remove effect
			if slot == HEAD then end
			if slot == BODY then end
			if slot == WEAPON then
			    self:set_power( self:get_power() - item:get_effect() )
                print("-"..item:get_effect().." power")
			end
			if slot == AMMO_SHIELD then
			    self:set_power( self:get_power() - item:get_effect() )
                print("-"..item:get_effect().." power")
			end
			if slot == LEG then end
			if slot == FEET then end
			if slot == RIDE then end
			if slot == BADGE then end
			if slot == UNSPECIFIED then end
			-- move to bag
			bag:insert( item )
		end
	end
end
------------------
function Player:star_upgrade()
    if not self.rank   then self.rank = 1 end
    if not self.stars then self.stars = 0 end
    req_star =
    {
	    50, 100, 200, 400, 800, 1600,
		3200, 6400, 12800,

		25600, 51200, 102400, 204800,
		409600, 819200, 1638400,
		3276800, 6553600,

		13107200, 26214400,
    }
    if self.rank >= 50 then
        self.rank = 50
        return
    end

    while self.stars >= req_star[self.rank] do
        self.rank = self.rank + 1
        print("Star level has been upgraded!")
        self.rank_title = rank_title[ self.level + 1 ]
        print("Your rank is now "..self.rank)
        print("New rank title: "..self.rank_title)
    end
end -- another form of exp(determines rank)
-------------
function player_event_handler()
	for i = 0, Player.factory:get_size() do
	if is_player( player_factory:get_object(i) ) then
        player:on_load()
		player:on_draw()
	end
    end
end
-------------
-- Load players here.
dofile("player/player1.lua")
------------------
