
Pet = 
{ 
    name = "Pet", 
	breed, 
	level = 1, 
	exp = 0, 
	health = 100, 
	mana, 
	
	hunger   = 100, 
	intimacy = 50, 
    stage = 0; -- 0 = egg, 1 = junior, 2 = secondary, 3 = advanced
	mode  = 0; -- 0 = assist, 1 = fight, 2 = safe	
	
    power, 
	defense, 
	resist, 
	speed, 
	move_speed,
 
    max_health=100, 
    max_mana=100,
    max_exp=100000000000,
    max_power=100,
    max_defense =100,
    max_speed = 100,
    max_resist = 100,
    max_move_speed = 10;
 

}
--------------
Pet_mt = 
{ 
    __index = Pet,
    __gc = 
	function(self)
	    print(self:get_name(), " deleted")
	end
}
--------------
-- pet AI
PROTECT_MODE = "Protect mode" -- pet defends master when attacked
ACTIVE_MODE = "Active mode" -- pet automatically fights with nearby monster
NORMAL_MODE = "Normal mode" -- if pet is atked pet will escape, pet follows
SAFE_MODE = "Safe mode" -- pet does not atked even if master is atked
--------------
-- evolved stages
EGG = 0 --"egg"
JUNIOR = 1 --"junior"
SECONDARY = 2 --"secondary"
ADVANCED = 3 --"advanced"
--------------
-- breeds
NORMAL_PLUFF = "Pluff"
SUPER_PLUFF = "Super Pluff"
--------------
function Pet.new(name, level, breed) 
    local pet = {}
 
    pet.name = name
    pet.level = level
    pet.breed = breed
 
    pet.condition = ALIVE
    pet.mode = NORMAL_MODE
  
    setmetatable(pet, Pet_mt)
    return pet
end
--------------
super_pluff = Pet.new("Super Pluff", 1, SUPER_PLUFF)
--------------
pluff = Pet.new("Pluff", 1, NORMAL_PLUFF)
--------------
function Pet.rename(pet) 

 if pet.IN_BAG == false then
  name_change = io.read()
  pet.name = name_change
  print("You have successfully renamed your pet.")
 elseif pet.IN_BAG == true then
  print("The pet is your bag.")
 end
 
end
--------------
function Pet.hatch(pet)
--[[
 PET IS NOT AT LEVEL 5
]]--
  if pet.level < 5 then
   print("Your pet is not ready to hatch out of its egg.")
  end
   --[[
  PET IS NOT PRESENT(OUTSIDE OF BAG)
 ]]--
  if pet.IN_BAG == true then
   print("The pet is inside in the bag.")
  end
   --[[
  PET IS NOT AN EGG
 ]]--
  if pet.stage ~= EGG then
   print("The pet has already hatched.")
  end
  



 if pet.stage == EGG and 
  pet.level == 5  and 
  pet.health > 0 then
  
  if pet.IN_BAG == false then 
  --[[ hatch ]]--
   pet.stage = 2 
   pet.stage_name = "Junior"
   pet = Pet.new(pet.name, pet.level, pet.breed, pet.stage)
   print("Your pet has hatched out of its egg.")
  end
  
 
end
end
--------------
 function Pet.follow(pet, master)
  --[[if pet is out, follow master]]--
  if pet.IN_BAG == false and pet.condition == ALIVE then
   print("Your pet is following you.")
  end
 end
-------------- 
function Pet.summon(pet)
--[[ if pet is in the inventory and 
  pet is clicked, then bring the pet
  outside of the bag
]]--
 command = io.read()
 if pet.IN_BAG == true then
  if command == "summon" and pet.condition == ALIVE then
   print("The pet has been summoned!")
  end
 end 
end
--------------
 function Pet.trade(pet, master, trader)
 --[[ if a trade is requested, and the pet
  is offered to the trader, then make sure 
  -- PET IS TRADED BEFORE IT IS DELETED
  trader.item_slot[] = pet
  pet = nil
 ]]-- 
  
 end
-------------- 
 --98% COMPLETE!
function Pet.evolve(pet)
 -- if pet is not an egg
--[[ if a certain pet, and at a
 certain level, then the pet
 can evolve into its new breed
]]--
 -- levels of evolution 
 if pet.IN_BAG == false and pet.condition == ALIVE then
  evol_level = { 15, 35, 55 }
  while pet.level >= evol_level[pet.stage] do
   pet.stage = pet.stage + 1 -- stage increases by 1
   print("Your pet has evolved to the next stage!")
  end
 end
end
-------------- 
 -- 98% COMPLETE!
function Pet.levelProgression(pet, master)
 -- pet cannot exceed master's level
 while pet.level > master.level do
  pet.level = master.level
  print("Pets cannot exceed their master's level.")
  return true
 end
 return false
end
-------------- 
function Pet.levelUp(pet)
 req_exp = { 7, 13, 29, 83, 145 }  -- player.req_exp[150] -7
 while pet.exp >= req_exp[pet.level] do
  pet.level = pet.level + 1
  print("Your pet's level has been upgraded!")
  print("Pet is now level "..pet.level)
  Pet.evolve(pet)
 end
end
-------------- 
function Pet.dead(pet) 
--[[ intimacy decreases every time
 the pet is killed
 pet is then stored back into 
 the player's inventory 
 
 pets always lose exp once
 they are dead
]]--
 while pet.health == 0 do
  pet.condition = DEAD; 
  pet.intimacy = pet.intimacy - math.random(5);
  pet.exp = pet.exp - (pet.level + math.random(10));
  print("Your pet has died.");
  pet.IN_BAG = true;
  return true
 end
 pet.condition = ALIVE
 return false
end
--------------
function Pet.displayInfo(pet)
 if pet.stage == 1 then
  pet.stage_name = "Egg"
 elseif pet.stage == 2 then
  pet.stage_name = "Junior"
 elseif pet.stage == 3 then
  pet.stage_name = "Secondary"
 elseif pet.stage == 4 then
  pet.stage_name = "Advanced"
 end

 Pet.limit(pet)
 
 print("Name: "..pet.name)
 print("Breed: "..pet.breed)
 print("Level: "..pet.level)
 print("Stage: "..pet.stage_name)
 
 print("Exp: "..pet.exp)
 
 print("Health: "..pet.health)
 print("Mana: "..pet.mana)
 
 print("Intimacy: "..pet.intimacy)
 print("Hunger: "..pet.hunger)
 
 print("Power: "..pet.power)
 print("Defense: "..pet.defense)
 print("Speed: "..pet.speed)
 print("Resistance: "..pet.resist)
 
 print("Condition: "..pet.condition)
 print("Mode: "..pet.mode)
end
--------------
function Pet.out(pet)

 while pet.IN_BAG == false do
  pet.intimacy = pet.intimacy + 1
  pet.hunger = pet.hunger - 1
  print("The pet is out of the bag.")
  Pet.limit(pet)
  return true
 end
 print("The pet is inside of the bag.")
 return false
end
--------------
function Pet.ins(pet)
 
 while pet.IN_BAG == true do
  print("The pet is inside of the bag.")
  return true
 end
  print("The pet is out of the bag.")
  Pet.limit(pet)
  return false
 end
-------------- 
 function Pet.fight(pet)
  if pet.health <= 0 then
   pet.condition = DEAD
   pet.IN_BAG = true
   print("Your pet is dead and cannot engage in battle.")
  end
 
  if pet.condition == ALIVE and pet.IN_BAG == false then
   if pet.mode ~= SAFE_MODE and pet.health >= 1 then
    print("The pet has engaged in battle.")
	Pet.limit(pet)
   elseif pet.mode == SAFE_MODE then
	print("Your pet is currently in Safe Mode.")
   end
  end
 end
-------------- 
 function Pet.limit(pet)
  if pet.intimacy >= 100 then
   pet.intimacy = 100
  end
  if pet.intimacy <= 0 then
   pet.intimacy = 0
  end
 
  if pet.hunger >= 100 then
   pet.hunger = 100
  end
  if pet.hunger <= 0 then
   pet.hunger = 0
  end
 
 if pet.health > pet.max_health then
  pet.health = pet.max_health
 end
 if pet.health <=  0 then
  pet.health = 0
  pet.condition = DEAD
 end
 
 if pet.mana > pet.max_mana then
  pet.mana = pet.max_mana
 end
 if pet.mana <= 0 then
  pet.mana = 0
 end
 
 if pet.exp <= 0 then
  pet.exp = 0
 end
 if pet.exp > pet.max_exp then
  pet.exp = pet.max_exp
 end
 
 --[[
 if pet.level < 0 then 
  pet.level = 1
 end
 
 XD Pet levels are 1 by default and 
 are never lowered so there's no point
 of this.
 ]]--
 
 if pet.power > pet.max_power then
  pet.power = pet.max_power
 end
 
 if pet.defense > pet.max_defense then
  pet.defense = pet.max_defense
 end
 
 if pet.speed > pet.max_speed then
  pet.speed = pet.max_speed 
 end
 
 if pet.resist > pet.max_resist then
  pet.resist = pet.max_resist
 end
 
 if pet.level < 5 then
  pet.stage = EGG
 end
 if pet.level >= 15 then
  pet.stage = JUNIOR
 end
 if pet.level >= 35 then
  pet.stage = SECONDARY
 end
 if pet.level >= 55 then
  pet.stage = ADVANCED
  end
  

 end
-------------- 
 function Pet.runAway(pet)
 --[[
  if pet.dead(pet) == true and pet.intimacy <= 5 then
   chance_of_running_away = math.random(1, 99) - pet.intimacy
   print(chance_of_running_away.."%")
  end
  ]]--
end
--------------
function Pet:ressurect()
    -- restore to full health
	self:set_health(self:get_maximum_health())
	-- intimacy 40 and below
	if self:get_intimacy() <= 40 then
	    -- 50% chance it will run away
	    local run = math.random(0, 1)
		if run == 0 then
		    print("Pet has revived")
		end
		if run == 1 then
		    print("Pet has ran away")
		end
	end
end
--------------
-- SETTERS
--------------
function Pet:set_name(name)
    self.name = name
end
--------------
function Pet:set_level(level)
    self.level = level
end
--------------
function Pet:set_stage(stage)
    self.stage = stage
end
--------------
function Pet:set_breed(breed)
    self.breed = breed
end
--------------
function Pet:set_mode(mode)
    self.mode = mode
end
--------------
function Pet:set_hunger(hunger)
    self.hunger = hunger
end
--------------
function Pet:set_intimacy(intimacy)
    self.intimacy = intimacy
end
--------------
function Pet:set_health(health)
    self.health = health
end
--------------
function Pet:set_mana(mana)
    self.mana = mana
end
--------------
--------------
--------------
-- GETTERS
--------------
function Pet:get_name()
    return self.name
end
--------------
function Pet:get_level()
    return self.level
end
--------------
function Pet:get_stage()
    return self.stage
end
--------------
function Pet:get_breed()
    return self.breed
end
--------------
function Pet:get_mode()
    return self.mode
end
--------------
function Pet:get_hunger()
    return self.hunger
end
--------------
function Pet:get_intimacy()
    return self.intimacy
end
--------------
function Pet:get_health()
    return self.health
end
--------------
--------------
--------------
--------------
--------------
-- BOOLEAN
--------------
function Pet:is_pet()
    if type(self) ~= "table" then
	    return false
	end
	if getmetatable(self) == Pet_mt then
	    return true
	end
	local g = _G
	for _, pet in pairs(g) do
	    if getmetatable(pet) == Pet_mt then
		    if getmetatable(self) == pet.mt then
		        return true  
		    end
		end
	end
	return false
end
--------------
is_pet = Pet.is_pet
--------------
function Pet:is_dead()
    if self:get_health() <= 0 then
        self:set_health(0)
		return true
    end	
	return false
end
--------------
function Pet:in_bag()
end
--------------
--------------