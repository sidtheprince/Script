
Storage = 
{ 
    gold       =  0, 
    slots      = {},
	max_slots  = 10,
	pin        = nil,
}
------------------
Storage_mt = 
{
    __index = Storage,
	__gc    = 
	function(self)
	    print("storage"..self:get_id().." deleted")
	end
}
------------------
function Storage:new()
    local storage = {}

	if not Storage.id then Storage.id = 0 end
	Storage.id = Storage.id + 1
	storage.id = Storage.id
	
    setmetatable(storage, Storage_mt)
    return storage
end 
------------------
function Storage:open()
    -- item
    print("Storage:")
    for slot, item in pairs(self.slots) do
        if self.slots[slot].type ~= EQUIPMENT then
            print("slot "..slot, item:get_name().."["..item:get_storage_quantity().."]") 
        else
            print("slot "..slot, item:get_name().."["..tostring(1).."]")
        end
    end
	-- gold
    print(gold:get_name()..": "..self.gold)
end
------------------
function Storage:close() end
------------------
function Storage:withdraw(item, amount)
    -- quantity in storage
    if not item.storage_quantity then 
	    item.storage_quantity = 0 
	end
    -- Is there an amount?
	if not amount then amount = 1 end
	-- Is the item valid?
	if not is_item(item) then
	    print("Not a vaid item")
		return
	end
	-- Is the item gold?
    if string.find(item:get_type(), MONEY) then
	    if self.gold < amount then
		    print("Not enough gold in storage")
			return
        end
		if self.gold >= amount then
		    self.gold = self.gold - amount
			print("Withdrew "..amount.." "..gold:get_name())
			Bag.gold = Bag.gold + amount
			return
		end
    end	
    -- Is the item in storage?
	if not item:in_storage() then
	    print(item:get_name().." not in Storage")
		return
	end
	-- Do you have enough of the item?
    if item.storage_quantity < amount then
	    print("Insuffient "..item:get_name())
		return
	end
    if item.storage_quantity >= amount then
	end
    -- Is the item stackable?
	-- equipment (non-stackable)
	if not item:is_stackable() then
		-- reduce quantity (only by 1)
		item.storage_quantity = item.storage_quantity - 1
	    -- delete equipment if none left in Storage
		if item.storage_quantity <= 0 then
		    item.storage_quantity = 0
		    self.slots[ item:get_slot(self) ] = nil
		end
		-- store in bag
		item:obtain(1)
	end
	-- stackable
	if item:is_stackable() then
		-- copy
	    if item:is_copy() then 
		    -- get parent
			local parent = item:get_parent()
		    -- reduce quantity
	        parent:set_storage_quantity(parent:get_storage_quantity() - amount)
			-- delete froms storage
			if parent:get_storage_quantity() <= 0 then
			    parent:set_storage_quantity(0)
				self.slots[ parent:get_slot(self) ] = nil
			end
			-- store in bag
			parent:obtain(amount)		
		end		
	    -- original item
	    if not item:is_copy() then 
		    -- reduce quantity
	        item:set_storage_quantity(item:get_storage_quantity() - amount)
			-- delete froms storage
			if item:get_storage_quantity() <= 0 then
			    item:set_storage_quantity(0)
				self.slots[ item:get_slot(self) ] = nil
			end
			-- store in bag
			item:obtain(amount)
		end
	end
end
------------------
function Storage:deposit(item, amount)
    -- quantity in storage
    if not item.storage_quantity then 
	    item.storage_quantity = 0 
	end
    -- Is there an amount?
	if not amount then amount = 1 end
	-- Is the item valid?
	if not is_item(item) then
	    print("Not a vaid item")
		return
	end
	-- Is the item gold?
    if string.find(item:get_type(), MONEY) then
	    if Bag.gold < amount then
		    print("Not enough gold in bag")
			return
        end
		if Bag.gold >= amount then
		    Bag.gold  = Bag.gold  - amount
		    self.gold = self.gold + amount
			print("Deposited "..amount.." "..gold:get_name())
			return
		end
    end	
	-- Is Storage full?
	if self:is_full() then
	    -- item not previously in bag  
	    if not item:in_storage() and 
		-- and not is stackable
		not item:is_stackable() then
		    print("Storage is full")
			return
		end
	end
    -- Is the item in Bag?
	if not item:in_bag() then
	    print(item:get_name().." not in bag")
		return
	end    
    if item:get_quantity() < amount then
	    print("Insuffient "..item:get_name())
		return
	end	
	-- Is the item stackable?
	if not item:is_stackable() then
	    -- store non-stackable (Next slot)
	    self.slots[#self.slots + 1] = item
		item.storage_quantity = item.storage_quantity + 1
		-- delete item from bag
	    item:delete(1)
	end
	if item:is_stackable() then
	    -- copy
		if item:is_copy() then 
		    -- get parent
		    local parent = item:get_parent()
            -- was previously in storage
			if parent:in_storage() then
			    -- increase quantity
			    parent.storage_quantity = parent.storage_quantity + amount
				-- message
				print("Deposited "..item:get_name().." +"..amount)
			end
		    -- not previously in storage
			if not parent:in_storage() then
		        -- store item
			    self.slots[#self.slots + 1] = parent
				-- increase quantity
			    parent:set_storage_quantity( parent:get_storage_quantity() + amount )
				-- message
				print("Deposited "..item:get_name().." +"..amount)
			end
			-- delete from bag
			parent:delete(amount)			
		end
	    -- original
		if not item:is_copy() then
		    -- was previously in storage
			if item:in_storage() then
			    -- increase quantity
			    item.storage_quantity = item.storage_quantity + amount
				-- message
				print("Deposited "..item:get_name().." +"..amount)
			end
		    -- not previously in storage
			if not item:in_storage() then
		        -- store item
			    self.slots[#self.slots + 1] = item
				-- increase quantity
			    item.storage_quantity = item.storage_quantity + amount
				-- message
				print("Deposited "..item:get_name().." +"..amount)
			end
			-- delete from bag
			item:delete(amount)
		end
	end
end
------------------
Storage.store = Storage.deposit
------------------
function Storage:set_pin(pin)
    if not self:has_pin() then
	    if string.len(tostring(pin)) >= 4 then
		    self.pin = pin
		    print("Pin has been set")
			return true
		else
		    print("Pin is too short")
		end
	end
	return false
end 
------------------
function Storage:change_pin(pin)
    local price = 500
    if self:has_pin() then -- a pin already exists
	    if self:get_pin() == pin then -- old pin and new pin match
	        print("Old pin and New pin match")
	        return 
	    end
		if Bag.gold >= price then -- enough gold in bag
		    local old_pin = self:get_pin() -- save old pin
		    self:delete_pin() -- delete old pin
			-- if new pin was set successfully
			if self:set_pin(pin) then
			-- spend money for the new pin
				Bag.gold = Bag.gold - price
			    print("Spent "..price.." "..gold:get_name())
			end
		else
		    print("Not enough gold in bag")
		end
	end
end
------------------
function Storage:buy_slot(slots)
    local price_per_slot = 1200
	local total = price_per_slot * slots
	
	-- You can have up to 100 slots (no more than that)
	if self:get_maximum_slot() <= 100 then
	    if Bag.gold >= total then -- enough gold in bag
		    -- spend money
			Bag.gold = Bag.gold - total
			print("Spent "..total.." "..gold:get_name())
			-- add more slots
		    self.max_slots = self.max_slots + slots
			print("Added "..slots.." slots to storage")
		else
		    print("Not enough gold")
		end
	else
	    print("Maximum slots reached = 100")
	end
end
------------------
function Storage:delete_pin()
    self.pin = nil
    print("Pin has been deleted.")
end
------------------
function Storage:get_id()
    return self.id
end
------------------
function Storage:get_pin()
    return self.pin
end
------------------
function Storage:get_size()
    return #self.slots
end
------------------
function Storage:get_maximum_slot()
    return self.max_slots
end
------------------
function Storage:has_pin()
    if not self.pin then
        return false
    end	
    return true
end
------------------
function Storage:is_storage()
    if getmetatable(self) == Storage_mt or 
	self == Storage then
	    return true
	end
	return false
end
------------------
is_storage = Storage.is_storage
------------------
function Storage:is_full()
    for i = 1, self.max_slots do
        if self.slots[i] == nil then
            return false
        end
    end
    return true
end 