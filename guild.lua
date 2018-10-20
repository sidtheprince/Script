Guild = { 
 name, 
 members = {},
 rank = 1, 
 MAX_MEMBERS = 20, 
 territory = tostring(0) ,
 
 id = 0,
 __data = {}
}

GUILD_PRICE = 500000 
member_rank = {
 "Master", "Apprentice", "Sentinel", "Trainee"
 
}


function Guild.new(name, founder)
 -- PLAYER MUST NOT BE IN A GUILD
 if not founder.IN_GUILD then 
  if founder.level >= 25 and founder.rank >= 5 and
   Bag.gold >= GUILD_PRICE then
   
   if name == nil then
    print("Enter the name of your guild here:")
    name = io.read()
   end
  
   -- GET THE GUILD NAME
   while string.len(name) < 2 do
    print("'guild 'name' is too short.")
    name = io.read()
   end  
  
   while string.len(name) > 20 do
    print("'guild name' must be at least 20 in length.")
    name = io.read()
   end
  
  --[[
  local NAME_TAKEN = nil
  
  for n=1, #Guild.__data do
   if Guild.__data[n].name == name then
	NAME_TAKEN = true
   else
    NAME_TAKEN = false
   end
  end
  
  while not NAME_TAKEN do
   print("Name  already taken.")
   name = io.read()
  end
  
  NAME_TAKEN = false
  ]]--
  -----
  
  if name ~= nil then
   
    -- PAY MONEY TO MAKE GUILD
   Bag.gold = Bag.gold - GUILD_PRICE
   print("You have spent "..GUILD_PRICE.." "..gold.name)
   
   
   -- CONSTRUCT THE GUILD
   local guild = {}
 
   -- PLAYER BECOMES THE FOUNDER
   
   guild.name = name
   guild.founder = founder.name
  
   guild.rank = 1
   guild.territory = tostring(0)
   guild.members = {}
   
   guild.position = member_rank
   
    -- RANK 1: MASTER
   founder.position = guild.position[1]
   founder.IN_GUILD = true 
   -- PLAYER IS IN GUILD
   
   
   --FOUNDER CANNOT BE CHANGED, BUT THE LEADER CAN
   
   guild.leader = founder
   founder.guild = guild
   
   
   Guild.id = Guild.id + 1
   guild.id = Guild.id
 
   Guild.__data[#Guild.__data+1] = guild -- guild is added to the guild data storage
   print("You have succeeded in created a guild!")
 
   setmetatable(guild, {__index = Guild})
   return guild
  end
  
  
  elseif founder.level < 25 and founder.rank < 5 then
   print("You do not meet the requirements to establish a guild.")
  elseif Bag.gold < GUILD_PRICE then
   print("Not enough gold in your bag.")
 end
 
 else
   print("You are already in a guild.")
 end
end

 -- MAKE A NEW GUILD

--[[
 sid.level = 25
 sid.rank = 5
 Bag.gold = 500000
 guild = Guild.new("Blue Warrior", sid)
 
 
 jack =Player.new("Jack")
 jack.level = 25
 jack.rank = 5
 Bag.gold = 500000
 guild2 = Guild.new("Blue Warrior", jack)
 
]]--
 
 
 --------------
--[[ USAGE:
player.level = 25; player.rank = 5; Bag.gold = 500000;
guild = Guild.new("The Guild of Gods", player)
]]--
--------------------

-- GUILD WINDOW
function Guild.open(guild)
 guild_window = { 
  board, 
  info = { 
   guild.name, banner, founder, members_number, rank, territory
   
  }, 
  member_list, 
  contribution,
 }
 
end



--[[
function Guild.invite() end -- all members and guild master
function Guild.upgrade() end -- guild masters only
function Guild.degrade() end -- guild masters and apprentices
function Guild.kick() end -- guild masters and apprentices only
function Guild.handOverAuthority() end -- guild master only
function Guild.disband() end -- guild master only
function Guild.leave() end -- player only
]]--


function Guild.invite(guild, member, player) 
 -- members and guild leaders
 --THE GUILD MEMBER INVITES A PLAYER NOT IN A GUILD
 if not player.IN_GUILD then
  if member.IN_GUILD then
   if member.position == guild.position[1] or member.position == guild.position[2] then
     print("The Player can join the guild.")
	 -- ADD PLAYER TO MEMBER LIST
     guild.members[#guild.members + 1] = player -- ADD PLAYER TO MEMBER LIST
     player.IN_GUILD = true -- IS IN THE GUILD
	 
	 player.guild = guild -- PLAYER'S GUILD
	 player.position = guild.position[4] -- RANK: TRAINEE
   else 
    print("You are not qualified to do that!")
   end
  
  else
   print("You are not in a guild!")
  end
  
 else
   print("The Player is already in a guild.")
 end
end





function Guild.upgrade(guild, member)
  -- guild masters only
  
  -- MEMBER IS IN THE GUILD, LEADER IS IN THE GUILD
 if member.IN_GUILD and guild.leader.IN_GUILD then
  if guild.leader.position == guild.position[1] then
   print("Upgrade a member's position.")
   
   -- MEMBER IS A TRAINEE, UPGRADE TO SENTINEL
   if member.position == guild.position[4] then
    member.position = guild.position[3]
   end
   -- MEMBER IS A SENTINEL, UPGRADE TO APPRENTICE
   if member.position == guild.position[3] then
    member.position = guild.position[2]
   end
   
   --NOONE CAN BE UPGRADED TO THE GUILD MASTER
   -- THIS ACT IS FORBIDDEN!!
   
 end
end
end


function Guild.degrade(guild, highranker, member)
  -- guild masters and apprentices only
  -- IN THE SAME GUILD
if guild.leader.guild == member.guild then

  -- MEMBER IS IN THE GUILD, LEADER IS IN THE GUILD
 if member.IN_GUILD and guild.leader.IN_GUILD then
  if guild.leader.position == guild.position[1] or highranker.position == guild.position[2] then
   print("Degrade a member's position.")
   
   -- MEMBER IS AN APPRENTICE, DEGRADE TO SENTINEL
   if member.position == guild.position[2] then
    member.position = guild.position[3]
	print(member.name.." has been degraded to "..guild.position[3])
   end
   -- MEMBER IS A SENTINEL, DEGRADE TO TRAINEE
   if member.position == guild.position[3] then
    member.position = guild.position[4]
	print(member.name.." has been degraded to "..guild.position[4])
   end
   
   --NOONE CAN BE UPGRADED TO THE GUILD MASTER
   -- THIS ACT IS FORBIDDEN!!
   else
    print("You are not qualified to degrade a member.")
 end
  elseif not member.IN_GUILD then
   print("The member is not in the guild.")
  elseif not guild.leader.IN_GUILD then
   print("You are not in the guild.")
end
 else
  print("You are not in the same guild as [member]")
 end
end



function Guild.kick(guild, highranker, member)

 -- THEY ARE BOTH IN THE SAME GUILD
 if highranker.guild == member.guild then
  if highranker.position == guild.position[1] or highranker.position == guild.position[2] then
  
 for m = 1, Guild.MAX_MEMBERS do
  if guild.members[m] == member then
   guild.members[m] = nil -- REMOVE MEMBER
   print("You have been kicked out of the guild.")
   member.IN_GUILD = false
   member.guild = nil
   member.position = nil
  end
  break
 end
 
  else
   print("Your are not qualified to kick out a member.")
 end
  else
   print("You are not in the same guild as the [member].")
 end
end



function Guild.handOverAuthority(guild, leader, member)
 if leader.IN_GUILD and member.IN_GUILD then

-- IN THE SAME GUILD
if guild.leader.guild == member.guild then

 if leader == guild.leader then
  if member.IN_GUILD then
   -- MEMBER BECOMES THE MASTER
   guild.leader = member
   member.posititon = guild.position[1]
   print(member.name.." is now "..guild.posititon[1])
   -- DEGRADE THE PREVIOUS GUILD LEADER
   guild.leader.position = guild.position[2]
   else 
    print("This member does not exist in the guild.")
  end
  else
   print("You are not the leader of the guild.")
 end
 
  else
   print("Leader is not in the same guild as the member.")
 end
  elseif not leader.IN_GUILD then
   print("You are not in any guild nor a guild leader.")
  elseif not member.IN_GUILD then
   print("You are not in any guild nor a guild member.")
 end
end


-- GOOD!
function Guild.leave(guild, member)
 --MEMBER IS IN THE GUILD
 if member.IN_GUILD then
 -- THE GUILD IS THE SAME AS THE MEMBER'S GUILD
  if member.guild == guild then
  -- THE MEMBER IS NOT THE GUILD LEADER
   if member.position ~= guild.position[1] then
     member.IN_GUILD = false
	 member.guild = nil
	 member.position = nil
    else
	 print("Guild leaders cannot abandon their guild.")
   end
   else
    print("This is not your guild.")
  end
  else
   print("You are not in a guild.")
 end
end




function Guild.disband(guild, leader)
 -- GUILD LEADER CAN DISBAND THE GUILD
 
 -- MUST BE IN A LEAGUE
 if leader.IN_GUILD then
  if leader.guild == guild then
   if leader.position == guild.position[1] then
    -- DESTROY THE GUILD
    guild = nil
	else
	 print("Only a guild leader can disband the league.")
   end
   else
 end
    print("This is not your guild.")
 else
  print("You are not in a league.")
  end
end





-- Guild.__data = {} -- holds the names of all the guilds that have been created

-- GUILD ADVANTAGES--------------------------------
-- GUILD WAREHOUSE, BANNER, WDR

Guild_Storage = {}

GUILD_DATA = {}
function Guild.assist(guild)

end

function guildDataList()
 for i = 1, 100 do
  if guild_data[i] ~= nil then
   print(guild_data[i].name)
  end
 end
end




function Guild.getID(guild)
 if type(guild) == "table" then
  for g=1, Guild.id do
   if Guild.__data[g] == guild then
    return Guild.__data[g].id 
   end
  end
 end
 
 if type(guild) == "string" then
  for g=1, Guild.id do
   if Guild.__data[g].name == guild then
    return Guild.__data[g].id
   end
  end
 end

end



function Guild.getNameById(id)
 for g=1, Guild.id do
  if Guild.__data[g].id == id then
   return Guild.__data[g].name
  end
 end
end