-- Game core functions will be powered by the Dokun Engine.
if DOKUN_STATUS ~= true then  -- but dokun has not fully initialised
    print("Dokun failed to start.")
end
require("global")
require("system")
require("input") -- new
require("time")
require ("data")
require("math1")
require("string1")
require("log")
require("magic")
require("player")
require("item")
require("storage")
require("pet")
require("monster")
require("bag") -- complete
require("world")
require("shop")
require("quest")
require("npc")
require("guild")
require("profession")
require("battle")
require("object")
require("stance")
require("chat")
require("gui")
require("fps")

if dokun then
window = Window:new("Script", 1280, 720)
window:create()
window:show()
while not game_over do
-- ======================
    window:set_viewport(window:get_width(), window:get_height())
    window:clear(32, 32, 32)
-- ======================
    -- draw world
	-- draw item
	-- draw objects (static)
	-- draw_monster
	-- draw NPC
    -- draw player
	-- draw ui
-- ======================	
    window:update()
end
end