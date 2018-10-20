if (dokun) then
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
function create_ui()
--==========================================
-- health_bar
health_bar = Progressbar:new()
health_bar:set_foreground_color(255, 51, 51)--, 255)
health_bar:set_outline(true)
health_bar:set_outline_width(1.0)
-- mana_bar
mana_bar = Progressbar:new()
mana_bar:set_foreground_color(0, 128, 255)
mana_bar:set_outline(true)
mana_bar:set_outline_width(1.0)
-- exp_bar
exp_bar = Progressbar:new()
exp_bar:set_foreground_color(153, 51, 255) --exp_bar:set_size(sprite_width, 10)
exp_bar:set_outline(true)
exp_bar:set_outline_width(1.0)

--==========================================
-- exp_text_display
exp_label = Label:new()
--exp_label:set_parent(exp_bar) -- label will be attached to exp_bar and move with the exp_bar
-- bag_icon
bag_icon = Image:new("ui/bag1_64x64.png")
end

function update_ui()
    -- health_bar
	local sprite_x, sprite_y          = Sprite.get_position(player)
	local sprite_width, sprite_height = Sprite.get_size    (player)
	-- size, position, range, and value may change so keep in loop (everything must be set before drawing)
	health_bar:set_size(sprite_width, 10)
    health_bar:set_position(sprite_x, sprite_height + sprite_y)
	health_bar:set_range(player:get_health(), player:get_maximum_health())
	health_bar:set_value(player:get_health())
	health_bar:draw()
	-- menu_bar
	local health_bar_x, health_bar_y          = health_bar:get_position()
	local health_bar_width, health_bar_height = health_bar:get_size    ()
	-- size, position, range, and value may change so keep in loop (everything must be set before drawing)
	mana_bar:set_size(sprite_width, 5)
    mana_bar:set_position(sprite_x, health_bar_y + health_bar_height + 1) -- spacing is 1
	mana_bar:set_range(player:get_mana(), player:get_maximum_mana())
    mana_bar:set_value(player:get_mana())
	mana_bar:draw()
    -- exp_bar
	local mana_bar_x, mana_bar_y          = mana_bar:get_position()
	local mana_bar_width, mana_bar_height = mana_bar:get_size    ()
	local current_exp              = player:get_exp      ()
	local exp_to_next_level        = player:get_exp_table(player:get_level() + 1)
	print("Current level: ", player:get_level ())
	print("Current XP: ", player:get_exp      ())
	print("XP to next level: ", player:get_exp_table(player:get_level() + 1))
	-- size, position, range, and value may change so keep in loop (everything must be set before drawing)
	exp_bar:set_size(sprite_width, 5)
    exp_bar:set_position(sprite_x, mana_bar_y + mana_bar_height)
	exp_bar:set_range(current_exp, exp_to_next_level) -- tostring(get_exp_percentage(current_exp, exp_to_next_level))
    exp_bar:set_value(current_exp) --expbar:reset()
	exp_bar:draw()
	-- exp_label
	exp_label:set_position(0, window:get_height()-50)
	exp_label:set_string(tostring(current_exp.." / "..exp_to_next_level) )
	exp_label:draw()
	-- bag_icon
	bag_icon:set_position(window:get_width()-50, window:get_height()-50)
	bag_icon:draw()	
	--[[
	local bag_icon_x, bag_icon_y = bag_icon:get_position()
	local bag_icon_width, bag_icon_height = bag_icon:get_size()
	if Mouse:is_over(bag_icon_x, bag_icon_y, bag_icon_width, bag_icon_height) then
	    if Mouse:is_pressed(1) then
	      print("Bag icon pressed")
		if not Bag.ui:is_visible() then
	    Bag:open()
		else 
		Bag:close()
		end
	    end
	end
	--Bag.ui:draw  ()
	]]--

end


mini_map = Widget:new() -- a customizable gui with no limitation
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

-- gui_factory
if dokun then
    gui_factory = Factory:new()
end

if (dokun) then
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