--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


if item_points_big_self == nil then
	item_points_big_self = class({})
end

function item_points_big_self:OnSpellStart()
	self:GetCaster():ChangeWood(self:GetSpecialValueFor("wood"))
	self:GetCaster():EmitSoundParams("DOTA_Item.InfusedRaindrop", 0, 0.5, 0)
	self:SpendCharge(0)
end