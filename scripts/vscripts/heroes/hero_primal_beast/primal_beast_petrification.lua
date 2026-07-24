--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_primal_beast_petrification", "heroes/hero_primal_beast/primal_beast_petrification", LUA_MODIFIER_MOTION_NONE)

primal_beast_petrification = class({})

function primal_beast_petrification:OnSpellStart()
	if not IsServer() then return end
	
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	
	-- Применяем модификатор окаменения
	caster:AddNewModifier(caster, self, "modifier_primal_beast_petrification", {duration = duration})
	
	-- Звук окаменения
	caster:EmitSound("Hero_Earth_Spirit.StoneRemnant.Impact")
end

modifier_primal_beast_petrification = class({})

function modifier_primal_beast_petrification:IsHidden() return false end
function modifier_primal_beast_petrification:IsPurgable() return false end
function modifier_primal_beast_petrification:IsDebuff() return false end

function modifier_primal_beast_petrification:GetStatusEffectName()
	return "particles/status_fx/status_effect_earth_spirit_petrify.vpcf"
end

function modifier_primal_beast_petrification:StatusEffectPriority()
	return 10
end

function modifier_primal_beast_petrification:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end

function modifier_primal_beast_petrification:OnCreated()
	if not IsServer() then return end
end

function modifier_primal_beast_petrification:OnDestroy()
	if not IsServer() then return end
	
	-- Звук при окончании
	self:GetParent():EmitSound("Hero_Tiny.Grow")
end
