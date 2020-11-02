
Bag = 
{
    gold      =  0;
    slots     = {};
    max_slots = 10;
}
---------------
Bag_mt = 
{
    __index = Bag;
	__gc    =
    function(self)
		print("Bag"..self:get_id().." deleted")
    end	
}
---------------
function Bag:new()
    local bag = {}
    bag.slots = {}
    --[[
        Every new bag has its own slots, but
        all bags share the same amount of gold.
    ]]--
	if not Bag.id then Bag.id = 0 end
	Bag.id = Bag.id + 1
	bag.id = Bag.id	
    setmetatable(bag, Bag_mt)
    return bag
end
---------------
---------------
function Bag:open() 
    -- item
    print("BAG:")
    for slot, item in pairs(self.slots) do
        if self.slots[slot]:is_stackable() then
            print("slot "..slot, item:get_name().."["..item:get_quantity().."]") 
        else
            print("slot "..slot, item:get_name().."["..tostring(1).."]")
        end
    end
	-- gold
    print(gold:get_name()..": "..self.gold)
if dokun then
   --GUI.show(self.ui)
end	
end
---------------
function Bag:close()
if dokun then
    --GUI.hide(self.ui)
end
end
---------------
function Bag:insert( item, amount ) -- new!
    if not amount then amount = 1 end
	-- gold (or any currency)
	if string.find(item:get_type(), nocase("currency")) then
	    self.gold = self.gold + amount
		return true
	end
	-- bag is full 
	if self:is_full() then
	    -- item was not previously in bag  
	    if not item:in_bag() or
		-- or item is not stackable
		not item:is_stackable() then
		    print("Bag is full")
			return false
		end
	end
	if is_item(item) then
		-- stackable -- stackable items such as potion, sword, etc.
		if item:is_stackable() then
			-- original item
			if not item:is_copy() then
				-- was previously in bag
				if item:in_bag() then
					-- increase quantity (by certain amount)
					item:set_quantity(item:get_quantity() + amount)--no need to add item image to slot if it was in bag previously and only the quantity needs to be increased
					-- dokun graphical stuff ...
					if dokun then if bag_slots then bag_slots[item:get_slot(self)]:get_label():set_string(tostring(item:get_quantity())) bag_slots[item:get_slot(self)]:get_label():show() end end--set quantity as bag_slots[item:get_slot(self)].label's string
					return true
				end
				-- not previously in bag
				if not item:in_bag() then
					-- store item (in the first available slot)
			        self.slots[self:get_first_available_slot()] = item--self.slots[ #self.slots + 1 ] = item--this will store item in the last index of Bag.slots
				    -- increase quantity (by certain amount)
					item:set_quantity(item:get_quantity() + amount)--add the item image to slot as it has not been in the bag previously
					-- dokun graphical stuff ...
					if dokun and bag_slots then
						bag_slots[item:get_slot(self)]:get_label():set_string(tostring(item:get_quantity())) bag_slots[item:get_slot(self)]:get_label():show()--set quantity as bag_slots[item:get_slot(self)].label's string
						if Sprite.get_texture(item):is_texture() then    
						   bag_slots[item:get_slot(self)]:get_image():copy_texture(Sprite.get_texture(item))
						end--if the item's texture_data is not nullptr, bag_slot will copy its texture
					end					
					return true					
				end
			end
			-- a copy item
			if item:is_copy() then
			    -- get parent
				local parent = item:get_parent()
				-- was previously in bag
				if parent:in_bag() then
					-- increase parent quantity
					parent:set_quantity(parent:get_quantity() + amount)--no need to add item image to slot if it was in bag previously and only the quantity needs to be increased
					-- dokun graphical stuff ...
					if dokun then if bag_slots then bag_slots[parent:get_slot(self)]:get_label():set_string(tostring(parent:get_quantity())) bag_slots[parent:get_slot(self)]:get_label():show() end end--set quantity as bag_slots[parent:get_slot(self)].label's string
					return true					
				end						
			    -- was not previously in the bag
			    if not parent:in_bag() then
				    -- store parent only
				    self.slots[self:get_first_available_slot()] = parent--self.slots[ #self.slots + 1 ] = parent
					-- increase parent quantity (by certain amount)
					parent:set_quantity( parent:get_quantity() + amount )--add the item image to slot as it has not been in the bag previously
					-- dokun graphical stuff ...
					if dokun and bag_slots then
						bag_slots[parent:get_slot(self)]:get_label():set_string(tostring(parent:get_quantity())) bag_slots[parent:get_slot(self)]:get_label():show()--set quantity as bag_slots[parent:get_slot(self)].label's string
						if Sprite.get_texture(parent):is_texture() then    
						    bag_slots[parent:get_slot(self)]:get_image():copy_texture(Sprite.get_texture(parent))
						end--if the item's texture_data is not nullptr, bag_slot will copy its texture
					end
					return true					
			    end
			end
		end
		-- equipable (non-stackable)
		if not item:is_stackable() then
			if player:is_equipped(item) then
			    print(item:get_name().." is equipped")
			    return false
			end	
			-- not previously in bag
			if not item:in_bag() then
			    -- store item
			    self.slots[self:get_first_available_slot()] = item--self.slots[self:get_first_available_slot()] = item--self.slots[ #self.slots + 1 ] = item
				-- increase quantity (only by 1)
				item:set_quantity(item:get_quantity() + 1)
				-- dokun graphical stuff ...
				if dokun and bag_slots then
					bag_slots[item:get_slot(self)]:get_label():set_string(tostring(item:get_quantity())) bag_slots[item:get_slot(self)]:get_label():show()--set quantity as bag_slots[item:get_slot(self)].label's string
					if Sprite.get_texture(item):is_texture() then    
					   bag_slots[item:get_slot(self)]:get_image():copy_texture(Sprite.get_texture(item)) -- bag_slots image will copy the item's texture
					end--if the item's texture_data is not nullptr, bag_slot will copy its texture
				end
                return true				
			-- already in bag (non-stackable)
			-- use a copy (non-stackables must be unique)
			else 
                print(item:get_name().." is already in bag")
				return false
			end						  						
		end
    end
	return false
end
---------------
function Bag:empty() -- new! --empties out bag, leaving no trace of item
    for slot, item in pairs(self.slots) do
	    -- zero out quantities
        if is_item(item) then
		    item:set_quantity(0)
		end
		-- empty bag
		self.slots[slot] = nil
		-- dokun graphical stuff ...
if dokun then--uncomment if using this line
	    --if bag_slots and empty_texture then bag_slots[slot]:get_image():copy_texture(empty_texture) end
end			
	end
end
---------------
function Bag:set_maximum_slots(max_slots)
    self.max_slots = max_slots
end
---------------
function Bag:get_size() -- number of items in bag
    return #self.slots
end
---------------
function Bag:get_maximum_slots() -- maximum slots
    return self.max_slots
end
---------------
function Bag:get_first_available_slot() -- new!!
	if self:get_size() == 0 then return 1 end -- if bag is empty, return 1 (1 = first available slot, since lua table indexes start at 1)
	-- if bag is not empty, get the first available slot you see
	for i=1, self:get_maximum_slots() do
		if self.slots[i] == nil then -- first empty slot (you approach)
            return i -- exit function, once you get the first empty slot
		end
	end	
	return 0
end	
---------------
function Bag:get_taken() -- takened slots
    return self:get_size()
end
---------------
function Bag:get_empty() --returns number of empty slots in bag
    return self:get_maximum_slots() - self:get_size()
end
---------------
 -- returns item in the specified slot
function Bag:get_item_in_slot(slot)
    if self.slots[slot] == nil then
        print("Empty Slot")
		return nil
    end
    if self.slots[slot] ~= nil then
        return self.slots[slot]--.name
    end
end
---------------
function Bag:get_item_slot_by_name(item_name)
    local slot_number
    for b=1, #self.slots do
        if self.slots[b]:get_name() == item_name then
            slot_number = b
            print(item_name.." found in slot "..b)
            break
        end
    end
    return slot_number
end
---------------
Bag.get_slot_by_name = Bag.get_item_slot_by_name
---------------
function Bag:get_id()
    return self.id
end
---------------
-- TESTED! WORKS 99%
function Bag:is_full() 
    for i = 1, self:get_maximum_slots() do
        if self.slots[i] == nil then
            return false
        end
    end
    return true
end
---------------
function Bag:is_bag()
    if self == Bag then return true end -- default bag
    if getmetatable(self) == Bag_mt then return true end -- object bag
	return false
end
