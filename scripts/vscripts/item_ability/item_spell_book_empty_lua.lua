--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_spell_book_empty_lua = class({})

function item_spell_book_empty_lua:IsRefreshable()
	return false
end

function item_spell_book_empty_lua:OnSpellStart()
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
                --如果正在选技能 卷轴不起作用
                if hCaster.bSelectingAbility or hCaster.bRemovingAbility or hCaster.bSelectingSpellBook or hCaster.bOmniscientBookRemoving or hCaster.bOmniscientBookSelectingAbility then
                    return
                end
                self:SpendCharge()
                -- hCaster.bSelectingSpellBook = true
                -- hCaster.sUISecret = CreateSecretKey()
                -- CustomGameEventManager:Send_ServerToPlayer(hPlayer,"ShowSpellBookAbilitySelection",{ui_secret=hCaster.sUISecret,security_key=Security:GetSecurityKey(nPlayerID)})
                HeroBuilder:ShowCurrentAbilitySelection(nPlayerID, ABILITY_SELECT_STATE_HIDE)
                -- CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowSpellBookAbilitySelection", { ui_secret = hCaster.sUISecret })
                EmitSoundOnClient("Item.TomeOfKnowledge", hPlayer)

                Util:RecordConsumableItem(hPlayer:GetPlayerID(), "item_spell_book_empty_lua")
            end
        end
    end
end