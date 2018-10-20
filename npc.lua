
NPC = 
{
    name  =         "";
	title = "Commoner";
}
------------------
NPC_mt = 
{
    __index = NPC,
	__gc    =
	function(self)
	    if dokun then
		    Sprite.free(self)
		end
		print(self:get_name().." deleted")
	end
}
------------------
if dokun then
    NPC.factory = Factory:new()
	npc_dialogue_box = Widget:new()
	npc_dialogue_box:set_size(500, 100)
	npc_dialogue_box:set_position(500, 400)
	npc_dialogue_box:set_color(160, 160, 160, 255)
	npc_dialogue_box:set_outline(true)
	--npc_dialogue_box:set_outline_color(32, 32, 32)
	npc_dialogue_box:set_gradient(true)
	--npc_dialogue_box
	npc_dialogue_box:set_visible(false)
	-- empty portrait image
	npc_dialogue_box:set_image(Image:new())
	-- set label
	npc_dialogue_box:set_label(Label:new())
end
------------------
function NPC:new(name, title)
    local npc 
    if dokun then
        npc = Sprite:new()
    else
        npc = {}
    end
	---------------
	if self == NPC then
        npc.name = name
        npc.title = title
	else
	    npc.name = self
		npc.title = name
	end
	---------------
    if not NPC.id then NPC.id = 0 end
    NPC.id = NPC.id + 1
    npc.id = NPC.id
    ---------------
    -- make :new function
    npc.mt = {__index = npc}
    npc.new = function()
        local new_npc = {}
        setmetatable(new_npc, npc.mt)
        return new_npc 
    end
	---------------
	if dokun then
	    NPC.factory:store(npc)
	end
	---------------
    setmetatable(npc, NPC_mt)
    return npc
end
------------------
function NPC:load(filename)
if dokun then
    local texture = Texture:new()
	if not texture:load(filename) then
	    print("Could not open "..filename) 
	    return false
	end
	Sprite.set_texture(self, texture)
end
    if self.on_load then self:on_load() end
	self.filename = filename -- save filename
    return true
end
function NPC:draw()
    if self.on_draw then self:on_draw() end
if dokun then
   Sprite.draw(self)
end
end
------------------
function NPC:talk(text)
    print(self:get_name()..": "..text)
if dokun then
    if self.filename then
	    --npc_dialogue_box:get_image():copy(Image:new(self.filename))
	    --npc_dialogue_box:get_image(self:get_image())
        npc_dialogue_box:set_image(Image:new(self.filename))--(Image:new(texture:get_file())
        --portrait:destroy()
	end
	npc_dialogue_box:get_label():set_string(self:get_name()..": "..text)
	--npc_dialogue_box:get_label():set_size(100, 20)
	--print(npc_dialogue_box:get_label():get_size())	
	npc_dialogue_box:show()
	-- prevent player from moving while dialogue_box is open
	--local player_x, player_y = Sprite.get_position(player)
	--Sprite.set_position(player, player_x, player_y)
end	
end
------------------
function NPC:detect(player, dist)
    if not dist then dist = 25 end
	    -- get position of monster and enemy
	    local player_x, player_y = Sprite.get_position(player)
        local self_x, self_y     = Sprite.get_position(self  )
		-- calculate the distance (how far they are from one another)
	    local distance = math.sqrt( ((self_x - player_x) * (self_x - player_x))  + ((self_y - player_y) * (self_y - player_y)))
		--print("Distance from "..self:get_name()..": "..distance) -- temporary
		-- distance from each other is less than
		-- 0 distance = right in each other's face; they are in the same position
		-- 1000 distance = too far from each other
		--print(distance)
		if (distance <= dist) then
		    return true
		end
	return false
end
------------------
function NPC:find(player) -- returns an available quest, otherwise returns nil
    for index, quest in pairs(self.quest) do
	    if getmetatable(quest) == Quest_mt then
		    if not quest:in_progress() then -- not in progress
			    if not quest:is_complete() or  -- not completed
				quest:is_repeatable() then  -- or is repeatable 
				if player:get_level() >= quest:get_require() then -- player meets quest requirements
				    quest:set_status(1) -- available
					return quest
				end
				end
			end
		end
	end
	return nil
end
------------------
function NPC:give_quest(player) -- gives quest to player
    local quest = self:find(player)
    if is_quest(quest) then
		-- obtain the quest
		player:set_quest(quest)
		print("Quest '"..quest:get_name().."' obtained")
		-- update status : In Progress
		quest:set_status(2)
		print("status: "..quest:get_status())
		return true
	end
	return false
end
------------------
function NPC:give_reward(quest, player)
    -- item
    for _, reward in pairs(quest.reward) do
		if is_item(reward) then
			reward:new():obtain(reward.amount)
		end
	end
	-- exp
	local exp_from_quest = quest:get_exp_reward()
	if type(exp_from_quest) == "number" then
	    if exp_from_quest > 0 then
            player:set_exp(player:get_exp() + exp_from_quest)
		    print("Obtained "..exp_from_quest.." EXP")
			player:level_up()
		end
	end
	-- gold
	local gold_from_quest = quest:get_gold_reward()
	if type(gold_from_quest) == "number" then
	    if gold_from_quest > 0 then
		    Bag.gold = Bag.gold + gold_from_quest
            print("Obtained "..gold_from_quest.." "..gold:get_name())
		end
    end
end
------------------
function NPC:roam(start, end_) 
if dokun then
        local s = start
		local e = end_
		local speed = self:get_movement_speed()
		-- move king back and forth
		npc_x, npc_y = Sprite.get_position(self)
		
		if npc_x >= e then -- 600 = end
		    right = false
			left = true
		end
		if npc_x <= s then -- 200 = start
		    right = true
			left = false
		end
		if right then
		    Sprite.set_position(self, npc_x + speed, npc_y)
		elseif left then
		    Sprite.set_position(self, npc_x - speed, npc_y)		
		end
	end
end
------------------
function NPC:open()end -- dialogue
------------------
function NPC:close()end -- dialogue
------------------
function NPC:show_quest() 
    if not self.quest then
        self.quest = {}
        print("No quests.")
    end
    for q = 1, #self.quest do
        if is_quest(self.quest[q]) then
            print(self.quest[q]:get_name(), self.quest[q]:get_status())
        end
    end
end
------------------
------------------
-- SETTERS
------------------
function NPC:set_name(name) 
    self.name = name 
end
------------------
function NPC:set_last_name(last_name) 
    self.last_name = last_name 
end
------------------
function NPC:set_title(title) 
    self.title = title 
end
------------------
function NPC:set_role(role) 
    self.role = role 
end 
------------------
function NPC:set_level(level) 
    self.level = level 
end
------------------
function NPC:set_health(health) 
    self.health = health 
end
------------------
function NPC:set_quest(quest)  -- GOOD!
    if not self.quest then 
	    self.quest = {} 
	end 
	if is_quest(quest) then 
	    quest:set_giver(self)  
		self.quest[#self.quest + 1] = quest 
	end 
end
------------------
function NPC:set_reward(index, reward, amount, _type) -- ??
    if not amount then
	    amount = 1
	end
 -- if no quests have been set
 -- set the quest_list for self
    if not self.quest then 
	    self.quest = {} 
	end
 -- get quest at [index] of self.quest_list
    local quest = self.quest[index]
    -- quest does not exist
    if not is_quest(quest) then 
        print("Invalid quest.")
	    return
    end
	if type(reward) == "number" then
	    _type = amount
	    quest:set_reward(reward, nil, _type);
	    return
	end
    -- set reward
	quest:set_reward(reward, amount, _type)
end
------------------
-- tested!
function NPC:set_options(options)
-- if no option_list, make an options list
 if not self.option_list then self.option_list = {}end
 -- list of strings separated by
 -- commas, spaces, dashes, etc.
 if type(options) == "string" then
  for word in string.gmatch(options, "%a+") do
   -- store options inside the 
   -- next slot in the table
   table.insert(self.option_list,word) 
  end
 end  
 if type(options) == "table" then
   -- set npc.option_list to the table
   self.option_list = options
 end
end -- npc:set_options({"Eat a banana", "Kill a sheep", "Fight a monkey"})
------------------
function NPC:set_movement_speed(move_speed)
    self.move_speed = move_speed
end
------------------
-- GETTERS
------------------
function NPC:get_id() 
    return self.id 
end
------------------
function NPC:get_name() return self.name end
------------------
function NPC:get_last_name() return self.last_name end
------------------
function NPC:get_title() return self.title end
------------------
function NPC:get_role() return self.role end
------------------
function get_npc_by_name(name) for _, npc in pairs(_G) do if is_npc(npc) then if npc.name == name then return npc end end end end
------------------
function get_npc_by_id(id) for _, npc in pairs(_G) do if is_npc(npc) then if npc.id == id then return npc end end end end
------------------
function NPC:get_npc_by_name(name) if self ~= NPC then return "function must be called by NPC." end return get_npc_by_name(name) end
------------------
function NPC:get_npc_by_id(id) if self ~= NPC then return "function must be called by NPC" end return get_npc_by_id(id) end
------------------
function NPC:get_quest(index) if type(index) == "number" then return self.quest_list[index] end return nil end
------------------
function NPC:get_num_quests() return #self.quest_list end -- number of quests an npc has
------------------
function NPC:get_options(index) return self.option_list[index] end 
------------------
NPC.get_option = NPC.get_options 
------------------
function NPC:get_quest(index)
    if not self.quest then return nil end
    return self.quest[index]
end
------------------
function NPC:get_reward(index)
    if not self.reward then return nil end
    return self.reward[index]
end
------------------
function NPC:get_movement_speed()
    if not self.move_speed then self.move_speed = 0.1 end
    return self.move_speed
end
------------------
-- BOOLEAN
------------------
function NPC:is_parent()
    if getmetatable(self) == NPC_mt then
	    return true
	end
	return false
end
------------------
function NPC:is_npc() 
     -- Is it a table?
    if type(self) ~= "table" then
	    return false
	end  
    if getmetatable(self) == NPC_mt then 
	    return true 
    end	
	if not dokun then
	    local g = _G
	    for _, npc in pairs(g) do
		    if getmetatable(npc) == NPC_mt then
			    if getmetatable(self) == npc.mt then
				    return true
				end
			end
		end
	end
	if dokun then
	    for i = 1, NPC.factory:get_size() do
		    if getmetatable(self) == NPC.factory:get_object(i).mt then
			    return true
			end
		end
	end
    return false 
end
------------------
is_npc = NPC.is_npc
------------------
-- EVENT
------------------
function NPC:select_all()
    if self:detect(player, 25) then
	    player.nearest_npc = self
	    --print("You are close enough to speak to NPC")
		local self_x, self_y          = Sprite.get_position(self)
		local self_width, self_height = Sprite.get_size    (self)
		if Mouse:is_over(self_x, self_y, self_width, self_height) and Mouse:is_pressed(1) then--if Keyboard:is_pressed(0x0020) then
		    if self.on_talk then self:on_talk(player) end
			--if self.on_select then self:on_select() end	
		end
	elseif  player.nearest_npc == self then
	    npc_dialogue_box:hide()	
	end
end
function NPC:draw_all()
if dokun then
    local self_x, self_y
    local self_width, self_height
	local npc
    for i = 0, NPC.factory:get_size() do
	    npc = NPC.factory:get_object(i)
		if npc then
		    self_width, self_height = Sprite.get_size(npc)
		    self_x, self_y = Sprite.get_position(npc)
		    npc:select_all()
			if not npc_dialogue_box:is_visible() then -- if dialogue_box is not visible 
			    npc:roam(200, 600) -- npc is free to roam about
			end
		    npc:draw()
		end
	end
end
end
------------------
function NPC:check_distance_from_player()
	local player_x, player_y = Sprite.get_position(player)
	local npc_x, npc_y       = Sprite.get_position(self)
	print(Math.distance(player_x, player_y,npc_x, npc_y ))
end
------------------
function npc_event_handler()
    local g = _G
	for _, npc in pairs(g) do
	    if is_npc(npc) then
		    npc:draw()
		end
	end
end
------------------
-- Load npc here.
dofile("npc/king.lua")
dofile("npc/don.lua")
------------------
 -- NOTE: ONLY NPCs can confirm a quest is completed