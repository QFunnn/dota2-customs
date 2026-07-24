--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


frog_reaper = class({})
LinkLuaModifier("modifier_frog_reaper", "creature_ability/frog_reaper", LUA_MODIFIER_MOTION_NONE)

function frog_reaper:GetIntrinsicModifierName()
	return "modifier_frog_reaper"
end
---------------------------------------------------
modifier_frog_reaper = class({})
function modifier_frog_reaper:IsHidden()
	return true
end
function modifier_frog_reaper:IsPurgable()
	return false
end
function modifier_frog_reaper:IsPurgeException()
	return false
end
function modifier_frog_reaper:IsDebuff()
	return false
end
function modifier_frog_reaper:RemoveOnDeath()
	return false
end
function modifier_frog_reaper:OnCreated(params)
	if IsServer() then
		self:StartIntervalThink(10)
		self:OnIntervalThink()
	end
end
function modifier_frog_reaper:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_frog_reaper:DeclareFunctions()
	return {
	}
end
function modifier_frog_reaper:CheckState()
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
function modifier_frog_reaper:OnIntervalThink()
	local hParent = self:GetParent()
	hParent:MoveToPosition(GoodFrogPos + RandomVector(RandomFloat(0, 200)))
end