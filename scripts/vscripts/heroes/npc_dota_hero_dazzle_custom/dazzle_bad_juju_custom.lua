--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dazzle_bad_juju_custom", "heroes/npc_dota_hero_dazzle_custom/dazzle_bad_juju_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_bad_juju_custom_cost", "heroes/npc_dota_hero_dazzle_custom/dazzle_bad_juju_custom", LUA_MODIFIER_MOTION_NONE)

dazzle_bad_juju_custom = class({})

dazzle_bad_juju_custom.modifier_dazzle_21 = 1
dazzle_bad_juju_custom.modifier_dazzle_21_health = 20

function dazzle_bad_juju_custom:GetHealthCost()
    local stack = (self:GetCaster():GetModifierStackCount("modifier_dazzle_bad_juju_custom_cost", self:GetCaster()))
    if stack == nil then
        return 75 + stack
    end
    if stack == 0 then
        return 75 + stack
    end
	return stack
end

function dazzle_bad_juju_custom:GetIntrinsicModifierName()
    return "modifier_dazzle_bad_juju_custom_cost"
end

function dazzle_bad_juju_custom:OnSpellStart()
    if not IsServer() then return end

    self:GetCaster():EmitSound("Hero_Dazzle.Weave")

    local modifier_dazzle_bad_juju_custom = self:GetCaster():FindModifierByName("modifier_dazzle_bad_juju_custom")
    if modifier_dazzle_bad_juju_custom then
        modifier_dazzle_bad_juju_custom = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_dazzle_bad_juju_custom", {duration = self:GetSpecialValueFor("mana_cost_increase_duration")})
        if modifier_dazzle_bad_juju_custom:GetStackCount() < self:GetSpecialValueFor("max_stacks") then  
            modifier_dazzle_bad_juju_custom:IncrementStackCount()
            local modifier_dazzle_bad_juju_custom_cost = self:GetCaster():FindModifierByName("modifier_dazzle_bad_juju_custom_cost")
            if modifier_dazzle_bad_juju_custom_cost then
                local mana_cost_increase_pct = self:GetSpecialValueFor("mana_cost_increase_pct")
                local new_health = self:GetHealthCost() * (1 + (mana_cost_increase_pct / 100))
                modifier_dazzle_bad_juju_custom_cost:SetStackCount(new_health)
            end
        end
    else
        modifier_dazzle_bad_juju_custom = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_dazzle_bad_juju_custom", {duration = self:GetSpecialValueFor("mana_cost_increase_duration")})
        modifier_dazzle_bad_juju_custom:IncrementStackCount()
        local modifier_dazzle_bad_juju_custom_cost = self:GetCaster():FindModifierByName("modifier_dazzle_bad_juju_custom_cost")
        if modifier_dazzle_bad_juju_custom_cost then
            local mana_cost_increase_pct = self:GetSpecialValueFor("mana_cost_increase_pct")
            local new_health = self:GetHealthCost() * (1 + (mana_cost_increase_pct / 100))
            modifier_dazzle_bad_juju_custom_cost:SetStackCount(new_health)
        end
    end
    local dazzle_innate_weave_custom = self:GetCaster():FindAbilityByName("dazzle_innate_weave_custom")
    if dazzle_innate_weave_custom then
        dazzle_innate_weave_custom:TargetModifier(self:GetCaster())
    end

    local skip_cooldown = 
    {
        ["dazzle_bad_juju_custom"] = true,
        ["item_refresher_custom"] = true,
    }

    local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")

    for i=0, self:GetCaster():GetAbilityCount()-1 do
        local ability = self:GetCaster():GetAbilityByIndex(i)
        if ability and skip_cooldown[ability:GetAbilityName()] == nil then
            local flCurrentCooldown = ability:GetCooldownTimeRemaining()
			local flReducedCooldown = flCurrentCooldown - cooldown_reduction
			ability:EndCooldown()
			if flReducedCooldown > 0 then
				ability:StartCooldown(flReducedCooldown)
			end
        end
    end
end

modifier_dazzle_bad_juju_custom = class({})
function modifier_dazzle_bad_juju_custom:IsPurgable() return false end
function modifier_dazzle_bad_juju_custom:IsPurgeException() return false end
function modifier_dazzle_bad_juju_custom:OnDestroy()
    if not IsServer() then return end
    local modifier_dazzle_bad_juju_custom_cost = self:GetCaster():FindModifierByName("modifier_dazzle_bad_juju_custom_cost")
    if modifier_dazzle_bad_juju_custom_cost then
        modifier_dazzle_bad_juju_custom_cost:SetStackCount(0)
    end
end

modifier_dazzle_bad_juju_custom_cost = class({})
function modifier_dazzle_bad_juju_custom_cost:IsPurgable() return false end
function modifier_dazzle_bad_juju_custom_cost:IsPurgeException() return false end
function modifier_dazzle_bad_juju_custom_cost:IsHidden() return true end