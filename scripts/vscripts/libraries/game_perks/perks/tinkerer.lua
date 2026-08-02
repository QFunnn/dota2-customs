--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

-- Updated 7.41
local ignored_special_values = {
	-- Tier 1
	item_occult_bracelet = {},
	item_kobold_cup = {},
	item_chipped_vest = {},
	item_polliwog_charm = {},
	item_dormant_curio = {},
	item_duelist_gloves = {},
	item_weighted_dice = {},
	item_ash_legion_shield = {},
	item_dagger_of_ristul = { AbilityHealthCost = true },
	item_stonefeather_satchel = {},
	item_possessed_mask = {},
	item_foragers_kit = {
		radius = true,
		tree_radius = true,
		tree_creation_interval = true,
		max_trees = true,
		old_destroy_radius = true,
	},

	-- Foragers Kit Items
	item_foragers_health = {},
	item_foragers_stats = {},
	item_foragers_mana = {},

	-- Tier 2
	item_essence_ring = {},
	item_mana_draught = { water_acceleration = true },
	item_poor_mans_shield = {},
	item_searing_signet = { damage_threshold = true, burn_duration = true, burn_tickrate = true },
	item_pogo_stick = {},
	item_defiant_shell = { counter_cooldown = true },
	item_crippling_crossbow = {},
	item_medallion_of_courage = {},
	item_seeds_of_serenity = {},

	-- Tier 3
	item_serrated_shiv = {},
	item_gunpowder_gauntlets = {},
	item_jidi_pollen_bag = { damage_interval = true },
	item_psychic_headband = {},
	item_unrelenting_eye = { hero_reduction = true, hero_check_radius = true },
	item_cloak_of_flames = {},
	item_spellslinger = { duration = true, restore_tickrate = true },
	item_stormcrafter = { interval = true },
	item_partisans_brand = {},

	-- Tier 4
	item_giant_maul = {},
	item_rattlecage = { damage_threshold = true, target_count = true },
	item_idol_of_screeauk = {},
	item_flayers_bota = {},
	item_metamorphic_mandible = { size_decrease = true, armor_decrease = true },
	item_dandelion_amulet = {},
	item_enchanters_bauble = {},
	item_prophets_pendulum = { delay_time = true, damage_interval = true },
	item_conjurers_catalyst = { damage_threshold = true },

	-- Tier 5
	item_desolator_2 = {},
	item_fallen_sky = {
		land_time = true,
		burn_interval = true,
		blink_damage_cooldown = true,
		burn_duration = true,
		stun_duration = true,
	},
	item_demonicon = {},
	item_minotaur_horn = {},
	item_spider_legs = {},
	item_riftshadow_prism = { health_cost = true },
	item_dezun_bloodrite = { health_pct = true },
	item_divine_regalia = {},
	item_harmonizer = {},
	item_heavy_blade = {},

	-- Cycled Out
	item_outworld_staff = { self_dmg_pct = true },
	item_witless_shako = { max_mana = true },
	item_force_boots = { push_duration = true },
	item_mirror_shield = { block_cooldown = true },
	item_bullwhip = { bullwhip_delay_time = true },
	item_nether_shawl = { bonus_armor = true },
	item_misericorde = { missing_hp = true },
	item_spy_gadget = { scan_cooldown_reduction = true },
	item_havoc_hammer = { angle = true },
	item_eye_of_the_vizier = { mana_reduction_pct = true },
	item_ogre_seal_totem = { leap_distance = true },
	item_book_of_shadows = { duration = true },
	item_unstable_wand = { duration = true },
	item_spell_prism = { bonus_cooldown = true },
	item_quickening_charm = { bonus_cooldown = true },
	item_spark_of_courage = { health_pct = true },
	item_philosophers_stone = { bonus_damage = true },
	item_vampire_fangs = { creep_lifesteal_reduction_pct = true },
	item_doubloon = { conversion_pct = true },
	item_nemesis_curse = { debuff_enemy_duration = true, debuff_self = true },
	item_craggy_coat = { active_duration = true, move_speed = true },
	item_ancient_guardian = { radius = true },
	item_avianas_feather = { flight_threshold = true },
	item_unwavering_condition = { magic_resist = true },
	item_panic_button = { health_threshold = true },
	item_safety_bubble = { restore_time = true },
	item_royal_jelly = { use_cooldown = true, AbilityChargeRestoreTime = true },
	item_light_collector = { radius = true, penalty = true },
	item_iron_talon = { alternative_cooldown = true, creep_damage_pct = true },
	item_gale_guard = { barrier_pct = true },
	item_whisper_of_the_dread = { vision_penalty = true },
	item_magnifying_monocle = { damage_threshold = true, damage_disable = true },
	item_pirate_hat = { gold_loss_reduction = true },
	item_sisters_shroud = { hp_threshold = true, evasion_loss = true },
	item_ninja_gear = { visibility_radius = true },
	item_dragon_scale = { duration = true },

	-- Enchantments
	item_enhancement_keen_eyed = { mana_reduction_pct = true },
	item_enhancement_greedy = { bonus_damage = true },
	item_enhancement_crude = { intelligence_pct = true },
	item_enhancement_feverish = { cost_increase = true },
	item_enhancement_audacious = { incoming_damage = true },
	item_enhancement_nimble = { hp_regen_reduce = true },
	item_enhancement_titanic = { attack_speed = true },
	item_enhancement_hulking = { attack_speed = true },
	item_enhancement_manic = { vision_reduce = true },
}

local ignored_special_values_common = {
	AbilityCooldown = true,
	AbilityManaCost = true,
	AbilityChannelTime = true,
	AbilityCharges = true,
}

tinkerer = class(base_game_perk)
function tinkerer:__OnCreated()
	self.items_multiplier = 1 + self.bonus_pct / 100

	if IsClient() then
		return
	end

	Timers:CreateTimer(0.1, function()
		local refresh_item = function(slot_id)
			local item = self:GetParent():GetItemInSlot(slot_id)

			if item and item:GetItemState() == 1 then
				item:OnUnequip()
				item:OnEquip()
			end
		end
		refresh_item(DOTA_ITEM_NEUTRAL_ACTIVE_SLOT)
		refresh_item(DOTA_ITEM_NEUTRAL_PASSIVE_SLOT)
	end)
end
function tinkerer:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function tinkerer:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

local neutral_list = {}

local neutralItemKV = LoadKeyValues("scripts/npc/neutral_items.txt")
for _, levelData in pairs(neutralItemKV.neutral_tiers) do
	if levelData and type(levelData) == "table" then
		for key, data in pairs(levelData) do
			if key == "items" then
				for k, _ in pairs(data) do
					neutral_list[k] = true
				end
			elseif key == "enhancements" then
				for _, v in pairs(data) do
					for k, _ in pairs(v) do
						neutral_list[k] = true
					end
				end
			end

			local forager_items = { "item_foragers_health", "item_foragers_stats", "item_foragers_mana" }

			for _, forage in pairs(forager_items) do
				neutral_list[forage] = true
			end
		end
	end
end
function tinkerer:_OverrideAbilitySpecialCallback(keys, base_value, inc_callback)
	local ability_name = keys.ability:GetAbilityName()
	if
		keys.ability
		and neutral_list
		and neutral_list[ability_name]
		and not ignored_special_values_common[keys.ability_special_value]
		and not (
			ignored_special_values[ability_name] and ignored_special_values[ability_name][keys.ability_special_value]
		)
	then
		--print("VALUE: [".. keys.ability_special_value .."] : [".. base_value .."] : [" .. keys.ability:GetItemSlot() .."] result: [" .. inc_callback(base_value) .. "]")
		return inc_callback(base_value)
	end
	return base_value
end

function tinkerer:GetModifierOverrideAbilitySpecial(keys)
	return self:_OverrideAbilitySpecialCallback(keys, 0, function(_)
		return 1
	end)
end

function tinkerer:GetModifierOverrideAbilitySpecialValue(keys)
	local value = keys.ability:GetLevelSpecialValueNoOverride(keys.ability_special_value, keys.ability_special_level)
	return self:_OverrideAbilitySpecialCallback(keys, value, function(_)
		return _ * (self.items_multiplier or 1)
	end)
end

function tinkerer:OnAttackLanded(keys)
	if not IsServer() then
		return
	end

	if self.parent ~= keys.attacker then
		return
	end
	if not self.parent:HasModifier("modifier_item_heavy_blade") then
		return
	end

	local target = keys.target

	if
		self.parent:IsRealHero()
		and self.parent:GetTeam() ~= target:GetTeam()
		and target.GetMaxMana
		and target:GetMaxMana()
		and target:GetMaxMana() > 1
	then
		local damage = target:GetMaxMana() * 0.04 * (self.items_multiplier - 1)
		ApplyDamage({
			victim = target,
			attacker = self.parent,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		})
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, target, damage, nil)
	end
end