--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


chen_divine_favor_lua = class({})
LinkLuaModifier("modifier_chen_divine_favor_lua", "abilities/heroes/chen/divine_favor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chen_divine_favor_aura_lua", "abilities/heroes/chen/divine_favor", LUA_MODIFIER_MOTION_NONE)

function chen_divine_favor_lua:GetAOERadius()
	return self:GetSpecialValueFor("aura_radius") or 0
end

function chen_divine_favor_lua:GetIntrinsicModifierName()
	return "modifier_chen_divine_favor_aura_lua"
end


------------------------------------------------------------------------------------------------------------------------------------------------


modifier_chen_divine_favor_aura_lua = class({})

function modifier_chen_divine_favor_aura_lua:IsHidden() return true end
function modifier_chen_divine_favor_aura_lua:IsDebuff() return false end
function modifier_chen_divine_favor_aura_lua:IsPurgable() return false end
function modifier_chen_divine_favor_aura_lua:IsAura() return true end
function modifier_chen_divine_favor_aura_lua:GetModifierAura() return "modifier_chen_divine_favor_lua" end
function modifier_chen_divine_favor_aura_lua:GetAuraRadius() return self.aura_radius end
function modifier_chen_divine_favor_aura_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_chen_divine_favor_aura_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_chen_divine_favor_aura_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES end
function modifier_chen_divine_favor_aura_lua:GetAuraDuration() return 0.5 end

function modifier_chen_divine_favor_aura_lua:OnCreated(kv)
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	if not self.ability or self.ability:IsNull() then return end
	if not self.caster or self.caster:IsNull() then return end

	self.aura_radius = self.ability:GetSpecialValueFor("aura_radius")
end

function modifier_chen_divine_favor_aura_lua:OnRefresh(kv)
	self:OnCreated(kv)
end


--------------------------------------------------------------------------------------------------------------------------------------------------


modifier_chen_divine_favor_lua = class({})

function modifier_chen_divine_favor_lua:IsHidden() return false end
function modifier_chen_divine_favor_lua:IsPurgable() return false end
function modifier_chen_divine_favor_lua:IsBuff() return true end
function modifier_chen_divine_favor_lua:IsDebuff() return false end

function modifier_chen_divine_favor_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	if not self.caster or self.caster:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self.armor = self.ability:GetSpecialValueFor("armor") or 0
	self.heal_rate = self.ability:GetSpecialValueFor("heal_rate") or 0
end

function modifier_chen_divine_favor_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_chen_divine_favor_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_chen_divine_favor_lua:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_chen_divine_favor_lua:GetModifierConstantHealthRegen()
	return self.heal_rate
end