--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_disconnect_player = class({})

function modifier_disconnect_player:IsHidden()
	return true
end

function modifier_disconnect_player:IsPurgable()
	return false
end
function modifier_disconnect_player:IsPurgeException()
	return false
end

function modifier_disconnect_player:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():AddNoDraw()
end

function modifier_disconnect_player:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():RemoveNoDraw()
end

function modifier_disconnect_player:CheckState()
	local state = {
		[MODIFIER_PROPERTY_DISABLE_HEALING] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end