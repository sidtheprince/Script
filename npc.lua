
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
------------------
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
    self:opend(text) -- draw text on dialogue_box
end
end
------------------ -- NEW
function NPC:opend(text) -- prepares the dialogue box (Shows either option_list or NPC speech text but never both at the same time!)
--[[
-- old code
if dokun then
	-- add image to dialogue_box (NPC portrait)(copies NPC's texture)
	if dialogue_box then if type(self.filename) == "string" then   dialogue_box:get_image():copy_texture(Sprite.get_texture(self)) end end-- can always access image via: dialogue_box:get_image() | don't load, instead copy texture
	-- add label to dialogue_box -- may give an error: "GUI has no parent"
	if dialogue_box then if type(text) == "string" then dialogue_box:get_label():set_string("   "..self:get_name()..": "..text) end end--set_string(self:get_name()..": "..text) end--(text) end
	-- show dialogue_box
	if dialogue_box then dialogue_box:show() end
	-- prevent player from moving while dialogue_box is open
end
]]--
-- new code
if dokun then
    if not dialogue_box then return end -- exit function if dialogue_box is nil
	-- add image to dialogue_box (NPC portrait - copies NPC's texture)
	if Sprite.get_texture(self):is_generated() then   dialogue_box:get_image():copy_texture(Sprite.get_texture(self)) end -- can always access image via: dialogue_box:get_image() | don't load, instead copy texture
	-- add label to dialogue_box -- shows text
	if type(text) == "string" then
        --dialogue_box.label:set_string("") -- clear any existing options strings (so it is not drawn while NPC is talking : labels are not drawn when strings are empty)
        dialogue_box.label1:set_string("")
        dialogue_box.label2:set_string("")
        dialogue_box.label3:set_string("")
        --dialogue_box.label:hide() -- hide options when NPC is talking (does not do anything unless you clear the string)
        dialogue_box.label1:hide()
        dialogue_box.label2:hide()
        dialogue_box.label3:hide()
        dialogue_box:get_label():set_string(self:get_name()..": "..text) -- set the text
        return	
        --[[
        dialogue_box.label1:set_string("") -- clear any existing options strings (so it is not drawn while NPC is talking : labels are not drawn when strings are empty)
        dialogue_box.label2:set_string("")
        dialogue_box.label3:set_string("")
        dialogue_box.label4:set_string("")
        dialogue_box.label1:hide() -- hide options when NPC is talking (does not do anything unless you clear the string)
        dialogue_box.label2:hide()
        dialogue_box.label3:hide()
        dialogue_box.label4:hide()
        dialogue_box:get_label():set_string(self:get_name()..": "..text) -- set the text
        return
        ]]--
    end
	-- show options_list
    if type(text) == "table" then
        dialogue_box:get_label():set_string(text[1])--(text[1].."\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"..text[2].."\n"..text[3].."\n"..text[4].."\n")--("") -- clear dialogue label_string (NOTE: WILL NOT BE DRAWN IF STRING IS EMPTY, ALSO THE POSITIONS WILL NOT BE SET)
        dialogue_box.label1:set_string(text[2]) -- assign options to label
        dialogue_box.label2:set_string(text[3])
        dialogue_box.label3:set_string(text[4])
        --dialogue_box.label4:set_string()
        dialogue_box.label1:show()         -- show options (does not do anything unless you set the string)
        dialogue_box.label2:show()
        dialogue_box.label3:show()
        --dialogue_box.label4:show()--dialogue_box:show()
        return    
        --[[
        dialogue_box:get_label():set_string("")--(text[1].."\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"..text[2].."\n"..text[3].."\n"..text[4].."\n")--("") -- clear dialogue label_string (NOTE: WILL NOT BE DRAWN IF STRING IS EMPTY, ALSO THE POSITIONS WILL NOT BE SET)
        dialogue_box.label1:set_string(text[1]) -- assign options to label
        dialogue_box.label2:set_string(text[2])
        dialogue_box.label3:set_string(text[3])
        dialogue_box.label4:set_string(text[4])
        dialogue_box.label1:show()         -- show options (does not do anything unless you set the string)
        dialogue_box.label2:show()
        dialogue_box.label3:show()
        dialogue_box.label4:show()--dialogue_box:show()
        return
        ]]--
    end
end
end
------------------
function NPC:detect(player, dist)
    if not dist then dist = 50 end
	    -- get position of monster and enemy
	    local player_x, player_y = Sprite.get_position(player)
        local self_x, self_y     = Sprite.get_position(self  )
		-- calculate the distance (how far they are from one another)
	    local distance = math.sqrt( ((self_x - player_x) * (self_x - player_x))  + ((self_y - player_y) * (self_y - player_y)))
		--print("Distance from "..self:get_name()..": "..distance) -- temporary
		-- distance from each other is less than
		-- 0 distance = right in each other's face; they are in the same position
		-- 1000 distance = too far from each other
		--print("Distance from NPC "..self:get_name()..": "..distance)
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
		local npc_x, npc_y = Sprite.get_position(self)

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
    if not amount then amount = 1 end
 -- if no quests have been set
 -- set the quest_list for self
    if not self.quest then self.quest = {} end
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
    if self:detect(player, 25) then -- if player is at least 25 units away from self
	    player.nearest_npc = self -- nearest npc is self
        --print("Nearest NPC is: "..self:get_name())
	    --print("You are close enough to speak to NPC")
		local self_x, self_y          = Sprite.get_position(self)
		local self_width, self_height = Sprite.get_size    (self) -- toggle the dialogue_box's visibility
		if not dialogue_box then return end -- exit function if dialogue_box is nil
		if not self.on_select then return end -- exit function if self.on_select() is nil
		-- dialogue_box and mouse interaction
        if not dialogue_box.label.original_color then dialogue_box.label.original_color = dialogue_box.label:get_color() end -- save original color once
        if dialogue_box:is_visible() then -- if dialogue_box is visible --print("original label color: ", dialogue_box.label.original_color)
            -- Talk option
            if Mouse:is_over(dialogue_box.label:get_rect()) then -- if mouse is over label
                --print("Mouse is over 'Talk' option")
                dialogue_box.label:set_color(201, 76, 76) --highlight the label with a new color --(32, 64, 64) 
                if Mouse:is_pressed(1) then self:on_talk(player) end -- if mouse is pressed while over the label, call the self:on_talk function
            else dialogue_box.label:set_color(255, 255, 255) --(dialogue_box.label.original_color)
            end
            -- Quest option
             if Mouse:is_over(dialogue_box.label1:get_x(), 551, dialogue_box.label1:get_width(), dialogue_box.label1:get_height()) then -- incorrect rect since it is updated in draw() call/must call after drawing--if Mouse:is_over(dialogue_box.label1:get_rect()) then -- if mouse is over label 
                --print("Mouse is over 'Quest' option")
                dialogue_box.label1:set_color(201, 188, 76) --highlight the label with a new color --(32, 64, 64) 
                if Mouse:is_pressed(1) then self:on_quest(player) end -- if mouse is pressed while over the label, call the self:on_talk function
            else dialogue_box.label1:set_color(255, 255, 255) --(dialogue_box.label.original_color)
            end           
            -- Story option
            if Mouse:is_over(dialogue_box.label2:get_x(), 570, dialogue_box.label2:get_width(), dialogue_box.label2:get_height()) then--if Mouse:is_over(dialogue_box.label2:get_rect()) then -- if mouse is over label 
                --print("Mouse is over 'Story' option")
                dialogue_box.label2:set_color(76, 201, 105) --highlight the label with a new color --(32, 64, 64) 
                if Mouse:is_pressed(1) then self:on_story(player) end -- if mouse is pressed while over the label, call the self:on_talk function
            else dialogue_box.label2:set_color(255, 255, 255) --(dialogue_box.label.original_color)
            end            
            -- Leave option
            if Mouse:is_over(dialogue_box.label3:get_x(), 589, dialogue_box.label3:get_width(), dialogue_box.label3:get_height()) then--if Mouse:is_over(dialogue_box.label3:get_rect()) then -- if mouse is over label 
                --print("Mouse is over 'Leave' option")
                dialogue_box.label3:set_color(76, 105, 201) --highlight the label with a new color --(32, 64, 64) 
                if Mouse:is_pressed(1) then self:on_leave(player) end -- if mouse is pressed while over the label, call the self:on_talk function
            else dialogue_box.label3:set_color(255, 255, 255) --(dialogue_box.label.original_color)
            end            
        end
		-- opening the dialogue_box (show)
		if Keyboard:is_pressed(0x0020) then--or Mouse:is_over(self_x, self_y, self_width, self_height) and Mouse:is_pressed(1) then-- NPC is pressed on with Mouse --Keyboard:is_pressed(0x0020) then--if Mouse:is_over(self_x, self_y, self_width, self_height) and Mouse:is_pressed(1) then--
            if not dialogue_box:is_visible() then -- if dialogue_box is hidden -- call self.on_select and show dialogue_box if hidden
                self:on_select(player)
                dialogue_box:show() 
                return
            end
		end
		-- closing the dialogue_box (hide)
        if Keyboard:is_pressed(0x0020) then -- or if spacebar is pressed --if not Mouse:is_over(dialogue_box:get_rect()) and Mouse:is_pressed(1) or -- if mouse is anywhere but on dialogue_box and is pressed
            if dialogue_box:is_visible() then -- clear string and image and, hide dialogue_box if shown
                dialogue_box:get_image():copy(empty_image)
                dialogue_box:get_label():set_string("")
                dialogue_box:hide() 
                return 
            end
        end
    else player.nearest_npc = nil
	end
end
------------------
function NPC:draw_all()
if dokun then
    local self_x, self_y
    local self_width, self_height
	local npc
    for i = 0, NPC.factory:get_size() do
	    npc = NPC.factory:get_object(i)
		if is_npc(npc) then
		    self_width, self_height = Sprite.get_size(npc)
		    self_x, self_y = Sprite.get_position(npc)
			----------------------------------------------
			npc:select_all()
			if dialogue_box then
				if not dialogue_box:is_visible() then -- if dialogue_box is not visible
			        npc:roam(200, 600) -- npc is free to roam about
			    end
		    end
		    npc:draw() -- draw npc
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
