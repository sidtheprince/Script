
Shop = 
{
    name = "General Shop";
    catalogue = {}, 
	max_slots = 10
}
---------------
Shop_mt =
{
    __index = Shop,
	__gc    = 
	function(self)
	    print("Shop"..self:get_id().." deleted")
	end
}
---------------
function Shop.new(type, owner, area)
    local store     = {}
    store.type      = type
    store.owner     = owner
    store.location  = area
    store.catalogue = {}
	
    if store.type == GENERAL_SHOP then
        store.catalogue[1] = potion
        store.catalogue[2] = health_potion
        store.catalogue[3] = mana_potion
        store.catalogue[4] = dual_potion
  
        store.catalogue[5] = port_stone
        store.catalogue[6] = newbie_handbook
    elseif store.type ==  "??" then
    elseif store.type == "??" then
    elseif store.type == "??" then
    elseif store.type == "??" then
    elseif store.type == "??" then
    elseif store.type == "??" then
    elseif store.type == "??" then
    elseif store.type == PET_SHOP then
        store.catalogue[1] = egg
    elseif store.type == MAGIC_SHOP then
        store.catalogue[1] = orb
    end
	
	if not Shop.id then Shop.id = 0 end
	Shop.id = Shop.id + 1
	store.id = Shop.id
 
    setmetatable(store, Shop_mt)
    return store
end
---------------
function Shop:open()end
---------------
function Shop:close()end
---------------
function Shop:add(item, price) 
    if type(price) == "number" then 
	    item:set_price(price) 
	end 
	self.catalogue[ #self.catalogue + 1 ] = item   
end -- adds item to shop
---------------
function Shop:find(item) 
    if is_item(item) then
	    return item:in_shop(self)
    end		
	return false
end
---------------
function Shop:buy(item, amount)
	local total = nil
	-- How many of this item?
	if not amount or 
	type(amount) ~= "number" then 
	    amount = 1
		-- default total price
		total = item:get_price() 
	end
	if amount > 0 then
	    -- calculate total price
	    total = item:get_price() * amount
	end
	-- Is item gold?
    if string.find(item:get_type(), MONEY) then
        print("Cannot buy gold")	
	    return
	end	
	-- Is Item in shop?
    if not self:find(item) then
	    print("Shop does not sell this item")
		return
	end
	-- Is Bag full?
	if Bag:is_full() then
	    -- item not previously in bag  
	    if not item:in_bag() or
		-- or not is stackable
		not item:is_stackable() then
		    print("Bag is full")
			return
		end
	end	
    -- Can Bag hold the amount
	-- Of a non-stackable (equipment)?
	if not item:is_stackable() then
		if amount > Bag:get_empty() then
		    print("Not enough bag space")
			return
		end
	end
    -- Do you have enough gold for purchase?
	if Bag.gold < total then
	    print("Not enough gold")
		return
	end
    if Bag.gold >= total then
	    if item:is_stackable() then
            -- spend gold (specific amount) 
			Bag.gold = Bag.gold - total
            print(total.." "..gold:get_name().." spent")
            -- add item to bag
            item:obtain(amount)
		end
		if not item:is_stackable() then
		    Bag.gold = Bag.gold - total
			print(total.." "..gold:get_name().." spent")
		    for num = 1, amount do
			    item:new():obtain()
			end
		end
        -- ????
		LOG:add("[Purchased]: "..item:get_name().." [Quantity]: "..amount.." [Spent]: "..total)
        LOG:update()
    end
end
---------------
function Shop:sell(item, amount)
    local total = nil
    -- Is amount specified?
    if not amount or 
	type(amount) ~= "number" then
	    amount = 1
	end
    -- Is Item in bag?
	if not item:in_bag() then
	    print(item:get_name().." not in bag")
		return
	end
	-- Enough to sell?
	if item:get_quantity() < amount then
		-- use up all of the item
		amount = item:get_quantity()
	end
	if item:get_quantity() >= amount then
	    -- amount will always be 1 for non-stackables
		if not item:is_stackable() then
		    amount = 1
		end
	    -- obtain gold
		print(item:get_name().." Sold -"..amount)
	    gold:obtain( item:get_price() * amount )
	    -- delete item
		item:delete(amount)
	end
 end
---------------
-- SETTERS
---------------
function Shop:set_name(name)
    shop.name = name
end
--------------- 
function Shop:set_type(type_)
    self.type = type_
	if self.type == GENERAL_SHOP or self.type == GENERAL then
        self.catalogue[1] = potion
        self.catalogue[2] = health_potion
        self.catalogue[3] = mana_potion
        self.catalogue[4] = dual_potion
  
        self.catalogue[5] = port_stone
        self.catalogue[6] = newbie_handbook	     
	end
end
--------------- 
function Shop.set_owner(owner)
    self.owner = owner
end
--------------- 
function Shop.set_area(area)
    self.area = area
end
---------------
-- GETTERS 
---------------
function Shop:get_id()
    return self.id
end
---------------
function Shop:get_name()
    return self.name
end
---------------
function Shop:get_type()
    return self.type
end
---------------
function Shop:get_owner()
    return self.owner
end
---------------
function Shop:get_area()
    return self.area
end
---------------
function Shop:get_item(index)
    return self.catalogue[index]
end
---------------
-- BOOLEAN
---------------
function Shop:is_shop() 
    -- Is it a table?
    if type(self) ~= "table" then
	    return false
	end
    if getmetatable(self) == Shop_mt then 
	    return true 
	end
	local g = _G
	for _, shop in pairs(g) do
	    if getmetatable(shop) == Shop_mt then
		    if getmetatable(self) == shop.mt then
			    return true
			end
		end
	end
	return false
end
---------------
is_shop = Shop.is_shop
---------------
dofile("world/general_shop.lua")
---------------