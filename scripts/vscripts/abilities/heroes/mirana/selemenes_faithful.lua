--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


mirana_selemenes_faithful_lua = class({})
LinkLuaModifier("modifier_mirana_selemenes_faithful_lua", "abilities/heroes/mirana/selemenes_faithful", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mirana_selemenes_faithful_buff_lua", "abilities/heroes/mirana/selemenes_faithful", LUA_MODIFIER_MOTION_NONE)

function mirana_selemenes_faithful_lua:GetIntrinsicModifierName()
	return "modifier_mirana_selemenes_faithful_lua"
end


---------------------------------------------------------------------------------------------------------------------------------------------------


modifier_mirana_selemenes_faithful_lua = class({})

function modifier_mirana_selemenes_faithful_lua:IsHidden() return true end
function modifier_mirana_selemenes_faithful_lua:IsDebuff() return false end
function modifier_mirana_selemenes_faithful_lua:IsPurgable() return false end
function modifier_mirana_selemenes_faithful_lua:RemoveOnDeath() return false end
function modifier_mirana_selemenes_faithful_lua:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_mirana_selemenes_faithful_lua:IsAura()
	if not IsValidEntity(self.caster) then return false end
	if self.caster:PassivesDisabled() then return false end
	return true
end
function modifier_mirana_selemenes_faithful_lua:GetAuraRadius() return -1 end
function modifier_mirana_selemenes_faithful_lua:GetAuraDuration() return 0.5 end
function modifier_mirana_selemenes_faithful_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_mirana_selemenes_faithful_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_mirana_selemenes_faithful_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_mirana_selemenes_faithful_lua:GetModifierAura() return "modifier_mirana_selemenes_faithful_buff_lua" end

function modifier_mirana_selemenes_faithful_lua:OnCreated()
	self.caster = self:GetCaster()
end

function modifier_mirana_selemenes_faithful_lua:OnRefresh()
	self:OnCreated()
end


---------------------------------------------------------------------------------------------------------------------------------------------------


modifier_mirana_selemenes_faithful_buff_lua = class({})

function modifier_mirana_selemenes_faithful_buff_lua:IsHidden() return (IsValidEntity(self.parent) and not self.parent:HasModifier("modifier_capturing_orb_custom")) end
function modifier_mirana_selemenes_faithful_buff_lua:IsDebuff() return false end
function modifier_mirana_selemenes_faithful_buff_lua:IsPurgable() return false end

function modifier_mirana_selemenes_faithful_buff_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	self.parent = self:GetParent()
	if not IsValidEntity(self.parent) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end

	self.heal_pct = self.ability:GetSpecialValueFor("heal_pct") or 0
end

function modifier_mirana_selemenes_faithful_buff_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_mirana_selemenes_faithful_buff_lua:OnDestroy(kv)
end

function modifier_mirana_selemenes_faithful_buff_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_mirana_selemenes_faithful_buff_lua:GetModifierHealthRegenPercentage()
	if not IsValidEntity(self.parent) then return 0 end
	if not self.parent:HasModifier("modifier_capturing_orb_custom") then return 0 end
	return self.heal_pct
end