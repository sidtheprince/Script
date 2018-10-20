chest = Object.new("Chest")

--chest:load("object/images/chest.png")   
chest.max = 50

-- texture
chest_tex = {}  
if dokun then
    chest_tex[1] = Texture:new("object/images/chest.png")
    chest_tex[2] = Texture:new("object/images/chest_open.png")
end   
 
function chest:store(item)
    self.item = item	
end

function chest:is_empty()
	if not chest.item then
		return true
	end
	return false
end

chest.opened = false
function chest:on_animate(player)   
    if dokun then  
	    -- player collides with chest
	    if Sprite.collide(self, player) and not chest.opened then
		    -- update chest texture
		    self:set_texture(chest_tex[2]) 
			-- chest is empty
			if self:is_empty() then
			    print("Nothing in here")                
				chest.opened = true        
			else
			    -- obtain item inside chest
				chest.item:set_obtained( chest.item:obtain() ) 
				-- delete item inside chest (forever)
				chest.item = nil                                  
				chest.opened = true
			end
	    end    
	end 
end
-- create an item
--local potion = potion:new()
--potion:load("item/potion.png")
-- store item in chest
chest:store( potion:new() )