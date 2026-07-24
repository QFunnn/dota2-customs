--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_relearn_book_lua = class({})


function item_relearn_book_lua:OnSpellStart()
    if IsServer() then
        local hCaster = self:GetCaster()
        local hPlayer = hCaster:GetPlayerOwner()
        if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") then
            if hPlayer then
                local nPlayerID = hPlayer:GetPlayerID()

                --如果当前有任何选择状态，不做反应
                if HeroBuilder.PlayerAbilitySelect[nPlayerID].state ~= ABILITY_SELECT_STATE_NONE then
                    return
                end

                --    --如果正在选技能 不起作用
                --    if hCaster.bSelectingAbility or hCaster.bRemovingAbility or hCaster.bSelectingSpellBook or hCaster.bOmniscientBookRemoving or hCaster.bOmniscientBookSelectingAbility then
                --    	   return
                --    end

                if GetMapName() == "random_1x8" then
                    CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SendHudError", { message = "dota_hud_error_random_map_can_not_use" })
                    return
                end

                self:SpendCharge()
                -- hCaster.bRemovingAbility = true
                -- hCaster.sUISecret = CreateSecretKey()
                HeroBuilder:ShowCurrentAbilitySelection(nPlayerID, ABILITY_SELECT_STATE_REMOVE)
                -- CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowRelearnBookAbilitySelection", { ui_secret = hCaster.sUISecret, security_key = Security:GetSecurityKey(nPlayerID) })

                EmitSoundOnClient("Item.TomeOfKnowledge", hPlayer)

                Util:RecordConsumableItem(hPlayer:GetPlayerID(), "item_relearn_book_lua")
            end
        end
    end
end