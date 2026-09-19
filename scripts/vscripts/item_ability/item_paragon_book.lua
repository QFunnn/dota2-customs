--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


item_paragon_book = class({})

function item_paragon_book:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer = hCaster:GetPlayerOwner()
		if
			hCaster
			and hCaster:IsRealHero()
			and not hCaster:IsTempestDouble()
			and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua")
			and hCaster:GetUnitLabel() ~= "spirit_bear"
		then
			if GetMapName() == "random_1x8" then
				CustomGameEventManager:Send_ServerToPlayer(
					hPlayer,
					"SendHudError",
					{ message = "dota_hud_error_random_map_can_not_use" }
				)
				return
			end

			if hPlayer then
				local nPlayerID = hPlayer:GetPlayerID()

				--если сейчас есть любое состояние выбора — не реагируем
				if not AbilitySelectionService:IsIdle(nPlayerID) then
					return
				end
				if hCaster.bUsedParagon then
					CustomGameEventManager:Send_ServerToPlayer(hPlayer, "OnlyUseOneTime", {})
					return
				end
				hCaster.bUsedParagon = true
				hCaster:EmitSound("Item.TomeOfKnowledge")
				self:SpendCharge()
				AbilityQuota:AddBonus(nPlayerID, 1)
				AbilitySelectionService:ShowRandomAbilitySelection(hPlayer:GetPlayerID())
			end
		end
	end
end