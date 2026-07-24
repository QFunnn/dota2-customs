--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_revenants_brooch_custom", "items/item_revenants_brooch_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_revenants_brooch_custom_counter", "items/item_revenants_brooch_custom", LUA_MODIFIER_MOTION_NONE)

item_revenants_brooch_custom = class({})

function item_revenants_brooch_custom:GetIntrinsicModifierName()
    return "modifier_revenants_brooch_custom"
end

function item_revenants_brooch_custom:GetManaCost(level)
    if IsServer() then
        if not self or not self:GetCaster() then return end 
        if self:GetToggleState() then
            if self:GetParent():HasModifier("modifier_huskar_blood_magic") then return end
            return self:GetSpecialValueFor("manacost_per_hit")
        end
    end
end

function item_revenants_brooch_custom:GetHealthCost(level)
    if IsServer() then
        if not self or not self:GetCaster() then return end 
        if self:GetToggleState() then
            if not self:GetParent():HasModifier("modifier_huskar_blood_magic") then return end
            return self:GetSpecialValueFor("manacost_per_hit")
        end
    end
end

function item_revenants_brooch_custom:GetAbilityTextureName()
    if not self or not self:GetCaster() then return end 
    if self:GetToggleState() then
        return "item_revenants_brooch_custom_active"
    end
    return "item_revenants_brooch_custom"
end

function item_revenants_brooch_custom:OnToggle()
    local caster = self:GetCaster()
end

modifier_revenants_brooch_custom = class({})
function modifier_revenants_brooch_custom:IsHidden() return true end
function modifier_revenants_brooch_custom:IsPurgable() return false end
function modifier_revenants_brooch_custom:IsPurgeException() return false end

function modifier_revenants_brooch_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MAGICAL_LIFESTEAL
    }
end

function modifier_revenants_brooch_custom:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage
end

function modifier_revenants_brooch_custom:OnCreated()
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.lifesteal = self:GetAbility():GetSpecialValueFor("spell_lifesteal")
    self.lifesteal_creeps = self:GetAbility():GetSpecialValueFor("spell_lifesteal_creep")
    if not IsServer() then return end 
    self.parent = self:GetParent()
    self:StartIntervalThink(FrameTime())
end

function modifier_revenants_brooch_custom:GetModifierProperty_MagicalLifesteal(params)
    return self.lifesteal
end

function modifier_revenants_brooch_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAbility():GetToggleState() then
        if not self:GetParent():HasModifier("modifier_revenants_brooch_custom_counter") and not self:GetParent():IsIllusion() then
            self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_revenants_brooch_custom_counter", {})
        end
    else
        self:GetParent():RemoveModifierByName("modifier_revenants_brooch_custom_counter")
    end
end

function modifier_revenants_brooch_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_revenants_brooch_custom_counter")
end

modifier_revenants_brooch_custom_counter = class({})

function modifier_revenants_brooch_custom_counter:IsHidden()
    return false
end

function modifier_revenants_brooch_custom_counter:IsPurgable()
    return false
end

function modifier_revenants_brooch_custom_counter:OnCreated(params)
    self.parent = self:GetParent()
    self.damage_reduce = self:GetAbility():GetSpecialValueFor("damage_reduction")
    self.mana_cost = self:GetAbility():GetSpecialValueFor("manacost_per_hit")
    self.parent = self:GetParent()
    if not IsServer() then return end
    self.modifier = self.parent:AddNewModifier(self.parent, nil, "modifier_item_revenants_brooch_active", {})
    self:StartIntervalThink(0.2)
end

function modifier_revenants_brooch_custom_counter:OnDestroy()
    if not IsServer() then return end
    if self.modifier and not self.modifier:IsNull() then
        self.modifier:Destroy()
    end
end

function modifier_revenants_brooch_custom_counter:OnIntervalThink()
    if not IsServer() then return end 
    local item = self.parent:FindItemInInventory(self:GetAbility():GetName())
    if not item or item:IsInBackpack() or self.parent:IsIllusion() then 
        self:Destroy()
        return
    end 
end 

function modifier_revenants_brooch_custom_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_SUPPRESS_CRIT,
    }
end

function modifier_revenants_brooch_custom:GetSuppressCrit()
    return 1
end

function modifier_revenants_brooch_custom_counter:GetModifierDamageOutgoing_Percentage()
    return self.damage_reduce
end

function modifier_revenants_brooch_custom_counter:GetModifierProjectileName()
    if self:GetParent():HasModifier("modifier_huskar_blood_magic") then
        if self:GetParent():GetHealth() < self:GetAbility():GetEffectiveHealthCost(-1) then return end
    else
        if self:GetParent():GetMana() < self:GetAbility():GetEffectiveManaCost(-1) then return end
    end
    if not self:GetAbility() then return "" end
    return "particles/items_fx/revenant_brooch_projectile.vpcf"
end

function modifier_revenants_brooch_custom_counter:GetOverrideAttackMagical()
    if IsClient() then return 1 end
    if self.parent:IsIllusion() then return end
    if self:GetParent():HasModifier("modifier_huskar_blood_magic") then
        if self:GetParent():GetHealth() < self:GetAbility():GetEffectiveHealthCost(-1) then return 0 end
    else
        if self:GetParent():GetMana() < self:GetAbility():GetEffectiveManaCost(-1) then return 0 end
    end
    if not self:GetAbility() then return 0 end
    return 1
end

function modifier_revenants_brooch_custom_counter:GetModifierTotalDamageOutgoing_Percentage(event)
    local parent = self:GetParent()
    if self.parent:IsIllusion() then return end
    if event.inflictor and (event.inflictor:GetName() ~= "muerta_gunslinger_custom" and event.inflictor:GetName() ~= "windrunner_focusfire_whirlwind") then return 0 end
    if event.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return 0 end
    if event.damage_type == DAMAGE_TYPE_MAGICAL then return 0 end
    if event.inflictor == self:GetAbility() then return 0 end
    if event.target and string.find(event.target:GetUnitName(), "npc_dota_techies") then return end
    if not self:GetAbility() then return 0 end
    if self:GetParent():GetUnitName() == "npc_dota_hero_luna" then
        local luna_moon_glaive_custom = self:GetParent():FindAbilityByName("luna_moon_glaive_custom")
        if luna_moon_glaive_custom and luna_moon_glaive_custom.outgoing and luna_moon_glaive_custom.outgoing > 0 then
            return
        end
    end
    if not event.process_procs then return end
    if parent:HasModifier("modifier_juggernaut_blade_fury_custom") then return end
    if self:GetParent():HasModifier("modifier_huskar_blood_magic") then
        if self:GetParent():GetHealth() < self:GetAbility():GetEffectiveHealthCost(-1) then return 0 end
        if not event.no_attack_cooldown and not self:GetCaster().riki_attack then
            if self:GetCaster():HasModifier("modifier_huskar_14") then
                local mana_cost = self:GetAbility():GetEffectiveHealthCost(-1)
                self:GetCaster():Heal(mana_cost / 100 * 100, nil)
            else
                self:GetCaster():SetHealth(math.max(self:GetCaster():GetHealth() - self:GetAbility():GetEffectiveHealthCost(-1), 1))
            end
        end
    else
        if self:GetParent():GetMana() < self:GetAbility():GetEffectiveManaCost(-1) then return 0 end
        if not event.no_attack_cooldown and not self:GetCaster().riki_attack then
            if self:GetCaster():HasModifier("modifier_huskar_14") then
                local mana_cost = self:GetAbility():GetEffectiveManaCost(-1)
                self:GetCaster():Heal(mana_cost / 100 * 100, nil)
            end
            self:GetParent():SpendMana(self:GetAbility():GetEffectiveManaCost(-1), self:GetAbility())
        end
    end
    local modifier_earthshaker_enchant_totem_custom = self:GetParent():HasModifier("modifier_earthshaker_enchant_totem_custom")
    Timers:CreateTimer(FrameTime(), function()
        if modifier_earthshaker_enchant_totem_custom then return end
        ApplyDamage({ attacker = parent, damage = event.original_damage * 0.8, damage_type = DAMAGE_TYPE_MAGICAL, victim = event.target, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK })
    end)
    event.target:EmitSound("Item.Brooch.Target." .. (parent:IsRangedAttacker() and "Ranged" or "Melee"))
    if modifier_earthshaker_enchant_totem_custom then return end
    return -200
end

function modifier_revenants_brooch_custom_counter:GetEffectName()
    return "particles/items5_fx/revenant_brooch.vpcf"
end

function modifier_revenants_brooch_custom_counter:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end