
health_potion = Item.new("Health Potion", GENERAL, 0, "Restores 300 Health.", 300) -- +300HP, 100 gold
health_potion:set_price(100)


function health_potion:on_load()
if dokun then
    Sprite.set_size(self, 16, 16)
    Sprite.set_position(self, math.random(0, 500), math.random(0, 500))
end	
end
health_potion:load("item/health_potion.png")

function health_potion:on_use(user)
    -- if user is dead
    if user:is_dead() then return end
    -- potion is not valid item
    if not is_item(self) then return end
    -- potion is not in the bag
    if not self:in_bag() then print(self:get_name().." is not in bag") return end
    -- health is full
    if user:get_health() == user:get_maximum_health() then
        print("Your health is full")
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
