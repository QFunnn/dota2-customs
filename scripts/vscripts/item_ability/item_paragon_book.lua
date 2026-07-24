--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_paragon_book = class({})


function item_paragon_book:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer = hCaster:GetPlayerOwner()
		if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") and hCaster:GetUnitLabel() ~= "spirit_bear" then


			if GetMapName() == "random_1x8" then
				CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SendHudError", { message = "dota_hud_error_random_map_can_not_use" })
				return
			end

			--如果已经被AI托管,直接给一个技能
			if hCaster.bTakenOverByBot then
				hCaster.bUsedParagon = true
				hCaster:EmitSound("Item.TomeOfKnowledge")
				AbilityQuota:AddTotal(hCaster:GetPlayerID(), 1)
				AbilitySelectionService:ShowRandomAbilitySelection(hCaster:GetPlayerID())
				self:SpendCharge()
				--如果是正常玩家
			else
				if hPlayer then
					local nPlayerID = hPlayer:GetPlayerID()

					--如果当前有任何选择状态，不做反应
					if not AbilitySelectionService:IsIdle(nPlayerID) then
						return
					end
					-- --如果正在选技能 不起作用
					-- if hCaster.bSelectingAbility or hCaster.bRemovingAbility or hCaster.bSelectingSpellBook or hCaster.bOmniscientBookRemoving or hCaster.bOmniscientBookSelectingAbility then
					--	 return
					-- end
					if hCaster.bUsedParagon then
						CustomGameEventManager:Send_ServerToPlayer(hPlayer, "OnlyUseOneTime", {})
						return
					end
					hCaster.bUsedParagon = true
					hCaster:EmitSound("Item.TomeOfKnowledge")
					self:SpendCharge()
					AbilityQuota:AddBonus(nPlayerID, 1)
					AbilitySelectionService:ShowRandomAbilitySelection(hPlayer:GetPlayerID())
					Util:RecordConsumableItem(hPlayer:GetPlayerID(), "item_paragon_book")
				end
			end
		end
	end
end