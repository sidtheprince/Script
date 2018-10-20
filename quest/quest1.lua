
-- quest1.lua
quest1 = Quest.new()
quest1:set_name("A New Beginning")
quest1:set_giver(nil)
quest1:set_require(1)
quest1:set_objective("Find Don so he may teach you the basics.")
quest1:set_target(don)
quest1:set_status(0);
quest1:set_repeatable(false)