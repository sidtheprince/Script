require("player")

Class = {
    Fighter = 
	{
        warrior, lancer, swordsman, guardian, -- tanks
        assassin, samurai, ninja, -- stealth 
        archer, scout, hunter , ranger, bowman, gunner, sharpshooter, slinger, beastmaster -- ranged
    },
 
    Caster = 
	{
        summoner, wizard, shaman, magician, -- casters, elementalists
        priest, druid, cleric    -- support + healers
    },
    Other = 
	{
        bard, sage, captain, hero, scout = "information gatherers, tracking, high movement, superior sensory",
        monk
    }
}

-- non-combat 
Subclass = 
{
    smith, chef, dokuner, 
    scribe, tailor, farmer, 
    mason, squire, maid, 
    alchemist
}