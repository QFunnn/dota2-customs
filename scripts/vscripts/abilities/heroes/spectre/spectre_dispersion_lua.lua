--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


spectre_dispersion_lua = class({})
modifier_spectre_dispersion_lua = modifier_spectre_dispersion_lua or class({})
modifier_spectre_dispersion_active_lua = modifier_spectre_dispersion_active_lua or class({})
LinkLuaModifier(
	"modifier_spectre_dispersion_lua",
	"abilities/heroes/spectre/spectre_dispersion_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_spectre_dispersion_active_lua",
	"abilities/heroes/spectre/spectre_dispersion_lua",
	LUA_MODIFIER_MOTION_NONE
)

function spectre_dispersion_lua:GetIntrinsicModifierName()
	return "modifier_spectre_dispersion_lua"
end
function spectre_dispersion_lua:GetBehavior()
	if self:GetCaster():HasShard() then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	else
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
end

function spectre_dispersion_lua:OnSpellStart()
	local caster = self:GetCaster()

	self.activation_duration = self:GetSpecialValueFor("activation_duration")

	local active_modifier = caster:AddNewModifier(caster, self, "modifier_spectre_dispersion_active_lua", {
		duration = self.activation_duration,
	})

	if active_modifier then
		self.activation_bonus_multiplier = 1 + self:GetSpecialValueFor("activation_bonus_pct") / 100
	end
end

function modifier_spectre_dispersion_lua:IsHidden()
	return true
end
function modifier_spectre_dispersion_lua:IsPurgable()
	return false
end
function modifier_spectre_dispersion_lua:RemoveOnDeath()
	return false
end

function modifier_spectre_dispersion_active_lua:IsHidden()
	return false
end
function modifier_spectre_dispersion_active_lua:IsPurgable()
	return true
end
function modifier_spectre_dispersion_active_lua:RemoveOnDeath()
	return false
end
function modifier_spectre_dispersion_active_lua:GetEffectName()
	return "particles/units/heroes/hero_spectre/spectre_dispersion_boost_effect.vpcf"
end
function modifier_spectre_dispersion_active_lua:OnDestroy()
	local ability = self:GetAbility()
	if ability then
		ability.activation_bonus_multiplier = nil
	end
end

if IsClient() then
	return
end -- dispersion doesnt need to run on the client at all to function

function modifier_spectre_dispersion_lua:OnRefresh()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.team = self.parent:GetTeamNumber()

	self.damage_reflection_pct = self.ability:GetSpecialValueFor("damage_reflection_pct") * 0.01
	self.min_radius = self.ability:GetSpecialValueFor("min_radius")
	self.max_radius = self.ability:GetSpecialValueFor("max_radius")
end

function modifier_spectre_dispersion_lua:DeclareFunctions()
	if self:GetParent():IsIllusion() or IsClient() then
		return
	end

	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, -- GetModifierIncomingDamage_Percentage
	}
end

function modifier_spectre_dispersion_lua:GetModifierIncomingDamage_Percentage(keys)
	if not keys.attacker or keys.attacker:IsNull() then
		return 0
	end
	if self.parent:PassivesDisabled() then
		return 0
	end

	if
		bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION
		or bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS
	then
		return -self.damage_reflection_pct * 100
	end

	local damage_resisted = keys.original_damage * self.damage_reflection_pct

	local origin = self.parent:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		self.team,
		origin,
		nil,
		self.max_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	local multiplier_by_active_modifier = 1
	if self.ability.activation_bonus_multiplier then
		multiplier_by_active_modifier = self.ability.activation_bonus_multiplier
	end

	for _, enemy in pairs(enemies) do
		local distance = (origin - enemy:GetAbsOrigin()):Length2D()

		-- https://www.desmos.com/calculator/u5tyqr2pl3
		local damage_falloff = math.min(1, 1 - (distance - self.min_radius) / (self.max_radius - self.min_radius))

		local damage = damage_falloff * damage_resisted * multiplier_by_active_modifier

		ApplyDamage({
			victim = enemy,
			attacker = self.parent,
			damage = damage,
			damage_type = keys.damage_type,
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_HPLOSS,
			ability = self.ability,
		})
	end

	return -self.damage_reflection_pct * 100 * multiplier_by_active_modifier
end