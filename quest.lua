
Quest = 
{
    name =           "";
	giver =         nil;
	require =         1;
	hint =       "None";
	target =        nil;
    status =          0;
    repeatable  = false;
}
------------------
Quest_mt = {
    __index = Quest,
	__gc    = 
	function(self)
	    print("Quest"..self:get_id().." deleted")
	end
}
------------------
function Quest:new(name, giver, require, hint, target, number)
    local quest 
if dokun then
	quest = Sprite:new()
else
	quest = {}
end
	if self == Quest then -- Quest:new
        quest.name    = name
        quest.giver   = giver
        quest.require = require
        quest.hint    = hint
	else
	    quest.name    = self -- Quest.new
        quest.giver   = name
        quest.require = giver
        quest.hint    = require
		quest.target  = hint
	end
 
    if Item then
        if is_item(target) then
            quest.target = target
            quest.target.received = 0
            quest.target.obtain_limit = num
        end
    end
    if Monster then
        if is_monster(target) then
            quest.target = target
            quest.target.slain = 0
            quest.target.kill_limit = num 
		end
    end
    if NPC then
        if is_npc(target) then
            quest.target = target
            quest.target.interacted = false
        end
    end
 
    if not Quest.id then Quest.id = 0 end
	Quest.id = Quest.id + 1
    quest.id = Quest.id
	
    setmetatable(quest, Quest_mt)
    return quest
end 
------------------
function Quest:find(seeker) -- updates and finds available global quests
    local g = _G
    for _, quest in pairs(g) do
	    -- a valid quest
	    if is_quest(quest) then
		    -- player does not have quest yet
		    if not quest:in_progress() then
                -- quest is not completed yet
                if not quest:is_complete() or
                -- or quest can be repeated
                quest:is_repeatable() then
                    -- quest matches player's level
                    if seeker:get_level() >= quest:get_require() then
				        -- set status : Available
					    quest:set_status(1) 
					    -- return quest
                        return quest
			        end
		        end
			end
        end
	end
	return nil
end
------------------
function Quest:obtain(player)
    if self:in_log(player) then
	    if self:in_progress() then
		    print("Quest in progress")
			return false
		end
		if self:is_complete() and 
		not self:is_repeatable() then
		    print("Quest is complete")
			return false
		end
	end
	if player:get_level() < self:get_require() then
	    print("Your level is too low")
        return false
	end
	self:set_status(2)
	player:set_quest(self)
	print("Obtained Quest '"..self:get_name().."'")	
	return true
end
------------------
function Quest:delete(player)
    for index, quest in pairs(player.quest) do
	    if self == player:get_quest(index) then
		    --if self:in_progress() then
		    -- change status
		    self:set_status(1)
			--end
            -- remove from log			
			player.quest[index] = nil
			print("Quest \""..quest:get_name().."\" deleted")
		end
	end
end
------------------
-- resets quest target data
-- on completion
function Quest:reset()
end
------------------
function Quest:update()
end
------------------
function Quest.show()
    for _, quest in pairs(_G) do
        if is_quest(quest) then
            print(quest:get_name(), quest:get_status())
        end
	end
end
------------------
-- SETTERS
------------------
function Quest:set_name(name) 
    self.name = name 
end
------------------
function Quest:set_giver(giver) 
    self.giver = giver 
end
------------------
function Quest:set_require(require) 
    self.require = require 
end
------------------
function Quest:set_hint(hint) 
    self.hint = hint 
end
------------------
Quest.set_objective = Quest.set_hint
------------------
function Quest:set_target(target, count) -- num is either number of items to receive or number of monsters to slay
    if type(count) ~= "number" then 
	    count = 1
	end
    if not target then
	    return
	end
	-- Item (to be obtained)
    if is_item(target) then
	    self.target = target
        self.target.received = 0
        self.target.obtain_limit = count
    end
	-- Monster (to be slain)
    if is_monster(target) then  
        self.target = target
        self.target.slain = 0
        self.target.kill_limit = count
    end
	-- NPC (to notify)
    if is_npc(target) then
        self.target = target
        self.target.interacted = false
    end
end
------------------
function Quest:set_status(status) -- 0 = not avail, 1 = avail, 2 = in progress, 3 = completed
    self.status = status 
end
------------------
function Quest:set_repeatable(repeatable) 
	self.repeatable = repeatable 
end
------------------
function Quest:set_reward(reward, amount, type_)
    if not amount then amount = 1 end
    if not self.reward then self.reward = {} end --quest.reward
	if is_item(reward) then
	    self.reward[#self.reward + 1] = reward:new()
		self.reward[#self.reward].amount = amount
	end
	if type(reward) == "number" then
	    if string.find(type_, nocase("exp")) then
		    self.exp_reward = reward
        end	
	    if string.find(type_, nocase("gold")) then
		    self.gold_reward = reward
        end				
	end
end
------------------
-- getters
------------------
function Quest:get_id() 
    return self.id 
end
------------------
function Quest:get_name() 
    return self.name 
end
------------------
function Quest:get_giver() 
    return self.giver 
end
------------------
function Quest:get_hint() 
    return self.hint 
end
------------------
Quest.get_objective = Quest.get_hint
------------------
function Quest:get_require() 
    return self.require 
end
------------------
Quest.get_requirement = Quest.get_require
------------------
function Quest:get_target() 
    return self.target 
end
------------------
function Quest:get_status() 
    local status_name
    if self.status == 0 then
	    status_name = "Not Available"
	end
    if self.status == 1 then
	    status_name = "Available"
	end
    if self.status == 2 then
	    status_name = "In Progress"
	end
    if self.status == 3 then
	    status_name = "Completed"
	end	
    return self.status, status_name 
end
------------------
function Quest:get_reward(index) 
    return self.reward[index] 
end
------------------
function Quest:get_exp_reward() 
    return self.exp_reward 
end
------------------
function Quest:get_gold_reward() 
    return self.gold_reward 
end
------------------
function get_quest_by_name(name)  
    local g = _G
    for _, quest in pairs(g) do 
	    if is_quest(quest) then
	        if quest:get_name() == name then 
		        return quest 
		    end  
		end
	end 
end
------------------
function get_quest_by_id(id)
    local g = _G
    for _, quest in pairs(g) do 
	    if is_quest(quest) then
	        if quest:get_id() == id then 
		        return quest 
		    end  
		end
	end 
end
------------------
-- BOOLEAN
------------------
function Quest:is_quest()
    if getmetatable(self) == Quest_mt then 
	    return true 
	end
	return false 
end
------------------
is_quest = Quest.is_quest
------------------
function Quest:is_repeatable() 
    return self.repeatable 
end
------------------
function Quest:is_available() 
	if self:get_status() == 0 then 
	    return false 
	end 
	if self:get_status() == 1 then 
	    return true 
	end 
	return false 
end
------------------
function Quest:in_progress() 
	if self:get_status() == 2 then 
	    return true 
	end 
	return false 
end
------------------
function Quest:is_complete() 
	if self:get_status() == 3 then 
	    return true 
	end 
	return false 
end
------------------
function Quest:in_log(player) 
    if not player.quest then player.quest = {} end
    for i = 0, #player.quest do
	    if player:get_quest(i) == self then
		    return true
		end
	end
	return false
end
------------------