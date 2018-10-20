

frame = 0
start = os.clock()

frame_rate = 0
if dokun then
   fps_font   = Font:new()
   Font.load(fps_font, "res/mitubachi.ttf")
   fps_string = Label:new()
   fps_string:set_font   (font)
end

function fps_counter()
--while 1 do
    frame = frame + 1
    if (os.clock() - start) > 1.0 then 
	    frame_rate = frame / (os.clock() - start)
		start = os.clock() -- reset start time and frames
		frame = 0 
	end
    if dokun then
       --fps_string:set_string("fps "..tostring(frame_rate))
       --fps_string:draw()
    else
	print("fps", frame_rate)
    end
--end
end
