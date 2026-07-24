--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_relearn_torn_page_lua = class({})
function item_relearn_torn_page_lua:OnChargeCountChanged(iCharges) end

function item_relearn_torn_page_lua:OnSpellStart()
	if not IsServer() then return end
    local caster = self:GetCaster()
    local player = caster:GetPlayerOwner()
    local PlayerID = caster:GetPlayerOwnerID()
    if not caster:IsRealHero() or 
    caster:IsTempestDouble() or 
    caster:HasModifier("modifier_arc_warden_tempest_double_lua") or not 
    player or 
    HeroBuilder:IsPlayerSelectAbilities(PlayerID) or not
    HeroBuilder:IsPlayerHasAbilities(PlayerID) then return end

    if HeroBuilder:AddAbilitiesSelectionToSchedule(PlayerID, ABILITY_SELECTION_TYPE.FAST_RELEARN, self:GetName()) then
        EmitSoundOnClient("Item.TomeOfKnowledge", player)
        Util:RecordConsumableItem(PlayerID, "item_relearn_torn_page_lua")
        HeroBuilder:IncrementPages(PlayerID)
        self:SpendCharge(0)
    end
end