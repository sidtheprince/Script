-- Game core functions will be powered by the Dokun Engine.
if dokun then
dokun:start()--initialize dokun first-- required if building with srdokun and libdokun
end -- print(DOKUN_STATUS)
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

WINDOW_WIDTH  = 1280
WINDOW_HEIGHT = 720

if dokun then --------------------------------------------------------
window = Window:new()
window:create("Script", WINDOW_WIDTH, WINDOW_HEIGHT)
window:show()

create_ui() -- can cause crash
-- level
--world = Level:new()
--frame = 0

-- play theme song
--theme = Music:new("audio/guardia.ogg")
--theme:set_volume(1)
--theme:play()
--Script.save("potion")
while window:is_open() do
-- ======================
    window:set_viewport(window:get_client_width(), window:get_client_height())
    window:clear(32, 32, 32)
-- ======================
    -- draw world
	-- lock sprite within window bounds
	-- locks all sprites within window bounds
    Sprite:lock_all(window:get_size())--Sprite.lock(player, 1280, 720)
	-- draw item
    Item:draw_all()
	-- draw objects (static)
    -- draw_monster
	Monster:draw_all()
	-- draw NPC
	NPC:draw_all()--king:draw()
	-- draw player
	player:draw()
	-- draw and update ui
    update_ui() -- can cause crash
    --fps_counter() -- can cause crash
-- ======================
    if window:is_focused() then
        if theme then if theme:is_paused() then theme:play() end end  
    end
    if not window:is_focused() then
        if theme then theme:pause() end
    end
-- ======================	
    window:update()
end
if not window:is_open() then
    window:destroy() -- destroy window (if not destroyed)
    dokun:close()    -- close lua (also calls on the gc to collect garbage) then closes the console
end
end -------------------------------------------------------------------  dofile"D:/sid/media/other/code/Script/main.lua"
-- freesounds account : lars1144 pw: s***123
-- ./dokun -e"require'main'"