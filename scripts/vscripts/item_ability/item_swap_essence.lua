--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_swap_essence = class({}) ---@class item_swap_essence : CDOTA_Item_Lua

function item_swap_essence:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local player = caster:GetPlayerOwner()
	if caster and caster:IsRealHero() and not caster:IsTempestDouble() and not caster:HasModifier("modifier_arc_warden_tempest_double_lua") then
		if not player then return end
		if caster.bSelectingAbility or caster.bRemovingAbility or caster.bSelectingSpellBook or caster.bOmniscientBookRemoving or caster.bOmniscientBookSelectingAbility then
			return
		end

		if string.find(GetMapName(), "1x8") then
			CustomGameEventManager:Send_ServerToPlayer(player, "OnlyMutiPlayerWarn", {})
			return
		end

		caster.sTeamSwapUISecret = CreateSecretKey()

		if not caster.nSwappingItemIndex then
			caster.nSwappingItemIndex = self:GetEntityIndex()
			CustomGameEventManager:Send_ServerToPlayer(player, "ShowSwap", {
				ui_secret = caster.sTeamSwapUISecret,
				item_index = caster.nSwappingItemIndex
			})
		else
			CustomGameEventManager:Send_ServerToPlayer(player, "ShowSwap", {
				ui_secret = caster.sTeamSwapUISecret,
			})
		end
		Util:RecordConsumableItem(player:GetPlayerID(), "item_swap_essence")
	end
end