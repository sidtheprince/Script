gold = Item.new("Dollop", MONEY, 0, "For purchasing items.", 0) -- item representing gold, not actually gold in numbers

function gold:on_load()
if dokun then
    Sprite.set_size(gold, 16, 16)
	Sprite.set_position(self, math.random(10, 500), math.random(10, 500))
end 
end
gold:load("item/gold.png")

function gold:on_use()
end