
ID_GLOBAL = 0
ID_LOCAL  = 1

ERROR = nil
SUCCESS = 0


PLAYER_ID =0
MONSTER_ID =0
NPC_ID =0
ITEM_ID = 0
MAGIC_ID =0
PET_ID =0
NPC_ID =0
SHOP_ID =0
WORLD_ID =0
CAMERA_ID =0

MAX_NUM_RANKT = 0 -- rank titles
MAX_NUM_BAGSLOT = 0
MAX_NUM_QUEST = 0


EQSLOT_HEAD = 0
EQSLOT_BODY = 1
EQSLOT_MAINHAND = 2 -- weapon
EQSLOT_ASSISTANCE = 3 -- ammo, or shield
EQSLOT_POWERUP1 =4
EQSLOT_POWERUP2 =5
EQSLOT_HAND =6
EQSLOT_LEG =7
EQSLOT_FEET =8
EQSLOT_BACK =9
EQSLOT_RIDE =10
EQSLOT_BADGE = 11
EQSLOT_UNSPECIFIED = 12

-- Item type
ITEM_TGENERAL = "General"; 
ITEM_TEQUIPMENT = "Equipment"; 
ITEM_TQUEST_ITEM = "Quest"; 
ITEM_TMATERIAL = "Material";
ITEM_TQUEST = ITEM_TQUEST_ITEM
-- Common, Normal, Rare, Unique
-- Item rarity
ITEM_RCOMMON = "Common"
ITEM_RNORMAL = "Normal"
ITEM_RRARE = "Rare"
ITEM_RUNIQUE = "Unique"
-- Item subtype
ITEM_STPOWERUP = "Power-Up"
ITEM_STNONE = "No Type";
ITEM_STMISC = "Miscellaneous"; 
ITEM_STPET = "Pet"; 
ITEM_STEGG = ITEM_TPET;
ITEM_STMONEY = "Currency"; 
ITEM_STRIDE = "Mount"; 
ITEM_STOUTFIT = "Outfit";
ITEM_STSCROLL = "Scroll";

ITEM_TSUB_BLASTER=""
ITEM_TSUB_SMASHER=""
ITEM_TSUB_EXPLOSIVE=""

ITEM_TSEMIMATERIAL = "Semi-Material"

ITEM_OBTMETHOD_ONCOLLISION = 0
ITEM_OBTMETHOD_ONPICKUP = 1
ITEM_OBTMETHOD_ONKILL = 2

MONSTER_TNORMAL = 0
MONSTER_TBOSS = 1

-- types
NORMAL = "Normal" or 0
BOSS = "Boss" or 1
-- states
PASSIVE = "Passive" or 0
AGGRESSIVE = "Aggressive" or 1


MONSTER_SDEAD = 0
MONSTER_SALIVE = 0

MONSTER_AGGRO = 0--
MONSTER_FRIENDLY = 1


MONSTER_KFLY = 0--
MONSTER_KGROUND = 0--


MONSTER_ELEMENT_WATER =0


-- monsters can only have 2 skills aside from their basic attacking
MONSTER_MAX_SKILL = 2

SPELL_USAGE_ASSIST=0--
SPELL_USAGE_OFFENSE=1
SPELL_USAGE_WEAKEN=2


NORTHT=0
EAST =1
SOUTH=2
WEST=3
SOUTHWEST=4
SOUTHEAST=5
NORTHWEST=6
NORTHEAST=7


WORLD_TYPE_NO_PVP=0
WORLD_TYPE_PVP=1
WORLD_TYPE_PVP_ENFORCED=2




GENERAL    = "General"
EQUIPMENT  = "Equipment"
QUEST_ITEM = "Quest"
MATERIAL   = "Material"

GENERAL_ITEM = "General"

ITEM_TQUEST = QUEST_ITEM;
----------------------
-- Item Subtypes
POWER_UP = "Power-Up"; 
OTHER = "Other"; 
UNKNOWN = OTHER;
MISC = "Miscellaneous"; 
PET = "Pet"; EGG = PET;
MONEY = "Currency"; 
RIDE = "Mount"; 
OUTFIT = "Outfit";
SCROLL = "Scroll";
BLASTER = "Blaster"; 
SMASHER = "Smasher";
EXPLOSIVE = "Explosive";
-------
HEAD = 1; -- HELMET
BODY = 2  -- ARMOR
MAIN_HAND = 3 -- WEAPON
ASSISTANT = 4 -- ARROW, SHIELD
LEG = 5 -- PANTS
HAND = 6 -- GLOVE
FEET = 7 -- BOOTS
BACK = 8
RIDE = 9

WEAPON = MAIN_HAND
AMMO_SHIELD = ASSISTANT
-------


SLOTP_HEAD=""
SLOTP_BODY=""
SLOTP_WEAPON=""
SLOTP_AMMO_SHIELD=""
SLOTP_POWERUP1=""
SLOTP_POWERUP2=""
SLOTP_LEG=""
SLOTP_FEET=""
SLOTP_RIDE=""
SLOTP_BADGE=""
SLOTP_UNSPECIFIED=""


SEPTUM = "Septum"; 
CAPSULE = "Capsule"; -- attack power
ORB = "Orb"; -- magic power and mana
DURA = "Dura"; -- duration
VOLTON = "Volton"; 
GARSE = "Garse"; 
TECHDRON = "Techdron" -- robot enhancements

MATERIAL = "Material" -- material(ex. ore)
SEMI_MATERIAL = "Semi-Material" -- semi-material(ex.bar - made from ore)
PRODUCT = "Product" -- product(ex. gold_sword - made from a gold bar)

----------------------

NO_PRICE = 0;
NO_REQUIRE = 0;
NO_EFFECT = 0;

----------------------

random_pet = {
 pluff, s_pluff
}


IDLE_ANIM=0
ATTACK_ANIM_MELEE =1 
ATTACK_ANIM_SPELL =2
HURT_ANIM=3
DEATH_ANIM=4



OPT_TTALK = 0
OPT_TQUEST = 1
OPT_TLEAVE = 2


QUEST_TCOMBAT = 0
QUEST_TDELIVERY = 1
QUEST_TCOLLECT = 2
QUEST_TLOCATE = 3
QUEST_TESCORT = 4
QUEST_TACHIEVE = 5
QUEST_TCRAFT = 6
QUEST_TEVENT = 7
-----------------------
NOT_AVAILABLE = 0
AVAILABLE     = 1
IN_PROGRESS   = 2 
COMPLETED     = 3 
------------------------
HORIZONTAL = 0
VERTICAL   = 1
------------------------


-- OWNERS MUST BE NPCS

GENERAL_SHOP = "GENERAL SHOP"
WEAPON_SHOP = "WEAPON SHOP"
ARMOR_SHOP = "ARMOUR SHOP"

MAGIC_SHOP = "MAGIC SHOP"

BARBER_SHOP = "BARBER SHOP"
PET_SHOP = "PET SHOP"

BOOK_SHOP = "Book Shop"
ANTIQUE_SHOP = "VALUABLE AND OLD SHIT"
BOUTIQUE = "" -- SELL FASHIONABLE CLOTHING
POTION_SHOP = "Potion Shop"
DEPARTMENT_STORE = ""
DAIRY_SHOP = "DAIRY SHOP"
AIR_STATION = "AIR STATION"
GARAGE = "GARAGE"
GARDEN_SHOP = "GARDEN SHOP"
GARDEN_CENTRE = GARDEN_SHOP
CLOCKWORKS = "CLOCKWORKS"
GIFT_SHOP = "GIFT SHOP"
HARDWARE_SHOP = ""
IRONMONGER = "" -- SHOP THAT SELLS TOOL AND METALS
JUNK_SHOP = "JUNK SHOP"
MEGA_STORE = ""
NEWSPAPER_STAND = "NEWSPAPER STAND" -- SELL NEWSPAPER
SALON = "" -- SELL EXPENSIVE CLOTHHING
PHARMACY = ""
CANDY_SHOP = "CANDY SHOP"
SWEET_SHOP = CANDY_SHOP
STALL = "STALL"
TRADING_POST = ""
TRADE_POST = TRADING_POST
THRIFT_SHOP = "" -- CHARITY SHOP
DRUG_STORE = ""
CLEANER = ""
STATIONER = "STATIONERY"
CARD_SHOP = "CARD SHOP"
STORAGE = "STORAGE"
BANK = STORAGE
CONFECTIONARY_SHOP = "SWEET SHOP" -- SWEETS FUDGE CANDY AND ALL THINGS SUGAR
FLORAL_SHOP = "FLORAL SHOP"
NOVELTY_SHOP = "NOVELTY SHOP" -- BUY NOVELTIES, JOKE ITEMS AND, TRICKS
LAUNDRETTE = "LAUNDRETTE"
SANDWICH_SHOP = "SANDWICH SHOP"
TOY_SHOP = "TOY SHOP"
BAKERY = "BAKERY"
FOOD_SHOP = "FOOD SHOP"
TECH_SHOP = ""
REPAIR_SHOP = "REPAIR SHOP"
VEHICLE_SHOP = ""
RIDE_SHOP = "RIDE SHOP"
MOUNT_SHOP = RIDE_SHOP
HEAL_SHOP = "HEAL SHOP"
CAFE = "CAFE AU LAIT"
RESTAURANT = "RESTAURANT"
RENTAL_SHOP = "RENTAL"
HARBOR = "HARBOR"



FIRE = "Fire"
WATER = "Water"
EARTH = "Earth"
AIR = "Wind"
NATURE = "Nature"
MIND = "Aura"
BLOOD = "Blood"
DARK = "Illusion"
LIFE = "Life"
--[[

Player = {
 name, id=0,
 level=1, exp=0, 
 health=100, mana=50,
 power=1, defense=1,
 speed=1, magic=0,
 rank, title,
 
 max_health=500,
 max_mana=350,
 
 level_cap = 150,
 
 class ="Player",
 inst=0
 }

----------------------


----------------------

rank_title = { 
 "Hero's Awakening" 
}


----------------------


equip_slot = {
 head, body,
 weapon, 
 ammo_shield, 
 power_up1, power_up,
 power_up2, 
 leg, 
 foot,
 ride,
 badge, 
 unspecified

}




----------------------------------------------------


]]--



function is_copy(object)
    local g = _G
    for _, instance in pairs(_G) do
	    if type(instance) == "table" then
		    if is_item(instance) or
			is_object(instance) or
			is_player(instance) or
			is_npc(instance) or
			is_monster(instance)
			then
                if getmetatable(object) == instance.mt then
			        return true
			    end
			end
		end
	end
	return false
end