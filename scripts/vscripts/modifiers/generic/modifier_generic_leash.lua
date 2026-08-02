--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_leash = class({})

function modifier_generic_leash:IsHidden()
	return true
end
function modifier_generic_leash:IsPurgable()
	return self:GetStackCount() == 0
end
function modifier_generic_leash:OnCreated(table)
	if not IsServer() then
		return
	end

	if table.no_dispel then
		self:SetStackCount(1)
	end
end

function modifier_generic_leash:CheckState()
	return {
		[MODIFIER_STATE_TETHERED] = true,
	}
end