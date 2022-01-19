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
if minetest.get_modpath("3d_armor") ~= nil then
	ediblestuff.make_armor_edible_while_wearing(mod,name,scale)
	-- Ok, so apparently this idea for chocolate armor wasn't super original. May as well play nice.
	local made_aliases = false
	for _,armormod in ipairs{"moarmour","armor_addon"} do
		if minetest.get_modpath(armormod) then
			ediblestuff.make_armor_edible_while_wearing(armormod,name,scale)
			if made_aliases then break end
			made_aliases = true
			for _,elm in pairs({
				"helmet",
				"chestplate",
				"leggings",
				"boots"
			}) do
				minetest.register_alias_force(mod..":"..elm.."_"..name,armormod..":"..elm.."_chocolate")
			end
			if minetest.get_modpath("shields") ~= nil then
				minetest.register_alias_force(mod..":shield_"..name,armormod..":shield_chocolate")
			end
		end
	end
end
