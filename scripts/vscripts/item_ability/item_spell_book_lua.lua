--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_spell_book_lua = class({})

function item_spell_book_lua:IsRefreshable()
	return false
end

function item_spell_book_lua:OnSpellStart()
    if IsServer() then
        local hCaster = self:GetCaster()
        if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") then
            hCaster:EmitSound("Item.TomeOfKnowledge")
            local sAbilityName = self.sAbilityName
            local nAbilityLevel = self.nAbilityLevel
            local flAbilityCoolDown = self.flAbilityCoolDown
            self:SpendCharge()

            HeroBuilder:AddAbility(hCaster:GetPlayerOwnerID(), sAbilityName, nAbilityLevel, flAbilityCoolDown)

            local hPlayer = hCaster:GetPlayerOwner()
            if hPlayer then
                EmitSoundOnClient("Item.TomeOfKnowledge", hPlayer)
            end
        end
    end
end