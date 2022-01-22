if farming.mod ~= "redo" then return end
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
ediblestuff.make_tools_edible(mod,name,scale)
if minetest.get_modpath("3d_armor") == nil then return end
ediblestuff.make_armor_edible_while_wearing(mod,name,scale)
-- Ok, so apparently this idea for chocolate armor wasn't super original. May as well play nice.
local made_aliases = false
for _,armormod in ipairs{"moarmour","armor_addon"} do
	if minetest.get_modpath(armormod) then
		ediblestuff.make_armor_edible_while_wearing(armormod,name,scale)
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
