--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_relearn_book_lua = class({}) ---@class CDOTA_Item_Lua

function item_relearn_book_lua:OnSpellStart()
    if not IsServer() then return end

    local hCaster = self:GetCaster()
    local hPlayer = hCaster:GetPlayerOwner()
    if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") then
        if hPlayer then
            local nPlayerID = hPlayer:GetPlayerID()

            if not AbilitySelectionService:IsIdle(nPlayerID) then
                return
            end

            self:SpendCharge()
            AbilitySelectionService:BeginRemove(nPlayerID, "item_relearn_book_lua")

            EmitSoundOnClient("Item.TomeOfKnowledge", hPlayer)

            local playerBookStats = GameMode.playerCountBookMap[nPlayerID] or {}
            playerBookStats["item_relearn_book_lua"] = (playerBookStats["item_relearn_book_lua"] or 0) + 1
            GameMode.playerCountBookMap[nPlayerID] = playerBookStats
            CustomNetTables:SetTableValue("player_books", tostring(nPlayerID), GameMode.playerCountBookMap[nPlayerID])
        end
    end
end