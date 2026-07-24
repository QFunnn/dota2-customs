--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_omniscient_book = class({})


function item_omniscient_book:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer =  hCaster:GetPlayerOwner()
		if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua")  then          
	       if hPlayer then
	       	   --如果正在选技能 不起作用
	           if hCaster.bSelectingAbility or hCaster.bRemovingAbility or hCaster.bSelectingSpellBook or hCaster.bOmniscientBookRemoving or hCaster.bOmniscientBookSelectingAbility then
	           	   return
	           end

	           if GetMapName()=="random_1x8" then
	               CustomGameEventManager:Send_ServerToPlayer(hPlayer,"SendHudError",{message="dota_hud_error_random_map_can_not_use"} )
	           	   return
	           end

		       self:SpendCharge()
		    --    hCaster.bOmniscientBookRemoving = true
		    --    hCaster.sUISecret= CreateSecretKey()
		       local nPlayerID = hPlayer:GetPlayerID()
	           CustomGameEventManager:Send_ServerToPlayer(hPlayer,"ShowRelearnBookAbilitySelection",{ui_secret=hCaster.sUISecret,security_key=Security:GetSecurityKey(nPlayerID),omniscient_book=true})
	           EmitSoundOnClient("Item.TomeOfKnowledge",hPlayer)

	           Util:RecordConsumableItem(hPlayer:GetPlayerID(),"item_omniscient_book")
	       end
		end
	end
end
