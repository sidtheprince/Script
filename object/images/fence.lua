  fence = Object.new("Fence")
  
fence:load("object/fence.png")  
  
function fence:on_spawn()  
  for i = 1, 10 do
    fence[i] = fence:new()
	fence[i]:load("object/fence.png")
	fence[i]:scale(5, 5)
  end
   fence[1]:set_position(200*2, 180)
   fence[2]:set_position(200+200, 180)
   fence[3]:set_position(200+400, 180)
   fence[4]:set_position(200+600, 180)
   fence[5]:set_position(200+800, 180)
   fence[6]:set_position(200+1000, 180)   
   
   fence:set_position(200, 180)
end

function fence:on_animate()
end