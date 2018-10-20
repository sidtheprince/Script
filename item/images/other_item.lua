<<<<<<< HEAD
﻿dofile("item.lua")


-- ============ all items ======================================== ---
-- general
guild_banner = Item.new("Guild Banner", GENERAL, "A banner that represents a guild.", NO_REQUIRE, 0, 100000)

-- unknown
mystery_crate = Item.new("Mystery Crate", "??", "", NO_REQUIRE, { potion, revival_scroll, double_exp_stone,  }, 0)


-- random and dumb items
leaf = Item.new("Leaf") -- falls off trees
water = Item.new("水")

stone = Item.new()


-- coins and collectibles
nugget = Item.new("Nugget") -- worth 80 gold
sack_of_gold = Item.new("Sack Of Gold") -- 1,000 gold




-- health items

-- CHAT OPTIONS
--function mute(player_name) end
--function whisper(player_name) end
--function guild_chat() end

------- ACTIONS AND EMOTICONS ---------------
--function laugh() end
--function clap() end
--function dance() end

-- mana items


-- food buffs
dragonfruit = Item.new("Dragonfruit") -- removes poison affects by 2%, power increases by 2%


-- power ups
capsule = Item.new("Capsule")

--weapons


wooden_stick = Item.new("Wood Stick", EQUIPMENT, "", 1, math.random(2, 5), 20)
wooden_stick.subtype = WEAPON
wood_stick = wooden_stick

gold_sword = Item.new("Gold Sword", EQUIPMENT, "", 1, 10, 199)
gold_sword.subtype =WEAPON
--ironhead_spear = Item.new()

-- armor

-- mounts

-- materials
wood = Item.new("Wood", MATERIAL, "A material that forms from the trunk or branches of a tree.", 1, 0, 0)
rubber = Item.new("Rubber", MATERIAL, "a tough elastic polymeric substance made from the latex of a tropical plant or synthetically.", 1, 0, 0)
plastic = Item.new("Plastic", MATERIAL, "Synthetic material that can be easily shaped or molded.", 1, 0, 0)
glass = Item.new("Glass", MATERIAL, "A hard and brittle substance that is typically transparent.", 1, 0, 0)


-- mining
mining_cap = Item.new("Mining Cap")
pickaxe = Item.new("Pickaxe") -- 24

ore = Item.new("Ore", MATERIAL)
bar = Item.new("Bar", SEMI_MATERIAL)
ingot = bar

copper = Item.new("Copper Ore", MATERIAL, "", 1, NO_EFFECT, NO_PRICE) -- level 1 mining required; materials are not sold in stores, but from resources
tin = Item.new("Tin Ore", MATERIAL, "", 1, NO_EFFECT, NO_PRICE)

iron = Item.new("Iron Ore", MATERIAL, "", 2, NO_EFFECT, NO_PRICE)


--NOTE: ores are not sold, but mined






-- lumberjack
hatchet = Item.new("Hatchet", EQUIPMENT)

-- fishing
fishing_rod = Item.new("Fishing Rod", EQUIPMENT)
bait = Item.new("Bait")


-- smithing
anvil = "not_an_item" -- used to shape bars into weapons and armor
hammer = Item.new("Hammer")

furnace = "not_an_item" -- used for smelting ore into metal bars

-- pottery
clay = Item.new("Clay", MATERIAL)
kiln = "not_an_item" -- cannot be carried around due to weight

-- heraldry
banner = Item.new("Banner")


-- gardening 
seed = Item.new("Seed")
pail = Item.new("Pail")

fertilizer = Item.new("Fertilizer")



-- carpentry
nail = Item.new("Nail")
hammer = hammer
wood = wood


-- tailoring
wool = Item.new("Wool")
cotton = Item.new("Cotton")
silk = Item.new("Silk")
linen =  Item.new("Linen")

animal_skin = Item.new("Animal Skin")

leather = Item.new("Leather", SEMI_MATERIAL)



-- dokunering
wrench = Item.new("Wrench")
screw = Item.new("Screw")
scrap_metal = Item.new("Metal Scrap")
nut = Item.new("Nut")

-- tools
radar = Item.new("Radar")

-- spells



-- quest 
book_of_legends = Item.new("Book of Legend")



gem = Item.new("Gem")
chest = Item.new("Chest")



-- quest
crown = Item.new("Crown")
=======
﻿dofile("item.lua")


-- ============ all items ======================================== ---
-- general
guild_banner = Item.new("Guild Banner", GENERAL, "A banner that represents a guild.", NO_REQUIRE, 0, 100000)

-- unknown
mystery_crate = Item.new("Mystery Crate", "??", "", NO_REQUIRE, { potion, revival_scroll, double_exp_stone,  }, 0)


-- random and dumb items
leaf = Item.new("Leaf") -- falls off trees
water = Item.new("水")

stone = Item.new()


-- coins and collectibles
nugget = Item.new("Nugget") -- worth 80 gold
sack_of_gold = Item.new("Sack Of Gold") -- 100,000 gold




-- health items

-- CHAT OPTIONS
--function mute(player_name) end
--function whisper(player_name) end
--function guild_chat() end

------- ACTIONS AND EMOTICONS ---------------
--function laugh() end
--function clap() end
--function dance() end

-- mana items


-- food buffs
dragonfruit = Item.new("Dragonfruit") -- removes poison affects by 2%, power increases by 2%


-- power ups
capsule = Item.new("Capsule")

--weapons


wooden_stick = Item.new("Wood Stick", EQUIPMENT, "", 1, math.random(2, 5), 20)
wooden_stick.subtype = WEAPON
wood_stick = wooden_stick

gold_sword = Item.new("Gold Sword", EQUIPMENT, "", 1, 10, 199)
gold_sword.subtype =WEAPON
--ironhead_spear = Item.new()

-- armor

-- mounts

-- materials
wood = Item.new("Wood", MATERIAL, "A material that forms from the trunk or branches of a tree.", 1, 0, 0)
rubber = Item.new("Rubber", MATERIAL, "a tough elastic polymeric substance made from the latex of a tropical plant or synthetically.", 1, 0, 0)
plastic = Item.new("Plastic", MATERIAL, "Synthetic material that can be easily shaped or molded.", 1, 0, 0)
glass = Item.new("Glass", MATERIAL, "A hard and brittle substance that is typically transparent.", 1, 0, 0)


-- mining
mining_cap = Item.new("Mining Cap")
pickaxe = Item.new("Pickaxe") -- 24

ore = Item.new("Ore", MATERIAL)
bar = Item.new("Bar", SEMI_MATERIAL)
ingot = bar

copper = Item.new("Copper Ore", MATERIAL, "", 1, NO_EFFECT, NO_PRICE) -- level 1 mining required; materials are not sold in stores, but from resources
tin = Item.new("Tin Ore", MATERIAL, "", 1, NO_EFFECT, NO_PRICE)

iron = Item.new("Iron Ore", MATERIAL, "", 2, NO_EFFECT, NO_PRICE)


--NOTE: ores are not sold, but mined






-- lumberjack
hatchet = Item.new("Hatchet", EQUIPMENT)

-- fishing
fishing_rod = Item.new("Fishing Rod", EQUIPMENT)
bait = Item.new("Bait")


-- smithing
anvil = "not_an_item" -- used to shape bars into weapons and armor
hammer = Item.new("Hammer")

furnace = "not_an_item" -- used for smelting ore into metal bars

-- pottery
clay = Item.new("Clay", MATERIAL)
kiln = "not_an_item" -- cannot be carried around due to weight

-- heraldry
banner = Item.new("Banner")


-- gardening 
seed = Item.new("Seed")
pail = Item.new("Pail")

fertilizer = Item.new("Fertilizer")



-- carpentry
nail = Item.new("Nail")
hammer = hammer
wood = wood


-- tailoring
wool = Item.new("Wool")
cotton = Item.new("Cotton")
silk = Item.new("Silk")
linen =  Item.new("Linen")

animal_skin = Item.new("Animal Skin")

leather = Item.new("Leather", SEMI_MATERIAL)



-- dokunering
wrench = Item.new("Wrench")
screw = Item.new("Screw")
scrap_metal = Item.new("Metal Scrap")
nut = Item.new("Nut")

-- tools
radar = Item.new("Radar")

-- spells



-- quest 
book_of_legends = Item.new("Book of Legend")



gem = Item.new("Gem")
chest = Item.new("Chest")



-- quest
crown = Item.new("Crown")
>>>>>>> d581ca734c9f411bcb2a95fb93d5835f4db24fcc
chalice = Item.new("Chalice")