mana_potion = Item.new("Mana Potion", GENERAL, 0, "Restores 150  Mana.", 150)
mana_potion:set_price(100)

function mana_potion:on_load()
if dokun then
    Sprite.set_size(self, 16, 16)
    Sprite.set_position(self, math.random(0, 500), math.random(0, 500))
end
end
mana_potion:load("item/mana_potion.png")

function mana_potion:on_use(user)
 if not user:is_dead() then
 if is_item(self) then
 if self:in_bag() then
 -- if mana is full
 if user:get_mana() == user:get_maximum_mana() then
  print("Your mana is already full");
  return;
 end
 -- mana is not full
 if user:get_mana() < user:get_maximum_mana() then
  -- apply the effect
  user:set_mana(user:get_mana()+self:get_effect())
  -- show message
  print("You used a "..self:get_name());
  print("+ "..self:get_effect().." Mana");
  -- delete the item from bag
  self:delete()
 end
 -- limit mana
 if user:get_mana() > user:get_maximum_mana() then
  user:set_mana(user:get_maximum_mana())
 end
 end
 end
 end
 end