
Item =
{
    name        =        "";
	type        = "General"; 
	description =    "None";
	require     =         0;
	effect      =         0;
	quantity    =         0;
	price       =         0;
	durability  =         0;
	rarity      =  "Common";
	tradeable   =      true; 
	subtype     =    "None";
}
----------------
if dokun then
   Item.factory = Factory:new() 
end
----------------
Item_mt = 
{ 
    __index = Item,
	__gc    = 
	function(self) 
if dokun then
	    Sprite.destroy(self)
end		
		print(self:get_name(), "deleted") 
	end
}
------------------
function Item:new(name, type, require, description, effect)
    local item 
    if dokun then
        item = Sprite:new()
    else
        item = {}
    end 
    ---------------------
	-- Item:new()
    if self == Item then
        item.name = name
        item.type = type
        item.description = description
        item.require = require
        item.effect = effect
    -- Item.new()
	else
        item.name = self
        item.type = name
        item.description = require
        item.require = type
        item.effect = description 
    end
    ---------------------
    -- generate id number
    if not Item.id then Item.id = 0
    end
    Item.id = Item.id + 1
    item.id = Item.id
    ----------------------
    -- create metatable for inst
    item.mt = {__index = item}
    ----------------------
    -- make clone function for inst
    item.new = function()
        local new_item 
        if dokun then
            new_item = Sprite:new() 
        else			
		    new_item = {}
        end
if dokun then
	    Item.factory:store(new_item) -- store even clone  in factory database
end		
        setmetatable(new_item, item.mt)
		-- non-stackable (set quantity to 0)  equipments have their own unique quantity since they are non-stackable items
		if not new_item:is_stackable() then
		    new_item:set_quantity(0)
		end
        return new_item
    end
	--------------------
	if dokun then 
	    Item.factory:store(item) -- store original item in factory
	end
    setmetatable(item, Item_mt)
    return item
end
----------------
function Item:load(filename)
if dokun then
    local texture = Texture:new()
	if not texture:load(filename) then
	    print("Could not open "..filename) 
	    return false
	end
	Sprite.set_texture(self, texture)
end
    if self.on_load then self:on_load() end
    return true
end
-----------------
function Item:draw()
    if self.on_draw then self:on_draw() end
if dokun then
    Sprite.draw(self)
end
end
----------------
-- if mouse over self, info displayed
function Item:show()
    if is_item(self) then
        print("Item name: "..self:get_name())
        print("ID: "..self:get_id())
        print("type: "..self:get_type())
        if self:get_require() <= 0 then
            print("level required: None")
        else
            print("level required: "..self:get_require())
        end
        print("usage: "..self:get_usage())
        print("effect: "..self:get_effect())
        print("price: "..self:get_price())
        if self:in_bag() or self:get_type() == "Currency" and Bag.gold > 0 then
            print("in_bag: ".."Yes")
        else
            print("in_bag: ".."No")
        end
        print("durability: "..self:get_durability())
        if self:is_tradeable() then  
            print("tradeable: ".."Yes")
        else
            print("tradeable: ".."No")
        end
        print("rarity: "..self:get_rarity())
    end
end
----------------
-- use an item that has been obtained
function Item:use(user) 
   -- If item is a string (must be item name)
    if type(self) == "string" then self = get_item_by_name(self)
    end -- Item.use("Potion", player)
  -- call user implemented on_use function
    self:on_use(user)
end
----------------
function Item:select() end -- self in the bag is selected
----------------
-- Item.move_to_slot -- Hold and drag to move an self in your bag.
function Item:swap(slot_num) -- Switch slots with another item in the bag.
    if self:in_bag() then
        -- Slot is empty.
        if Bag.slots[slot_num] == nil then
            Bag.slots[self:get_slot()] = nil -- Empty old slot. 
            Bag.slots[slot_num] = self -- Fill new slot.
        else
            -- Slot is taken.  
            Bag.slots[self:get_slot()] = Bag.slots[slot_num] -- Move the other item from its slot to self's slot.
            Bag.slots[slot_num] = self   -- Now move self to the slot of the other item.
        end
    end
end -- slot must be empty 
----------------
function Item:swap_with_another_item(item)
end
----------------
function Item:equip(user) 
    if is_player(user) then user:equip(self) end
end -- Equip an item from your bag.
----------------
function Item:unequip(user)
    if is_player(user) then user:unequip(self) end
end
----------------
function Item:toss(player, bag, amount)
    if type(bag) ~= "table" then bag = Bag end -- main bag
    if type(amount) ~= "number" then amount = 1 end
    -- If gold exists
	if type(gold) == "table" then
	    -- item is gold (or copy of gold)
	    if self == gold or getmetatable(self) == gold.mt then print("gold gold gold")
	        -- player has enough gold to toss out of Bag
		    if Bag.gold >= amount then
		        -- reduce gold amount
	            Bag.gold = Bag.gold - amount
			    -- set obtained to false
			    self:set_obtained(false)
				-- set position a few distance from player
			if dokun then
			    local player_x, player_y = Sprite.get_position(player)
				Sprite.set_position(self, player_x + math.random(-20, 80), player_y + math.random(-20, -20) )
			end
				-- show message
				print(self:get_name(), "tossed")
            end	
	    end
	end
	
    -- check if item is in the bag
	if self:in_bag() then    
	    local slot_num 
		-- Non stackable items ( e.g equipments )
		if not self:is_stackable() then  -- non-stackable items take up a full slot in the Bag
		-- get slot position in bag
		slot_num = self:get_slot(bag)
		-- delete item from bag		
		Bag.slots[ slot_num ]:delete()  		
		-- set obtained to false (so it can be redrawn)
		self:set_obtained(false)
        -- drop at a few distance from current player position
	if dokun then	
		local player_x, player_y = Sprite.get_position(player)
		Sprite.set_position(self, player_x + math.random(-20, 80), player_y + math.random(-20, -20))
	end
		-- show message
		print(self:get_name(), "tossed")
		else -- if it is stackable delete the parent
			-- self is a copy of original item
			if self:is_copy() then
				-- if item is stacked, 
				-- you only have to delete 
				-- the parent item from the bag
				slot_num = self:get_parent():get_slot(bag)
                -- delete parent from bag				
			    self:get_parent():delete()
				-- copy is not obtained (so it can be redrawn)
				self:set_obtained(false)
				-- drop copy item a few distance from player
			if dokun then	
			    local player_x, player_y = Sprite.get_position(player)			
				Sprite.set_position(self, player_x + math.random(-20, 80), player_y + math.random(-20, -20) )
			end
				-- show message
				print(self:get_name().."(copy)", "tossed")
			else
			    -- self is the the original item ; get its slot number
			slot_num = self:get_slot(bag) 	
			-- delete item from bag (decrement and set to nil)
			Bag.slots[ slot_num ]:delete()  					
			-- set obtained to false (so it can be redrawn)
			self:set_obtained(false)
			-- drop item a few distance from player
		if dokun then	
			local player_x, player_y = Sprite.get_position(player) 		
			Sprite.set_position(self, player_x + math.random(-20, 80), player_y + math.random(-20, -20))
        end
			-- show message			
			print(self:get_name(), "tossed") 
			end
		end
    end
end -- Toss an item out of your bag.
----------------
function Item:delete(amount, bag) -- Delete an item in your bag.
    if not bag then bag = Bag end
  -- amount is not specified, (amount to be deleted)
  -- set default to one
    if not amount then amount = 1 
    end
  -- NON-STACKABLE CLONES(EQUIPMENT CLONES) ARE TREATED AS ORDINARY OBJECTS INHERITED FROM Item
 -- reduce quantity of item if above zero
 -- by a specified amount. (and if self is original item) e.g potion, sword or non-stackable clone
    if not self:is_copy() or not self:is_stackable() then -- or not stackable
        if self:get_quantity() > 0 then self:set_quantity( self:get_quantity() - amount ) 
    end
    elseif self:is_copy() and self:is_stackable() then
	-- reduce quantity of parent if stackable copy e.g potion:new()
    if self:get_parent():get_quantity() > 0 then self:get_parent():set_quantity(self:get_parent():get_quantity() - amount) end
	end                                                                
  
 -- once the  quantity reaches 0, remove it from bag
    if not self:is_stackable() or -- equipment (non-stackable)
    self:get_quantity() <= 0 then -- None of the specific item found in bag.
        self:set_quantity(0) -- To ensure that the item's quantity not a negative number.
        -- now remove from slot
        for i = 1, #bag.slots do
            -- bag slot contains the original item (not a copy) since its not stackable
            if bag.slots[i] == self then -- The item is found in bag.
                table.remove(bag.slots, i) -- Remove item from Bag, shifting elements up.
                break
            end
        end
    end
end
----------------
function Item:examine() end -- Examine an items outside of bag(works for non-obtainable items)
----------------
function Item:trade() end -- trade item with another player or npc
----------------
function Item:obtain(amount, bag) -- get the self inside your inventory; obtain an self by picking_up or collision?
	-- default amount = 1
	if not amount then amount = 1 end
	-- use default Bag (if nil)
	if not bag then bag = Bag end
    -- store in bag
	if bag:insert( self, amount ) then
	    if string.find(self:get_type(), nocase("currency")) then
		    print("Obtained "..amount.." "..self:get_name())
		else
		    print("Obtained "..self:get_name().." +"..amount.."")
		end
	    
		return true
	end
	return false
end
----------------
function Item:sell(amount) 
    local shop = Shop:new()
	shop:sell(self, amount)
end
----------------
function Item:buy(shop, amount) 
    if not is_shop(shop) then
	    print("Not a valid shop")
	end
	if is_shop(shop) then
	    shop:buy(self, amount)
	end
end
----------------
function Item:list() for _, item in pairs(_G) do if is_item(item) then print(item:get_name()) end end 
end
----------------
-- SETTERS
----------------
function Item:set_name(name) 
    self.name = name 
end
----------------
function Item:set_type(type) 
    self.type = type 
end
----------------
function Item:set_description(description) 
    self.description = description 
end
----------------
function Item:set_require(require) 
    self.require = require 
end
----------------
function Item:set_effect(effect) 
    self.effect = effect 
end
----------------
function Item:set_price(price) 
    self.price = price 
end
----------------
function Item:set_quantity(quantity) 
    self.quantity = quantity 
end
----------------
function Item:set_weight(weight) 
    self.weight = weight 
end
----------------
function Item:set_durability(durability) 
    self.durability = durability 
end
----------------
function Item:set_tradeable(tradeable) 
    self.tradeable = tradeable
end
----------------
function Item:set_subtype(subtype) 
    self.subtype = subtype 
end
----------------
function Item:set_rarity(rarity) 
    self.rarity = rarity 
end
----------------
function Item:set_obtained(obtained)
    self.obtained = obtained
end
---------------- new!
function Item:set_storage_quantity(storage_quantity) 
    self.storage_quantity = storage_quantity
end
----------------
-- GETTERS
function Item:get_id() 
    return self.id 
end
----------------
function Item:get_name() 
    return self.name 
end
----------------
function Item:get_type() 
    return self.type 
end
----------------
function Item:get_description() 
    return self.description 
end 
Item.get_usage = Item.get_description
----------------
function Item:get_require() 
    return self.require 
end
----------------
function Item:get_effect() 
    return self.effect 
end
----------------
function Item:get_price() 
    return self.price 
end
----------------
function Item:get_quantity() 
    return self.quantity 
end
----------------
function Item:get_weight() 
    return self.weight 
end
----------------
function Item:get_durability() 
    return self.durability 
end
----------------
function Item:get_rarity() 
    return self.rarity 
end
----------------
function Item:get_subtype() 
    return self.subtype 
end
----------------
-- NOTE: DOES NOT WORK WITH CLONE ITEMS.
-- CAN ONLY GET THE ORIGINAL ITEM.
function get_item_by_name(name)
    local _G = _G
    for _, item in pairs(_G) do 
        if is_item(item) then -- must be a valid item
            if item.name == name then 
			    return item
            end 
        end
    end 
    return nil
end
----------------
-- NOTE: DOES NOT WORK WITH CLONE ITEMS.
-- CAN ONLY GET THE ORIGINAL ITEM.
function get_item_by_id(id) 
    local _G = _G
    for _, item in pairs(_G) do 
        if is_item(item) then -- must be a valid item
            if item.id == id then 
                return item 
            end 
        end
    end 
    return nil
end
----------------
-- STATIC FUNCTION(S)
function Item:get_item_by_id(id) 
    if self ~= Item then 
        error "'self' must be class Item" 
    end 
	local item = get_item_by_id(id)
    return item
end
----------------
function Item:get_item_by_name(name) 
    if self ~= Item then 
        error "'self' must be class Item" 
    end 
	local item = get_item_by_name(name)
    return item
end
----------------
function Item:get_count() 
    if self ~= Item then 
        error "'self' must be class Item" 
    end 
    local num_item = 0 
    local _G = _G
    for _, item in pairs(_G) do 
        if is_item(item) then 
		    num_item = num_item + 1 
        end 
    end 
    return num_item 
end -- # of item objects
----------------
function Item:get_slot(bag) -- Get slot number of item inside bag or storage.
 -- specify which bag ( if multiple bags )
    if not bag then bag = Bag end 
 -- NON-Stackable items are their own tables while stackable will become the exact as the parent
 -- a clone and stackable e.g. potion:new()
    local item_obj = self
	if self:is_copy() and self:is_stackable() then
   -- get the original item
        item_obj = self:get_parent()
    end 
    for slot_num, item in pairs(bag.slots) do
	    if bag.slots[slot_num] == item_obj then 
            return slot_num
        end 	
    end
	if getmetatable(bag) == Bag_mt or bag == Bag then
        print("Not in bag")
        return 0
	end
	if getmetatable(bag) == Storage_mt or bag == Storage then
        print("Not in storage")
        return 0
	end	
end
----------------
function Item:get_parent()
    -- object of Item
    if getmetatable(self) == Item_mt then return Item end
	-- clone of Item object
	local _G = _G
	for _, item in pairs(_G) do
	    if type(item) == "table" then
		    if getmetatable(item) == Item_mt then
		        if getmetatable(self) == item.mt then
			        return item
			    end
		    end
		end
	end
end
----------------
function Item:get_storage_quantity() 
    return self.storage_quantity 
end
----------------
-- CONDITIONS
----------------
function Item:is_item()
    -- Is it a table?
    if type(self) ~= "table" then
	    return false
	end
    -- The original item. (created with Item.new())
    if getmetatable(self) == Item_mt then 
	    return true 
	end
	-- A copy of the item. 
	if not dokun then
	    local _G = _G
	    for _, item in pairs(_G) do
			if getmetatable(item) == Item_mt then
			    if getmetatable(self) == item.mt then
				    return true
			    end
			end
		end
	end
if dokun then
	for _ = 1, Item.factory:get_size() do
		if getmetatable(self) == Item.factory:get_object(_).mt then
			return true
		end
	end
end
	return false 
end 
----------------
is_item = Item.is_item
----------------
function Item:in_bag(bag)
    if not bag then bag = Bag end 
    -- original or non-stackable
    for slot_num, item in pairs(bag.slots) do -- scan through bag slots for item.
        if item == self then 
            return true -- the item is the same as self.
        end 
    end
	-- stackable item
	if self:is_stackable() then
        -- A copy of the item.
        for slot_num, item in pairs(bag.slots) do 
            if getmetatable(self) == item.mt then 
                return true 
            end 
        end
	end
    return false 
end
----------------
function Item:in_storage(storage)
    if not storage then storage = Storage end 
    -- original or non-stackable
    for slot_num, item in pairs(storage.slots) do 
        if item == self then return true 
        end 
    end 
	-- stackable item
	if self:is_stackable() then	
    -- A copy of the item.
        for slot_num, item in pairs(storage.slots) do 
            if getmetatable(self) == item.mt then 
		        return true 
            end 
        end 
	end
    return false 
end
----------------
function Item:in_shop(shop)
    if not shop then return false end 
    -- original or non-stackable
    for slot_num, item in pairs(shop.catalogue) do 
        if item == self then 
		    return true 
        end 
    end 
	-- stackable item
	if self:is_stackable() then	
    -- A copy of the item.
        for slot_num, item in pairs(shop.catalogue) do 
            if getmetatable(self) == item.mt then 
		        return true 
            end 
        end 
	end
    return false 
end
----------------
function Item:is_tradeable() 
    if type(self.tradeable) == "boolean" then 
        return self.tradeable 
    end 
    return false 
end
----------------
function Item:is_obtained() -- new! NOTE: just because an item is in a bag does not mean its mean obtained; obtained is a different story as it applies to the physical item in its "sprite form"
    if type(self.obtained) == "boolean" then
	    return self.obtained
	end
	return false
end
----------------
function Item:is_copy()
    local _G = _G
    for _, item in pairs(_G) do
	    if type(item) == "table" then
		    if getmetatable(item) == Item_mt then
                if getmetatable(self) == item.mt then
			        return true
			    end
			end
		end
	end
	return false
end
Item.is_child = Item.is_copy
----------------
function Item:is_stackable() -- equipments are not stackable
    if not string.find(self:get_type(), nocase("Equipment")) or not self:get_type() then
	    return true
	end
	return false
end
----------------
-- EVENT FUNCTION(S)
-- detect all collision with all items
function Item.collide_all() -- global items
end
----------------
-- draw all items
function Item:draw_all()
if dokun then
    --Item:hover_all()
    --Item:collide_all() -- collision event
	--Item:toss_all()
	--Item:use_all()
	local item -- local in a loop reduces speed of Lua (local variables only exist within functions)
    for i = 0, Item.factory:get_size() do
        if type(Item.factory:get_object(i)) == "table" then
	        item = Item.factory:get_object(i)
			-- obtain items on collision
			if Sprite.collide(player, item) and not item:is_obtained() then 
			    item:set_obtained(item:obtain()) 
			end
			-- draw items (if not obtained)(or if the item is equipped by a user, draw it on user's body)
			if not item:is_obtained() or (string.find(item:get_type(), nocase("Equipment")) and player:is_equipped(item)) then --
                 item:draw()			
			end
		end
    end
end
end
----------------
function Item:use_all()
--[[
    if is_item(self) then
	    -- if key is pressed
	    --if Keyboard:is_pressed() then
		    -- item can be used
		    player:use(self)
		--end
	end
]]--	
if dokun then
end
end
----------------
function Item:toss_all()
--[[
    if is_item(self) then
	    -- if item is in the bag
		if self:in_bag() then
		    -- toss the item out of bag
			self:toss(player)
		end
	end
]]--
--[[
if dokun then		
    for i = 0, Item.factory:get_size() do
        if type(Item.factory:get_object(i)) == "table" then
		    local item = Item.factory:get_object(i)
        if Keyboard:is_pressed(0x0020) then
			if item:in_bag() then
			    item:toss(player)
				break
			end

		end
	end	
end	
end
]]
end
----------------
function Item:hover_all()
--[[
if dokun then
    for i = 0, Item.factory:get_size() do
        if type(Item.factory:get_object(i)) == "table" then
	        local item = Item.factory:get_object(i)
			local item_x, item_y = Sprite.get_position(item)
			local item_width, item_height = Sprite.get_size(item)
            if Mouse:is_over(item_x, item_y, item_width, item_height) then
			    --print("Mouse is over "..item:get_name())
				--Mouse:set_cursor(58)
            --else Mouse:set_cursor(68)			
			end
        end
    end		
end
]]
end
----------------
function Item:look_at_mouse() -- rotates to mouse position
		local mouse_x, mouse_y = Mouse:get_position(window)
		local self_x, self_y = Sprite.get_position(sword) 
		local a = self_x - mouse_x
		local b = self_y - mouse_y
        -- get mouse angle
		mouse_angle = math.atan2(-a, -b) * 180 / math.pi
  		-- object follow mouse
		self:rotate(mouse_angle + 180)
end
----------------
-- Load items here.
-- default items
dofile("item/gold.lua")
dofile("item/potion.lua")
dofile("item/health_potion.lua")
dofile("item/mana_potion.lua")
dofile("item/dual_potion.lua") 

dofile("item/sword.lua")
dofile("item/warrior_sword.lua")
--[[
[NOTE]: Equipments are non-stackable.
[NOTE]: Stackable items share the same quantity and non-stackable have their own unique quantity
]]--