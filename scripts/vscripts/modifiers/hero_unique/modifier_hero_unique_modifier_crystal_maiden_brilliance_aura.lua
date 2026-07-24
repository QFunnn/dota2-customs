--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_crystal_maiden_brilliance_aura = class({})
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:IsHidden() return true end
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:IsPurgable() return false end
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:IsPurgeException() return false end
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:RemoveOnDeath() return false end
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:AllowIllusionDuplicate() return true end

LinkLuaModifier("modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect", "modifiers/hero_unique/modifier_hero_unique_modifier_crystal_maiden_brilliance_aura.lua", LUA_MODIFIER_MOTION_NONE)

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:OnCreated(params)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()

    if IsServer() then
        self:CheckAuraLevel()
        self:StartIntervalThink(1)
    end
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:OnIntervalThink()
    if not IsServer() then return end

    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
        return
    end

    self:CheckAuraLevel()
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:CheckAuraLevel()
    local parent = self:GetParent()
    local should_apply_bonus = false

    if parent:PassivesDisabled() then
        if parent:HasModifier("modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect") then
            parent:RemoveModifierByName("modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect")
        end
        return
    end

    if parent and parent:HasAbility("crystal_maiden_brilliance_aura") then
        local aura_ability = parent:FindAbilityByName("crystal_maiden_brilliance_aura")
        if aura_ability and aura_ability:GetLevel() > 0 then
            should_apply_bonus = true
        end
    end

    if should_apply_bonus then
        if not parent:HasModifier("modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect") then
            parent:AddNewModifier(parent, self.ability, "modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect", {})
        end
    else
        if parent:HasModifier("modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect") then
            parent:RemoveModifierByName("modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect")
        end
    end
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:OnSpentMana(event)
    if not IsServer() then return end

    if event.unit == self:GetParent() and event.ability then
        local parent = self:GetParent()
        if parent:PassivesDisabled() then return end

        if parent and parent:HasAbility("crystal_maiden_brilliance_aura") then
            local aura_ability = parent:FindAbilityByName("crystal_maiden_brilliance_aura")
            if aura_ability and aura_ability:GetLevel() > 0 then
                local manacost_reduction = aura_ability:GetSpecialValueFor("manacost_reduction_pct")
                if manacost_reduction >= 100 then
                    if event.ability:GetName() == "leshrac_pulse_nova" then
                        local Manacost = event.ability:GetSpecialValueFor("mana_cost_per_second")
                        self:GetParent():GiveMana(Manacost)
                    elseif event.ability:GetName() == "doom_bringer_scorched_earth_custom" then
                        local Manacost = event.ability:GetSpecialValueFor("mana_cost")
                        self:GetParent():GiveMana(Manacost)
                    end
                end
            end
        end
    end
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:DeclareFunctions()
	return
	{
        MODIFIER_EVENT_ON_SPENT_MANA,
        MODIFIER_PROPERTY_DISABLE_HEALING
	}
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura:CheckState()
    local state = {}
    return state
end

-- Эффект-модификатор, применяется когда аура прокачана хотя бы на 1 уровень
modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect = class({})

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:IsHidden() return false end
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:IsPurgable() return false end
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:IsPurgeException() return false end
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:RemoveOnDeath() return false end
function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:GetTexture() return "crystal_maiden_brilliance_aura" end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:OnCreated(params)
    if IsServer() then
        self:StartIntervalThink(0.5)
    end
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:OnIntervalThink()
    if not IsServer() then return end

    local parent = self:GetParent()
    if parent:PassivesDisabled() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
	}
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:GetModifierPercentageManacostStacking(params)
    local parent = self:GetParent()
    if parent:PassivesDisabled() then
        return 0
    end
    local ability = self:GetAbility()
    if ability and not ability:IsNull() then
        return ability:GetSpecialValueFor("manacost_reduction_pct")
    end
    return 0
end

function modifier_hero_unique_modifier_crystal_maiden_brilliance_aura_effect:GetModifierPercentageCooldown(params)
    local parent = self:GetParent()
    if parent:PassivesDisabled() then
        return 0
    end
    local ability = self:GetAbility()
    if ability and not ability:IsNull() then
        return ability:GetSpecialValueFor("cooldown_reduction_pct")
    end
    return 0
end