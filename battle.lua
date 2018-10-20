
function engage()
    if not slime:is_dead() and not player:is_dead() then
    repeat
	    player:fight(slime)
		slime:fight(player)
	until
	    player:is_dead() or slime:is_dead()
		
    if player:is_dead() and not slime:is_dead() then
 	    print("Defeat!")
		print("You are slain by "..slime:get_name()..".")
	elseif slime:is_dead() and not player:is_dead() then
	    print("Victory!")
		print(slime:get_name().." has been slain.")
	    slime:on_kill(player)
	end
	
	end
end