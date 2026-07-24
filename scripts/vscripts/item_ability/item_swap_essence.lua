--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_swap_essence = class({})


function item_swap_essence:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer =  hCaster:GetPlayerOwner()
		if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua")  then          
	       if hPlayer then
	       	   --如果正在选技能 不起作用
	           if hCaster.bSelectingAbility or hCaster.bRemovingAbility or hCaster.bSelectingSpellBook or hCaster.bOmniscientBookRemoving or hCaster.bOmniscientBookSelectingAbility then
	           	   return
	           end
               
               if string.find(GetMapName(),"1x8") then
               	   CustomGameEventManager:Send_ServerToPlayer(hPlayer,"OnlyMutiPlayerWarn",{})
	           	   return
	           end

		       hCaster.sTeamSwapUISecret= CreateSecretKey()
		       local nPlayerID = hPlayer:GetPlayerID()
               
               -- hCaster.nSwappingItemIndex 正在调换技能的标志位
		       if not hCaster.nSwappingItemIndex then
                  hCaster.nSwappingItemIndex = self:GetEntityIndex()
                  CustomGameEventManager:Send_ServerToPlayer(hPlayer,"ShowSwap",{ui_secret=hCaster.sTeamSwapUISecret,security_key=Security:GetSecurityKey(nPlayerID),item_index=hCaster.nSwappingItemIndex})
		       else
		       	  CustomGameEventManager:Send_ServerToPlayer(hPlayer,"ShowSwap",{ui_secret=hCaster.sTeamSwapUISecret,security_key=Security:GetSecurityKey(nPlayerID)})
		       end
		       Util:RecordConsumableItem(hPlayer:GetPlayerID(),"item_swap_essence")
	       end
		end
	end
end
