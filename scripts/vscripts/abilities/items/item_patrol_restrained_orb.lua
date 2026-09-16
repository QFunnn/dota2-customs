--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
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