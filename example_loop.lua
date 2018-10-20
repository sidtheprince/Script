require "main"

quit = false

-- loops are forever.
-- they are aon-going events that occur while the game is running
-- your life is like a loops
-- while(I_AM_ALIVE()) eat() sleep() go_to_bed() go_to_school() end
-- the loop repeats

load_world() -- loads all the maps
load_all_items() -- loads all items
load_all_npcs() -- loads all npcs
load_all_monsters() -- loads all monsters

load_all_gui()-- loads all gui

while not quit do
 
 draw_world() -- draws all the maps
 draw_all_items() -- loads all items
 draw_all_npcs() -- loads all npcs
 draw_all_monsters()
 
 draw_all_gui() -- draws all the gui
 
 if item:in_bag() then
  if mouse:over(item) then
   item:show_info()
  end
 end

 if mouse:over(player2) then
  if mouse:click(RIGHT_MBUTTON) then
   player2:show_option_box("add, duel, guild, block")
  end
 end

 if mouse:over(npc) then
  if mouse:d_click(LEFT_MBUTTON) then
   npc:talk()
  end
 end
 
 if mouse:over(slime) then
  if mouse:click(LEFT_MBUTTON) then
   player:set_target(slime)
   player:fight(player:get_target())
  end
 end
 
 -- move the player
 if keyboard:press(UP) then
  player:set_sprite(player.up[frame])
  player.y = player.y - 5
 end
 if keyboard:press(DOWN) then
  player:set_sprite(player.down[frame])
  player.y = player.y + 5
 end
 if keyboard:press(LEFT) then
  player:set_sprite(player.left[frame])
  player.x = player.x - 5
 end
 if keyboard:press(RIGHT) then
  player:set_sprite(player.right[frame])
  player.x = player.x + 5
 end
 if keyboard:press(SPACEBAR) then
  player:jump()
 end
-- update the frame
 frame = frame + 1
 if(frame > 4) then
   frame = 1
 end
 
 
-- collision detection
if player:intersect(slime) then
 player.health = player.health - 1
end
 
if player:intersect(potion) then
 potion:obtain()
end 
 
 -- keep camera on player
 camera:follow(player)
 
 window:update()
 window:show()
end