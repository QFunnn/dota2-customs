--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_omniscient_book = class({})
function item_omniscient_book:OnChargeCountChanged(iCharges) end


function item_omniscient_book:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer =  hCaster:GetPlayerOwner()
		if hCaster and 
		hCaster:IsRealHero() and not 
		hCaster:IsTempestDouble() and not 
		hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") and 
		hPlayer and not 
		HeroBuilder:IsPlayerSelectAbilities(hPlayer:GetPlayerID()) and HeroBuilder:IsPlayerHasAbilities(hPlayer:GetPlayerID()) then  
			self:SpendCharge(0)
			HeroBuilder:AddAbilitiesSelectionToSchedule(hPlayer:GetPlayerID(), ABILITY_SELECTION_TYPE.DEV)

			EmitSoundOnClient("Item.TomeOfKnowledge",hPlayer)

			Util:RecordConsumableItem(hPlayer:GetPlayerID(),"item_omniscient_book")
	    end
	end
end
