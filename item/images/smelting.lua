
require "item"
require "bag"

copper = Item.new("Copper Ore", MATERIAL)
copper:obtain()

function smelt(ore, amount_of_ore, ore_2, amount_of_ore2)
-- if there is only 1 ore in the parameter
 if ore ~= nil and ore_2 == nil then
 -- make sure it is not a SEMI-MATERIAL
  if ore.type == MATERIAL then
   convertTOSemiMat(ore)
  end
 end
 
end


function convertTOSemiMat(mat)
 if mat:in_bag() then

  if string.find(mat:get_name(), "Ore", 1) then -- material is an ore
   new_material_name = string.gsub(mat:get_name(), "Ore", "Bar") -- replaces <metal_name>Ore with <metal_name>Bar

   local bar = Item.new(new_material_name) -- creates a new bar
 
   bar:set_type(SEMI_MATERIAL)
   bar:set_description(mat:get_description())
   bar:set_require(mat:get_require())
   bar:set_effect(mat:get_effect())
   bar:set_price(mat:get_price())
 
   print("Successfully smelted "..mat:get_name().." to a "..new_material_name)
 
 
   mat:delete() -- delete the ore from the bag
   bar:obtain() -- obtain a new bar and add to bag
  end
 end
end
