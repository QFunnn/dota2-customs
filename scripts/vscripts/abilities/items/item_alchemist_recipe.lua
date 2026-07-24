--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




item_alchemist_recipe = class({})

function item_alchemist_recipe:OnSpellStart()
if not IsServer() then return end

upgrade:init_upgrade(self:GetCaster(),13,nil,nil)	
self:SpendCharge(0)
end

function item_alchemist_recipe:OnAbilityPhaseStart()
if not IsServer() then return end
if players[self:GetCaster():GetId()]:HasModifier("modifier_end_choise")
 then return false end
return true
end


------------------------------------------------------------
