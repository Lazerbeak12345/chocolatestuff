chocolatestuff = {}
chocolatestuff.make_thing_edible = function(item,amount)
	minetest.override_item(item, {
		on_use = minetest.item_eat(amount),
	})
	if minetest.get_modpath("hunger_ng") ~= nil then
		hunger_ng.add_hunger_data(item, {
			satiates = amount,
		})
	end
end
chocolatestuff.make_things_edible = function(mod,name,scale,items)
	for typ,amount in pairs(items) do
		chocolatestuff.make_thing_edible(mod..":"..typ.."_"..name,scale*amount)
	end
end
if farming.mod == "redo" then
	local mod = "chocolatestuff"
	local name = "chocolate"
	instant_ores.register_metal({ -- cuz eating your armor is so metal
		name = mod..":"..name,
		description = "Chocolate",
		artificial = true,  -- We don't need ores.
		power = .5, -- So weak as to crumble after but a few real uses.
		color = "#653302",  -- Color sampled from the chocolate color in the farming redo mod
	})
	minetest.register_alias_force( -- Dark chocolate sortof looks like an ingot. This is why this mod is even a thing.
		mod..":"..name.."_ingot",
		"farming:chocolate_dark"
	)
	minetest.register_alias_force(
		mod..":"..name.."block",
		"farming:chocolate_block"
	)
	local scale=2.5
	chocolatestuff.make_things_edible(mod,name,scale,{
		pick=3,
		shovel=1,
		axe=3,
		sword=2,
		hoe=2 -- hoe comes with the chocolate, so we know we have it.
	})
	if minetest.get_modpath("3d_armor") ~= nil then
		chocolatestuff.make_things_edible(mod,name,scale,{
			helmet=5,
			chestplate=8,
			leggings=7,
			boots=4,
		})
		if minetest.get_modpath("shields") ~= nil then
			chocolatestuff.make_thing_edible(mod..":shield_"..name,scale*7)
		end
	end
end
