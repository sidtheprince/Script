
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
if dokun then
    --bag.ui = Grid:new()
	--bag.ui:set_row(2)
	--bag.ui:set_column(5)
end	
	if not Bag.id then Bag.id = 0 end
	Bag.id = Bag.id + 1
	bag.id = Bag.id	
    setmetatable(bag, Bag_mt)
    return bag
end
---------------
if dokun then --[[
    if not Bag.icon then 
	    Bag.icon = Button:new() 
	end
	if not Bag.ui then
	    Bag.ui = Grid:new()
		Bag.ui:set_row(2)
	    Bag.ui:set_column(5)
	end ]]--
end
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
	if string.find(item:get_type(), MONEY) then
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
		-- stackable
		if item:is_stackable() then
			-- original item
			if not item:is_copy() then
				-- was previously in bag
				if item:in_bag() then
					-- increase quantity (by certain amount)
					item:set_quantity(item:get_quantity() + amount)
					return true
				end
				-- not previously in bag
				if not item:in_bag() then
					-- store item
			        self.slots[ #self.slots + 1 ] = item
				    -- increase quantity (by certain amount)
					item:set_quantity(item:get_quantity() + amount)
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
					parent:set_quantity(parent:get_quantity() + amount)
                    return true					
				end						
			    -- was not previously in the bag
			    if not parent:in_bag() then
				    -- store parent only
				    self.slots[ #self.slots + 1 ] = parent
					-- increase parent quantity (by certain amount)
					parent:set_quantity( parent:get_quantity() + amount )
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
			    self.slots[ #self.slots + 1 ] = item
				-- increase quantity (only by 1)
				item:set_quantity(item:get_quantity() + 1)
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
function Bag:empty() -- new!
    for slot, item in pairs(self.slots) do
	    -- zero out quantities
        if is_item(item) then
		    item:set_quantity(0)
		end
		-- empty bag
		self.slots[slot] = nil
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
function Bag:get_taken() -- takened slots
    return self:get_size()
end
---------------
function Bag:get_empty()
    return self:get_maximum_slots() - self:get_size()
end
---------------
 -- returns item name in the specified slot
function Bag:get_item_in_slot(slot)
    if self.slots[slot] == nil then
        print("Empty Slot")
		return nil
    end
    if self.slots[slot] ~= nil then
        return self.slots[slot].name
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