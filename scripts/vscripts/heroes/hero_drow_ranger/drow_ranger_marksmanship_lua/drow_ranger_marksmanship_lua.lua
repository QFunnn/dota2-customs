--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_drow_ranger_marksmanship_lua",
	"heroes/hero_drow_ranger/drow_ranger_marksmanship_lua/drow_ranger_marksmanship_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_drow_ranger_marksmanship_lua_aura_buff",
	"heroes/hero_drow_ranger/drow_ranger_marksmanship_lua/drow_ranger_marksmanship_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_drow_ranger_marksmanship_lua_effect",
	"heroes/hero_drow_ranger/drow_ranger_marksmanship_lua/modifier_drow_ranger_marksmanship_lua_effect",
	LUA_MODIFIER_MOTION_NONE
)

drow_ranger_marksmanship_lua = class({})

function drow_ranger_marksmanship_lua:GetIntrinsicModifierName()
	return "modifier_drow_ranger_marksmanship_lua"
end

function drow_ranger_marksmanship_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf", context)
end

function drow_ranger_marksmanship_lua:GetCastRange()
	if not IsClient() then
		return
	end

	return self:GetSpecialValueFor("aura_radius")
end

function drow_ranger_marksmanship_lua:OnProjectileHit_ExtraData(target, location, data)
	if not target then
		return
	end
	self.split = true
	self.split_procs = data.procs == 1
	self:GetCaster():PerformAttack(target, true, true, true, false, false, false, false)
	self.split = false
end

function drow_ranger_marksmanship_lua:OnUpgrade()
	local caster = self:GetCaster()

	local auraModifier = caster:FindModifierByName("modifier_drow_ranger_marksmanship_lua")

	if not auraModifier then
		return
	end

	local effectModifier = caster:FindModifierByName("modifier_drow_ranger_marksmanship_lua_effect")
	if effectModifier then
		effectModifier:OnRefresh()
	end

	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		auraModifier:GetAuraRadius() + 50,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for i = 1, #units do
		local unit = units[i]

		local auraModifier = unit:FindModifierByName("modifier_drow_ranger_marksmanship_lua_aura_buff")
		if auraModifier then
			auraModifier:OnRefresh()
		end
	end
end

function drow_ranger_marksmanship_lua:OnHeroCalculateStatBonus()
	local caster = self:GetCaster()

	local special_bonus_unique_drow_ranger_2 = caster:FindAbilityByName("special_bonus_unique_drow_ranger_2")

	if
		special_bonus_unique_drow_ranger_2
		and (not self.special_bonus_unique_drow_ranger_2 and special_bonus_unique_drow_ranger_2:GetLevel() > 0)
	then
		self.special_bonus_unique_drow_ranger_2 = true

		self:OnUpgrade()
	end
end

modifier_drow_ranger_marksmanship_lua = class({})

function modifier_drow_ranger_marksmanship_lua:IsHidden()
	return true
end
function modifier_drow_ranger_marksmanship_lua:IsPurgable()
	return false
end
function modifier_drow_ranger_marksmanship_lua:GetModifierAura()
	return self.auraModifierName
end
function modifier_drow_ranger_marksmanship_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_drow_ranger_marksmanship_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_drow_ranger_marksmanship_lua:GetAuraRadius()
	return self.radius
end
function modifier_drow_ranger_marksmanship_lua:GetAuraEntityReject(target)
	if target:HasModifier("modifier_drow_ranger_marksmanship_lua_effect") and target ~= self:GetCaster() then
		return true
	end

	if target == self:GetCaster() then
		self.auraModifierName = "modifier_drow_ranger_marksmanship_lua_effect"
	else
		self.auraModifierName = "modifier_drow_ranger_marksmanship_lua_aura_buff"
	end
	return false
end
function modifier_drow_ranger_marksmanship_lua:IsAura()
	local caster = self:GetCaster()

	return not caster:PassivesDisabled() and not caster:IsIllusion()
end
function modifier_drow_ranger_marksmanship_lua:OnCreated()
	local ability = self:GetAbility()

	self.radius = ability:GetSpecialValueFor("aura_radius")
end

modifier_drow_ranger_marksmanship_lua_aura_buff = class({})

function modifier_drow_ranger_marksmanship_lua_aura_buff:IsHidden()
	return false
end
function modifier_drow_ranger_marksmanship_lua_aura_buff:IsDebuff()
	return false
end
function modifier_drow_ranger_marksmanship_lua_aura_buff:IsPurgable()
	return false
end

function modifier_drow_ranger_marksmanship_lua_aura_buff:OnCreated()
	local allyAgilityBonusPct = self:GetAbility():GetSpecialValueFor("agility_bonus_allies_pec")
	self.drowAgilityBonusMult = self:GetAbility():GetSpecialValueFor("agility_bonus_pct") / 100

	self.agilityBonusMult = (allyAgilityBonusPct / 100) * self.drowAgilityBonusMult
end

function modifier_drow_ranger_marksmanship_lua_aura_buff:OnRefresh()
	self:OnCreated()
end

function modifier_drow_ranger_marksmanship_lua_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
end

modifier_drow_ranger_marksmanship_lua_aura_buff.GetModifierBonusStats_Agility = Debounce(0.1, function(self)
	if self.agiLock then
		return
	end

	local caster, parent = self:GetCaster(), self:GetParent()

	if caster == parent then
		return
	end

	caster.agiLock = true
	local agility = caster:GetAgility()
	self.agiLock = false

	return math.floor(agility * (1 / (1 + self.drowAgilityBonusMult)) * self.agilityBonusMult)
end)