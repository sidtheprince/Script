
borg = Monster.new("Borg", 2)

borg:load("monster/borg.png")
borg.max = 20

borg:scale(2, 2)
borg:set_position(Vector2(200, 500))

borg:set_name("Borg")
borg:set_level(1)
borg:set_health(203)
borg:set_max_health(203)

borg:set_item_drop(potion, 50)



function borg:on_kill( player )

    borg:drop( player )
end
