-- create an item
ball = Item.new("Ball", GENERAL, 0, "Something you can play with.", 0) --> Item.new(name, type, required_level, description, effect)

-- set properties here
ball:set_price(10)


-- user-defined functions
function ball:on_use(user) 

end


