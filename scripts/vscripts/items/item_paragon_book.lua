--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_paragon_book = class({})
function item_paragon_book:OnChargeCountChanged(iCharges) end

function item_paragon_book:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()
    local player = caster:GetPlayerOwner()
    local PlayerID = caster:GetPlayerOwnerID()
    if not caster:IsRealHero() or caster:IsTempestDouble() or caster:HasModifier("modifier_arc_warden_tempest_double_lua") or not player then return end
    if caster.bUsedParagon then
        CustomGameEventManager:Send_ServerToPlayer(player, "OnlyUseOneTime", {})
        return
    end
    if HeroBuilder:AddAbilitiesSelectionToSchedule(PlayerID, ABILITY_SELECTION_TYPE.BASIC, self:GetName()) then
        caster.bUsedParagon = true	              
        EmitSoundOnClient("Item.TomeOfKnowledge", player)         
        Util:RecordConsumableItem(PlayerID, "item_paragon_book")
        self:SpendCharge(0)
    end
end

item_paragon_book_2 = class({})
function item_paragon_book_2:OnChargeCountChanged(iCharges) end

function item_paragon_book_2:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()
    local player = caster:GetPlayerOwner()
    local PlayerID = caster:GetPlayerOwnerID()
    if not caster:IsRealHero() or caster:IsTempestDouble() or caster:HasModifier("modifier_arc_warden_tempest_double_lua") or not player then return end
    if caster.bUsedParagon_2 then
        CustomGameEventManager:Send_ServerToPlayer(player, "OnlyUseOneTime", {})
        return
    end
    
    if HeroBuilder:AddAbilitiesSelectionToSchedule(PlayerID, ABILITY_SELECTION_TYPE.BASIC, self:GetName()) then
        caster.bUsedParagon_2 = true	              
        EmitSoundOnClient("Item.TomeOfKnowledge", player)         
        Util:RecordConsumableItem(PlayerID, "item_paragon_book")
        self:SpendCharge(0)
    end
end