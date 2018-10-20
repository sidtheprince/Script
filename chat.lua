
Chat = {}
-----------------
Chat_mt =
{
    __index = Chat,
	__gc    =
	function(self)
	end
}
-----------------
function Chat.new(mode, channel)
    local chat = {}
	if(dokun) then
	    if Edit then
		    chat = Edit:new()
		end
	end
    chat.mode = mode
 
    setmetatable(chat, Chat_mt)
    return chat 
end
-----------------
GENERAL = "General"
WHISPER = "Whisper"


TRADE = "Trade"
PARTY = "Party"
GUILD = "Guild"
FRIEND = "Friend"
MARRIAGE = "Marriage"

BUDDY = FRIEND
-----------------
function displayText(text) 
 print(text)
end
-----------------
go = true
function textEntered() 
 while go do
 if KEYBOARD:is_pressed(KEY_UP) then
   displayText(text_edit.text)
 end
 end
end
-----------------
function Chat.set_mode(mode) end
-----------------
function Chat.activate()
--[[
    while Chat.click()  do
        Chat.cursor("|")
        break
        text = io.read()
    end
    print("Press enter when done")
    if key == "enter" or "return" then
        Chat.displayTextBubble(text)
 
    elseif text == nil then
        print("Nothing to be displayed here.")
    end
]]--
end
-----------------
function Chat.click()
    key = io.read()
    if key == "click" then 
        return true;
    end
    return false;
end
----------------- 
function Chat.cusror(line)
    line = "|"
    return line
end
----------------- 
function Chat.readText(text)
end
----------------- 
function Chat.displayTextBubble(text)
    print(player.name.." > "..text.."")
end 
----------------- 
function Chat.whisper(cmd, text, receiver)
  --if cmd = "w/"..(receiver.name) then
   --print(cmd..text)
end
----------------- 
function Chat.filter(word)
   if type(word) == "string" then
        self.filter[#self.filter+1] = word
   end
end
-----------------
--chat_box = Chat:new()