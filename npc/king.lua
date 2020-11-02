-- king.lua
king = NPC:new("Calibus", "The Doll King")
------------------
function king:on_load()
if dokun then
    Sprite.set_size(self, 32, 32)
    Sprite.set_position(self, math.random(10, 500), math.random(10, 500))
end
end
if not king:load("npc/king.png") then
   print("Could not load king")
end
------------------
-- load quests
dofile("quest/quest4.lua")
-- set quests
king:set_quest(get_quest_by_name("A New Citizen")) -- quests are stored in order in self.quest_list
------------------
------------------
-- set chat options
king:set_options("Talk, Quest, Story, Leave") -- options are set and stored in order
------------------
function king:on_select(player)
    -- global quests (from other NPCs)
    if get_quest_by_name("The Doll King"):in_progress() then
		if is_npc( get_quest_by_name("The Doll King"):get_target() ) then --if quest_target is an npc
		    -- king is target
            if get_quest_by_name("The Doll King"):get_target() == self then
				    -- update status : Completed
					get_quest_by_name("The Doll King"):set_status(3)
					print("Quest complete!")
					-- start conversation
					self:talk("So you must be the newcomer that")
					self:talk("Don has told me so much about")
					self:talk("Oh my, I haven't introduced myself")
					self:talk("I am Calibus, king of the Doll World")
					self:talk("Anyways, you have yet to become a citizen")
					-- give local quest
					self:give_quest(player)
					return
		    end
        end				
	end
    -- local quests (from current NPC)
    for _, quest in pairs(self.quest) do
		-- quest in progress
		if quest:in_progress() then
			-- (NPC) as quest target
			if is_npc( quest:get_target() ) then
			    -- king is target
                if quest:get_target() == self then
                    if quest == get_quest_by_name("A New Citizen") then
					    -- update status : Completed
						quest:set_status(3)
						-- start conversation
						king:talk("For all your training and hard work")
						king:talk("I'd like to reward you with this...")
						-- set reward here
						king:set_reward(1, citizen_paper) -- set reward for self.quest[1]
						-- get reward
                        --self:give_reward(quest)
						for _, reward in pairs(quest.reward) do
						    if is_item(reward) then
						        reward:obtain()
							end
						end
						-- continue conversation
						king:talk("Congratulations, on becoming citizen")
						king:talk("I hope you have a safe journey.")
                        return
					end
                end				
			end
			-- (Monster) as quest target
			if is_monster(quest:get_target()) then    
				if quest:get_target().slain == quest:get_target().kill_limit then
				    -- update status(quest)
					quest:set_status(3)	
					print("Quest complete!")		
			    end
			end
			-- (Item) as quest target
			if is_item(quest:get_target()) then
				if quest:get_target().received == quest:get_target().obtain_limit then
				    -- update status(quest)
					quest:set_status(3)
					print("Quest complete!")
			    end			
			end
		end
	end

if not dokun then
 -- Options to choose from once
 -- NPC is selected or clicked on
 print("Choose an option: ")
 -- display options with :get_option()
 for o = 1, #self.option_list do
  print(o.." "..self:get_options(o))
 end
 
 choice = io.read("*number")
 if choice == 1 then self:on_talk(player) end
 if choice == 2 then self:on_quest(player) end
 if choice == 3 then self:on_story(player) end
 if choice == 4 then self:on_leave(player) end
end --if not dokun
if dokun then -- don goes staight to "NPC:talk" that is why the option_list only show up after talking to Don. NPC:talk updates the option_list
   self:opend(self.option_list) -- sets up options list
end -- if dokun
end
------------------
function king:on_talk()
    self:talk("Welcome to the land of the Dolls.\n I am King Calibus, ruler of the Doll World.")
end
------------------
function king:on_quest(player)
    -- unless you complete the Doll King quest
	-- you cannot take any quests from Calibus
    if not get_quest_by_name("The Doll King"):is_complete() then
	    self:talk("Might you be a rookie in training? If so then please return to Don")
		return
	end
    if not self:give_quest(player) then
	    self:talk("I have no quests for you right now.")
	end
end
------------------
function king:on_story()
 -- tell a long and boring story
    self:talk("Long ago..")
    self:talk("blah blah blah.")
    self:talk("The end.")
end
------------------
function king:on_leave()
    self:talk("Farewell, young adventurer.")
    return
end
