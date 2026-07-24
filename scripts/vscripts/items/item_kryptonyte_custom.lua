--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_kryptonyte_custom", "items/item_kryptonyte_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_kryptonyte_custom_cooldown", "items/item_kryptonyte_custom", LUA_MODIFIER_MOTION_NONE )

item_kryptonyte_custom = class({})

function item_kryptonyte_custom:GetIntrinsicModifierName() 
    return "modifier_item_kryptonyte_custom"
end

modifier_item_kryptonyte_custom = class({})
function modifier_item_kryptonyte_custom:IsHidden() return true end
function modifier_item_kryptonyte_custom:IsPurgable() return false end
function modifier_item_kryptonyte_custom:IsPurgeException() return false end

modifier_item_kryptonyte_custom.percentage_abilities = 
{
    ["abyssal_underlord_firestorm_custom"] = true,
    ["ability_elder_titan_earth_splitter"] = true,
    ["winter_wyvern_arctic_burn"] = true,
    ["doom_bringer_infernal_blade"] = true,
    ["enigma_midnight_pulse_custom"] = true,
    ["enigma_black_hole"] = true,
    ["huskar_life_break"] = true,
    ["phoenix_sun_ray"] = true,
    ["spectre_dispersion_custom"] = true,
    ["death_prophet_spirit_siphon"] = true,
    ["custom_phantom_assassin_fan_of_knives"] = true,
    ["bloodseeker_rupture"] = true,
    ["item_spirit_vessel"] = true,
    ["terrorblade_reflection_lua"] = true,
    ["venomancer_poison_nova_custom"] = true,
    ["necrolyte_heartstopper_aura_lua"] = true,
    ["zuus_static_field"] = true,
    ["item_blade_mail"] = true,
    ["item_panzer_custom"] = true,
    ["item_iron_talon"] = true,
    ["sandking_caustic_finale"] = true,
    ["sandking_caustic_finale_lua"] = true,
    ["jakiro_liquid_ice"] = true,
    ["jakiro_liquid_ice_lua"] = true,
    ["witch_doctor_maledict_custom"] = true,
    ["bloodseeker_blood_mist_custom"] = true,
    ["witch_doctor_voodoo_restoration_custom"] = true,
    ["item_shivas_guard_2"] = true,
    ["meepo_ransack_custom"] = true,
    ["shadow_demon_disseminate_custom"] = true,
    ["dragon_knight_elder_dragon_form_custom"] = true,
    ["muerta_pierce_the_veil"] = true,
    ["zuus_arc_lightning_custom"] = true,
    ["venomancer_noxious_plague"] = true,
    ["life_stealer_infest"]=true,
}

function modifier_item_kryptonyte_custom:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.bonus_strength = self.ability:GetSpecialValueFor("bonus_all_stats")
    self.bonus_agility = self.ability:GetSpecialValueFor("bonus_all_stats")
    self.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect") + self.ability:GetSpecialValueFor("bonus_all_stats")
    self.chance = self.ability:GetSpecialValueFor("chance")
    self.cooldown_crit = self.ability:GetSpecialValueFor("cooldown_crit")
    self.critical_damage = self.ability:GetSpecialValueFor("critical_damage")
    self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
    self.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana")
end

function modifier_item_kryptonyte_custom:DeclareFunctions()
    return  
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST
    }
end

function modifier_item_kryptonyte_custom:GetModifierHealthBonus()
    return self.bonus_health
end

function modifier_item_kryptonyte_custom:GetModifierManaBonus()
    return self.bonus_mana
end

function modifier_item_kryptonyte_custom:GetModifierBonusStats_Strength()
    return self.bonus_strength
end

function modifier_item_kryptonyte_custom:GetModifierBonusStats_Agility()
    return self.bonus_agility
end

function modifier_item_kryptonyte_custom:GetModifierBonusStats_Intellect()
    return self.bonus_intellect
end

function modifier_item_kryptonyte_custom:PercentAbility(ability)
    if self.percentage_abilities[ability] == nil then
        return false
    end
    return true
end

function modifier_item_kryptonyte_custom:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end

function modifier_item_kryptonyte_custom:OnAbilityFullyCast(params)
    if params.unit == self.parent then
        -- Проверяем, не является ли это неудачной активацией смока
        if params.ability and params.ability.GetAbilityName then
            local ability_name = params.ability:GetAbilityName()
            if ability_name == "item_smoke_of_deceit_custom" then
                if params.ability.bSmokeActivated == false then
                    return
                end
            end
        end
        
        if self:GetAbility():IsFullyCastable() and not self:GetParent():HasModifier("modifier_item_kryptonite_another_cooldown") then
            self:GetAbility().IsCastAbility = true
            local units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
            for _, unit in pairs(units) do
                self:FillacteryEffect(unit)
            end
            self:GetAbility().IsCastAbility = nil
            self:GetAbility():UseResources(false, false, false, true)
        end
    end
end

function modifier_item_kryptonyte_custom:FillacteryEffect(unit)
    if not IsServer() then return end
    ApplyDamage({attacker = self:GetCaster(), victim = unit, ability = self:GetAbility(), damage = self:GetAbility():GetSpecialValueFor("bonus_spell_damage"), damage_type = DAMAGE_TYPE_MAGICAL})
    unit:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_phylactery_slow", {duration = self:GetAbility():GetSpecialValueFor("slow_duration")})
    local particle = ParticleManager:CreateParticle("particles/items_fx/phylactery.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    unit:EmitSound("Item.Phylactery.Target")
end

function modifier_item_kryptonyte_custom:GetModifierTotalDamageOutgoing_Percentage(params)
    if params.damage_type == DAMAGE_TYPE_MAGICAL then 
        if params.target == nil then return end
        if params.inflictor == nil then return end
        if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS ) then return end
        if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION ) then return end
        local chance = self.chance
        if params.target:HasModifier("modifier_item_gleipnir_magic_custom_debuff") and not params.target:IsHero() then
            chance = chance + self:GetAbility():GetSpecialValueFor("bonus_crit_creep")
        end
        if RollPercentage(chance) or self:GetAbility().IsCastAbility then
            local critical_damage = self.critical_damage
            if self.parent:HasModifier("modifier_item_kryptonyte_custom_cooldown") then
                if (params.target:HasModifier("modifier_item_gleipnir_magic_custom_debuff") and not params.target:IsHero()) or self:GetAbility().IsCastAbility then
                    if self:PercentAbility(params.inflictor:GetAbilityName()) then
                        return
                    end
                    SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.target, params.original_damage + (params.original_damage / 100 * (critical_damage - 100)), nil)
                    return critical_damage - 100
                end
            else
                if self:PercentAbility(params.inflictor:GetAbilityName()) then
                    return
                end
                self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_item_kryptonyte_custom_cooldown", {duration = self.cooldown_crit})
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.target, params.original_damage + (params.original_damage / 100 * (critical_damage - 100)), nil)
                return critical_damage - 100
            end
        end
    end
end

modifier_item_kryptonyte_custom_cooldown = class({})
function modifier_item_kryptonyte_custom_cooldown:IsHidden() return true end
function modifier_item_kryptonyte_custom_cooldown:IsPurgable() return false end
function modifier_item_kryptonyte_custom_cooldown:IsPurgeException() return false end