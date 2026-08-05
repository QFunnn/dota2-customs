--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_disarmed_lua = class({})

function modifier_generic_disarmed_lua:IsDebuff()
	return true
end
function modifier_generic_disarmed_lua:IsStunDebuff()
	return true
end

function modifier_generic_disarmed_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	local resist = 1 - self:GetParent():GetStatusResistance()
	local duration = kv.duration * resist
	self:SetDuration(duration, true)
end

function modifier_generic_disarmed_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_generic_disarmed_lua:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_generic_disarmed_lua:GetEffectName()
	return "particles/generic_gameplay/generic_disarm.vpcf"
end

function modifier_generic_disarmed_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end