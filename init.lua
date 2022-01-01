local chocolatestuff = {}  -- If this is ever needed by another mod, move the needed functions to an api mod, and have this and the other both point to the api
chocolatestuff.satiates = {}  -- How much does an armor item satiate when equipped?
chocolatestuff.make_thing_edible = function(item,amount)
	minetest.override_item(item, {
		on_use = minetest.item_eat(amount),
	})
	chocolatestuff.satiates[item] = amount
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
if minetest.get_modpath("stamina") then
	if stamina.settings ~= nil then
		-- For minetest-mods/stamina
		chocolatestuff.get_max_hunger = function ()
			return stamina.settings.visual_max
		end
	else
	    -- works for TenPlus1 and sofar
		chocolatestuff.get_max_hunger = function ()
			return STAMINA_VISUAL_MAX
		end
	end
	chocolatestuff.get_hunger = function (player)
		local meta = player:get_meta()
		local amount = meta:get_string("stamina:level")
		if not amount then return end
		return tonumber(amount)
	end
	chocolatestuff.alter_hunger = stamina.change
elseif minetest.get_modpath("hbhunger") then
	chocolatestuff.get_max_hunger = function ()
		return hbhunger.SAT_MAX
	end
	chocolatestuff.get_hunger = function (player)
		return hbhunger.get_hunger_raw(player)
	end
	chocolatestuff.alter_hunger = function (player, amount)
		local name = player:get_player_name()
		hbhunger.hunger[name] = hbhunger.hunger[name] + amount
		hbhunger.set_hunger_raw(player)
	end
elseif minetest.get_modpath("hunger_ng") then
	chocolatestuff.get_max_hunger = function (player)
		local info = hunger_ng.get_hunger_information(player:get_player_name())
		if info.invalid then return end
		return info.maximum.hunger
	end
	chocolatestuff.get_hunger = function (player)
		local info = hunger_ng.get_hunger_information(player:get_player_name())
		if info.invalid then return end
		return info.hunger.exact
	end
	chocolatestuff.alter_hunger = function (player, amount)
		hunger_ng.alter_hunger(player:get_player_name(),amount)
	end
else
	-- No known hunger mod. Use hp instead.
	minetest.log("info","chocolatestuff: no known hunger mod. using hp for armor hunger filling instead")
	chocolatestuff.get_max_hunger = function (player)
		return player:get_properties().hp_max
	end
	chocolatestuff.get_hunger = function (player)
		return player:get_hp()
	end
	chocolatestuff.alter_hunger = function (player, amount)
		player:set_hp(player:get_hp()+amount)
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
		chocolatestuff.equipped = {}
		-- TODO FIX UPSTREAM. This is only needed bc instant_ores doesn't do this correctly
		local function buggy_armor_search_workaround(elms)
			for _,elm in pairs(elms) do
				if elm:find("chocolatestuff:") == 1 then
					return true
				end
			end
			return false
		end
		-- check if they have the armor equipped.
		local function delayed_armor_check(pname)
			return function ()
				local player=minetest.get_player_by_name(pname)
				-- this can fail inside register_on_joinplayer.
				local elms=armor:get_weared_armor_elements(player)
				if elms == nil then
					-- If it does fail, wait another second (it's possible to get into an infinite loop here...)
					minetest.log("info", "chocolatestuff: armor check was delayed...")
					minetest.after(1, delayed_armor_check(pname))
					return
				end
				if elms.chocolate ~= nil or buggy_armor_search_workaround(elms) then
					chocolatestuff.equipped[pname] = true
				else
					chocolatestuff.equipped[pname] = nil
				end
			end
		end
		local function armor_check_event(player)
			-- We don't know if the reference to player is still valid after the delay(s). Just pass the name.
			minetest.after(0, delayed_armor_check(player:get_player_name()))
		end
		minetest.register_on_joinplayer(armor_check_event)
		armor:register_on_equip(armor_check_event)
		armor:register_on_unequip(armor_check_event)
		armor:register_on_destroy(armor_check_event)
		minetest.register_globalstep(function()
			-- Instead of iterating over every player, only iterate over players we know have chocolatestuff equipped
			for pname,_ in pairs(chocolatestuff.equipped) do
				local player=minetest.get_player_by_name(pname)
				local n, armor_inv = armor:get_valid_player(player,"[chocolatestuff register_globalstep]")
				if n then
					local hunger_max = chocolatestuff.get_max_hunger(player)
					local hunger_ratio = (hunger_max - chocolatestuff.get_hunger(player))/hunger_max
					if hunger_ratio >= .15 then -- TODO make this a setting
						local inv_list = armor_inv:get_list("armor")
						local list = {}
						for i,slot in ipairs(inv_list) do
							if slot:get_count() > 0 then
								list[#list+1] = {slot, i}
							end
						end
						local victim_armor_tuple = list[math.random(#list)]
						local victim_armor, index = victim_armor_tuple[1], victim_armor_tuple[2]
						local armor_max = 65535 -- largest possible tool durability
						local durability_ratio = (armor_max - victim_armor:get_wear())/armor_max
						local item_satiates = chocolatestuff.satiates[victim_armor:get_name()]
						if not item_satiates then
							item_satiates = hunger_max
						end
						local possible_satiation = math.min(hunger_ratio,durability_ratio)
						chocolatestuff.alter_hunger(player,possible_satiation*item_satiates)
						armor:damage(player,index,victim_armor,possible_satiation*armor_max)
						minetest.chat_send_player(pname,"You ate "..math.ceil(possible_satiation*100).."% of a random equipped chocolate armor piece.")
						if hunger_ratio >= durability_ratio then
							local old_armor=ItemStack(victim_armor)
							victim_armor:take_item()
							armor:set_inventory_stack(player,index,victim_armor)
							armor:run_callbacks("on_unequip",player,index,old_armor)
							armor:run_callbacks("on_destroy",player,index,old_armor)
							armor:set_player_armor(player)
						end
					end
				else
					chocolatestuff.equipped[pname]=nil
				end
			end
		end)
	end
end
