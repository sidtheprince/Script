citizen_paper = Item:new("Citizen Papers")
citizen_paper:set_require(1)
citizen_paper:set_description("Proof of Citizenship in the Doll World") 
citizen_paper:set_tradeable(false)
function citizen_paper:on_load()
if dokun then
    Sprite.set_visible(self, false) --invisible by default
    --Sprite.set_size(self, 16, 16)
    --Sprite.set_position(self, math.random(0, 500), math.random(0, 500))
--[[    
    print("citizen_paper.new before lock", citizen_paper.new) -- citizen_paper.new  function: 0x2a1f000
    citizen_paper.new = nil -- make sure this item cannot be copied
    print("citizen_paper.new after locked", citizen_paper.new) -- Item.new	function: 0x2a0a600
    print("Item.new", Item.new) -- Item.new	 function: 0x2a0a600
]]--    
end    	
end
if not citizen_paper:load("item/citizen_paper.png") then
    print("Could not load "..citizen_paper:get_name())
end
