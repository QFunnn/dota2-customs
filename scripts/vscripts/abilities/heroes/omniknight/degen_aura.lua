--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


omniknight_degen_aura_lua = class({})
LinkLuaModifier( "modifier_omniknight_degen_aura_lua", "abilities/heroes/omniknight/degen_aura", LUA_MODIFIER_MOTION_NONE )

function omniknight_degen_aura_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius") or 0
end

function omniknight_degen_aura_lua:GetIntrinsicModifierName()
	return "modifier_omniknight_degen_aura_lua"
end


------------------------------------------------------------------------------------------------------------------------------------------------


modifier_omniknight_degen_aura_lua = class({})

function modifier_omniknight_degen_aura_lua:IsHidden() return true end
function modifier_omniknight_degen_aura_lua:IsDebuff() return false end
function modifier_omniknight_degen_aura_lua:IsPurgable() return false end
function modifier_omniknight_degen_aura_lua:IsAura() return true end
function modifier_omniknight_degen_aura_lua:GetModifierAura() return "modifier_omniknight_degen_aura_effect" end
function modifier_omniknight_degen_aura_lua:GetAuraRadius() return self.radius end
function modifier_omniknight_degen_aura_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_omniknight_degen_aura_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_omniknight_degen_aura_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_omniknight_degen_aura_lua:GetAuraDuration() return 1 end

function modifier_omniknight_degen_aura_lua:OnCreated(kv)
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	if not self.ability or self.ability:IsNull() then return end
	if not self.caster or self.caster:IsNull() then return end

	self.radius = self.ability:GetSpecialValueFor("radius")
end

function modifier_omniknight_degen_aura_lua:OnRefresh(kv)
	self:OnCreated(kv)
end