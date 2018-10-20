
bubble_gun = Item.new("Bubble Gun", EQUIPMENT, 1, "A gun filled with bubbles.", 20)

bubble_gun:set_price(30)
bubble_gun:set_subtype("Weapon")


function bubble_gun:on_use(user) 
 local player = user; if not player.equip_slot then player.equip_slot = {} end

---------------------------------------------------- when the equipment slot is empty 
 -- item is in the bag
 if self:in_bag() then
 -- item is a weapon
 if self:get_subtype() == WEAPON or self:get_subtype() == MAIN_HAND then
 -- equip_slot is empty
 if not player.equip_slot["Weapon"] then
 -- player meets level requirements
 if player:get_level() >= self:get_require() then 
  -- remove the item from the bag
  table.remove(Bag.slots, self:get_slot())
  -- add item to equip slot
  player.equip_slot["Weapon"] = self
  -- show message
  print("Equipped "..player.equip_slot["Weapon"]:get_name())
  -- apply the effect
  player:set_power(player:get_power()+self:get_effect())
 else
  print("Your level is too low.")
 end -- player meets level requirement
 else
  --[[print("Equip slot is already taken.")]]--
 end -- equip_slot is not taken
 else
  print(self:get_name().." is not a valid weapon!")
 end -- is a weapon
 else
  print("The item is not in the bag.")
 end -- is in bag
 
 ---------------------------------------------- when the equipment slot is taken
 -- REMOVE THE OLD ITEM from player.equip_slot["Weapon"]
 -- item is in the bag
 if self:in_bag() then
 -- item is a weapon
 if self:get_subtype() == WEAPON or self:get_subtype() == MAIN_HAND then
 -- equip_slot is taken
 if player.equip_slot["Weapon"] then
 -- player meets level requirements
 if player:get_level() >= self:get_require() then 
 -- send current equipped item back into the bag
  Bag.slots[#Bag.slots + 1] = player.equip_slot["Weapon"]
 -- remove all effects from the old item
  player:set_power(player:get_power()-player.equip_slot["Weapon"]:get_effect())
  -- show message
  print("Unequipped "..player.equip_slot["Weapon"]:get_name())
 -- clear the equip slot
  player.equip_slot["Weapon"] = nil
 
 -- ADD THE NEW ITEM(self)
 -- remove self from the bag
  table.remove(Bag.slots, self:get_slot())
 -- add self in the slot now that the old item is removed
  player.equip_slot["Weapon"] = self
 -- apply effect from self
  player:set_power(player:get_power()+self:get_effect())
   -- show message
  print("Equipped "..self:get_name())
 else
  print("Your level is too low.")
 end
 end
 else 
  print(self:get_name().." is not a valid weapon!")
 end
 else
  --print("The item is not in the bag")
 end 



end