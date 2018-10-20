
--require("lmessage")

_System = {}

DISCONNECTED = 1


function onLogin() end
function onLogout() end


function message_box(text, title)
 --message(text, title)
end 


function _System.log_error(username, password)
 print("Invalid username or password! Please try again.")
end

function _System.disconnect()
 print("You have been disconnected from the server.")
 LOG:add_event("[ERROR]: Connection with the server failed.")
 LOG:save()
 end
 
 
 function _System.on_log(game)
  print("Welcome to "..game.name)
 end
 
 function screen_load_error()
  print("Error loading screen.")
 end
 

 
 function trade_request_message(player, trader)
  print(trader.name.." has invited you to a trade. Do you wish to proceed?")
  print("Accept, deny.")
 end
 
 function guild_invite_message()
  print("[] has invited you to his or her guild. Do you wish to join?")
  print("Accept, deny.")

 end
 
 function party_request_message()
  print("[] has invited you to a trade. Do you wish to proceed?")
  print("Accept, deny.")
 end
 
 function friend_request_message()
  print("[] wishes to add you as a friend. Do you wish to be his or her friend?")
  print("Accept, deny.")
 end
 
 function invalid_pin()
  print("Invalid PIN number!")
 end
 
 function valid_pin()
  print("Successfully entered your PIN number!")
 end
 
 function trade_failure()
  print("Trade failed or trade unsuccessful.")
 end
 
 function trade_success()
 
 end
 
 function wait_on_response()
  print("Waiting for the player to respond...")
 end
 
 function item_obtained()
  print("You have obtained a(n) []!")
 end
 
 function gold_obtained()
  print("Obtained # []!")
 end
 
 function low_hp()
  print("Not enough HP available.")
 end
 
 function low_mp()
  print("Not enough MP available.")
 end
 
 
 function message_received()
  print("Message has been received!")
 end
 
 function message_send_failure()
  print("Failure sending a message.")
 end
 
 function insufficient_gold()
  print("Sorry, You are unable to purchase due to low amount of currency.")
 end
 
 function bag_full()
  print("Not enough space in your Bag.")
 end
 
function battle_time()
 print("There are (#) minutes left of the battle.")
end

function level_up()
 print("Congratulations! You have been upgraded to the next level.")
end

function star_upgrade()
 print("Star Level has been upgraded!")
end

function health_restored()
 print("+(#) HP")
end

function mana_restored()
 print("+(#) MP")
end

function material_collect()
 print("Obtaining material... Please wait...")
end

function manufacturing()
 print("Manufacturing in progress..")
end

function low_level()
 print("Your level is too low.")
end

function area_restriction()
 print("Warning! You cannot enter this area.")
end

function requirement_not_reached()
 print("You do not meet the requirements to use the equipment.")
end

function chatroom_leave()
 print("[] has left the Chatroom.")
end

function defeat()
 print("You have been defeated by [].")
end

function lose_exp()
 print("You have lost (#) exp.")
end

function dead()
 print("You are now dead.")
end

function pet_dead()
 print("Your pet has died.")
end

function settings_changed()
 print("Settings and preferences have been changed successfully!")
end

function time_out()
 print("GM has sentenced you to (#) minutes of jail time due to violation of the game rules.")
end

function announcement(GM)
 print("There will be a maintenance on all servers on [day of week] [month] (day#) (year#) and itwill start from ##:##AM to ##:##PM.")
end

function guid_war_start()
 print("The war has begun!")
end

function guild_war_end()
 print("The war has ended!")
end

function territory_aquired()
 print("The territory [] has been occupied by guild [].")
end

function war_declared()
 print("Guild territorial war has been declared by guild [] against guild [].")
end


function marriage_message()
 print("Congratulations to [] and [] on their marriage. May their love grow and endure forever.")
end