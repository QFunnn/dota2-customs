--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



item_patrol_reward_2               = class({})


function item_patrol_reward_2:OnAbilityPhaseStart()
local player = self:GetCaster()


if player:HasModifier("modifier_end_choise") then 
   return false
end


return true 

end


function item_patrol_reward_2:OnSpellStart()
if not IsServer() then return end


self.parent = self:GetParent()

upgrade:init_upgrade(self.parent, nil, nil, after_legen, nil, nil, "patrol_2")

self:SpendCharge(0)

end