chocolatestuff = {}
local hunger_ng_path = minetest.get_modpath("hunger_ng")
chocolatestuff.make_thing_edible = function(item,amount)
	if hunger_ng_path then
		hunger_ng.add_hunger_data(item, {
			satiates = amount,
		})
		minetest.override_item(item, {
			on_use = function (items,user,thing)
				if items:get_definition()._hunger_ng then -- sometimes the add_hunger_data just doesn't work.
					return minetest.do_item_eat(amount,nil,items,user,thing)
				end
				minetest.log(
					"warn",
					"[chocolatestuff] hunger_ng.add_hunger_data didn't work! Using manual hunger modification."
				)
				local player_name=user:get_player_name()
				local hbefore=hunger_ng.get_hunger_information(player_name)
				hunger_ng.alter_hunger(
					player_name,
					amount,
					"hunger_ng.add_hunger_data didn't work. Manual adjustment."
				)
				local hafter=hunger_ng.get_hunger_information(player_name)
				if (not hbefore.invalid)
				and (not hafter.invalid)
				and hafter.hunger.exact ~= hbefore.hunger.exact
				then
					items:take_item()
					return items
				end
				-- NOTE silently fails if player_name == "" or hbefore.invalid or hafter.invalid
			end
		})
	else
		minetest.override_item(item, {
			on_use = minetest.item_eat(amount),
		})
	end
end
chocolatestuff.make_things_edible = function(mod,name,scale,items)
	for typ,amount in pairs(items) do
		chocolatestuff.make_thing_edible(mod..":"..typ.."_"..name,scale*amount)
	end
end
if farming.mod and farming.mod == "redo" then
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
	if minetest.get_modpath("3d_armor") then
		chocolatestuff.make_things_edible(mod,name,scale,{
			helmet=5,
			chestplate=8,
			leggings=7,
			boots=4,
		})
		if minetest.get_modpath("shields") then
			chocolatestuff.make_thing_edible(mod..":shield_"..name,2.5*7)
		end
	end
end
