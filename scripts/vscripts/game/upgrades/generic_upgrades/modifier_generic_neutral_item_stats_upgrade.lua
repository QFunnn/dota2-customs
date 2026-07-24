--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_neutral_item_stats_upgrade = modifier_generic_neutral_item_stats_upgrade or class(modifier_base_generic_upgrade)

local ignored_item_special_values = {
	item_fallen_sky 			= {land_time = true, burn_interval = true, blink_damage_cooldown = true},
	item_ninja_gear 			= {visibility_radius = true },
	
	item_witless_shako 			= {max_mana = true},
	item_force_boots 			= {push_duration = true},
	item_mirror_shield 			= {block_cooldown = true},
	item_bullwhip 				= {bullwhip_delay_time = true},
	item_stormcrafter 			= {interval = true},
	item_nether_shawl 			= {bonus_armor = true },
	item_misericorde 			= {missing_hp = true },
	item_spy_gadget				= {scan_cooldown_reduction = true},
	item_havoc_hammer			= {angle = true},
	item_eye_of_the_vizier		= {mana_reduction_pct = true},
	item_dagger_of_ristul		= {health_sacrifice = true},
	item_ogre_seal_totem		= {leap_distance = true},
	item_book_of_shadows		= {duration = true},
	item_unstable_wand			= {duration = true},
	item_spell_prism			= {bonus_cooldown = true},
	item_quickening_charm		= {bonus_cooldown = true},
	item_spark_of_courage		= {health_pct = true},
	item_defiant_shell			= {counter_cooldown = true},
	item_philosophers_stone		= {bonus_damage = true},
	item_vampire_fangs			= {creep_lifesteal_reduction_pct = true},
	item_doubloon				= {conversion_pct = true},
	item_nemesis_curse			= {debuff_enemy_duration = true, debuff_self = true},
	item_craggy_coat			= {active_duration = true, move_speed = true},
	item_ancient_guardian		= {radius = true},
	item_avianas_feather		= {flight_threshold = true},
	item_rattlecage				= {damage_threshold = true, target_count = true},
	item_unwavering_condition	= {magic_resist = true},
	item_panic_button			= {health_threshold = true},
	item_safety_bubble			= {restore_time = true},
	item_royal_jelly			= {use_cooldown = true, AbilityChargeRestoreTime = true},
	item_light_collector		= {radius = true, penalty = true},
}

local ignored_generic_values = {
	["AbilityChannelTime"] = true,
	["AbilityCooldown"] = true,
	["AbilityManaCost"]	= true,
}

function modifier_generic_neutral_item_stats_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("neutral_item_stats")

	if IsClient() then return end

	local parent = self:GetParent()
	local item = parent:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)

	if item then
		item:OnUnequip()
		item:OnEquip()
	end
end

function modifier_generic_neutral_item_stats_upgrade:OnCreated()
	self.neutral_list = {}

	local neutralItemKV = LoadKeyValues("scripts/npc/neutral_items.txt")
	for neutralTier, levelData in pairs(neutralItemKV) do
		if levelData and type(levelData) == "table" then
			for key,data in pairs(levelData) do
				if key =="items" then
					for item_name, _ in pairs(data) do
						-- In case the balance gods require that we separate the bonus per tier, so be it
						self.neutral_list[item_name] = tonumber(neutralTier)
					end
				end
			end
		end
	end

	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_neutral_item_stats_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_neutral_item_stats_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_generic_neutral_item_stats_upgrade:GetModifierOverrideAbilitySpecial(keys)
	local ability_name = keys.ability:GetAbilityName()
	if keys.ability and self.neutral_list and self.neutral_list[ability_name]
	and not (ignored_item_special_values[ability_name] and ignored_item_special_values[ability_name][keys.ability_special_value])
	and (not ignored_generic_values[keys.ability_special_value]) then
		return 1
	end

	return 0
end

function modifier_generic_neutral_item_stats_upgrade:GetModifierOverrideAbilitySpecialValue(keys)
	local value = keys.ability:GetLevelSpecialValueNoOverride(keys.ability_special_value, keys.ability_special_level)

	return value * (1 + 0.01 * self.bonus)
end

function modifier_generic_neutral_item_stats_upgrade:OnAttackLanded(keys)
	if not IsServer() then return end

	local parent = self:GetParent()
	if parent ~= keys.attacker then return end
	if not parent:HasModifier("modifier_item_heavy_blade") then return end

	local target = keys.target

	if parent:IsRealHero() and parent:GetTeam() ~= target:GetTeam() and target.GetMaxMana and target:GetMaxMana() and target:GetMaxMana() > 1 then
		-- take 4% of max mana and multiply by 0.85
		-- the vanila witchbane damage is already applied
		local damage = target:GetMaxMana() * 0.04 * 0.01 * self.bonus
		ApplyDamage({
			victim = target,
			attacker = parent,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
		})
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, target, damage, nil)
	end
end