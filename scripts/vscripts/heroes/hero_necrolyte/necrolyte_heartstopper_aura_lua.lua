--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


necrolyte_heartstopper_aura_lua = class({}) ---@class necrolyte_heartstopper_aura_lua : CDOTA_Ability_Lua

LinkLuaModifier("modifier_necrolyte_heartstopper_aura_lua", "heroes/hero_necrolyte/necrolyte_heartstopper_aura_lua",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_heartstopper_aura_lua_effect",
	"heroes/hero_necrolyte/necrolyte_heartstopper_aura_lua", LUA_MODIFIER_MOTION_NONE)

local HEARTSTOPPER_DAMAGE_INTERVAL = 1.0


function necrolyte_heartstopper_aura_lua:GetIntrinsicModifierName()
	return "modifier_necrolyte_heartstopper_aura_lua"
end

----------------------------------------------------------------------------
modifier_necrolyte_heartstopper_aura_lua = class({}) ---@class modifier_necrolyte_heartstopper_aura_lua : CDOTA_Modifier_Lua

function modifier_necrolyte_heartstopper_aura_lua:IsHidden()
	return self:GetStackCount() <= 0
end

function modifier_necrolyte_heartstopper_aura_lua:IsDebuff()
	return false
end

function modifier_necrolyte_heartstopper_aura_lua:IsPurgable()
	return false
end

function modifier_necrolyte_heartstopper_aura_lua:IsPurgeException()
	return false
end

function modifier_necrolyte_heartstopper_aura_lua:IsAura()
	local hParent = self:GetParent()
	return not hParent:PassivesDisabled()
end

function modifier_necrolyte_heartstopper_aura_lua:GetModifierAura()
	return "modifier_necrolyte_heartstopper_aura_lua_effect"
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraRadius()
	return self.aura_radius
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_necrolyte_heartstopper_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS
end

function modifier_necrolyte_heartstopper_aura_lua:OnCreated()
	self.aura_radius = self:GetAbilitySpecialValueFor("aura_radius")
	self.hero_multiplier = self:GetAbilitySpecialValueFor("hero_multiplier")
	self.regen_duration = self:GetAbilitySpecialValueFor("regen_duration")
	self.health_regen = self:GetAbilitySpecialValueFor("health_regen")
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	if IsServer() then
		self.tStacks = {}
		self:StartIntervalThink(0.2)
	end
end

function modifier_necrolyte_heartstopper_aura_lua:OnRefresh()
	self.aura_radius = self:GetAbilitySpecialValueFor("aura_radius")
	self.hero_multiplier = self:GetAbilitySpecialValueFor("hero_multiplier")
	self.regen_duration = self:GetAbilitySpecialValueFor("regen_duration")
	self.health_regen = self:GetAbilitySpecialValueFor("health_regen")
	self.mana_regen = self:GetAbilitySpecialValueFor("mana_regen")
	if IsServer() then
	end
end

function modifier_necrolyte_heartstopper_aura_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_necrolyte_heartstopper_aura_lua:OnDeath(params)
	local hAttacker = params.attacker
	local hUnit = params.unit
	local hParent = self:GetParent()
	if IsValid(hParent) and IsValid(hAttacker) and IsValid(hUnit) and hParent == hAttacker and hAttacker ~= hUnit then
		local iCount = 1
		if hUnit:IsRealHero() then
			iCount = iCount * self.hero_multiplier
		end
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStacks,
			{ fDieTime = GameRulesCustom:GetGameTime() + (self.regen_duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end

function modifier_necrolyte_heartstopper_aura_lua:OnIntervalThink()
	local fGameTime = GameRulesCustom:GetGameTime()
	for i = #self.tStacks, 1, -1 do
		if fGameTime >= self.tStacks[i].fDieTime then
			self:SetStackCount(math.max(0, self:GetStackCount() - self.tStacks[i].iCount))
			table.remove(self.tStacks, i)
		end
	end
end

function modifier_necrolyte_heartstopper_aura_lua:GetModifierConstantHealthRegen()
	return self:GetStackCount() * self.health_regen
end

function modifier_necrolyte_heartstopper_aura_lua:GetModifierConstantManaRegen()
	return self:GetStackCount() * self.mana_regen
end

--------------------------------------------------------------------------
modifier_necrolyte_heartstopper_aura_lua_effect = class({}) ---@class modifier_necrolyte_heartstopper_aura_lua_effect : CDOTA_Modifier_Lua

function modifier_necrolyte_heartstopper_aura_lua_effect:IsHidden()
	return false
end

function modifier_necrolyte_heartstopper_aura_lua_effect:IsDebuff()
	return true
end

function modifier_necrolyte_heartstopper_aura_lua_effect:IsPurgable()
	return false
end

function modifier_necrolyte_heartstopper_aura_lua_effect:IsPurgeException()
	return false
end

function modifier_necrolyte_heartstopper_aura_lua_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_necrolyte_heartstopper_aura_lua_effect:OnCreated()
	self.aura_damage = self:GetAbilitySpecialValueFor("aura_damage")
	self.heal_reduction_pct = self:GetAbilitySpecialValueFor("heal_reduction_pct")
	if IsServer() then
		self:StartIntervalThink(HEARTSTOPPER_DAMAGE_INTERVAL)
	end
end

function modifier_necrolyte_heartstopper_aura_lua_effect:OnRefresh()
	self.aura_damage = self:GetAbilitySpecialValueFor("aura_damage")
	self.heal_reduction_pct = self:GetAbilitySpecialValueFor("heal_reduction_pct")
end

function modifier_necrolyte_heartstopper_aura_lua_effect:OnIntervalThink()
	local hAbility = self:GetAbility()
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if IsValid(hAbility) and IsValid(hCaster) and IsValid(hParent) then
		local fDamage = self.aura_damage * hParent:GetMaxHealth() * 0.01
		local heal_regen_to_damage = self:GetAbilitySpecialValueFor("heal_regen_to_damage")
		if heal_regen_to_damage > 0 then
			fDamage = fDamage + hCaster:GetHealthRegen() * heal_regen_to_damage * 0.01
		end
		fDamage = fDamage * HEARTSTOPPER_DAMAGE_INTERVAL
		ApplyDamage({
			attacker = hCaster,
			victim = hParent,
			damage = fDamage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = hAbility,
			damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		})
	end
end

function modifier_necrolyte_heartstopper_aura_lua_effect:GetModifierHPRegenAmplify_Percentage(params)
	return -self.heal_reduction_pct
end