dual_potion = Item.new("Dual Potion", GENERAL, 0, "Restores 50% HP and 50% MP.") -- health = health + full_health / dual_potion.effect(which is 2); 500 gold
if player then
 dual_potion:set_effect(player:get_maximum_health()/2)
end
dual_potion:set_price(500)

function dual_potion:on_load()
if dokun then
    Sprite.set_size(self, 32, 32)
    Sprite.set_position(self, math.random(0, 500), math.random(0, 500))
end
end
dual_potion:load("item/dual_potion.png")

function dual_potion:on_use(user)


end