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
	ediblestuff.make_things_edible(mod,name,scale,{
		pick=3,
		shovel=1,
		axe=3,
		sword=2,
		hoe=2 -- hoe comes with the chocolate, so we know we have it.
	})
	if minetest.get_modpath("3d_armor") ~= nil then
		ediblestuff.make_things_edible(mod,name,scale,{
			helmet=5,
			chestplate=8,
			leggings=7,
			boots=4,
		})
		-- Ok, so apparently this idea for chocolate armor wasn't super original. May as well play nice.
		local moarmour = minetest.get_modpath("moarmour")
		for _,elm in pairs({
			"helmet",
			"chestplate",
			"leggings",
			"boots"
		}) do
			local elm_name=mod..":"..elm.."_"..name
			-- Seperatly register armor as one that you can eat while wearing
			ediblestuff.edible_while_wearing[elm_name] = true
			if moarmour then
				local moarmour_name = "moarmour:"..elm.."_chocolate"
				minetest.register_alias_force(elm_name,moarmour_name)
				ediblestuff.make_thing_edible(moarmour_name,ediblestuff.satiates[elm_name])
				ediblestuff.edible_while_wearing[moarmour_name] = true
			end
		end
		if minetest.get_modpath("shields") ~= nil then
			local shield_item_name = mod..":shield_"..name
			ediblestuff.make_thing_edible(shield_item_name,scale*7)
			ediblestuff.edible_while_wearing[shield_item_name] = true
			if moarmour then
				local moarmour_name = "moarmour:shield_chocolate"
				minetest.register_alias_force(shield_item_name,moarmour_name)
				ediblestuff.make_thing_edible(moarmour_name,ediblestuff.satiates[shield_item_name])
				ediblestuff.edible_while_wearing[moarmour_name] = true
			end
		end
	end
end
