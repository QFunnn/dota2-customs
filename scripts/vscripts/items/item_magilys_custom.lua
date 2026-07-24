--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_magilys_custom", "items/item_magilys_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_magilys_custom_cooldown", "items/item_magilys_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_gleipnir_magic_custom_debuff", "items/item_magilys_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_gleipnir_magic_custom_debuff_rooted", "items/item_magilys_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_kryptonite_another_cooldown", "items/item_magilys_custom", LUA_MODIFIER_MOTION_NONE )
require( "utils/bit" )

item_magilys_custom = class({})

function item_magilys_custom:GetIntrinsicModifierName() 
    return "modifier_item_magilys_custom"
end

modifier_item_magilys_custom = class({})

modifier_item_magilys_custom.percentage_abilities = 
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
    ["item_hydras_breath"]=true,
}

function modifier_item_magilys_custom:IsHidden() return true end
function modifier_item_magilys_custom:IsPurgable() return false end
function modifier_item_magilys_custom:IsPurgeException() return false end

function modifier_item_magilys_custom:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
    self.bonus_agility = self.ability:GetSpecialValueFor("bonus_agility")
    self.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
    self.chance = self.ability:GetSpecialValueFor("chance")
    self.cooldown_crit = self.ability:GetSpecialValueFor("cooldown_crit")
    self.critical_damage = self.ability:GetSpecialValueFor("critical_damage")
end

function modifier_item_magilys_custom:DeclareFunctions()
    return  
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST
    }
end

function modifier_item_magilys_custom:OnAbilityFullyCast(params)
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
        
        if self:GetAbility():GetName() ~= "item_gleipnir_magic_custom" then return end
        if not self:GetParent():HasModifier("modifier_item_kryptonite_another_cooldown") then
            self:GetAbility().IsCastAbility = true
            local units = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
            for _, unit in pairs(units) do
                self:FillacteryEffect(unit)
            end
            self:GetAbility().IsCastAbility = nil
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_kryptonite_another_cooldown", {duration = 6})
        end
    end
end

function modifier_item_magilys_custom:FillacteryEffect(unit)
    if not IsServer() then return end
    ApplyDamage({attacker = self:GetCaster(), victim = unit, ability = self:GetAbility(), damage = self:GetAbility():GetSpecialValueFor("bonus_spell_damage"), damage_type = DAMAGE_TYPE_MAGICAL})
    unit:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_phylactery_slow", {duration = self:GetAbility():GetSpecialValueFor("slow_duration")})
    local particle = ParticleManager:CreateParticle("particles/items_fx/phylactery.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    unit:EmitSound("Item.Phylactery.Target")
end

-- Manual spell lifesteal hook (only fires for gleipnir, not magilys precursor).
-- Триггерится через modifier_abilities_optimization_thinker.takedamage_attacker диспатчер.
function modifier_item_magilys_custom:TakeDamageScriptModifier(keys)
    if not IsServer() then return end
    if not self or self:IsNull() then return end
    if self.ability:GetName() ~= "item_gleipnir_magic_custom" then return end
    if keys.attacker ~= self.parent then return end
    if keys.unit:IsBuilding() or keys.unit:IsOther() then return end
    if self.parent:IsIllusion() then return end
    if keys.inflictor == nil then return end
    if keys.damage_category ~= DOTA_DAMAGE_CATEGORY_SPELL then return end
    if bit:_and(keys.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL) == DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL then return end
    -- Анти-дубль: если у героя НЕСКОЛЬКО глейпниров — лечим только от первого
    -- gleipnir-инстанса (НЕ просто [1] — он может быть от magilys precursor).
    local first_gleipnir = nil
    for _, mod in pairs(self.parent:FindAllModifiersByName(self:GetName())) do
        if mod:GetAbility() and mod:GetAbility():GetName() == "item_gleipnir_magic_custom" then
            first_gleipnir = mod
            break
        end
    end
    if first_gleipnir ~= self then return end
    local lifesteal = self.ability:GetSpecialValueFor("spell_lifesteal")
    if lifesteal and lifesteal > 0 and keys.damage and keys.damage > 0 then
        keys.attacker:Heal(keys.damage * lifesteal * 0.01, keys.attacker)
    end
end

function modifier_item_magilys_custom:GetModifierBonusStats_Strength()
    return self.bonus_strength
end

function modifier_item_magilys_custom:GetModifierBonusStats_Agility()
    return self.bonus_agility
end

function modifier_item_magilys_custom:GetModifierBonusStats_Intellect()
    return self.bonus_intellect
end

function modifier_item_magilys_custom:PercentAbility(ability)
    if self.percentage_abilities[ability] == nil then
        return false
    end
    return true
end

function modifier_item_magilys_custom:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end

function modifier_item_magilys_custom:GetModifierTotalDamageOutgoing_Percentage(params)
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
            if self.parent:HasModifier("modifier_item_magilys_custom_cooldown") then
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
                self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_item_magilys_custom_cooldown", {duration = self.cooldown_crit})
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.target, params.original_damage + (params.original_damage / 100 * (critical_damage - 100)), nil)
                return critical_damage - 100
            end
        end
    end
end

modifier_item_magilys_custom_cooldown = class({})
function modifier_item_magilys_custom_cooldown:IsHidden() return true end
function modifier_item_magilys_custom_cooldown:IsPurgable() return false end
function modifier_item_magilys_custom_cooldown:IsPurgeException() return false end

----------------------------------------------------------------------------------

item_gleipnir_magic_custom = class({})

function item_gleipnir_magic_custom:GetIntrinsicModifierName() 
    return "modifier_item_magilys_custom"
end

function item_gleipnir_magic_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function item_gleipnir_magic_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local radius = self:GetSpecialValueFor("radius")
    self:GetCaster():EmitSound("Item.Gleipnir.Cast")
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for _, target in pairs(enemies) do
        local info = {Target = target,Source = self:GetCaster(),Ability = self,EffectName = "particles/items3_fx/gleipnir_projectile_custom.vpcf",iMoveSpeed = 1900,vSourceLoc= self:GetCaster():GetAbsOrigin(),bDodgeable = true}
        ProjectileManager:CreateTrackingProjectile(info)
    end
end

function item_gleipnir_magic_custom:OnProjectileHit(target, vLocation)
    if target == nil then return end
    target:EmitSound("Item.Gleipnir.Target")
    target:AddNewModifier(self:GetCaster(), self, "modifier_item_gleipnir_magic_custom_debuff", {duration = self:GetSpecialValueFor("debuff_duration") * (1-target:GetStatusResistance())})
    target:AddNewModifier(self:GetCaster(), self, "modifier_item_gleipnir_magic_custom_debuff_rooted", {duration = self:GetSpecialValueFor("duration") * (1-target:GetStatusResistance())})
end

modifier_item_gleipnir_magic_custom_debuff = class({})

function modifier_item_gleipnir_magic_custom_debuff:IsPurgable() return true end

function modifier_item_gleipnir_magic_custom_debuff:DeclareFunctions()
    return 
    { 
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, 
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION,
    } 
end

function modifier_item_gleipnir_magic_custom_debuff:OnCreated()
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.spell_amplify = self.ability:GetSpecialValueFor("spell_amplify")
end

function modifier_item_gleipnir_magic_custom_debuff:GetModifierIncomingDamage_Percentage(keys)
    if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL or keys.damage_type == DAMAGE_TYPE_MAGICAL then
        return self.spell_amplify
    end
end

function modifier_item_gleipnir_magic_custom_debuff:GetModifierMagicalResistanceDirectModification(keys)
    if IsClient() then
        return self.spell_amplify * -1
    end
end

modifier_item_gleipnir_magic_custom_debuff_rooted = class({})
function modifier_item_gleipnir_magic_custom_debuff_rooted:IsPurgable() return true end
function modifier_item_gleipnir_magic_custom_debuff_rooted:CheckState()
    if not self:GetParent():IsHero() then
        return
        {
            [MODIFIER_STATE_ROOTED] = true,
            [MODIFIER_STATE_SILENCED] = true
        }
    end
    return
    {
        [MODIFIER_STATE_ROOTED] = true
    }
end

function modifier_item_gleipnir_magic_custom_debuff_rooted:GetEffectName() return "particles/items3_fx/gleipnir__custom_root.vpcf" end



modifier_item_kryptonite_another_cooldown = class({})
function modifier_item_kryptonite_another_cooldown:IsPurgable() return false end
function modifier_item_kryptonite_another_cooldown:IsPurgeException() return false end
function modifier_item_kryptonite_another_cooldown:RemoveOnDeath() return false end
function modifier_item_kryptonite_another_cooldown:IsHidden() return true end