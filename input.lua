-- input.lua
function m()
end
------------
function k() 
    -- Object. (Arrow keys)
    if Keyboard:is_pressed(KEY_UP) then	
        player:move(0, 0.1)
    end
    --------------------------
    if Keyboard:is_pressed(KEY_DOWN) then
       -- position = position + vel * dt
	    player:move(0, -0.1) 
    end
    --------------------------
    if Keyboard:is_pressed(KEY_LEFT) then
        player:move(-0.1, 0)
    end
    --------------------------
    if Keyboard:is_pressed(KEY_RIGHT) then 
        player:move(0.1, 0)
    end
   -------------------------- 
     -- Camera.   (W,A,S,D [Z,X])
   if Keyboard:is_pressed(0x57) then -- W
        camera:move(0, 5, 0) 
   end
   -------------------------- 
   if Keyboard:is_pressed(0x41) then -- A
        camera:strafe(-5)
   end   
   -------------------------- 
   if Keyboard:is_pressed(0x53) then -- S
        camera:move(0, -5, 0)	 	
   end
   -------------------------- 
   if Keyboard:is_pressed(0x44) then -- D
        camera:strafe(5)
   end   
   --------------------------    
  -- Spacebar.
  if Keyboard:is_pressed(0x20) then  
  end
  if Keyboard:is_released(0x20) then
  end
  --------------------------
  -- Switch
    if Keyboard:is_pressed(0x31) then 
    end
	if Keyboard:is_pressed(0x32) then 
	end 
	if Keyboard:is_pressed(0x33) then 
	end
	if Keyboard:is_pressed(0x34) then
	end
end
------------
keyboard = k
mouse    = m
------------