--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_player_abandon = modifier_player_abandon or class({})

function modifier_player_abandon:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end


function modifier_player_abandon:OnCreated()
	if not IsServer() then return end

	self:GetParent():AddNoDraw()
	self:GetParent():RespawnHero(false, false)
end


function modifier_player_abandon:OnRemoved()
	if not IsServer() then return end

	self:GetParent():RemoveNoDraw()
	self:GetParent():RespawnHero(false, false)
end