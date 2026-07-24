--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_extra_creature_centaur_khan = class({})


function item_extra_creature_centaur_khan:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer =  hCaster:GetPlayerOwner()
		if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") then          
	       if hPlayer then
	       	   ExtraCreature:AddExtraCreature(hPlayer:GetPlayerID(),"npc_dota_centaur_khan")
	       	   self:SpendCharge()
	       end
		end
	end
end
