--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


lone_druid_spirit_bear_orb_capture = lone_druid_spirit_bear_orb_capture or class({})
LinkLuaModifier("modifier_lone_druid_spirit_bear_orb_capture", "abilities/heroes/lone_druid/spirit_bear_orb_capture", LUA_MODIFIER_MOTION_NONE)


function lone_druid_spirit_bear_orb_capture:GetIntrinsicModifierName()
	return "modifier_lone_druid_spirit_bear_orb_capture"
end



modifier_lone_druid_spirit_bear_orb_capture = modifier_lone_druid_spirit_bear_orb_capture or class({})


function modifier_lone_druid_spirit_bear_orb_capture:IsHidden() return false end
function modifier_lone_druid_spirit_bear_orb_capture:IsDebuff() return false end
function modifier_lone_druid_spirit_bear_orb_capture:IsPurgable() return false end
function modifier_lone_druid_spirit_bear_orb_capture:RemoveOnDeath() return false end
function modifier_lone_druid_spirit_bear_orb_capture:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_lone_druid_spirit_bear_orb_capture:OnCreated()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then return end
	self.ability = self:GetAbility()
	if not IsValidEntity(self.ability) then return end

	self.orb_capture_damage_pct = self.ability:GetSpecialValueFor("orb_capture_damage_pct") or 0
end

function modifier_lone_druid_spirit_bear_orb_capture:OnRefresh(kv)
	self:OnCreated(kv)
end


function modifier_lone_druid_spirit_bear_orb_capture:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_lone_druid_spirit_bear_orb_capture:GetModifierDamageOutgoing_Percentage(event)
	if not IsValidEntity(self.caster) then return end
	if not IsValidEntity(self.ability) then return end
	if not event.attacker or not event.target then return end
	if self.caster ~= event.attacker then return end
	if not event.target:HasModifier("modifier_capturing_orb_custom") then return end
	if self.caster:PassivesDisabled() then return end

	return self.orb_capture_damage_pct
end

function modifier_lone_druid_spirit_bear_orb_capture:OnTooltip()
	return self.orb_capture_damage_pct
end