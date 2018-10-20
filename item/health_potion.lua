
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

end
