--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_dummy = class({})

function modifier_dummy:IsHidden()
	return true
end
function modifier_dummy:IsDebuff()
	return false
end
function modifier_dummy:IsPurgable()
	return false
end
function modifier_dummy:IsPurgeException()
	return false
end
function modifier_dummy:AllowIllusionDuplicate()
	return false
end
function modifier_dummy:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
function modifier_dummy:CheckState()
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end