dual_potion = Item.new("Dual Potion", GENERAL, 0, "Restores 50% HP and 50% MP.") -- health = health + full_health / dual_potion.effect(which is 2); 500 gold
--if player then
 --dual_potion:set_effect(player:get_maximum_health()/2)
--end
dual_potion:set_price(500)

function dual_potion:on_load()
if dokun then
    Sprite.set_size(self, 32, 32)
    Sprite.set_position(self, math.random(0, 500), math.random(0, 500))
end
end
dual_potion:load("item/dual_potion.png")

function dual_potion:on_use(user)
    -- if user is dead
    if user:is_dead() then return end
    -- potion is not valid item
    if not is_item(self) then return end
    -- potion is not in the bag
    if not self:in_bag() then print(self:get_name().." is not in bag") return end    
    -- health or mana is not full
    if user:get_health() < user:get_maximum_health() or
    user:get_mana() < user:get_maximum_mana() then   
        -- set the effect (health)
        dual_potion:set_effect(user:get_maximum_health()/2)
        -- apply the effect
        user:set_health(user:get_health() + self:get_effect())
        ------------------------------------------------------
        -- set the effect (mana)
        dual_potion:set_effect(user:get_maximum_mana()/2)
        -- apply the effect
        user:set_mana(user:get_mana() + self:get_effect())
        ------------------------------------------------------
        -- show message
        print("You used a "..self:get_name())
        print("+"..self:get_effect().."HP")
        print("+"..self:get_effect().."MP")
        -- delete item after use
        self:delete()
    end  
    -- set health limit
    if user:get_health() > user:get_maximum_health() then
        user:set_health(user:get_maximum_health())
    end
    -- set mana limit
    if user:get_mana() > user:get_maximum_mana() then
        user:set_mana(user:get_maximum_mana())
    end    
end