
function login()
end

--[[
Menu = { 
 options = {} 
}



function Menu.new(options) 
 local menu

 
 setmetatable(menu, {__index=Menu})
 return menu
end



esc_menu = Menu.new()

esc_menu[1] = "Change Keys"
esc_menu[2] = ""
esc_menu[3] = ""
esc_menu[4] = ""
esc_menu[5] = ""
esc_menu[6] = ""
esc_menu[7] = ""
esc_menu[8] = "Exit Game"
esc_menu[9] = ""
esc_menu[10] = ""
esc_menu[11] = ""
esc_menu[12] = ""

settings = Menu.new()
setting[1] = {
 name = "General"
 
 DISPLAY_MODE = FULL_SCREEN
 SCREEN_RESOLUTION = (1028 * 1028)
 
 VIDEO_QUALITY = "VERY LOW" or "LOW" or "HIGH" or "VERY HIGH" or "MEDIUM"
}

settings[2] = { 
 name = "Sound"

 MAIN_SOUND = 100
 BACKGROUND_SOUND = 100
 SOUND_EFFECT = 100
 NPC_VOICE = 100
}

setting[3] = {
 name = "Graphics"

 SHADOW = true
 ligtning = true
 CAMERA = "FIXED"
}

setting[4] = {
 name = "Input"

 CONTROLS = { UP = "W" DOWN = "S" LEFT = "A" RIGHT = "D" JUMP = "SPACEBAR" FIGHT = "CTRL"}
 MOUSE_CONTROLS = { }
}



-- game settings + options


ON = true
OFF  = false

ENABLED = ON
DISABLED = OFF

PICK_UP = "PICK_UP"
COLLISION = "COLLISION"



Settings = {
-- preference

 
  obtain_method = "PICK_UP";
 
 

  FRIEND_REQUEST = ON, 
  PARTY_INVITE = ON, 
  GUILD_INVITE = ON, 
  DUEL_REQUEST = ON,
 

 auto_attack = ON;
 filter_chat = OFF;
 
 
 cross_hair = ON;
 
 mini_map_zoom = 100;
 
 
 hide_hud = OFF;
 
 show_tips = ON;
 
cursor_speed = 100;
 aim_sensitivity = 100;
 
 refresh_rate = 60;
 
 fps = 60;

 water_reflection = ON;
 
 
 camera_shake = ON;
 
 -- for my deaf people
 subtitle = ENABLED;
 subtitle_language = "ENGLISH";
 
 -- movie(video)
 
 cinematics = ON;
 widescreen = ON; -- Aspect Ratios: Widescreen(Letterbox) - the black bars , Pan and Scan
 -- system messages
  combat_damage_text = ON;
 
 game_start_animation = "game_start.mp4";
 ----
 
 shadows = ON;
 
 
 
 
 
 -- graphics
 
 mode = "FULL_SCREEN";
 w, h = vec2D(1024, 768); -- 640x480 800x600 1280x1024 1600x1200 Resolutions
 

 quality = "MID" ; -- LOW HIGH MID VERY_LOW VERY_HIGH
 driver = "OPENGL"; -- DIRECTX
 
 view = "THIRD_PERSON"; -- FIRST_PERSON(cannot see yourself, but what's in front of you), THIRD_PERSON(can see your whole body)
 
 brightness = 50;
 
 
 ------------
 
 
 
 
 -- audio
 npc = 100;
 music = 100;
 background = 100;
 sound_effect = 100;
 ui_sound = 100;
 
 ambient_sound = 50;
 
 enable_audio = true; -- mute = OFF
 voice_chat = OFF;
 
 npc_voice = ON;


 -- controls
 zoom = "MIDDLE_MOUSE";
 pick_up = "";
 jump = "SPACEBAR";
 kick = "RIGHT_MOUSE";
 attack = "LEFT_MOUSE";
 crouch = "";
 
 move_foward = "KEY_UP";
 move_back ="KEY_DOWN";
 move_left = "KEY_LEFT";
 move_right = "KEY_RIGHT";
 
 rotate_camera = "RIGHT_MOUSE + MOUSE_MOVE";
screen_shot = "PRTSC";

chat_mode = "ENTER";

menu = "ESC";




-- camera
auto_camera = OFF;


-- user interface
show_player_names = ON;
show_npc_names = ON;

show_monster_names = ON;

window_visibility = "TRANSPARENT"; -- SOLID
  
 -- game
 on_gamestart_text = "Welcome Back";
 
 quit_game = false;
 
}



function Settings.setItemObtainMethod() end

function Settings.enable() end
function Settings.disable() end
]]--
