function print_dead()
	print("You are dead")
	coroutine.yield()--runs first part of function on resume, then the second after resuming it again
	print("That is too bad")
end	

co = coroutine.create(print_dead) --add function to coroutine
coroutine.status(co) -- suspended
coroutine.resume(co) -- starts 'print_dead' function : prints "You are dead" (first part of function)
coroutine.status(co) -- suspended
coroutine.resume(co) -- this will print "That is too bad"                    (second part of function)
coroutine.status(co) -- dead   (job has ended)

--[[
There is a trick to continuously calling a coroutine function, over and over again (since you cannot resume a "dead" coroutine):

	if coroutine.status(bag_toggle_co) == "dead" then bag_toggle_co = coroutine.create(bag_toggle) end
	if coroutine.status(bag_toggle_co) =="suspended" then coroutine.resume(bag_toggle_co) end--bag_toggle()

]]--
