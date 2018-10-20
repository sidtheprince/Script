-- sword.lua
sword = Item.new("Sword", EQUIPMENT, 1, "A plain, but powerful sword.", 10)

sword:set_price(25)
sword:set_subtype("Smasher")
sword:set_durability(20)

function sword:on_load()
if dokun then
    Sprite.set_size(self, 16, 16)
    Sprite.set_position(self, math.random(0, 500), math.random(0, 500))
end    	
end
if not sword:load("item/sword.png") then
    print("Could not load "..sword:get_name())
end

function sword:on_use(user)
    user:equip(self)
end

function sword:on_collide()
    self:set_obtained(self:obtain())
end
