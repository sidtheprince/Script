frame = 0
start = os.clock()

frame_rate = 0
if dokun then
fps_string = Label:new()
end

function fps_counter() -- call in loop
--while 1 do
    frame = frame + 1
    if (os.clock() - start) > 1.0 then 
	    frame_rate = frame / (os.clock() - start)
		start = os.clock() -- reset start time and frames
		frame = 0 
	end
if dokun then
    fps_string:set_string("fps: "..tostring(frame_rate))
    fps_string:set_position(10, window:get_client_height() - 50)
    fps_string:draw()
end
if not dokun then
    print("fps: ", frame_rate)
end
end
