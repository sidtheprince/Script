
Monster = 
{
    name           = "";
	type           =  0; -- 0(normal), 1(boss)
	level          =  1;
    health         = 100,
	attack         = 1,
	defense        = 1,
	magic          = 0,
	resist         = 1, -- magic resistance
	stealth        = 0, -- how much a monster can stay hidden
	water_resist   = 0,
	fire_resist    = 0,
	thunder_resist = 0,
	ice_resist     = 0,
	poison_resist  = 0,
	speed          = 1,
	attack_speed   = 1,
	move_speed     = 1,
	-- capacities
	max_health     = 100,
	-- other properties
    element        = nil,	-- FIRE, WATER, EARTH, WIND, SPACE, DARK, LIGHT, NATURE
	aggressive     = false,
	-- drops
    gold_drop = 0;
	min_gold_drop  = gold_drop;
	max_gold_drop  =       nil;
	exp_drop = 0;
	min_exp_drop   =  exp_drop;
    max_exp_drop   =       nil;
	max_spawn      =         3;
	max            =        20;
	-- other stuff
	area           =       nil;
	voice          =       nil;
}

--------------
Monster_mt = 
{
    __index = Monster,
	__gc    = 
	function(self)
        if dokun then
            Sprite.destroy(self)
        end		
	    print(self:get_name().." deleted.") 
	end
}
--------------
if dokun then
    Monster.factory = Factory:new()
end
------------------
function Monster:new(name, level)
    local monster 
    if dokun then
        monster = Sprite:new()
    else
        monster = {}
    end 
    -- set defaults
	------------------
    if self == Monster then
	    monster.name = name 
        monster.level = level
	else
	    monster.name = self 
        monster.level = name	    
	end
    ------------------	
    -- generate id for monster
    if not Monster.id then Monster.id = 0 
    end
    Monster.id = Monster.id + 1
    monster.id = Monster.id
    -- create a metatable
    monster.mt = {__index = monster}
    -- make copy function
    monster.new = function()
        local new_monster 
        if dokun then
            new_monster = Sprite:new()
        else
            new_monster = {}
        end
if dokun then
	    Monster.factory:store(new_monster) -- store even clone mobs in factory database
end
        setmetatable(new_monster, monster.mt)
        return new_monster
    end
	--
if dokun then
	Monster.factory:store(monster)
end
	-- set monster parent
    setmetatable(monster, Monster_mt)
    return monster 
end
--------------
function Monster:load(filename)
if self.on_load then self:on_load() else print(self.get_name()..":on_load does not exist") end -- do something on_load
if dokun then
    Sprite.set_texture(self, Texture:new(filename))
end
end
--------------
function Monster:draw(frame)
if self.on_draw then self:on_draw(player) else print(self:get_name()..":on_draw does not exist") end -- do something on_draw
if not self:is_dead() then -- if not dead
if dokun then
    if not frame then frame = 0 end
    Sprite.draw(self, frame)
end
end
end
--------------
-- monster chases after its enemy
function Monster:follow() -- monster must have a "target" to follow
    local target = self:get_target()
	if not is_player(target) then print("Cannot follow target : Invalid target.") return end
	local vel = 0.09
	local self_x, self_y     = self:get_position  ()	
	local target_x, target_y = target:get_position()
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
--------------
-- monster makes a sound or speaks
function Monster.speak(monster) 
    if dokun then
	    if not self.voice then
		    self.voice = Sound:new()
	    end
		self.voice:play()
	end
end
--------------
function Monster:animate()
    if type(self.animate) == "function" then
	    self:on_animate()
	end
end
--------------
-- respawn monster after it dies
function Monster:spawn(x, y) 
    local monster = self
	for m = 1, monster.max do
	    monster[m] = monster:new() -- new monster clone
		monster[m]:set_health(monster:get_max_health()) -- reset health
		
		global_load(monster[m], "monster/"..monster:get_name()..".png") -- load all from file
		set_position(monster[m], math.random(0, x), math.random(0, y)) -- randomize spawn point
	end
end
--------------
-- monster roams about area
function Monster:roam() 
end 
--------------
-- monster drops an item after being slain 
function Monster:drop(player)
  -- get self.exp_drop 
    local exp_gained = self:get_exp_drop()
  -- ensure that self.exp_drop is a number
    if type(exp_gained) ~= "number" then 
        exp_gained = 0
	end 
  -- self.exp_drop must be more than 0 
  -- in order to obtain the exp
  if exp_gained > 0 then 
   -- give a player some exp
   player.exp = player.exp + exp_gained
  end
   -- show message
   print("Obtained "..exp_gained.." Exp")
  ------------------------
  local item_drop
  -- self.item_list is not set
    if type(self.item_drop_list) ~= "table"  then 
        self.item_drop_list = {} 
    end 
  
    for i = 1, #self.item_drop_list do -- scan through all items in self.item_drop_list
        if chance1(self.item_drop_list[i].dropchance) == true then -- chance1(50) there is a 50% chance it will be true
	        item_drop = self.item_drop_list[i] -- if chance1(item.dropchance) is false then item_drop will be nil
	        break
        end
    end
  --[NOTE]: sometimes an item drops and sometimes it doesn't
  -- an item is dropped by monster
    if item_drop ~= nil then                          
        -- bag is not full
        if not Bag:is_full() then
            -- obtain the item (with no collision)
            Item.obtain(item_drop:new()) -- works with unique+ non-stackable items
        end
        -- bag is full, but an item is stackable
        if Bag:is_full() and item_drop:is_stackable() then
        -- obtain the item (with no collision)
            Item.obtain(item_drop)
        end
    end
    -- 
  ------------------------
    -- is self.gold_drop set?
	local gold_drop = self:get_gold_drop()
    if type(gold_drop) ~= "number" then 
        gold_drop = 0
	end 
    -- is self.gold_drop more than 0? 
    if gold_drop > 0 then
        -- put gold inside the Bag
        Bag.gold = Bag.gold + gold_drop
        -- show message
        print("Obtained "..gold_drop .." "..gold:get_name())
    end
end
--------------
function Monster:detect(enemy, dist) -- how far enemy has to be to be detected
    if not dist then dist = 118 end
	    -- get position of monster and enemy
        local enemy_x, enemy_y
	    enemy_x, enemy_y = enemy:get_position()
	    local self_x, self_y
        self_x, self_y = self:get_position()
		-- calculate the distance (how far they are from one another)
	    local distance = math.sqrt( math.pow(self_x - enemy_x, 2) + math.pow(self_y - enemy_y, 2) )
		--print(self:get_name().." distance from player: "..distance) -- temporary
		-- distance from each other is less than
		-- 0 distance = right in each other's face; they are in the same position
		-- 1000 distance = too far from each other
		if (distance <= dist) then
		    return true
		end
	return false
end
--------------
function Monster:check(player) -- checks if a quest in the player's quest log is related to a monster
    if not player.quest then player.quest = {} end
    for _, quest in pairs(player.quest) do
	    if is_quest(quest) then
		    if quest:in_progress() then
			    local target = quest:get_target()
				if target == self or getmetatable(self) == self.mt then
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
--------------
function Monster:find_nearest_player()
if dokun then
    local player
    for p = 0, Player.factory:get_size() do
	    player = Player.factory:get_object(p)
		if player then
		    if self:detect(player, 150) then 
				return player--self:set_target(player)
			end
		end
	end
end
    return nil
end
--------------
-- respawn a monster, setting it to full health
function Monster:respawn()
    if self:is_dead() then
	    -- revive with partial health
	    self:set_health( self:get_maximum_health()/4 )
	end
end
--------------
function Monster:regenerate( health, seconds) 
    -- monster is not dead
    if not self:is_dead() then
	    -- monster health is less than its max health
	    if self:get_health() < self:get_maximum_health() then
		    -- increase health per second
		    self:set_health( self:get_health() + ( health / os.clock() ) )
		end
	end
end
--------------
Monster.regen = Monster.regenerate
--------------
 -- at low health use special move
 -- monster attacks an opponent 
function Monster:hit(target)
   local damage 
	if self:is_dead() then
	    print(self:get_name().." is dead")
		return
	end
	if not is_player(target) then return end --return if target is not a player
	if not self:is_dead() then
	    if target:is_dead() then
		    print("You are dead") 
			return
		end
	end
    if not self:is_dead() and not target:is_dead() then
        -- calc damage
        damage = self:get_attack() - target:get_defense()    
		if damage < 0 then damage = 0 print(self:get_name().."'s attack missed") end
        -- deal damage
        target:set_health( target:get_health() - damage )
		-- once an aggressive monster or boss deals damage to a player, then player's target is set to monster
		target:set_target(self)
        -- show message
        print(self:get_name().." attacks "..target:get_name().." +"..damage)
		print("Siddy HP: "..target:get_health())
		-- adjust health (if less than 0)
		if target:get_health() <= 0 then
		    target:set_health(0)
			print("You are killed by "..self:get_name())
	        return
		end		
        if self:get_health() <= 0 then 
		    self:set_health(0) 
			print("You have slain "..self:get_name())
			return
		end
    end
end
--------------
 -- SETTERS
--------------
function Monster:set_name(name) 
    if type(name) == "string" then 
	    self.name = name
	else 
	    error("'name' must be a string!") 
	end 
end
--------------
function Monster:set_level(level) 
    if type(level) == "number" then 
	    self.level = level 
	else 
	    error("'level' must be a number!") 
	end 
end
--------------
function Monster:set_type(type_) 
    if type(type_) == "number" then 
	    self.type = type_ 
	else 
	    error("'type' must be a number!") 
	end 
end
--------------
function Monster:set_health(health) 
    self.health = health 
end
--------------
Monster.set_hp = Monster.set_health
--------------
function Monster:set_maximum_health(max_health) 
    self.max_health = max_health 
end
--------------
Monster.set_max_hp = Monster.set_maximum_health
--------------
function Monster:set_power(power) 
    self.attack = power 
end
--------------
Monster.set_attack = Monster.set_power
--------------
function Monster:set_defense(defense) 
    self.defense = defense 
end
--------------
function Monster:set_magic(magic) 
    self.magic = magic 
end
--------------
function Monster:set_resistance(resist) 
    self.resist = resist 
end
--------------
Monster.set_magic_resistance = Monster.set_resistance
--------------
function Monster:set_exp_drop(exp_drop, max_exp_drop) 
    if type(exp_drop) == "number" then 
	    self.exp_drop = exp_drop 
		self.min_exp_drop = self.exp_drop 
	else 
	    error("'exp' must be a number!") 
	end 
	if type(max_exp_drop) == "number" then 
	    self.max_exp_drop = max_exp_drop 
	end 
end
--------------
function Monster:set_item_drop(drop, drop_chance) 
    if not self.item_drop_list then 
	    self.item_drop_list = {} 
	end 
	-- get drop(item)
	local item = drop:new() 
	-- store drop(item)
	self.item_drop_list[#self.item_drop_list + 1] = item 
	-- 50% drop_chance (default)
	if not drop_chance or
	type(drop_chance) ~= "number" then 
	    drop_chance = 50 
	end 
	-- set drop_chance
	self.item_drop_list[#self.item_drop_list].dropchance = drop_chance 
end
--------------
function Monster:set_gold_drop(gold_drop, max_gold_drop) 
    if type(gold_drop) == "number" then 
	    self.gold_drop = gold_drop 
		self.min_gold_drop = gold_drop 
	else 
	    error("'gold' must be a number!") 		
	end 
	if type(max_gold_drop) == "number" then 
	    self.max_gold_drop = max_gold_drop 
	end 
end
--------------
function Monster:set_drop(drop, dropchance) -- items = slime:set_drop(potion, 50) slime:set_drop(gold, 1) exp = slime:set_drop(6)
   -- drop is an item (or gold)
    if is_item(drop) then
        if drop:get_type() ~= MONEY then
            self:set_item_drop(drop, dropchance)
        end
        if drop:get_type() == MONEY then
            local amount = dropchance
            self:set_gold_drop(amount)
        end
   end
   -- drop is a number(exp)
   if type(drop) == "number" then
        self:set_exp_drop(drop)
   end
end
--------------
function Monster:set_boss(boss) 
	if not boss then
	    self.type = 0 
	end 
    if boss then 
	    self.type = 1 
	end
end
--------------
function Monster:set_target(target) 
    self.target = target 
end -- entity that monster will attempt to attack
--------------
function Monster:set_position(x, y)
   if (dokun) then
        Sprite.set_position(self, x, y)   
   end
end
--------------
function Monster:set_texture(texture)
   if (dokun) then
        Sprite.set_texture(self, texture)
   end
end
--------------
function Monster:set_state(state) 
    self.state = state 
end
--------------
function Monster:set_element(element) 
    self.element = element 
end
--------------
function Monster:set_skill(skill) 
    if not self.skill then 
	    self.skill = {} 
	end 
	if is_spell(skill) then 
	    self.skill[#self.skill + 1] = skill 
	end 
end
--------------
function Monster:set_voice(voice) 
    self.voice = voice 
end -- must be a sound
--------------
function Monster:set_area(area) 
    if is_area(area) then 
        self.area = area 
	end 
end
--------------
function Monster:set_max_instance(max_instance) 
    self.max = max_instance 
end
--------------
-- GETTERS
--------------
function Monster:get_id() 
    return self.id 
end
--------------
function Monster:get_name() 
    return self.name 
end
--------------
function Monster:get_level() 
    return self.level 
end
--------------
function Monster:get_type() 
    return self.type 
end
--------------
function Monster:get_exp_drop() 
    if type(self.max_exp_drop) == "number" then 
        return math.random(self.min_exp_drop, self.max_exp_drop) 
	end 
	return self.exp_drop 
end
--------------
function Monster:get_min_exp_drop() 
    return self.min_exp_drop 
end
--------------
function Monster:get_max_exp_drop() 
    return self.max_exp_drop 
end
--------------
function Monster:get_item_drop(index) 
    return self.item_drop_list[index] 
end
--------------
function Monster:get_gold_drop() 
    if type(self.max_gold_drop) == "number" then 
	    return math.random(self.min_gold_drop, self.max_gold_drop) 
	end 
	return self.gold_drop 
end
--------------
function Monster:get_min_gold_drop() 
    return self.min_gold_drop 
end
--------------
function Monster:get_max_gold_drop() 
    return self.max_gold_drop 
end
--------------
function Monster:get_health() 
    return self.health 
end
--------------
Monster.get_hp = Monster.get_health
--------------
function Monster:get_maximum_health() 
    return self.max_health 
end
--------------
function Monster:get_attack() 
    return self.attack 
end
--------------
Monster.get_power = Monster.get_attack
--------------
function Monster:get_defense() 
    return self.defense 
end
--------------
function Monster:get_magic() 
    return self.magic 
end
--------------
function Monster:get_magic_resistance() 
    return self.resist 
end
--------------
Monster.get_resistance = Monster.get_magic_resistance
--------------
function Monster:get_attack_speed() 
    return self.attack_speed 
end
--------------
function Monster:get_movement_speed() 
    return self.move_speed 
end
--------------
Monster.get_movement = Monster.get_movement_speed
--------------
function Monster:get_state() 
    return self.state 
end -- passive or aggressive
--------------
function Monster:get_element() 
    return self.element 
end
--------------
function Monster:get_stealth() 
    return self.stealth 
end
--------------
function Monster:get_skill(index) 
    return self.skill[index] 
end
--------------
function Monster:get_position() 
if dokun then
	return Sprite.get_position(self)
end
    return self.x, self.y
end
--------------
function Monster:get_target() 
    return self.target 
end
--------------
function Monster:get_area() 
    return self.area 
end
--------------
function Monster:get_info() 
    print("name",  self:get_name())
    print("level", self:get_level())
    print("boss",  self:is_boss())
	
    print("element ".."??")
    print("state ", self:get_state())
    -- stats
    print("health "..self:get_health())
 
    print("power "..self:get_attack())
    print("defense "..self:get_defense())
    print("movement "..self:get_movement())
    --print("speed "..self:get_attack_speed())
    print("magic "..self:get_magic())
    print("resistance "..self:get_magic_resistance())
    local cls -- class
    if is_monster(self) then
        cls = "Monster"
    else 
        cls = "??"
    end
    print("inherits from "..cls)

    print("area ".."??")
end
--------------
function get_monster_by_id(id) 
    for _, monster in pairs(_G) do 
        if is_monster(monster) then
            if monster:get_id() == id then 
                return monster 
            end 
        end 
    end
end
--------------
function get_monster_by_name(name) 
    for _, monster in pairs(_G) do 
        if is_monster(monster) then
            if monster:get_name() == name then 
                return monster 
            end 
        end
    end 
end
--------------
function Monster:get_monster_by_id(id) 
    return get_monster_by_id(id)
end
--------------
function Monster:get_monster_by_name(name) 
    return get_monster_by_name(name)
end
--------------
-- BOOLEAN
--------------
function Monster:is_monster() 
    -- Is it a table?
    if type(self) ~= "table" then
	    return false
	end
    if getmetatable(self) == Monster_mt then 
	    return true 
    end--works for monsters that are not copies 
if not dokun then
	local g = _G
    for _, monster in pairs(g) do
	    if getmetatable(monster) == Monster_mt then
		    if getmetatable(self) == monster.mt then
			    return true
			end
		end
	end
end
if dokun then
    local monster
	for i = 1, Monster.factory:get_size() do
	    monster = Monster.factory:get_object(i)
		if getmetatable(self) == monster.mt then
			return true
		end
	end
end
    return false 
end
--------------
is_monster = Monster.is_monster
--------------
function Monster:is_dead() 
    if self:get_health() <= 0 then
        self:set_health(0)
        return true 
    end 
    return false 
end
--------------
function Monster:is_boss() 
    return (self:get_type() == 1)
end
--------------
function Monster:is_aggressive()
    if self.aggressive then
	    return true
	end
	return false
end
--------------
Monster.is_aggro = Monster.is_aggressive
--------------
function Monster:in_combat_with( enemy ) -- checks if monster is currently in combat with an enemy (player or npc)
    --[NOTE]: Monster can lose target when its target escapes or runs to a far distance
    --[NOTE]: Monster can have a target that is either player or NPC
	local target = self:get_target()
	--if not target then return false end -- return false if no target is set
    if self:is_dead() then self:set_target(nil) return false end -- monster cannot be dead and be in_combat at the same time WTF xD
	if is_player(target) then if target:is_dead() then target:set_target(nil) return false end end --cannot be in_combat with a dead target
    -- Aggressive monsters automatically attack when a player is near them
    if self:is_aggressive() then if self:detect( enemy, 150 ) then return true end end--(combat/cast_distance=150)
    -- When player targets a non-aggressive monster, Monster.in_combat is true
    if not self:is_aggressive() then  -- player could be casting a spell from afar so I made the distance 150 (combat/cast_distance=150)
	    if self:detect( enemy, 150 ) then if enemy:get_target() == self and self:get_target() == enemy then return true end end-- if player attacks first
	end
	return false
end
--------------
function Monster:has_target()
    if is_player(self.target) or is_npc(self.target) then return true end
	return false
end
--------------
-- EVENT
--------------
function Monster:collision_event(player)
    if dokun then
        local _G = _G                    
		for num, monster in pairs(_G) do -- LOCAL VARIABLES DO NOT WORK HERE
		    if type(monster) == "table" then -- object is a table
			    if getmetatable(monster) == Monster_mt  -- object is an item (Monster base mt)
				    or getmetatable(monster) == monster.mt then -- or a clone of an item (Monster object mt)	
					    if Sprite.collide(player, monster) and not Monster.is_dead(monster) then -- if player collides with monster
							-- battle the monster  ( whether original or clone )
							battle(player, monster)
						end			
				end
			end
		end
	end
end

function Monster.boss_event()
end
--------------
function Monster:draw_all()
if dokun then--this acts as a #define like in C/C++
    local monster
    for i = 0, Monster.factory:get_size() do
	    monster = Monster.factory:get_object(i)
		if is_monster(monster) then--if monster is not nil
		    if not monster:is_dead() then--if monster is not dead
			    monster.width, monster.height = Sprite.get_texture (monster):get_size() -- 24,20
                monster.x, monster.y          = Sprite.get_position(monster)
			    -- animate the monster monster:animate()
                -- update monster healthbar
	            monster.health_bar:set_size(monster.width, 5)
                monster.health_bar:set_position(monster.x, monster.height + monster.y) -- update slimehbar position in loop
	            monster.health_bar:set_range(0, monster:get_maximum_health())
	            monster.health_bar:set_value(monster:get_health()) -- update slimehbar value in loop
	            monster.health_bar:draw() -- draw slimehbar
			    -- draw monster
			    monster:draw()
			end
		end
	end
end
end
				----------------------------
				--[[
				-- target
				target  = player--monster:get_target()
	            if target then 
				    target.x, target.y = target:get_position()
				    target.width, target.height = Sprite.get_size(player)
	                -- calculate distance from player
	                local distance_from_target = math.sqrt(math.pow(monster.x - target.x, 2) + math.pow(monster.y - target.y, 2))
                    -- check for any collision with target
	                if((monster.x < target.x + target.width) and (target.x < monster.x) and (monster.y < target.y + target.height) and (target.y < monster.y)) then
	                    collide = true
	                end
					if Keyboard:is_pressed(KEY_T) then 
	                    if distance_from_target > 150 then print("Target is too far") return end --target is nil when you are 150 units too far
	                    target:set_target(monster) print("Player target set to "..monster:get_name()) -- player target is slime	
	                end --TEMPORARY
				
                    if not monster:is_aggressive() then
                        if target:get_target() == monster then -- if player attacks first
                            -- set player as new target and follow target
		                    monster:set_target( target )       --print("You are now in combat with Slime")
		                    monster:follow()                   -- slime will follow its target 
		                    if collide then monster:hit( target ) end-- slime can only attack when close enough to attack player (at a distance of 1)
	                    end
	                    if (distance_from_target >= 200) then monster:set_target(nil) monster:set_target(nil) end --print("Target lost")--print("No target found")  -- stop chasing player if he runs to a distance of 200 or more	-- lose target when player runs or is at a certain distance-- distance is more than or equal to specified distance(300)
					end		
				end ]]--
				----------------------------- 
-----------------------------------
-- [NOTE]: Monsters have unlimited mana or do not need mana.
-----------------------------------
-- Load items here.
dofile("monster/slime.lua") 
dofile("monster/slime_king.lua") 
--dofile("monster/borg.lua") 
-----------------------------------