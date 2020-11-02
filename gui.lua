if dokun then
--[[
    portrait = Widget:new()

portrait:set_shape(1) -- 0 = box, 1 = circle
portrait:set_border(true)
portrait:set_border_width(30)
portrait:set_border_color(128, 128, 128)

player_face = Icon:new()
player_face:set_from_data({9, 78, 3})

portrait:set_content(player_face)
portrait:set_padding(0)
portrait:set_margin(0)
portrait:set_
]]--
function create_ui() -- for player to interact with
--==========================================
-- custom_font
fontsm = Font:new()
fontsm:set_size(0, 18)--16) -- set size before loading
fontsm:load("font/chi_jyun/chi_jyun.ttf")--("font/Lazy.ttf")
-- health_bar
health_bar = Progressbar:new()
health_bar:set_foreground_color(255, 51, 51)--, 255)
health_bar:set_background_color(100, 100, 100)
health_bar:set_outline(true)
health_bar:set_outline_width(1.0)
health_bar:set_label(Label:new()) health_bar:get_label():set_alignment("center")--hp_bar has a label
-- mini health_bar
health_bar_mini = Progressbar:new()
health_bar_mini:set_foreground_color(255, 51, 51) --comeback to this later
-- HP_label
HP_label = Label:new()
HP_label:set_string("HP") -- causes crash
HP_label:set_color(health_bar:get_foreground_color())
-- mana_bar
mana_bar = Progressbar:new()
mana_bar:set_foreground_color(0, 128, 255)
mana_bar:set_background_color(100, 100, 100)
mana_bar:set_outline(true)
mana_bar:set_outline_width(1.0)
mana_bar:set_label(Label:new()) mana_bar:get_label():set_alignment("center")--mp_bar has a label
-- MP_label
MP_label = Label:new()
MP_label:set_string("MP")
MP_label:set_color(mana_bar:get_foreground_color())
-- exp_bar
exp_bar = Progressbar:new()
exp_bar:set_foreground_color(153, 51, 255) --exp_bar:set_size(sprite_width, 10)
exp_bar:set_background_color(100, 100, 100)
exp_bar:set_outline(true)
exp_bar:set_outline_width(1.0)
exp_bar:set_label(Label:new())--exp_bar has a label
exp_bar:get_label():set_alignment("center")--never use label:set_parent() (label does not with with parents)
-- XP_label
XP_label = Label:new()
XP_label:set_string("XP")
XP_label:set_color(exp_bar:get_foreground_color())
--==========================================
-- level_label
level_label = Label:new()
--==========================================
-- system label (for messages)
-- system label 1 and 2 display the engine status
--system_label  = Label:new()
--system2_label = Label:new()
--system2_label:set_scale(0.5, 0.5)--text does not show after scaling for some reason
-- system label 3 displays game events and messages...
--system3_label = Label:new()
--system3_label:set_string("...")
 -- replace "print" function
--print = function(text) system3_label:set_string(text) end
--==========================================
-- player_portrait
-- :set_position(10, window:get_client_height()-50)
--==========================================
-- dialogue_box (for NPC)
dialogue_box = Widget:new()
dialogue_box:set_size(500, 100)--(250, 100)
dialogue_box:set_color(14, 19, 29, 255)
dialogue_box:set_outline(true)
dialogue_box:set_outline_color(32, 32, 32)
dialogue_box:set_gradient(true)
dialogue_box:set_visible(false)-- hidden by default
-- set empty image
dialogue_box:set_image(Image:new())
dialogue_box:get_image():set_alignment("right")
-- set empty label
dialogue_box:set_label(Label:new()) --label is automatically drawn when box is drawn --dialogue_box.label:set_font(fontsm) -- crashes the engine -- apparently, setting the font crashes engine
dialogue_box:get_label():set_relative_position(10, 10)--dialogue_box:get_label():get_relative_y());
--dialogue_box:get_label():
-- add multiple labels
dialogue_box:set_label_list(Label:new()) --dialogue_box.label1:set_font(dialogue_box:get_label():get_font())-- dialogue_box.label1 -- causes text to not show up
dialogue_box:set_label_list(Label:new()) --dialogue_box.label2:set_font(dialogue_box:get_label():get_font()) -- dialogue_box.label2 -- causes text to not show up
dialogue_box:set_label_list(Label:new()) --dialogue_box.label3:set_font(dialogue_box:get_label():get_font()) -- dialogue_box.label3 -- causes text to not show up
--dialogue_box:set_label_list(Label:new()) --dialogue_box.label4:set_font(dialogue_box:get_label():get_font()) -- dialogue_box.label4 -- causes text to not show up
--dialogue_box:show() -- should be hidden by default
--==========================================
-- bag_icon
bag_icon = Image:new("ui/bag1_64x64.png")
-- bag_slots (but in GUI form)
bag_slots = {}--ordinary table--   bag_slots=Widget:new() bag_slots:set_size(32 *Bag:get_maximum_slots(), 32) --10each
for i=1, Bag:get_maximum_slots() do
	bag_slots[i] = Widget:new()
	bag_slots[i]:set_size(32, 32)--each slot is 32x32
	bag_slots[i]:set_image(Image:new())--create and set empty image for each bag_slots
	bag_slots[i]:get_image():set_alignment("center")-- image will be placed at center of bag_slot[i]
	bag_slots[i]:set_label(Label:new())  bag_slots[i]:get_label():set_string(tostring(0)) bag_slots[i]:get_label():hide()--set label to display quantity of an item?--hide label by default (unless an item is added)
	if i ~= 1 then--if i is nor equal to 1 (excluding the first bag_slot)
		bag_slots[i].prev_slot = bag_slots[i - 1] --save previous slots
	end
end
-- bag_toggle_coroutine
bag_toggle = function()
	for i =1, #bag_slots do
		if bag_slots[i]:is_visible() then bag_slots[i]:hide() end--hide gold_box as well: gold_box:hide()
	end
	coroutine.yield()
	for i =1, #bag_slots do
	    if not bag_slots[i]:is_visible() then bag_slots[i]:show() end--show gold_box as well: gold_box:show()
	end
end
bag_toggle_co = coroutine.create(bag_toggle) --add function to coroutine
--    for i=1, #Bag.slots do --depending on number of items in bag.slots-- make sure item image is loaded first
--        local item = Bag.slots[i]
--        if Sprite.get_texture(item):is_texture() then print(item:get_name().."'s texture is valid.'")
--        bag_slots[i]:get_image():copy_texture(Sprite.get_texture(item)) end
--    end
empty_texture = Texture:new() -- always keep this texture empty. NEVER fill it with any data!
empty_sprite = Sprite:new()
empty_sprite:set_texture(empty_texture)
empty_sprite:set_color(64, 64, 64, 255)

empty_image = Image:new() -- will be copied by "bag_slots[i]:get_image()" to make it look like an item has disappeared after its been consumed
empty_image:set_color(bag_slots[1]:get_color()) -- copy the bag_slots[i] base color--print("empty_image size: ", empty_image:get_size()) --size is 0,0 but I guess there's no need to change that except the color
--==========================================
-- gold_box
gold_box = Widget:new()
gold_box:set_size(100, 32)
gold_box:set_label(Label:new()) gold_box:get_label():set_string(tostring(0))
gold_box:set_image(Image:new())
if Sprite.get_texture(gold):is_texture() then gold_box:get_image():copy_texture(Sprite.get_texture(gold)) end
gold_box:get_image():set_alignment("center")
--==========================================
-- tooltip --default
tooltip = Widget:new()
tooltip:set_color(64, 64, 64, 255)
tooltip:set_label(Label:new())
tooltip:get_label():get_alignment("center")
--tooltip:get_label():set_string()
tooltip:set_visible(false)--hide by default
tooltip_toggle = function(bag)
	if not bag then bag = Bag end
	local item, item_x, item_y, item_width, item_height
	for i=1, bag:get_maximum_slots() do
		item = bag.slots[i] -- get item from Bag.slots
		if is_item(item) then -- if item is valid
			item_x, item_y          = bag_slots[item:get_slot()]:get_position()--get bag_slot's rect
			item_width, item_height = bag_slots[item:get_slot()]:get_size()

			if Mouse:is_over(item_x, item_y, item_width, item_height) then
				if Sprite.get_texture(item):get_file() == bag_slots[item:get_slot()]:get_image():get_file() then--if Sprite.get_texture(item):get_data() == bag_slots[item:get_slot()]:get_image():get_data() then --if the item's texturedata is equal to the bag_slots' texturedata
				    --print(item:get_name().."'s data matches item in bag_slots "..item:get_slot())
				    tooltip:get_label():set_string(item:get_name())
			        tooltip:show()
			        --print("Mouse is over "..item:get_name())--for debug purposes
		        else tooltip:hide()-- hide tooltip--does hide for some reason
				end
			end--this end closes the if sprite:texture:filename = bag_slots:filename
	   end
	end
end
-- tooltip2
--[[
tooltip2 = Widget:new()
tooltip2:set_color(64, 64, 64, 255)
tooltip:set_label(Label:new())
tooltip:set_visible(false)--hide by default
-- item info (on mouse_over item)
tooltip2:get_label(0):set_string("name: "..item:get_name())
tooltip2:get_label(1):set_string("number : "..item:get_id())
tooltip2:get_label(2):set_string("type: "..item:get_type())
tooltip2:get_label(3):set_string("level Req.: "..item:get_require())
tooltip2:get_label(4):set_string("usage: "..item:get_usage())
tooltip2:get_label(5):set_string("effect: "..item:get_effect())
tooltip2:get_label(6):set_string("price: "..item:get_price())
tooltip2:get_label(7):set_string("owned: "..item:get_quantity())
tooltip2:get_label(8):set_string("durability: "..item:get_durability())
tooltip2:get_label(9):set_string("tradeable: "..item:is_tradeable())
]]--
--==========================================
-- error_box
error_box = Widget:new()
error_box:set_title_bar(true)
--error_box:
error_box:set_title_bar_button_close(true)
error_box:set_outline(true)
error_box:set_size(200, 50)
error_box:set_position(window:get_client_width()/2, window:get_client_height() / 2)
-- error_box_label
error_box_label = Label:new()
error_box_label:set_font(fontsm)
error_box_label:set_string("This is an error")
error_box_label:set_alignment("center")
--error_box:set_size(error_box_label:get_width()+10, error_box_label:get_height()+10)
-- error_box_title_label
error_box_title_label = Label:new()
error_box_title_label:set_font(fontsm)
error_box_title_label:set_string("Script")
error_box:set_title_bar_label(error_box_title_label)
-- error_box_title_image
--error_title_image = Image:new("player/naked.png")
--error_box:set_title_bar_image(error_title_image)
-- set label and other stuff
error_box:set_label(error_box_label)
--error_box:hide()
--print("Label size: ", error_box_label:get_width(), error_box_label:get_height())
--==========================================
--==========================================
--==========================================
end

function update_ui()
	-- level_label
	level_label:set_position(10, window:get_client_height()-25)
	level_label:set_string("LV "..tostring(player:get_level()))
	level_label:draw()
    -- health_bar
	local sprite_x, sprite_y          = Sprite.get_position(player)
	local sprite_width, sprite_height = Sprite.get_size    (player)
	HP_label:set_position(health_bar:get_x()-25, window:get_client_height()-25)
	HP_label:draw()
	-- size, position, range, and value may change so keep in loop (everything must be set before drawing)
	health_bar:set_size(200, 20)--health_bar:set_size(sprite_width, 5)
    health_bar:set_position(100, window:get_client_height() - 30)--health_bar:set_position(sprite_x, sprite_height + sprite_y)--health_bar will go under the player's feet
	health_bar:set_range(0, player:get_maximum_health())--print(health_bar:get_range())
	health_bar:set_value(player:get_health())
	health_bar:get_label():set_string(tostring(player:get_health()))
	health_bar:draw()
	-- health_bar_mini -- does not need a label
	health_bar_mini:set_size(sprite_width, 5)
	health_bar_mini:set_position(sprite_x, sprite_height + sprite_y)--health_bar will go underneath the player's feet
	health_bar_mini:set_range(0, player:get_maximum_health())
	health_bar_mini:set_value(player:get_health())
	health_bar_mini:draw()
	-- mana_bar
	local health_bar_x, health_bar_y          = health_bar:get_position()
	local health_bar_width, health_bar_height = health_bar:get_size    ()
	MP_label:set_position(mana_bar:get_x()-25, window:get_client_height()-25)
	MP_label:draw()
	-- size, position, range, and value may change so keep in loop (everything must be set before drawing)
	mana_bar:set_size(200, 20)--mana_bar:set_size(sprite_width, 5)
    mana_bar:set_position((health_bar:get_x() + health_bar_width + 30), health_bar_y)--mana_bar:set_position(sprite_x, health_bar_y + health_bar_height + 1) -- spacing is 1
	mana_bar:set_range(0, player:get_maximum_mana())--print(mana_bar:get_range())
	mana_bar:set_value(player:get_mana())
	mana_bar:get_label():set_string(tostring(player:get_mana()))
	mana_bar:draw() --remove comment to draw manabar
    -- exp_bar
	local mana_bar_x, mana_bar_y          = mana_bar:get_position()
	local mana_bar_width, mana_bar_height = mana_bar:get_size    ()
	local current_exp              = player:get_exp      ()
	local exp_to_next_level        = player:get_exp_table(player:get_level() + 1)
	XP_label:set_position(exp_bar:get_x()-25, window:get_client_height()-25)
	XP_label:draw()
	--print("Current level: ", player:get_level ())
	--print("Current XP: ", player:get_exp      ())
	--print("XP to next level: ", player:get_exp_table(player:get_level() + 1))
	-- size, position, range, and value may change so keep in loop (everything must be set before drawing)
	exp_bar:set_size(200, 20)--exp_bar:set_size(sprite_width, 5)
    exp_bar:set_position(mana_bar:get_x() + mana_bar:get_width() + 30, mana_bar_y)--exp_bar:set_position(sprite_x, mana_bar_y + mana_bar_height)--uncomment only if placed underneath mana_bar
	exp_bar:set_range(current_exp, exp_to_next_level)  tostring(get_exp_percentage(current_exp, exp_to_next_level))
	exp_bar:set_value(current_exp) --expbar:reset()
	exp_bar:get_label():set_string(tostring(current_exp.."/"..exp_to_next_level))--.." ("..tostring(get_exp_percentage(current_exp, exp_to_next_level).."%)")) --also prints current exp in percentage form
	exp_bar:draw() --remove comment to draw expbar
	--===============================================================
	-- system label 1
	--system_label:set_position(10, window:get_client_height()-50)
	--system_label:set_string("Status: ")
	--system_label:draw()
	-- system label 2
	--system2_label:set_position(system_label:get_x() + 80, system_label:get_y())--(system_label:get_x() + system_label:get_width(), system_label:get_y())--label:get_width, label:get_height both crashes the engine for some reason
	--if DOKUN_STATUS then system2_label:set_color(127,255,0) system2_label:set_string("Online") else system2_label:set_color(255, 51, 51) system2_label:set_string("Offline") end
	--system2_label:draw()
	--===============================================================
	-- bag_icon
	local bag_icon_x, bag_icon_y          = bag_icon:get_position()
	local bag_icon_width, bag_icon_height = bag_icon:get_size    ()
	if Mouse:is_over(bag_icon_x, bag_icon_y, bag_icon_width, bag_icon_height) then
		if Mouse:is_pressed(1) then
			if coroutine.status(bag_toggle_co) == "dead" then bag_toggle_co = coroutine.create(bag_toggle) end
			if coroutine.status(bag_toggle_co) =="suspended" then coroutine.resume(bag_toggle_co) end--bag_toggle()
		end
    end
	bag_icon:set_position(window:get_client_width()-50, window:get_client_height()-50)
	bag_icon:draw()
	--===============================================================
	-- bag_slots
	bag_slots[1]:set_position((exp_bar:get_x() + exp_bar:get_width()+bag_slots[1]:get_width()), bag_icon:get_y() + 15)--((exp_bar:get_x() + exp_bar:get_width()) + (bag_slots[1]:get_width() * 4), bag_icon:get_y() + 15)-- set first bag_slot position which will decide where the rest of the slots go
	for i=1, #bag_slots do
		if i ~= 1 then local prev = bag_slots[i].prev_slot bag_slots[i]:set_position((prev:get_x()+prev:get_width())+1, prev:get_y()) end --exclude first bag_slot : (bag_slot[1])
	    bag_slots[i]:draw()--draw slots
	end
	--===============================================================
	-- gold_box
	gold_box:get_label():set_string(tostring(Bag.gold))
	gold_box:set_position(bag_slots[10]:get_x()+bag_slots[10]:get_width()+2, bag_slots[1]:get_y())--((bag_slots[1]:get_x()-gold_box:get_width())-1, bag_slots[1]:get_y())
	if Mouse:is_over(gold_box:get_rect()) then tooltip:get_label():set_string(gold:get_name().."s: "..tostring(Bag.gold)) tooltip:show() else tooltip:hide() end
	gold_box:draw()
	--===============================================================
	-- tooltip
	--tooltip:show()--only show if mouse_over object
	tooltip:set_size(10 * string.len(tooltip:get_label():get_string()), 16)
	tooltip:set_position(bag_slots[(#bag_slots / 2)]:get_x(), bag_slots[1]:get_y()-bag_slots[1]:get_height())
	tooltip_toggle()
	tooltip:draw()
	--===============================================================
	-- dialogue_box  : update -- gotta work on scrolling text and so on ...
    dialogue_box:set_size(window:get_client_width()-(window:get_client_width()/4), dialogue_box:get_height())
    dialogue_box:set_position((window:get_client_width() - dialogue_box:get_width()) / 2, window:get_client_height() - 200) --height=450
	--print("Dialogue Box position: ", dialogue_box:get_position())
	-- dialogue_box : image update
	--print("Portrait image position: ",dialogue_box:get_image():get_position())
	-- dialogue_box : label update - dialogue_box:get_label()
	-- draw dialogue_box
	--dialogue_box:get_label():set_position(1300, 1000)--does nothing to a GUI with a parent, use set_relative_position instead
    --print("Dialogue box position: ", dialogue_box:get_position())
    --print("Dialogue label position: ", dialogue_box:get_label():get_position())
    --print("Dialogue label position relative to box: ", dialogue_box:get_label():get_relative_position())
	dialogue_box:draw()-- draw dialogue_box as long as its visible
    --===============================================================
end


--mini_map = Widget:new() -- a customizable gui with no limitation
--[[
minimap:set_shape("CIRCLE") -- literally a circle
minimap:set_size() -- how big or small s the circle?
minimap:set_border(true) -- give the circle a border
minimap:set_border_width(50) -- how thick/fat is the border of the circle?(from 0-100)
minimap:set_border_texture("GRANITE") --set the texture of the border
minimap:set_border_color("BLUE") -- or just give the border a color instead of a texture
minimap:set_border_size(minimap:get_size()) -- set the border size to match the circle size
minimap:set_border_style("SOLID") -- is the border solid, dotted, or lined?
minimap:set_padding(0, "ALL_SIDES") -- how far is the space between the minimap and its contents; clears an area around the minimao content; ALL_SIDES= top, bottom, right, left
minimap:set_border_radius(0) -- does not work with CIRCLES since circle already have rounded corners
]]--

--[[
-- spellbar
skill_bar = Widget:new()

-- menu buttons
info_menu = Widget:new()
bag_menu = Widget:new() -- 180, 250
quest_menu = Widget:new()
map_menu = Widget:new()
friend_menu = Widget:new()
party_menu = Widget:new()
guild_menu = Widget:new()
skill_menu = Widget:new()
options_menu = Widget:new()


info_icon = Widget:new()
--info_icon:set_as_icon()

bag_icon = Widget:new()
--bag_icon:set_as_icon()
bag_icon:show()

quest_icon = Widget:new()
--quest_icon:set_as_icon()


-- ammunition
amount_of_ammo = 99
ammo_icon = Widget:new()
ammo_icon:set_size(32, 32)
ammo_icon:set_position(490, 1000)
ammo_icon:set_as_image()
ammo_icon:load_from_file()
ammo_icon:show()

ammo_num_display= Label:new()
ammo_num_display:set_string(tostring(amount_of_ammo))
ammo_num_display:set_font("Consolas.ttf")
ammo_num_display:set_style("BOLD")
ammo_num_display:set_color("WHITE")
ammo_num_display:show()

cross_hair = GUI.new("WIDGET")
cross_hair:set_as_image();
cross_hair:set_alpha(true); -- see through when targeting an enemy
cx, cy = cross_hair:get_center_position() -- gets the cross_hair gui 's center(radius)

function follow_cross_hair()
 if on_mousemove() then -- while the mouse is moving
  cross_hair:set_position(mouse:get_x(), mouse:get_y()) -- follow the cross hair
 end
end

--mouse_cursor:set_icon("src/sword.png")
--mouse_cursor:set_size(10, 10)


EXAMPLES:
WE CAN TURN A PLAIN WHITE SQUARE INTO A REAL CONTAINER GUI HERE:
menu = GUI.new("WIDGET") -- a widget is a customizable gui and you can make anything out of it
menu:set_as_box() -- box widget is just a plain square
menu:set_radius(25) -- now lets make the corners round; 2nd arg is 'ALL_SIDES' by default
menu:set_color(Rbg(0, 51, 102)) -- set the color to dark blue
menu:set_border(true) -- lets give it a frame
menu:set_border_width(50) -- thicken/fatten the border
menu:set_border_color(Rbg(0, 0, 0)) -- make the border color black





-- WE CAN MAKE THE BOX GUI MORE LIKE A WINDOW
menu:set_title_bar(true) -- give it a title bar
menu:set_title_bar_text("Menu")
menu:set_title_bar_icon("src/icon.png")
menu:set_title_bar_color("DEFAULT")
menu:set_title_bar_orientation("HORIZONTAL") -- we can even have a sideways title bar. Isn't that something?



-- NORMAL GUI FUNCTIONS
menu:set_position(0, 0)
menu:set_width(550)
menu:set_height(400)

menu:show() -- show the menu


icon_bar = GUI.new("WIDGET")
icon_bar:set_as_box() icon_bar:set_width(900) icon_bar:set_height(10)
icon_bar:add_icon_from_file("src/mail.png")
icon_bar:add_seperator(5, 5, "VERTICAL")
icon_bar:add_icon(icon)
]]--

end
--[[
-- gui_factory
if dokun then
    gui_factory = Factory:new()
end

if dokun then
    function GUI:is_gui()
	    if type(self) ~= "table" then
		    return false
		end
		if getmetatable(self) == GUI_mt then
		    return true
		end
		return false
    end
    is_gui = GUI.is_gui
end

function ui_event_handler()
	for i = 0, gui_factory:get_size() do
	    if is_gui( gui_factory:get_object(i) ) then
		    -- draw event
			--gui:draw()
		end
	end
end
]]--
