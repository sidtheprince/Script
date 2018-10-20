-- Game core functions will be powered by the Dokun Engine.
if DOKUN_STATUS ~= true then  -- but dokun has not fully initialised
    --print("Dokun failed to start.")
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
require("bag") -- complete   ERROR
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

if dokun then --------------------------------------------------------
window = Window:new()
window:create("Script", 1280, 720)
window:show()
-- level
--world = Level:new()
--frame = 0

--map = Sprite:new("map/map1.png")
--map:set_size(window:get_width(), window:get_height())

create_ui()

--Script.save("potion")
while window:is_open() do
-- ======================
    window:set_viewport(window:get_width(), window:get_height())
    window:clear(32, 32, 32)
-- ======================
    -- draw world
	--map:set_size(1280, 720) -- update map dimensions
	--map:draw()
	-- draw item
    Item:draw_all()
	-- draw objects (static)
	-- draw_monster
	Monster:draw_all()
	-- draw NPC
	NPC:draw_all()--king:draw()
    -- draw player
	player:draw(frame)
	-- draw ui
	update_ui()
	npc_dialogue_box:draw()-- draw dialogue_box as long as its visible
-- ======================	
    window:update()
end
if not window:is_open() then
    window:destroy() -- destroy window (if not destroyed)
    dokun:close()    -- close lua (also calls on the gc to collect garbage) then closes the console
end
end -------------------------------------------------------------------  dofile"D:/sid/media/other/code/Script/main.lua"