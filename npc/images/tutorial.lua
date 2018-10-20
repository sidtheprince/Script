<<<<<<< HEAD
-- [[ create npc here ]]--

 npc = NPC.new("Jack")


--[[ set properties here ]] --
 npc:set_title("King of the Pirates")
 npc:set_role("Pirate")
 npc:set_surname("Sparrow")
 npc:set_position(0, 0, 0)


--[[ load quests here ]]--
 
 dofile("quest1.lua")


--[[ set quests here ]]--
 
 npc:set_quest(quest1)

--[[ set rewards here ]]--
 
 npc:set_reward(1, potion, 10) -- reward for the first quest set is a potion with a quantity of 10
 
 
--[[ set functions here ]]--

-- [NOTE]: functions with the on_ prefix must be
--    defined by the user.
 
-- mandatory: on_select, on_talk, on_quest, on_leave
-- optional: make your own "on_" function
 
 -- when you click an npc
 function npc:on_select(player)
  print("Choose an option:")
  for o = 1, #self.option_list do
   print(self:get_options(o))
  end
 -- choose an option
  local choice = io.read("*number")
  if choice == 1 then self:on_talk(player) end -- talk
  if choice == 2 then self:on_quest(player) end -- quest
  if choice == 3 then self:on_story(player) end -- story
  if choice == 4 then self:on_leave(player) end -- leave
 end
 
 -- when you click 'talk' 
 function npc:on_talk(player)
  self:talk("Hello, "..player:get_name())
 end
 
 -- when you click 'quest'
 function npc:on_quest(player)
  self:give(player, "quest")
 end

 -- when you click 'leave'
 function npc:on_leave()
  self:talk("We'll meet again.")
  self:close_dialogue()
=======
-- [[ create npc here ]]--

 npc = NPC.new("Jack")


--[[ set properties here ]] --
 npc:set_title("King of the Pirates")
 npc:set_role("Pirate")
 npc:set_surname("Sparrow")
 npc:set_position(0, 0, 0)


--[[ load quests here ]]--
 
 dofile("quest1.lua")


--[[ set quests here ]]--
 
 npc:set_quest(quest1)

--[[ set rewards here ]]--
 
 npc:set_reward(1, potion, 10) -- reward for the first quest set is a potion with a quantity of 10
 
 
--[[ set functions here ]]--

-- [NOTE]: functions with the on_ prefix must be
--    defined by the user.
 
-- mandatory: on_select, on_talk, on_quest, on_leave
-- optional: make your own "on_" function
 
 -- when you click an npc
 function npc:on_select(player)
  print("Choose an option:")
  for o = 1, #self.option_list do
   print(self:get_options(o))
  end
 -- choose an option
  local choice = io.read("*number")
  if choice == 1 then self:on_talk(player) end -- talk
  if choice == 2 then self:on_quest(player) end -- quest
  if choice == 3 then self:on_story(player) end -- story
  if choice == 4 then self:on_leave(player) end -- leave
 end
 
 -- when you click 'talk' 
 function npc:on_talk(player)
  self:talk("Hello, "..player:get_name())
 end
 
 -- when you click 'quest'
 function npc:on_quest(player)
  self:give(player, "quest")
 end

 -- when you click 'leave'
 function npc:on_leave()
  self:talk("We'll meet again.")
  self:close_dialogue()
>>>>>>> d581ca734c9f411bcb2a95fb93d5835f4db24fcc
 end