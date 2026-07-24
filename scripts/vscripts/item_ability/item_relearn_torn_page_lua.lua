--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_relearn_torn_page_lua = class({})

function item_relearn_torn_page_lua:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()
    local player = caster:GetPlayerOwner()
    if caster and caster:IsRealHero() and not caster:IsTempestDouble() and not caster:HasModifier("modifier_arc_warden_tempest_double_lua") then
        if player then
            local playerId = player:GetPlayerID()

            if not AbilitySelectionService:IsIdle(playerId) then
                return
            end

            if caster.abilitiesList == nil or #caster.abilitiesList == 0 then
                return
            end

            local tempList = table.deepcopy(caster.abilitiesList)

            if tempList == nil or #tempList == 0 then
                return
            end
            self:SpendCharge()
            local randomIndex = RandomInt(1, #tempList)
            local removingAbility = tempList[randomIndex]
            AbilitySelectionService:BeginRemove(playerId, "item_relearn_torn_page_lua")
            AbilitySelectionService:ResolveRelearnBookSelection(player:GetPlayerID(), removingAbility)
            EmitSoundOnClient("Item.TomeOfKnowledge", player)

            local playerBookStats = GameMode.playerCountBookMap[playerId] or {}
            playerBookStats["item_relearn_torn_page_lua"] = (playerBookStats["item_relearn_torn_page_lua"] or 0) + 1
            GameMode.playerCountBookMap[playerId] = playerBookStats
            CustomNetTables:SetTableValue("player_books", tostring(playerId), GameMode.playerCountBookMap[playerId])
        end
    end
end