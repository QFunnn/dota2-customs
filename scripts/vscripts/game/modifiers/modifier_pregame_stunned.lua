--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pregame_stunned = modifier_pregame_stunned or class({})

function modifier_pregame_stunned:IsHidden() return true end
function modifier_pregame_stunned:IsPurgable() return false end
function modifier_pregame_stunned:RemoveOnExpire() return false end


function modifier_pregame_stunned:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end


function modifier_pregame_stunned:OnCreated()
	self:StartIntervalThink(1)
end


function modifier_pregame_stunned:OnIntervalThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		self:Destroy()
	end
end