--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_patrol_restrained_orb = class({})

function item_patrol_restrained_orb:OnSpellStart()
	if not IsServer() then
		return
	end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_patrol_reward_1_orb", {})
	self:SpendCharge(0)
end