--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_modifier_lone_druid_16_debuff", "modifiers/talents/npc_dota_hero_lone_druid/modifier_lone_druid_16", LUA_MODIFIER_MOTION_NONE)

modifier_lone_druid_16=class({})

function modifier_lone_druid_16:IsHidden() return self:GetParent():HasModifier("modifier_modifier_lone_druid_16_debuff") end
function modifier_lone_druid_16:IsPurgable() return false end
function modifier_lone_druid_16:IsPurgeException() return false end
function modifier_lone_druid_16:RemoveOnDeath() return false end

function modifier_lone_druid_16:OnCreated()
	self.bonus = {1.5,3,4.5}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_lone_druid_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_lone_druid_16:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,

	}
end

function modifier_lone_druid_16:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
    if params.damage <= 0 then return end
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_modifier_lone_druid_16_debuff", {duration = 3})
end

function modifier_lone_druid_16:GetModifierHealthRegenPercentage()
	if self.bonus == nil and self:GetStackCount() == 0 then return end
	if self:GetParent():HasModifier("modifier_modifier_lone_druid_16_debuff") then return end
	return self.bonus[self:GetStackCount()]
end

function modifier_lone_druid_16:GetTexture() return "lone_druid_16" end

modifier_modifier_lone_druid_16_debuff = class({})
function modifier_modifier_lone_druid_16_debuff:IsDebuff() return true end
function modifier_modifier_lone_druid_16_debuff:IsPurgable() return false end
function modifier_modifier_lone_druid_16_debuff:RemoveOnDeath() return false end
function modifier_modifier_lone_druid_16_debuff:GetTexture() return "lone_druid_16" end