tree = Object.new("Tree")

--tree:load("object/tree.png")
tree:scale(8, 8)
tree:set_position(math.random(0, 800), math.random(0, 600))

tree.max = 100
  
function tree:on_spawn()
for i = 1, tree.max do
    tree[i] = tree:new()
	tree[i]:load("object/tree.png")
	tree[i]:scale(8, 8)
    tree:set_position(math.random(0, 1000 *2), math.random(0, 1000 * 2))
end
end

--tree:on_spawn()

function tree:on_animate()

end