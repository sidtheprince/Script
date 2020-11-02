warrior_sword = Item:new("Warrior Sword", EQUIPMENT, 2, "A legendary sword lost in time", 50)
warrior_sword:set_subtype( "Smasher" )

function warrior_sword:on_load()
if dokun then
    Sprite.set_size(self, 32, 32)
    Sprite.set_position(self, math.random(10, 500), math.random(10, 500))
end	
end
warrior_sword:load("item/warrior_sword.png")

function warrior_sword:on_use(user)
    if is_player(user) then user:equip(self) end
end
