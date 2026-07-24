--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_clinkz_death_pact_custom", "abilities/heroes/clinkz/death_pact", LUA_MODIFIER_MOTION_NONE)

clinkz_death_pact_custom = clinkz_death_pact_custom or class({})

function clinkz_death_pact_custom:CastFilterResultTarget(target)
	if target:GetUnitName() == "npc_dota_clinkz_skeleton_archer" then return UF_SUCCESS end

	return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS, self:GetCaster():GetTeamNumber())
end

function clinkz_death_pact_custom:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if not target or target:IsNull() then return end

	target:EmitSound("Hero_Clinkz.DeathPact")
	local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_clinkz/clinkz_death_pact.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 1, caster:GetAbsOrigin())

	local max_health = math.min(target:GetMaxHealth(), self:GetSpecialValueFor("max_health_limit"))

	-- How come it doesn't update to refresh the modifier? strange
	local current_death_pact_mod = caster:FindModifierByName("modifier_clinkz_death_pact_custom")
	if current_death_pact_mod and not current_death_pact_mod:IsNull() then
		current_death_pact_mod:Destroy()
	end

	caster:AddNewModifier(caster, self, "modifier_clinkz_death_pact_custom", {
		duration = self:GetSpecialValueFor("duration"),
		max_health = max_health,
		creep_name = target:GetUnitName(),
	})

	target:ForceKill(false)
	caster:Heal(max_health, self)
end

---

modifier_clinkz_death_pact_custom = modifier_clinkz_death_pact_custom or class({})

modifier_clinkz_death_pact_custom.neutral_creep_ability_map = {
	npc_dota_neutral_centaur_khan 				= "centaur_khan_war_stomp",
	npc_dota_neutral_dark_troll_warlord			= "dark_troll_warlord_raise_dead",
	npc_dota_neutral_fel_beast					= "fel_beast_haunt",
	npc_dota_neutral_giant_wolf					= "giant_wolf_intimidate",
	npc_dota_neutral_harpy_scout				= "harpy_scout_take_off",
	npc_dota_neutral_harpy_storm				= "harpy_storm_chain_lightning",
	npc_dota_neutral_polar_furbolg_ursa_warrior	= "polar_furbolg_ursa_warrior_thunder_clap",
	npc_dota_neutral_dark_troll					= "dark_troll_warlord_ensnare",
	npc_dota_neutral_forest_troll_high_priest	= "forest_troll_high_priest_heal",
	npc_dota_neutral_mud_golem					= "mud_golem_hurl_boulder",
	npc_dota_neutral_mud_golem_split			= "mud_golem_hurl_boulder",
	npc_dota_neutral_mud_golem_split_doom		= "mud_golem_hurl_boulder",
	npc_dota_neutral_ogre_mauler				= "ogre_bruiser_ogre_smash",
	npc_dota_neutral_ogre_magi					= "ogre_magi_frost_armor",
	npc_dota_neutral_satyr_trickster			= "satyr_trickster_purge",
	npc_dota_neutral_satyr_soulstealer			= "satyr_soulstealer_mana_burn",
	npc_dota_neutral_satyr_hellcaller			= "satyr_hellcaller_shockwave",
	npc_dota_neutral_warpine_raider				= "warpine_raider_seed_shot",
	npc_dota_neutral_wildkin					= "enraged_wildkin_tornado",
	npc_dota_neutral_enraged_wildkin			= "enraged_wildkin_hurricane"
}

modifier_clinkz_death_pact_custom.consumed_gains_random_neutral = {
	npc_dota_clinkz_skeleton_archer = true
}

function modifier_clinkz_death_pact_custom:IsHidden() return false end
function modifier_clinkz_death_pact_custom:IsPurgable() return false end
function modifier_clinkz_death_pact_custom:RemoveOnDeath() return true end

function modifier_clinkz_death_pact_custom:GetEffectName()
	return "particles/units/heroes/hero_clinkz/clinkz_death_pact_buff.vpcf"
end

function modifier_clinkz_death_pact_custom:OnCreated(params)
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	if IsServer() then
		self.max_health = params.max_health
		self:SetHasCustomTransmitterData(true)
		if self.caster:HasTalent("special_bonus_unique_clinkz_2") then
			self:CreateNeutralAbility(params.creep_name)
		end
	end
end

function modifier_clinkz_death_pact_custom:OnDestroy(params)
	if IsServer() and self.creep_ability and not self.creep_ability:IsNull() then
		self.caster:SwapAbilities("generic_hidden", self.creep_ability:GetAbilityName(), false, false)
		self.caster:RemoveAbility(self.creep_ability:GetAbilityName())
	end
end

function modifier_clinkz_death_pact_custom:CreateNeutralAbility(creep_name)
	local ability_name = self.neutral_creep_ability_map[creep_name] or self.consumed_gains_random_neutral[creep_name] and self:GetRandomNeutralAbility()
	if not ability_name then return end

	self.creep_ability = self.caster:AddAbility(ability_name)

	if self.creep_ability and not self.creep_ability:IsNull() then
		self.caster:SwapAbilities("generic_hidden", self.creep_ability:GetAbilityName(), false, true)
		self.creep_ability:SetLevel(1)
	end
end

function modifier_clinkz_death_pact_custom:GetRandomNeutralAbility()
	local neutral_table = {}
	for _, neutral_ability in pairs(self.neutral_creep_ability_map) do
		table.insert(neutral_table, neutral_ability)
	end

	return neutral_table[math.random(#neutral_table)]
end

function modifier_clinkz_death_pact_custom:AddCustomTransmitterData()
	-- Server
	local data = {
		max_health = self.max_health
	}

	return data
end

function modifier_clinkz_death_pact_custom:HandleCustomTransmitterData( data )
	-- Client
	self.max_health = data.max_health
end

function modifier_clinkz_death_pact_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS
	}
end

function modifier_clinkz_death_pact_custom:GetModifierPreAttack_BonusDamage()
	return (self.max_health or 0) * self.ability:GetSpecialValueFor("damage_gain_pct") / 100
end

function modifier_clinkz_death_pact_custom:GetModifierExtraHealthBonus()
	return (self.max_health or 0) * self.ability:GetSpecialValueFor("health_gain_pct") / 100
end