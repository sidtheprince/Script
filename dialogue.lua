require "dokun"


SUBTITLE = "CAPTIONING"
SPEECH_BUBBLE = "SPEECH_BUBBLE"
BANNER = "BANNER"

Dialogue = { ["type"]="SPEECH_BUBBLE" }


function Dialogue.new(dialogue_type, text, speaker) 
 local dialogue = {}

 dialogue.type = dialogue_type
 dialogue.text = text
 dialogue.speaker = speaker
 
 setmetatable(dialogue, {__index = Dialogue})
 return dialogue
end

function Dialogue.show(dialogue) end

text = TEXT:new()
text:set_string("Hello, Gregor. I have been waiting for you.")
text:set_size(12)
text:set_color("BLACK")
text:set_pos(800, 200) -- below the screen


caption = Dialogue.new("CAPTION", nil, jack)

-- can use a text table or a string
function Dialogue.set_text(dialogue, text_class) 
 if type(text_class) == "string" then
  print(text_class)
 elseif type(text_class) == "table" then
  print(text_class.text)
 end
end


caption:set_text(text)
caption:show()




function enable_caption(bool) end
