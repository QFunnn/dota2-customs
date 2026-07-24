--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dazzle_bad_juju_custom", "heroes/hero_dazzle/dazzle_bad_juju_custom", LUA_MODIFIER_MOTION_NONE)

dazzle_bad_juju_custom = class({})

function dazzle_bad_juju_custom:GetHealthCost(level)
    local BaseCost = self:GetSpecialValueFor("health_cost")
    local Cost = BaseCost
    local Stacks = (self:GetCaster():GetModifierStackCount("modifier_dazzle_bad_juju_custom", self:GetCaster()))
    local IncreaseHealthCost = self:GetSpecialValueFor("mana_cost_increase_pct")
    for i=1, Stacks do
        Cost = Cost + (Cost * (IncreaseHealthCost * 0.01))
    end
	return Cost
end

function dazzle_bad_juju_custom:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()

    local health_cost = self:GetHealthCost(self:GetLevel())
    if health_cost > 0 then
        ApplyDamage({
            attacker = caster,
            victim = caster,
            damage = health_cost,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
            ability = self,
        })
    end

    caster:EmitSound("Hero_Dazzle.Weave")

    local IncreaseDuration = self:GetSpecialValueFor("mana_cost_increase_duration")
    local CooldownReductionItems = self:GetSpecialValueFor("cooldown_reduction_items")
    local CooldownReductionAbilities = self:GetSpecialValueFor("cooldown_reduction")

    caster:AddNewModifier(caster, self, "modifier_dazzle_bad_juju_custom", {duration = IncreaseDuration})

    local skip_cooldown = 
    {
        ["dark_willow_shadow_realm"] = true,
        ["huskar_burning_spear"] = true,
        ["drow_ranger_frost_arrows_custom"] = true,
        ["kunkka_tidebringer"] = true,
        ["viper_poison_attack"] = true,
        ["clinkz_searing_arrows"] = true,
        ["enchantress_impetus"] = true,
        ["weaver_geminate_attack"] = true,
        ["jakiro_liquid_fire"] = true,
        ["jakiro_liquid_ice"] = true,
        ["ancient_apparition_chilling_touch"] = true,
        ["silencer_glaives_of_wisdom"] = true,
        ["obsidian_destroyer_arcane_orb"] = true,
        ["tusk_walrus_punch"] = true,
        ["frostivus2018_clinkz_searing_arrows"] = true,
        ["puck_phase_shift_custom"] = true,
        ["dazzle_bad_juju_custom"] = true,
        ["item_refresher_custom"] = true,
    }

    for i=0, caster:GetAbilityCount()-1 do
        local ability = caster:GetAbilityByIndex(i)
        if ability and skip_cooldown[ability:GetAbilityName()] == nil then
            local flCurrentCooldown = ability:GetCooldownTimeRemaining()
			local flReducedCooldown = flCurrentCooldown - CooldownReductionAbilities
			ability:EndCooldown()
			if flReducedCooldown > 0 then
				ability:StartCooldown(flReducedCooldown)
			end
        end
    end

    for i=0,5 do
        local ability = caster:GetItemInSlot(i)
        if ability and skip_cooldown[ability:GetAbilityName()] == nil then
            local flCurrentCooldown = ability:GetCooldownTimeRemaining()
			local flReducedCooldown = flCurrentCooldown - CooldownReductionItems
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
function modifier_dazzle_bad_juju_custom:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.BonusArmor = ability:GetSpecialValueFor("bonus_armor")
        self.MaxStacks = ability:GetSpecialValueFor("max_stacks")
    end

    if IsServer() and self:GetStackCount() < self.MaxStacks then
        self:IncrementStackCount()
    end
end

function modifier_dazzle_bad_juju_custom:OnRefresh()
    self:OnCreated()
end

function modifier_dazzle_bad_juju_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_dazzle_bad_juju_custom:GetModifierPhysicalArmorBonus() return (self.BonusArmor or 0) * self:GetStackCount() end