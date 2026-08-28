--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_drop = {
	{
		items = {
			"item_ring_of_protection",
			"item_magic_stick",
			"item_flask",
			"item_circlet",
			"item_gauntlets",
			"item_mantle",
			"item_slippers",
			"item_buckler",
			"item_ring_of_basilius",
			"item_chainmail",
			"item_hyperstone",
			"item_lesser_crit",
		},
	},
}

item_drop2 = {
	{
		items = {
			"item_buckler",
			"item_ring_of_basilius",
			"item_chainmail",
			"item_headdress",
			"item_lifesteal",
			"item_boots",
			"item_boots_of_elves",
			"item_blades_of_attack",
			"item_demon_edge",
			"item_moon_shard",
			"item_reaver",
			"item_mystic_staff",
		},
	},
}

item_drop3 = {
	{
		items = {
			"item_mana_plate2",
			"item_heavy_shield2",
			"item_heavy_plate2",
			"item_life_catcher2",
			"item_immune_mask2",
			"item_grave_shoulder2",
			"item_armor_of_god2",
			"item_bloody_knife2",
			"item_winter_cloak2",
			"item_hell_blade2",
			"item_talisman_of_evasion_lua2",
			"item_blasting_shot2",
			"item_doom_sword2",
			"item_doom_spear2",
			"item_gu2",
			"item_magic_boots2",
			"item_magic_amulet2",
			"item_magic_soul2",
			"item_critical_ring2",
			"item_dark_mist2",
			"item_god_tribute2",
			"item_block_shield2",
			"item_power_pendant2",
			"item_dark_stick2",
			"item_physical_immune2",
			"item_crit_blade2",
			"item_des_blade2",
			"item_universal_lua2",
			"item_mp_bag",
			"item_health_bag",
			"item_book_of_knowledge",
			"item_armor_aura",
			"item_base_damage_aura",
			"item_expiriance_aura",
			"item_move_aura",
			"item_attack_speed_aura",
			"item_hp_aura",
			"item_boss_soul",
		},
	},
}

function chest(keys)
	for _, drop in ipairs(item_drop) do
		local items = drop.items or nil
		local items_num = #items
		local item_name = items[1]
		if items_num > 1 then
			item_name = items[RandomInt(1, #items)]
		end
		local wws = keys.caster
		local new_charges = keys.ability:GetCurrentCharges() - 1
		if new_charges <= 0 then
			UTIL_Remove(keys.ability)
			keys.caster:EmitSound("DOTA_Item.InfusedRaindrop")
			local vPoint = wws:GetAbsOrigin()
			itemdrop = CreateItem(item_name, nil, nil)
			local dropRadius = RandomFloat(50, 100)
			drop = CreateItemOnPositionSync(vPoint + RandomVector(dropRadius), itemdrop)
		end
	end
end

function chest2(keys)
	for _, drop in ipairs(item_drop2) do
		local items = drop.items or nil
		local items_num = #items
		local item_name = items[1]
		if items_num > 1 then
			item_name = items[RandomInt(1, #items)]
		end
		local wws = keys.caster
		local new_charges = keys.ability:GetCurrentCharges() - 1
		if new_charges <= 0 then
			UTIL_Remove(keys.ability)
			keys.caster:EmitSound("DOTA_Item.InfusedRaindrop")
			local vPoint = wws:GetAbsOrigin()
			itemdrop = CreateItem(item_name, nil, nil)
			local dropRadius = RandomFloat(50, 100)
			drop = CreateItemOnPositionSync(vPoint + RandomVector(dropRadius), itemdrop)
		end
	end
end

function chest_d(keys)
	for _, drop in ipairs(item_drop3) do
		local items = drop.items or nil
		local items_num = #items
		local loot_duration = 10
		local item_name = items[1]
		if items_num > 1 then
			item_name = items[RandomInt(1, #items)]
		end
		local wws = keys.caster
		local new_charges = keys.ability:GetCurrentCharges() - 1
		if item_name == "item_boss_soul" then
			keys.caster:EmitSound("Item.StarEmblem.Enemy")
		else
			keys.caster:EmitSound("DOTA_Item.InfusedRaindrop")
		end
		local vPoint = wws:GetAbsOrigin()
		itemdrop = CreateItem(item_name, nil, nil)
		local dropRadius = RandomFloat(50, 100)
		drop = CreateItemOnPositionSync(vPoint + RandomVector(dropRadius), itemdrop)
		if loot_duration then
			itemdrop:SetContextThink("KillLoot", function()
				return KillLoot(itemdrop, drop)
			end, loot_duration)
		end
		if new_charges <= 0 then
			UTIL_Remove(keys.ability)
		else
			keys.ability:SetCurrentCharges(new_charges)
		end
	end
end

function KillLoot(item, drop)
	if drop:IsNull() then
		return
	end
	local nFXIndex =
		ParticleManager:CreateParticle("particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, drop)
	ParticleManager:SetParticleControl(nFXIndex, 0, drop:GetOrigin())
	ParticleManager:SetParticleControl(nFXIndex, 1, Vector(35, 35, 25))
	ParticleManager:ReleaseParticleIndex(nFXIndex)
	EmitGlobalSound("Item.PickUpWorld")
	UTIL_Remove(drop)
end