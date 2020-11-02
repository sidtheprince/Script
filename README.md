![Script logo](junk/script.png "Script-logo")

```sh
Though this is a text-based Lua RPG game. I will add graphics to it when I complete the Dokun Engine.
```

# Usage:
```lua
require "main" -- inside lua
-- or
./dokun main.lua # from the terminal (if using dokun)
```

# Building:
Requires <a href="https://github.com/sidtheprince/srdokun">srdokun</a>.
```sh
./glue ./srlua main.lua main # compiles into an executable
```

# More examples:
```lua
-- obtaining item and opening your bag
potion:obtain() -- items: gold, potion, health_potion, mana_potion, dual_potion, sword
Bag:open()
-- getting item information
potion:show_info()

-- using and equiping items
potion:use(player)
player:equip(sword)

-- storing your items away when bag is full
Storage:store(potion)
-- withdrawing items from storage
Storage:withdraw(potion)

-- getting item, gold, and exp, drops from monsters
slime:drop(player) -- monsters: slime, slime_king, borg
Bag:open()

-- interacting with NPCs
don:on_select(player) -- npcs: king, don

-- battling monsters
for i=1, 100 do player:hit(slime) end

-- creating new class objects
poop = Item:new()
bag2 = Bag:new()
player2 = Player:new()
```

# Controls:
These only work while using <a href="https://github.com/sidtheprince/dokun">dokun</a>.
```
Arrow keys - moving the player.
Spacebar   - interaction with NPCs.
Number keys (1-10) - use item in bag.
Z - zoom in (camera).
X - zoom out (camera).
ESC - exit game.
```

# Documentation:
```
coming soon!
```
