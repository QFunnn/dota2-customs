--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_relearn_book_return = class({})
function item_relearn_book_return:OnChargeCountChanged(iCharges) end

function item_relearn_book_return:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local player = caster:GetPlayerOwner()
    local PlayerID = caster:GetPlayerOwnerID()

    if not caster:IsRealHero() or caster:IsTempestDouble() or caster:HasModifier("modifier_arc_warden_tempest_double_lua") or not player or HeroBuilder:IsPlayerSelectAbilities(PlayerID) or not
    HeroBuilder:IsPlayerHasAbilities(PlayerID) then return end

    local pudge_meat_hook = caster:FindAbilityByName("pudge_meat_hook")
    if pudge_meat_hook then
        pudge_meat_hook:SetActivated(false)
    end

    if HeroBuilder:AddAbilitiesSelectionToSchedule(PlayerID, ABILITY_SELECTION_TYPE.RELEARN_RETURN, self:GetName()) then
        EmitSoundOnClient("Item.TomeOfKnowledge", player)
        Util:RecordConsumableItem(PlayerID, "item_relearn_book_return")

        self:SpendCharge(0)
    end
end