-- don.lua
don = NPC.new("Don", "Newbie Trainee")
function don:on_load()
if dokun then
    Sprite.set_size(self, 19, 20)
    Sprite.set_position(self, math.random(10, 500), math.random(10, 500))
end
end
if not don:load("npc/don.png") then
    print("Could not load "..don:get_name())
end
------------------
-- load quests here
dofile("quest/quest1.lua")
dofile("quest/quest2.lua")
dofile("quest/quest3.lua")
-- set quests
don:set_quest(get_quest_by_name("Prove Your Strength"))
don:set_quest(get_quest_by_name("The Doll King"))
-- set rewards
don:set_reward(1, potion, 1)
don:set_reward(1, 10, "exp")
don:set_reward(1, 20, "gold")
-- set other
don:set_movement_speed(0.2)
------------------
-- set npc options
don:set_options("Talk, Quest, Story, Leave")
------------------
-- check player quest
function don:on_select(player)
    -- global quest (given by other NPC)
	local quest = get_quest_by_name("A New Beginning")
	if is_quest(quest) then
	-- quest log is not in log
	if not quest:in_log(player) then 
	    player:set_quest(quest) 
		quest:set_status(2) 
	end
	    if quest:in_progress() then
	        if quest:get_target() == self then
			    -- update status : Completed
			    quest:set_status(3)
				print("Quest complete!")
		        don:talk("Welcome to Doll Island. I'm Don and I'll be guiding you in becoming familiar with this world")
	            don:talk("Well then, lets get started with training")
				don:talk("To prove your strength, I'll need you to defeat 10 slimes in the field")
				don:talk("Come speak to me once you're done.")
                self:give_quest(player)	
                return				
		    end
	    end
	end
    -- local quests(given by NPC)
    for _, quest in pairs(self.quest) do
		-- quest in progress
		if quest:in_progress() then
			-- (king) as quest target
			if quest:get_target() == self then
				-- update status : Completed
				quest:set_status(3)
				-- show message
                print("Quest '"..quest:get_name().."' Completed!")	
                -- obtain reward	
                self:give_reward(quest, player)			
			end
			-- (Monster) as quest target
			if is_monster(quest:get_target()) then
			    -- confirm if all were slain
				if quest:get_target().slain == quest:get_target().kill_limit then
				    -- update status : Completed
				    quest:set_status(3)
				    -- show message
                    print("Quest complete!")	
                    -- obtain reward	
                    self:give_reward(quest, player)			
                    -- start conversation
				    if quest == get_quest_by_name("Prove Your Strength") then
				        -- say something (relevant to this quest)
					    self:talk("Good, you have defeated all "..quest:get_target().kill_limit.." "..quest:get_target():get_name().."s")
						self:talk("I have some good news. The king wants to meet you.")
						self:talk("You should go and speak to the king.")
						self:talk("You'll find him south of this Island")
						self:talk("Farewell, young lad")
                        -- give a new quest
					    self:give_quest(player)			
					    return
				    end		
                else
                    self:talk("You still have "..(quest:get_target().kill_limit - quest:get_target().slain).." "..quest:get_target():get_name().."s to defeat\nNow get to it")
					return					
			    end
			end
			-- (Item) as quest target
			if is_item(quest:get_target()) then
			end
		end
	end
	
    print("Choose an option:")
    -- display each option
    for o = 1, #self.option_list do
        print(o.." "..self:get_options(o))
    end
    -- get the player's choice
    local choice = io.read("*number")
    if choice == 1 then self:on_talk(player) end
    if choice == 2 then self:on_quest(player) end
    if choice == 3 then self:on_story(player) end
    if choice == 4 then self:on_leave(player) end	
end
------------------
function don:on_talk(player) 
    self:talk("Hello there, "..player:get_name())
end
------------------
function don:on_quest(player)
    if not self:give_quest(player) then
	    self:talk("I have no quests right now")
		if get_quest_by_name("The Doll King"):in_progress() then
		    self:talk("By the way, the king is waiting for you")
		end
	end
end
------------------
function don:on_story(player)
    self:talk("So, you want to hear a story, Huh?")
    self:talk("Alright then, I'll tell you about how the Doll World came to be.")
    self:talk("It all started when..")
    self:talk("blah, blah, blah")
    self:talk("The end.")
end
------------------
function don:on_leave(player)
    if not self:give_quest(player) then
        self:talk("I hope my training was enough for you to handle.")
	end
    self:talk("Take care now, "..player:get_name())
end