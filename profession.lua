
Profession = 
{
 

}

function Profession.new(craft, toolt)
 local field = {}

 field.type = craft 
 field.tool_list = toolt
 
 
 setmetatable(field, {__index = Profession})
 return field
end


mining = Profession.new("Mining", { pickaxe })
smithing = Profession.new("Smithing", { })

pottery = Profession.new("Pottery")
tailoring = Profession.new("Tailoring")

lumbering = Profession.new("Lumbering")

fletching = Profession.new("Fletching")
farming = Profession.new("Farming")
heraldry = Profession.new("Heraldry")
fishing = Profession.new("Fishing")
collecting = Profession.new("Collecting")
carpentry = Profession.new("Carpentry")
alchemy = Profession.new("Alchemy")
herbalism = Profession.new("Herbalism")
cooking = Profession.new("Cooking")
dokunering = Profession.new("Engineering")
jewelry_making = Profession.new("Jewelry-Making")
gardening = Profession.new("Gardening")
enchanting = Profession.new("Enchanting")
taming = Profession.new("Taming")
