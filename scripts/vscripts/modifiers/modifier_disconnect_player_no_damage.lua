--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_disconnect_player_no_damage = class({})

function modifier_disconnect_player_no_damage:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
end

function modifier_disconnect_player_no_damage:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self:GetParent():HasModifier("modifier_fountain_invulnerability") then
		self:Destroy()
	end
end

function modifier_disconnect_player_no_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_disconnect_player_no_damage:GetModifierTotalDamageOutgoing_Percentage()
	return -1000
end