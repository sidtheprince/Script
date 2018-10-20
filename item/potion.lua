-- potion.lua
potion = Item.new("Potion", GENERAL, 0, "Recovers 50 Health", 50)
potion:set_price(10)

function potion:on_load()
if dokun then
    Sprite.set_size(self, 16, 16)
    Sprite.set_position(self, math.random(10, 500), math.random(10, 500))
end	
end
potion:load("item/potion.png")

function potion:on_use(user)
-- if user is dead
    if user:is_dead() then
        print("You are dead")
	    return
    end
 -- potion is not valid item
    if not is_item(self) then
        print("Not a valid item")
	    return
    end
 -- potion is not in the bag
    if not self:in_bag() then
        print(self:get_name().." not in bag")
	    return
    end
    -- health is full
    if user:get_health() == user:get_maximum_health() then
        print("Your health is full.")
		return 
    end
    -- health is not full
    if user:get_health() < user:get_maximum_health() then   
        -- apply the effect
        user:set_health(user:get_health() + self:get_effect())
        -- show message
        print("You used a "..self:get_name())
        print("+"..self:get_effect().."HP")
        -- delete item after use
        self:delete()
    end
    -- set health limit
    if user:get_health() > user:get_maximum_health() then
        user:set_health(user:get_maximum_health())
    end
end

function potion:on_collide()  
    self:set_obtained( self:obtain() )  
end 