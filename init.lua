local scale=2.5
if minetest.get_modpath("farming") ~= nil and farming.mod == "redo" then
	minetest.register_alias_force( -- Dark chocolate sortof looks like an ingot. This is why this mod is even a thing.
		"chocolatestuff:chocolate_ingot",
		"farming:chocolate_dark"
	)
	minetest.register_alias_force(
		"chocolatestuff:chocolateblock",
		"farming:chocolate_block"
	)
elseif minetest.get_modpath("mtfoods") ~= nil then
	scale=1.5 -- mtfoods:chocolate doesn't satiate as much as farming:chocolate_dark
	minetest.register_alias_force(
		"chocolatestuff:chocolate_ingot",
		"mtfoods:chocolate"
	)
elseif minetest.get_modpath("food_basic") ~= nil then
	minetest.register_alias_force(
		"chocolatestuff:chocolate_ingot",
		"foods:dark_chocolate"
	)
elseif minetest.get_modpath("mcl_morefood") ~= nil then
	scale=5.5  -- Chocolate in this mod is very filling
	minetest.register_alias_force(
		"chocolatestuff:chocolate_ingot",
		"mcl_morefood:chocolate_dark"
	)
else
	minetest.log("info","chocolatestuff: could not find source for chocolate. Chocolate armor will not be obtainable in survival.")
end
instant_ores.register_metal({ -- cuz eating your armor is so metal
	name = "chocolatestuff:chocolate",
	description = "Chocolate",
	artificial = true,  -- We don't need ores.
	power = .5, -- So weak as to crumble after but a few real uses.
	color = "#653302",  -- Color sampled from the chocolate color in the farming redo mod
})
ediblestuff.make_tools_edible("chocolatestuff","chocolate",scale)
if minetest.get_modpath("3d_armor") == nil then return end
ediblestuff.make_armor_edible_while_wearing("chocolatestuff","chocolate",scale)
-- Ok, so apparently this idea for chocolate armor wasn't super original. May as well play nice.
local made_aliases = false
for _,armormod in ipairs{"moarmour","armor_addon"} do
	if minetest.get_modpath(armormod) then
		ediblestuff.make_armor_edible_while_wearing(armormod,"chocolate",scale)
		if made_aliases then break end
		made_aliases = true
		minetest.register_alias_force("chocolatestuff:helmet_chocolate",    armormod..":helmet_chocolate")
		minetest.register_alias_force("chocolatestuff:chestplate_chocolate",armormod..":chestplate_chocolate")
		minetest.register_alias_force("chocolatestuff:leggings_chocolate",  armormod..":leggings_chocolate")
		minetest.register_alias_force("chocolatestuff:boots_chocolate",     armormod..":boots_chocolate")
		if minetest.get_modpath("shields") ~= nil then
			minetest.register_alias_force("chocolatestuff:shield_chocolate",armormod..":shield_chocolate")
		end
	end
end
-- If neither of the other mods are present...
if not made_aliases then
	minetest.register_alias_force("moarmour:helmet_chocolate",       "chocolatestuff:helmet_chocolate")
	minetest.register_alias_force("moarmour:chestplate_chocolate",   "chocolatestuff:chestplate_chocolate")
	minetest.register_alias_force("moarmour:leggings_chocolate",     "chocolatestuff:leggings_chocolate")
	minetest.register_alias_force("moarmour:boots_chocolate",        "chocolatestuff:boots_chocolate")
	minetest.register_alias_force("armor_addon:helmet_chocolate",    "chocolatestuff:helmet_chocolate")
	minetest.register_alias_force("armor_addon:chestplate_chocolate","chocolatestuff:chestplate_chocolate")
	minetest.register_alias_force("armor_addon:leggings_chocolate",  "chocolatestuff:leggings_chocolate")
	minetest.register_alias_force("armor_addon:boots_chocolate",     "chocolatestuff:boots_chocolate")
	if minetest.get_modpath("shields") ~= nil then
		minetest.register_alias_force("moarmour:shield_chocolate",   "chocolatestuff:shield_chocolate")
		minetest.register_alias_force("armor_addon:shield_chocolate","chocolatestuff:shield_chocolate")
	end
end
