<<<<<<< HEAD
poop = Item.new("Poop")

poop:load("item/poop.png")

function poop:on_use() 
 print("Ew, you used a "..poop:get_name())

=======
poop = Item.new("Poop")

function poop:on_use() 
 print("Ew, you used a "..poop:get_name())

>>>>>>> d581ca734c9f411bcb2a95fb93d5835f4db24fcc
end