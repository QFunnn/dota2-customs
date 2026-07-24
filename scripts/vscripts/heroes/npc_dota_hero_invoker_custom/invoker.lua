--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_invoker_quas_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_quas_custom_passive", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_quas_custom_damage_interval", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

invoker_quas_custom = class({})

invoker_quas_custom.modifier_invoker_15_damage = {4,8,12}
invoker_quas_custom.modifier_invoker_15_duration = 3


function invoker_quas_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_invoker.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_invoker.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_invoker.vpcf", context)
end

function invoker_quas_custom:GetIntrinsicModifierName()
    return "modifier_invoker_quas_custom_passive"
end

function invoker_quas_custom:ProcsMagicStick()
    return false
end

function invoker_quas_custom:OnSpellStart()
    local caster = self:GetCaster()
    local modifier = caster:AddNewModifier(
        caster,
        self,
        "modifier_invoker_quas_custom",
        {  }
    )
    self.invoke:AddOrb( modifier, "particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf" )
end

function invoker_quas_custom:OnUpgrade()
    if not self.invoke then
        local invoke = self:GetCaster():FindAbilityByName( "invoker_invoke_custom" )
        if invoke:GetLevel()<1 then invoke:UpgradeAbility(true) end
        self.invoke = invoke
    else
        self.invoke:UpdateOrb("modifier_invoker_quas_custom", self:GetLevel())
    end
end

modifier_invoker_quas_custom = class({})

function modifier_invoker_quas_custom:IsHidden()
    return false
end

function modifier_invoker_quas_custom:IsDebuff()
    return false
end

function modifier_invoker_quas_custom:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_invoker_quas_custom:IsPurgable()
    return false
end

function modifier_invoker_quas_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    }
end

function modifier_invoker_quas_custom:GetModifierConstantHealthRegen()
    return self:GetAbility():GetSpecialValueFor("hp_regen_per_instance")
end

modifier_invoker_quas_custom_passive = class({})

function modifier_invoker_quas_custom_passive:IsHidden() return true end
function modifier_invoker_quas_custom_passive:IsPurgable() return false end
function modifier_invoker_quas_custom_passive:IsPurgeException() return false end

function modifier_invoker_quas_custom_passive:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
         
    }
    return funcs
end

function modifier_invoker_quas_custom_passive:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_strength") * self:GetAbility():GetLevel()
end

function modifier_invoker_quas_custom_passive:OnAttackLanded(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if not self:GetCaster():HasModifier("modifier_invoker_15") then return end
    params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_invoker_quas_custom_damage_interval", {duration = self:GetAbility().modifier_invoker_15_duration+FrameTime()})
end

modifier_invoker_quas_custom_damage_interval = class({})

function modifier_invoker_quas_custom_damage_interval:OnCreated(params)
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_invoker_quas_custom_damage_interval:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self:GetAbility().modifier_invoker_15_damage[self:GetCaster():GetTalentLevel("modifier_invoker_15")] * self:GetAbility():GetLevel(), damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_invoker_quas_custom_damage_interval:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOOLTIP
    }
end

function modifier_invoker_quas_custom_damage_interval:OnTooltip()
    return self:GetAbility().modifier_invoker_15_damage[self:GetCaster():GetTalentLevel("modifier_invoker_15")] * self:GetAbility():GetLevel()
end

LinkLuaModifier( "modifier_invoker_wex_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_wex_custom_passive", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

invoker_wex_custom = class({})

invoker_wex_custom.modifier_invoker_8_attack_speed = {4,8,12}

function invoker_wex_custom:ProcsMagicStick()
    return false
end

function invoker_wex_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf", context )
end

function invoker_wex_custom:GetIntrinsicModifierName()
    return "modifier_invoker_wex_custom_passive"
end

function invoker_wex_custom:OnSpellStart()
    local caster = self:GetCaster()
    local modifier = caster:AddNewModifier(
        caster,
        self, 
        "modifier_invoker_wex_custom",
        {  }
    )
    self.invoke:AddOrb( modifier, "particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf" )
end

function invoker_wex_custom:OnUpgrade()
    if not self.invoke then
        local invoke = self:GetCaster():FindAbilityByName( "invoker_invoke_custom" )
        if invoke:GetLevel()<1 then invoke:UpgradeAbility(true) end
        self.invoke = invoke
    else
        self.invoke:UpdateOrb("modifier_invoker_wex_custom", self:GetLevel())
    end
end

modifier_invoker_wex_custom = class({})

function modifier_invoker_wex_custom:IsHidden()
    return false
end

function modifier_invoker_wex_custom:IsDebuff()
    return false
end

function modifier_invoker_wex_custom:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_invoker_wex_custom:IsPurgable()
    return false
end

function modifier_invoker_wex_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_invoker_wex_custom:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("attack_speed_per_instance")
end

function modifier_invoker_wex_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("move_speed_per_instance")
end

modifier_invoker_wex_custom_passive = class({})

function modifier_invoker_wex_custom_passive:IsHidden() return true end
function modifier_invoker_wex_custom_passive:IsPurgable() return false end
function modifier_invoker_wex_custom_passive:IsPurgeException() return false end

function modifier_invoker_wex_custom_passive:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
    return funcs
end

function modifier_invoker_wex_custom_passive:GetModifierAttackSpeedBonus_Constant()
    if not self:GetParent():HasModifier("modifier_invoker_8") then return end
    return self:GetAbility().modifier_invoker_8_attack_speed[self:GetCaster():GetTalentLevel("modifier_invoker_8")] * self:GetAbility():GetLevel()
end

function modifier_invoker_wex_custom_passive:GetModifierBonusStats_Agility()
    return self:GetAbility():GetSpecialValueFor("bonus_agility") * self:GetAbility():GetLevel()
end

LinkLuaModifier( "modifier_invoker_exort_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_exort_custom_passive", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

invoker_exort_custom = class({})

invoker_exort_custom.modifier_invoker_1_damage = {4,8,12}

function invoker_exort_custom:ProcsMagicStick()
    return false
end

function invoker_exort_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf", context )
end

function invoker_exort_custom:GetIntrinsicModifierName()
    return "modifier_invoker_exort_custom_passive"
end

function invoker_exort_custom:OnSpellStart()
    local caster = self:GetCaster()
    local modifier = caster:AddNewModifier(
        caster,
        self,
        "modifier_invoker_exort_custom",
        {  }
    )
    self.invoke:AddOrb( modifier, "particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf" )
end

function invoker_exort_custom:OnUpgrade()
    if not self.invoke then
        local invoke = self:GetCaster():FindAbilityByName( "invoker_invoke_custom" )
        if invoke:GetLevel()<1 then invoke:UpgradeAbility(true) end
        self.invoke = invoke
    else
        self.invoke:UpdateOrb("modifier_invoker_exort_custom", self:GetLevel())
    end
end

modifier_invoker_exort_custom = class({})

function modifier_invoker_exort_custom:IsHidden()
    return false
end

function modifier_invoker_exort_custom:IsDebuff()
    return false
end

function modifier_invoker_exort_custom:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_invoker_exort_custom:IsPurgable()
    return false
end

function modifier_invoker_exort_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_invoker_exort_custom:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage_per_instance")
end

modifier_invoker_exort_custom_passive = class({})

function modifier_invoker_exort_custom_passive:IsHidden() return true end
function modifier_invoker_exort_custom_passive:IsPurgable() return false end
function modifier_invoker_exort_custom_passive:IsPurgeException() return false end

function modifier_invoker_exort_custom_passive:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
    return funcs
end

function modifier_invoker_exort_custom_passive:GetModifierPreAttack_BonusDamage()
    if not self:GetParent():HasModifier("modifier_invoker_1") then return end
    return self:GetAbility().modifier_invoker_1_damage[self:GetCaster():GetTalentLevel("modifier_invoker_1")] * self:GetAbility():GetLevel()
end

function modifier_invoker_exort_custom_passive:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_intellect") * self:GetAbility():GetLevel()
end

invoker_invoke_custom = class({})

function invoker_invoke_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_invoke.vpcf", context )
end

function invoker_invoke_custom:ProcsMagicStick()
    return false
end
invoker_empty1_custom = class({})
invoker_empty2_custom = class({})
orb_manager = {}
ability_manager = {}
orb_manager.orb_order = "qwe"

orb_manager.invoke_list = {
    ["qqq"] = "invoker_cold_snap_custom",
    ["qqw"] = "invoker_ghost_walk_custom",
    ["qqe"] = "invoker_ice_wall_custom",
    ["www"] = "invoker_emp_custom",
    ["qww"] = "invoker_tornado_custom",
    ["wwe"] = "invoker_alacrity_custom",
    ["eee"] = "invoker_sun_strike_custom",
    ["qee"] = "invoker_forge_spirit_custom",
    ["wee"] = "invoker_chaos_meteor_custom",
    ["qwe"] = "invoker_deafening_blast_custom",
}

orb_manager.modifier_list = {
    ["q"] = "modifier_invoker_quas_custom",
    ["w"] = "modifier_invoker_wex_custom",
    ["e"] = "modifier_invoker_exort_custom",

    ["modifier_invoker_quas_custom"] = "q",
    ["modifier_invoker_wex_custom"] = "w",
    ["modifier_invoker_exort_custom"] = "e",
}

invoker_invoke_custom.reach_points =
{
    [1] = false,
    [2] = false,
    [3] = false,
}

function invoker_invoke_custom:Spawn()
    if not IsServer() then return end
    self:SetLevel(1)
end

function invoker_invoke_custom:GetCooldown(level)
    local cooldown = 7
    local quas = self:GetCaster():FindAbilityByName("invoker_quas_custom")
    local wex = self:GetCaster():FindAbilityByName("invoker_wex_custom")
    local exort = self:GetCaster():FindAbilityByName("invoker_exort_custom")
    local cd_red = 0
    if exort then
        cd_red = cd_red + exort:GetLevel() * self:GetSpecialValueFor("cooldown_reduction_per_orb")
    end
    if wex then
        cd_red = cd_red + wex:GetLevel() * self:GetSpecialValueFor("cooldown_reduction_per_orb")
    end
    if quas then
        cd_red = cd_red + quas:GetLevel() * self:GetSpecialValueFor("cooldown_reduction_per_orb")
    end
    cooldown = cooldown - cd_red
    return cooldown / ( self:GetCaster():GetCooldownReduction())
end

function invoker_invoke_custom:OnSpellStart()
    local caster = self:GetCaster()
    local ability_name = self.orb_manager:GetInvokedAbility()
    self.ability_manager:Invoke( ability_name )
    self:PlayEffects()
end

function invoker_invoke_custom:OnHeroLevelUp()
    if not IsServer() then return end
    if self:GetCaster():IsIllusion() then return end
    if self:GetCaster():GetLevel() >= self:GetSpecialValueFor("first_ability_level") and not self.reach_points[1] then
        self.reach_points[1] = true
        self:GetCaster():SetAbilityPoints(self:GetCaster():GetAbilityPoints() + 1)
        print("first invoke")
    elseif self:GetCaster():GetLevel() >= self:GetSpecialValueFor("second_ability_level") and not self.reach_points[2] then
        self.reach_points[2] = true
        self:GetCaster():SetAbilityPoints(self:GetCaster():GetAbilityPoints() + 1)
        print("second invoke")
    elseif self:GetCaster():GetLevel() >= self:GetSpecialValueFor("third_ability_level") and not self.reach_points[3] then
        self.reach_points[3]  = true
        self:GetCaster():SetAbilityPoints(self:GetCaster():GetAbilityPoints() + 1)
        print("third invoke")
    end
end

function invoker_invoke_custom:OnUpgrade()
    self.orb_manager = orb_manager:init()
    self.ability_manager = ability_manager:init()
    self.ability_manager.caster = self:GetCaster()
    self.ability_manager.ability = self
    local empty1 = self:GetCaster():FindAbilityByName( "invoker_empty1_custom" )
    local empty2 = self:GetCaster():FindAbilityByName( "invoker_empty2_custom" )
    table.insert(self.ability_manager.ability_slot,empty1)
    table.insert(self.ability_manager.ability_slot,empty2)
end

function invoker_invoke_custom:AddOrb( modifier, particle )
    self.orb_manager:Add( modifier, particle )
end

function invoker_invoke_custom:UpdateOrb( modifer_name, level )
    updates = self.orb_manager:UpdateOrb( modifer_name, level )
    self.ability_manager:UpgradeAbilities()
end

function invoker_invoke_custom:GetOrbLevel( orb_name )
    if not self.orb_manager.status[orb_name] then return 0 end
    return self.orb_manager.status[orb_name].level
end

function invoker_invoke_custom:GetOrbInstances( orb_name )
    if not self.orb_manager.status[orb_name] then return 0 end
    return self.orb_manager.status[orb_name].instances
end

function invoker_invoke_custom:GetOrbs()
    local ret = {}
    for k,v in pairs(self.orb_manager.status) do
        ret[k] = v.level
    end
    return ret
end

function invoker_invoke_custom:PlayEffects()
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_invoke.vpcf"
    local sound_cast = "Hero_Invoker.Invoke"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    self:GetCaster():EmitSound(sound_cast)
end

function orb_manager:init()
    local ret = {}

    ret.MAX_ORB = 3
    ret.status = {}
    ret.modifiers = {}
    ret.names = {}

    for k,v in pairs(self) do
        ret[k] = v
    end
    return ret
end

function orb_manager:Add( modifier, particle )
    local orb_name = self.modifier_list[modifier:GetName()]
    if not self.status[orb_name] then
        self.status[orb_name] = {
            ["instances"] = 0,
            ["level"] = modifier:GetAbility():GetLevel(),
        }
    end

    if modifier:GetCaster().invoked_orbs_particle == nil then
        modifier:GetCaster().invoked_orbs_particle = {}
    end

    if modifier:GetCaster().invoked_orbs_particle_attach == nil then
        modifier:GetCaster().invoked_orbs_particle_attach = {}
        modifier:GetCaster().invoked_orbs_particle_attach[1] = "attach_orb1"
        modifier:GetCaster().invoked_orbs_particle_attach[2] = "attach_orb2"
        modifier:GetCaster().invoked_orbs_particle_attach[3] = "attach_orb3"
    end

    if modifier:GetCaster().invoked_orbs_particle[1] ~= nil then
        ParticleManager:DestroyParticle(modifier:GetCaster().invoked_orbs_particle[1], false)
        modifier:GetCaster().invoked_orbs_particle[1] = nil
    end

    modifier:GetCaster().invoked_orbs_particle[1] = modifier:GetCaster().invoked_orbs_particle[2]
    modifier:GetCaster().invoked_orbs_particle[2] = modifier:GetCaster().invoked_orbs_particle[3]
    modifier:GetCaster().invoked_orbs_particle[3] = ParticleManager:CreateParticle(particle, PATTACH_OVERHEAD_FOLLOW, modifier:GetCaster())
    ParticleManager:SetParticleControlEnt(modifier:GetCaster().invoked_orbs_particle[3], 1, modifier:GetCaster(), PATTACH_POINT_FOLLOW, modifier:GetCaster().invoked_orbs_particle_attach[1], modifier:GetCaster():GetAbsOrigin(), false)


    local temp_attachment_point = modifier:GetCaster().invoked_orbs_particle_attach[1]
    modifier:GetCaster().invoked_orbs_particle_attach[1] = modifier:GetCaster().invoked_orbs_particle_attach[2]
    modifier:GetCaster().invoked_orbs_particle_attach[2] = modifier:GetCaster().invoked_orbs_particle_attach[3]
    modifier:GetCaster().invoked_orbs_particle_attach[3] = temp_attachment_point

    table.insert(self.modifiers,modifier)
    table.insert(self.names,orb_name)
    self.status[orb_name].instances = self.status[orb_name].instances + 1

    if #self.modifiers>self.MAX_ORB then
        self.status[self.names[1]].instances = self.status[self.names[1]].instances - 1

        if not self.modifiers[1]:IsNull() then
            self.modifiers[1]:Destroy()
        end

        table.remove(self.modifiers,1)
        table.remove(self.names,1)
    end
    
end

function orb_manager:GetInvokedAbility()
    local key = ""
    for i=1,string.len(self.orb_order) do
        k = string.sub(self.orb_order,i,i)

        if self.status[k] then 
            for i=1,self.status[k].instances do
                key = key .. k
            end
        end
    end
    return self.invoke_list[key]
end

function orb_manager:UpdateOrb( modifer_name, level )
    for _,modifier in pairs(self.modifiers) do
        if modifier:GetName()==modifer_name then
            modifier:ForceRefresh()
        end
    end

    local orb_name = self.modifier_list[modifer_name]
    if not self.status[orb_name] then
        self.status[orb_name] = {
            ["instances"] = 0,
            ["level"] = level,
        }
    else
        self.status[orb_name].level = level
    end
end

function ability_manager:init()
    local ret = {}

    ret.abilities = {}
    ret.ability_slot = {}
    ret.MAX_ABILITY = 2

    for k,v in pairs(self) do
        ret[k] = v
    end
    return ret
end

function ability_manager:Invoke( ability_name )
    if not ability_name then return end

    local ability = self:GetAbilityHandle( ability_name )
    ability.orbs = self.ability:GetOrbs()

    if self.ability_slot[1] and self.ability_slot[1]==ability then
        self.ability:RefundManaCost()
        self.ability:EndCooldown()
        return
    end

    local exist = 0
    for i=1,#self.ability_slot do
        if self.ability_slot[i]==ability then
            exist = i
        end
    end
    if exist>0 then
        self:InvokeExist( exist )
        self.ability:RefundManaCost()
        self.ability:EndCooldown()
        return
    end

    self:InvokeNew( ability )
end

function ability_manager:InvokeExist( slot )
    for i=slot,2,-1 do
        self.caster:SwapAbilities( 
            self.ability_slot[slot-1]:GetAbilityName(),
            self.ability_slot[slot]:GetAbilityName(),
            true,
            true
        )
        self.ability_slot[slot], self.ability_slot[slot-1] = self.ability_slot[slot-1], self.ability_slot[slot]
    end
end

function ability_manager:InvokeNew( ability )
    if #self.ability_slot<self.MAX_ABILITY then
        table.insert(self.ability_slot,ability)
    else
        self.caster:SwapAbilities( 
            ability:GetAbilityName(),
            self.ability_slot[#self.ability_slot]:GetAbilityName(),
            true,
            false
        )
        self.ability_slot[#self.ability_slot] = ability
    end

    self:InvokeExist( #self.ability_slot )
end

function ability_manager:GetAbilityHandle( ability_name )
    local ability = self.abilities[ability_name]

    if not ability then
        ability = self.caster:FindAbilityByName( ability_name )
        self.abilities[ability_name] = ability
        
        if not ability then
            ability = self.caster:AddAbility( ability_name )
            self.abilities[ability_name] = ability
        end

        self:InitAbility( ability )
    end

    return ability
end

function ability_manager:InitAbility( ability )
    if IsInToolsMode() then
        ability:SetLevel(7)
    else
        ability:SetLevel(1)
    end
    ability.GetOrbSpecialValueFor = function( self, key_name, orb_name )
        if not IsServer() then return 0 end
        if not self.orbs[orb_name] then return 0 end
        return self:GetLevelSpecialValueFor( key_name, self.orbs[orb_name] )
    end
end 

function ability_manager:UpgradeAbilities()
    for _,ability in pairs(self.abilities) do
        ability.orbs = self.ability:GetOrbs()
    end
end

function ability_manager:GetValueQuas(ability, caster, value)
    if caster:GetUnitName() == "npc_dota_hero_rubick" then
        caster = ability.original_owner
    end
    local quas = caster:FindAbilityByName("invoker_quas_custom")
    if quas then
        local level = quas:GetLevel() - 1
        return ability:GetLevelSpecialValueFor(value, level)
    end
    return 0
end

function ability_manager:GetValueWex(ability, caster, value)
    if caster:GetUnitName() == "npc_dota_hero_rubick" then
        caster = ability.original_owner
    end
    local wex = caster:FindAbilityByName("invoker_wex_custom")
    if wex then
        local level = wex:GetLevel() - 1
        return ability:GetLevelSpecialValueFor(value, level)
    end
    return 0
end

function ability_manager:GetValueExort(ability, caster, value)
    if caster:GetUnitName() == "npc_dota_hero_rubick" then
        caster = ability.original_owner
    end
    local exort = caster:FindAbilityByName("invoker_exort_custom")
    if exort then
        local level = exort:GetLevel() - 1
        return ability:GetLevelSpecialValueFor(value, level)
    end
    return 0
end

LinkLuaModifier( "modifier_invoker_alacrity_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

invoker_alacrity_custom = class({})

invoker_alacrity_custom.modifier_invoker_10 = {50,100}
invoker_alacrity_custom.modifier_invoker_10_duration = {2,4}
invoker_alacrity_custom.modifier_invoker_radius = 600

function invoker_alacrity_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_alacrity.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf", context )
end

function invoker_alacrity_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_invoker_10") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_SHOW_IN_GUIDES
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_SHOW_IN_GUIDES
end

function invoker_alacrity_custom:GetCooldown(level)
    return self.BaseClass.GetCooldown( self, level )
end

function invoker_alacrity_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_invoker_10") then
        duration = duration + self.modifier_invoker_10_duration[self:GetCaster():GetTalentLevel("modifier_invoker_10")]
    end
    if self:GetCaster():HasModifier("modifier_invoker_10") then
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.modifier_invoker_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false)
        for _, unit in pairs(units) do
            unit:AddNewModifier( self:GetCaster(), self, "modifier_invoker_alacrity_custom", { duration = duration } )
            unit:EmitSound("Hero_Invoker.Alacrity")
        end
        -- self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_invoker_alacrity_custom", { duration = duration } )
        -- self:GetCaster():EmitSound("Hero_Invoker.Alacrity")
        return
    end
    local target = self:GetCursorTarget()
    target:AddNewModifier( self:GetCaster(), self, "modifier_invoker_alacrity_custom", { duration = duration } )
    target:EmitSound("Hero_Invoker.Alacrity")
end

modifier_invoker_alacrity_custom = class({})

function modifier_invoker_alacrity_custom:OnCreated( kv )
    self.bonus_damage = ability_manager:GetValueExort(self:GetAbility(), self:GetCaster(), "bonus_damage")
    self.bonus_attack_speed = ability_manager:GetValueWex(self:GetAbility(), self:GetCaster(), "bonus_attack_speed")
    if not IsServer() then return end
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_alacrity.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    self:AddParticle( effect_cast, false, false, -1, false, false )
end

function modifier_invoker_alacrity_custom:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
    }
    return funcs
end

function modifier_invoker_alacrity_custom:GetModifierAttackRangeBonus()
    if not self:GetCaster():HasModifier("modifier_invoker_10") then return end
    return self:GetAbility().modifier_invoker_10[self:GetCaster():GetTalentLevel("modifier_invoker_10")]
end

function modifier_invoker_alacrity_custom:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage
end

function modifier_invoker_alacrity_custom:GetModifierAttackSpeedBonus_Constant()
    return self.bonus_attack_speed
end

function modifier_invoker_alacrity_custom:GetEffectName()
    return "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf"
end

function modifier_invoker_alacrity_custom:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end


LinkLuaModifier( "modifier_invoker_emp_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_emp_pull_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

invoker_emp_custom = class({})

function invoker_emp_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_emp.vpcf", context )
end

invoker_emp_custom.modifier_invoker_12 = {-1,-1}
invoker_emp_custom.modifier_invoker_12_mana = {150,300}
invoker_emp_custom.modifier_invoker_13 = {-10,-20}

function invoker_emp_custom:GetAOERadius()
    return self:GetSpecialValueFor( "area_of_effect" )
end

function invoker_emp_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_invoker_13") then
        bonus = self.modifier_invoker_13[self:GetCaster():GetTalentLevel("modifier_invoker_13")]
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function invoker_emp_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local delay = self:GetSpecialValueFor("delay")
    if self:GetCaster():HasModifier("modifier_invoker_12") then
        delay = delay + self.modifier_invoker_12[self:GetCaster():GetTalentLevel("modifier_invoker_12")]
    end
    local thinker = CreateModifierThinker( self:GetCaster(), self, "modifier_invoker_emp_custom", { duration = delay }, point, self:GetCaster():GetTeamNumber(), false )
    thinker:EmitSound("Hero_Invoker.EMP.Cast")
end

modifier_invoker_emp_custom = class({})

function modifier_invoker_emp_custom:IsHidden()
    return true
end

function modifier_invoker_emp_custom:IsPurgable()
    return false
end

function modifier_invoker_emp_custom:OnCreated( kv )
    if not IsServer() then return end
    self.area_of_effect = self:GetAbility():GetSpecialValueFor("area_of_effect")
    self.mana_burned = ability_manager:GetValueWex(self:GetAbility(), self:GetCaster(), "mana_burned")

    if self:GetCaster():HasModifier("modifier_invoker_12") then
        self.mana_burned = self.mana_burned + self:GetAbility().modifier_invoker_12_mana[self:GetCaster():GetTalentLevel("modifier_invoker_12")]
    end

    self.damage_per_mana_pct = self:GetAbility():GetSpecialValueFor("damage_per_mana_pct") / 100

    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_emp.vpcf", PATTACH_WORLDORIGIN, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.area_of_effect, 0, 0 ) )
    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Invoker.EMP.Charge", self:GetCaster() )
end

function modifier_invoker_emp_custom:OnDestroy( kv )
    if not IsServer() then return end
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.area_of_effect, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MANA_ONLY, 0, false )

    local damageTable = 
    {
        attacker = self:GetCaster(),
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self:GetAbility(),
    }

    for _,enemy in pairs(enemies) do
        local mana_burn = math.min( enemy:GetMana(), self.mana_burned )
        enemy:Script_ReduceMana( mana_burn, self:GetAbility() )
        self:GetCaster():GiveMana(mana_burn * 0.5)
        damageTable.victim = enemy
        damageTable.damage = mana_burn * self.damage_per_mana_pct
        ApplyDamage(damageTable)
    end

    if self.effect_cast then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end

    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Invoker.EMP.Discharge", self:GetCaster() )
    UTIL_Remove( self:GetParent() )
end

function modifier_invoker_emp_custom:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("area_of_effect")
end

function modifier_invoker_emp_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_invoker_emp_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_invoker_emp_custom:GetAuraDuration()
    return 0
end

function modifier_invoker_emp_custom:GetModifierAura()
    return "modifier_emp_pull_custom"
end

function modifier_invoker_emp_custom:IsAura()
    return self:GetCaster():HasModifier("modifier_invoker_12")
end

modifier_emp_pull_custom = class({})

function modifier_emp_pull_custom:IsHidden() return true end
function modifier_emp_pull_custom:IsPurgable() return false end

function modifier_emp_pull_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_emp_pull_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAuraOwner() == nil then return end
    if self:GetParent():IsDebuffImmune() then return end
    if self:GetParent():IsInvulnerable() then return end
    local unit_location = self:GetParent():GetAbsOrigin()
    local vector_distance = self:GetAuraOwner():GetAbsOrigin() - unit_location
    local distance = (vector_distance):Length2D()
    local direction = (vector_distance):Normalized()
    if not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():IsCurrentlyVerticalMotionControlled() then
        local point = unit_location + direction * (150 * FrameTime())
        point = GetGroundPosition(point, self:GetParent())
        if GridNav:CanFindPath( self:GetParent():GetAbsOrigin(), point ) then
            self:GetParent():SetAbsOrigin(point)
        else
            FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
        end
    end
end

function modifier_emp_pull_custom:OnDestroy()
    if not IsServer() then return end
    if self:GetParent():IsDebuffImmune() then return end
    if self:GetParent():IsInvulnerable() then return end
    if self:GetParent():IsCurrentlyHorizontalMotionControlled() then return end
    if self:GetParent():IsCurrentlyVerticalMotionControlled() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
end


LinkLuaModifier( "modifier_invoker_ghost_walk_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_ghost_walk_custom_purge", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_ghost_walk_custom_debuff", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

invoker_ghost_walk_custom = class({})

invoker_ghost_walk_custom.modifier_invoker_20 = 60

function invoker_ghost_walk_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_ghost_walk.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_ghost_walk_debuff.vpcf", context )
end

function invoker_ghost_walk_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():StartGesture(ACT_DOTA_CAST_GHOST_WALK)
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_invoker_ghost_walk_custom_purge", { duration = duration } )
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_invoker_ghost_walk_custom", { duration = duration } )
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_ghost_walk.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    self:GetCaster():EmitSound("Hero_Invoker.GhostWalk")
end

modifier_invoker_ghost_walk_custom_purge = class({})
function modifier_invoker_ghost_walk_custom_purge:IsHidden() return true end
function modifier_invoker_ghost_walk_custom_purge:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_invoker_ghost_walk_custom")
end

modifier_invoker_ghost_walk_custom = class({})

function modifier_invoker_ghost_walk_custom:IsPurgable()
    return false
end

function modifier_invoker_ghost_walk_custom:OnCreated()
    self.radius = self:GetAbility():GetSpecialValueFor( "area_of_effect" )
    self.aura_duration = self:GetAbility():GetSpecialValueFor( "aura_fade_time" )
    self.self_slow = ability_manager:GetValueWex(self:GetAbility(), self:GetCaster(), "self_slow")
    self.enemy_slow = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "enemy_slow")
    self.health_regen = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "health_regen")
    self.mana_regen = ability_manager:GetValueWex(self:GetAbility(), self:GetCaster(), "mana_regen")
end

function modifier_invoker_ghost_walk_custom:OnRefresh()
    self.radius = self:GetAbility():GetSpecialValueFor( "area_of_effect" )
    self.aura_duration = self:GetAbility():GetSpecialValueFor( "aura_fade_time" )
    self.self_slow = ability_manager:GetValueWex(self:GetAbility(), self:GetCaster(), "self_slow")
    self.enemy_slow = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "enemy_slow")
    self.health_regen = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "health_regen")
    self.mana_regen = ability_manager:GetValueWex(self:GetAbility(), self:GetCaster(), "mana_regen")
end

function modifier_invoker_ghost_walk_custom:IsAura()
    return true
end

function modifier_invoker_ghost_walk_custom:GetModifierAura()
    return "modifier_invoker_ghost_walk_custom_debuff"
end

function modifier_invoker_ghost_walk_custom:GetAuraRadius()
    return self.radius
end

function modifier_invoker_ghost_walk_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_invoker_ghost_walk_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_invoker_ghost_walk_custom:GetAuraDuration()
    return self.aura_duration
end

function modifier_invoker_ghost_walk_custom:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function modifier_invoker_ghost_walk_custom:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_invoker_ghost_walk_custom:GetModifierConstantHealthRegen()
    return self.health_regen
end

function modifier_invoker_ghost_walk_custom:GetModifierConstantManaRegen()
    return self.mana_regen
end

function modifier_invoker_ghost_walk_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.self_slow
end

function modifier_invoker_ghost_walk_custom:GetModifierInvisibilityLevel()
    return 1
end

modifier_invoker_ghost_walk_custom_debuff = class({})

function modifier_invoker_ghost_walk_custom_debuff:IsPurgable()
    return false
end

function modifier_invoker_ghost_walk_custom_debuff:OnCreated()
    self.enemy_slow = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "enemy_slow")
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
end

function modifier_invoker_ghost_walk_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_invoker_20") then return end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self:GetAbility().modifier_invoker_20 * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_invoker_ghost_walk_custom_debuff:OnRefresh()
    self.enemy_slow = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "enemy_slow")
end

function modifier_invoker_ghost_walk_custom_debuff:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
    return funcs
end

function modifier_invoker_ghost_walk_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.enemy_slow
end

function modifier_invoker_ghost_walk_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_invoker/invoker_ghost_walk_debuff.vpcf"
end

function modifier_invoker_ghost_walk_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

LinkLuaModifier( "modifier_invoker_sun_strike_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

invoker_sun_strike_custom = class({})

invoker_sun_strike_custom.modifier_invoker_2_radius = 75
invoker_sun_strike_custom.modifier_invoker_2 = 7
invoker_sun_strike_custom.modifier_invoker_7 = -10

function invoker_sun_strike_custom:GetCooldown( level )
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_invoker_7") then
        bonus = self.modifier_invoker_7
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function invoker_sun_strike_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", context )
end

function invoker_sun_strike_custom:GetBehavior()
    --if self:GetCaster():HasModifier("modifier_invoker_7") then
    --    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_SHOW_IN_GUIDES
    --end
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_SHOW_IN_GUIDES
end

function invoker_sun_strike_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_invoker_2") then
        bonus = self.modifier_invoker_2_radius
    end
    return self:GetSpecialValueFor( "area_of_effect" ) + bonus
end

function invoker_sun_strike_custom:OnSpellStart()
    if not IsServer() then return end

    local point = self:GetCursorPosition()
    local delay = self:GetSpecialValueFor("delay")
    local vision_distance = self:GetSpecialValueFor("vision_distance")
    local vision_duration = self:GetSpecialValueFor("vision_duration")

    local target = self:GetCursorTarget()
    if target ~= nil then
        local cooldown = 60 * self:GetCaster():GetCooldownReduction()
        self:EndCooldown()
        self:StartCooldown(cooldown)
        for i=1, 20 do
            local point = self:GetCaster():GetAbsOrigin() + RandomVector(RandomInt(100, 900))
            CreateModifierThinker( self:GetCaster(), self, "modifier_invoker_sun_strike_custom", { duration = delay }, point, self:GetCaster():GetTeamNumber(), false )
            AddFOWViewer( self:GetCaster():GetTeamNumber(), point, vision_distance, vision_duration, false )
        end
        return
    end

    CreateModifierThinker( self:GetCaster(), self, "modifier_invoker_sun_strike_custom", { duration = delay }, point, self:GetCaster():GetTeamNumber(), false )
    AddFOWViewer( self:GetCaster():GetTeamNumber(), point, vision_distance, vision_duration, false )
end

LinkLuaModifier( "modifier_invoker_sun_strike_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

modifier_invoker_sun_strike_custom = class({})

function modifier_invoker_sun_strike_custom:IsHidden()
    return true
end

function modifier_invoker_sun_strike_custom:IsPurgable()
    return false
end

function modifier_invoker_sun_strike_custom:OnCreated( kv )
    if not IsServer() then return end
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_invoker_2") then
        bonus = self:GetAbility().modifier_invoker_2_radius
    end
    self.area_of_effect = self:GetAbility():GetSpecialValueFor("area_of_effect") + bonus
    self.damage = ability_manager:GetValueExort(self:GetAbility(), self:GetCaster(), "damage")

    local effect_cast = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf", PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.area_of_effect, 0, 0 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    EmitSoundOnLocationForAllies( self:GetParent():GetOrigin(), "Hero_Invoker.SunStrike.Charge", self:GetCaster() )
end

function modifier_invoker_sun_strike_custom:OnDestroy( kv )
    if not IsServer() then return end
    local damageTable =
    {
        attacker = self:GetCaster(),
        damage_type = DAMAGE_TYPE_PURE,
        ability = self:GetAbility(),
    }

    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.area_of_effect, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

    for _,enemy in pairs(enemies) do
        damageTable.victim = enemy
        if self:GetCaster():HasModifier("modifier_invoker_2") then
            damageTable.damage = self.damage
        else
            damageTable.damage = self.damage / #enemies
        end
        ApplyDamage(damageTable)
    end

    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.area_of_effect, 0, 0 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Invoker.SunStrike.Ignite", self:GetCaster() )

    local invoker_forge_spirit_custom = self:GetCaster():FindAbilityByName("invoker_forge_spirit_custom")
    if invoker_forge_spirit_custom then
        if self:GetCaster():HasModifier("modifier_invoker_2") then
            local forge_duration = invoker_sun_strike_custom.modifier_invoker_2
            local forged_spirit = invoker_forge_spirit_custom:CreateForge(self:GetParent():GetOrigin(), forge_duration)
            self:GetParent():EmitSound("Hero_Invoker.ForgeSpirit")
        end
    end

    UTIL_Remove( self:GetParent() )
end

LinkLuaModifier( "modifier_invoker_cold_snap_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_cold_snap_custom_passive", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE )

invoker_cold_snap_custom = class({})

function invoker_cold_snap_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_cold_snap_status.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf", context )
end

function invoker_cold_snap_custom:GetCooldown(level)
    return self.BaseClass.GetCooldown( self, level )
end

function invoker_cold_snap_custom:GetManaCost(level)
    return self.BaseClass.GetManaCost(self, level)
end

function invoker_cold_snap_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_HIDDEN + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_SHOW_IN_GUIDES
end

--function invoker_cold_snap_custom:GetIntrinsicModifierName()
--    return "modifier_invoker_cold_snap_custom_passive"
--end

invoker_cold_snap_custom.modifier_invoker_17 = {16,32}
invoker_cold_snap_custom.modifier_invoker_17_heal = {16,32}

function invoker_cold_snap_custom:OnSpellStart()
    if not IsServer() then return end

    local target = self:GetCursorTarget()

    if target:TriggerSpellAbsorb(self) then return end

    local duration = ability_manager:GetValueQuas(self, self:GetCaster(), "duration")

    target:AddNewModifier( self:GetCaster(), self, "modifier_invoker_cold_snap_custom", { duration = duration } )

    local direction = target:GetOrigin()-self:GetCaster():GetOrigin()

    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf", PATTACH_POINT_FOLLOW, target )
    ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() + direction )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    self:GetCaster():EmitSound("Hero_Invoker.ColdSnap.Cast")
    target:EmitSound("Hero_Invoker.ColdSnap")
end

modifier_invoker_cold_snap_custom = class({})

function modifier_invoker_cold_snap_custom:OnCreated( kv )
    self.damage = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "freeze_damage")

    if self:GetCaster():HasModifier("modifier_invoker_17") then
        self.damage = self.damage + self:GetAbility().modifier_invoker_17[self:GetCaster():GetTalentLevel("modifier_invoker_17")]
    end
    self.heal = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "freeze_heal")
    self.duration = self:GetAbility():GetSpecialValueFor("freeze_duration")
    self.cooldown = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "freeze_cooldown")
    self.threshold = self:GetAbility():GetSpecialValueFor("damage_trigger")
    if not IsServer() then return end
    self.onCooldown = false
    self:Freeze()
end

function modifier_invoker_cold_snap_custom:OnRefresh( kv )
    self.damage = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "freeze_damage")

    if self:GetCaster():HasModifier("modifier_invoker_17") then
        self.damage = self.damage + self:GetAbility().modifier_invoker_17[self:GetCaster():GetTalentLevel("modifier_invoker_17")]
    end
    self.heal = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "freeze_heal")
    self.duration = self:GetAbility():GetSpecialValueFor("freeze_duration")
    self.cooldown = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "freeze_cooldown")
    self.threshold = self:GetAbility():GetSpecialValueFor("damage_trigger")
end

function modifier_invoker_cold_snap_custom:OnTakeDamage( params )
    if IsServer() then
        if params.unit~=self:GetParent() then return end
        if params.damage<self.threshold then return end
        if self.onCooldown then return end
        self:Freeze()
        self:PlayEffects( params.attacker )
    end
end

function modifier_invoker_cold_snap_custom:OnIntervalThink()
    self.onCooldown = false
    self:StartIntervalThink(-1)
end

function modifier_invoker_cold_snap_custom:Freeze()
    self.onCooldown = true
    local damageTable = 
    { 
        victim = self:GetParent(),
        attacker = self:GetCaster(),
        damage = self.damage,
        damage_type = self:GetAbility():GetAbilityDamageType(),
        ability = self:GetAbility() 
    }
    ApplyDamage(damageTable)
    local heal = 0
    if self:GetCaster():HasModifier("modifier_invoker_17") then
        heal = heal + self:GetAbility().modifier_invoker_17_heal[self:GetCaster():GetTalentLevel("modifier_invoker_17")]
    end
    self:GetCaster():Heal(heal, self:GetAbility())
    self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_stunned", { duration = self.duration } )
    self:StartIntervalThink( self.cooldown )
end

function modifier_invoker_cold_snap_custom:GetEffectName()
    return "particles/units/heroes/hero_invoker/invoker_cold_snap_status.vpcf"
end

function modifier_invoker_cold_snap_custom:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_invoker_cold_snap_custom:PlayEffects( attacker )
    local direction = self:GetParent():GetOrigin()-attacker:GetOrigin()

    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf", PATTACH_POINT_FOLLOW, target )
    ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:SetParticleControl( effect_cast, 1,  self:GetParent():GetOrigin()+direction )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    self:GetParent():EmitSound("Hero_Invoker.ColdSnap.Freeze")
end

--modifier_invoker_cold_snap_custom_passive = class({})
--
--function modifier_invoker_cold_snap_custom_passive:IsHidden() return true end
--function modifier_invoker_cold_snap_custom_passive:IsPurgable() return false end
--function modifier_invoker_cold_snap_custom_passive:IsPurgeException() return false end
--
--function modifier_invoker_cold_snap_custom_passive:OnCreated( kv )
--    if IsServer() then
--        self.distance_to_skill = 0
--        self.currentpos = self:GetParent():GetAbsOrigin()
--        self:StartIntervalThink(FrameTime())
--    end
--end
--
--function modifier_invoker_cold_snap_custom_passive:OnIntervalThink()
--    if not IsServer() then return end
--    local pos = self:GetParent():GetOrigin()
--    local dist = (pos - self.currentpos):Length2D()
--    self.currentpos = pos
--    if dist > 1000 then return end
--
--    if self:GetCaster():HasModifier("modifier_invoker_20") then
--        self.distance_to_skill = self.distance_to_skill + dist
--        if self.distance_to_skill > self:GetAbility().modifier_invoker_20 then
--
--            local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false )
--
--            if #enemies > 0 then
--                enemies[1]:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = 0.01})
--
--                local direction = self:GetParent():GetOrigin()-enemies[1]:GetOrigin()
--
--
--                local damage = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "freeze_damage")
--
--                if self:GetCaster():HasModifier("modifier_invoker_17") then
--                    damage = damage + self:GetAbility().modifier_invoker_17[self:GetCaster():GetTalentLevel("modifier_invoker_17")]
--                end
--
--                local damageTable = 
--                { 
--                    victim = enemies[1],
--                    attacker = self:GetCaster(),
--                    damage = damage,
--                    damage_type = self:GetAbility():GetAbilityDamageType(),
--                    ability = self:GetAbility() 
--                }
--
--                ApplyDamage(damageTable)
--
--                local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf", PATTACH_POINT_FOLLOW, enemies[1] )
--                ParticleManager:SetParticleControlEnt( effect_cast, 0, enemies[1], PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
--                ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() + direction )
--                ParticleManager:ReleaseParticleIndex( effect_cast )
--
--                self:GetCaster():EmitSound("Hero_Invoker.ColdSnap.Cast")
--                enemies[1]:EmitSound("Hero_Invoker.ColdSnap")
--            end
--
--            self.distance_to_skill = 0
--        end
--    end
--end

LinkLuaModifier("modifier_invoker_forge_spirit_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_1_spirit_melting_strike_custom_debuff", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invulnerable_forge_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_forged_spirit_melting_strike_custom_debuff", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)

invoker_forge_spirit_custom = class({})

invoker_forge_spirit_custom.modifier_invoker_7 = 100

function invoker_forge_spirit_custom:OnSpellStart()
    if not IsServer() then return end
    local spirit_count = 1
    local invoker_quas_custom = self:GetCaster():FindAbilityByName("invoker_quas_custom")
    local invoker_exort_custom = self:GetCaster():FindAbilityByName("invoker_exort_custom")
    if invoker_quas_custom and invoker_exort_custom then
        if invoker_quas_custom:GetLevel() > 3 and invoker_exort_custom:GetLevel() > 3 then
            spirit_count = spirit_count + 1
        end
        if invoker_quas_custom:GetLevel() >= 8 and invoker_exort_custom:GetLevel() >= 8 then
            spirit_count = spirit_count + 1
        end
    end
    if self:GetCaster():HasModifier("modifier_invoker_7") then
        spirit_count = spirit_count + math.floor(self:GetCaster():GetStrength() / self.modifier_invoker_7)
    end
    if self.forged_spirits then
        for _, unit in pairs(self.forged_spirits) do
            if unit and not unit:IsNull() and unit:IsAlive() then
                unit:ForceKill(true)
            end
        end
    end
    self.forged_spirits = {}
    for i = 1, spirit_count do
        local forged_spirit = self:CreateForge(self:GetCaster():GetAbsOrigin() + RandomVector(100))
        table.insert(self.forged_spirits, forged_spirit)
    end
    self:GetCaster():EmitSound("Hero_Invoker.ForgeSpirit")
end

function invoker_forge_spirit_custom:CreateForge(point, new_duration)
    local damage = ability_manager:GetValueExort(self, self:GetCaster(), "spirit_damage")
    local health = ability_manager:GetValueQuas(self, self:GetCaster(), "spirit_hp")
    local mana = ability_manager:GetValueExort(self, self:GetCaster(), "spirit_mana")
    local duration = ability_manager:GetValueQuas(self, self:GetCaster(), "spirit_duration")
    local spirit_armor = ability_manager:GetValueExort(self, self:GetCaster(), "spirit_armor")
    if new_duration then
        duration = new_duration
    end
    local forged_spirit = CreateUnitByName("npc_dota_invoker_forged_spirit", point, false, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
    forged_spirit:AddNewModifier(self:GetCaster(), self, "modifier_kill", { duration = duration })
    if self:GetCaster():HasModifier("modifier_invoker_6") then
        forged_spirit:AddNewModifier(self:GetCaster(), self, "modifier_invulnerable_forge_custom", { duration = duration - FrameTime() })
    end
    forged_spirit:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
    forged_spirit:SetBaseMaxHealth(health)
    forged_spirit:SetBaseDamageMin(damage)
    forged_spirit:SetBaseDamageMax(damage)
    forged_spirit:SetPhysicalArmorBaseValue(spirit_armor)
    FindClearSpaceForUnit(forged_spirit, forged_spirit:GetOrigin(), false)
    forged_spirit:SetAngles(0, 0, 0)
    forged_spirit:SetForwardVector(self:GetCaster():GetForwardVector())
    forged_spirit:AddNewModifier(self:GetCaster(), self, "modifier_invoker_forge_spirit_custom", { duration = duration })
    return forged_spirit
end

modifier_invulnerable_forge_custom = class({})
function modifier_invulnerable_forge_custom:IsPurgable() return false end
function modifier_invulnerable_forge_custom:IsHidden() return true end
function modifier_invulnerable_forge_custom:IsPurgeException() return false end
function modifier_invulnerable_forge_custom:CheckState()
    local is_invulnerable = true
    local distance = (self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
    if distance > 600 or not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") then
        is_invulnerable = false
    end
    if is_invulnerable then
        return 
        {
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        }
    end
end
function modifier_invulnerable_forge_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():Kill(self:GetAbility(), nil)
end


modifier_invoker_forge_spirit_custom = class({})

function modifier_invoker_forge_spirit_custom:IsHidden()
    return true
end

function modifier_invoker_forge_spirit_custom:IsDebuff()
    return false
end

function modifier_invoker_forge_spirit_custom:IsPurgable()
    return false
end

function modifier_invoker_forge_spirit_custom:OnCreated(kv)
    self.armor = self:GetAbility():GetSpecialValueFor("spirit_armor") - self:GetParent():GetPhysicalArmorBaseValue()
    self.attack_range = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "spirit_attack_range")
end

function modifier_invoker_forge_spirit_custom:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
         
    }

    return funcs
end

function modifier_invoker_forge_spirit_custom:GetModifierAttackRangeBonus()
    return self.attack_range
end

function modifier_invoker_forge_spirit_custom:OnAttackLanded( params )
    if params.attacker ~= self:GetParent() then return end
    if params.target == self:GetParent() then return end
    params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_forged_spirit_melting_strike_custom_debuff", {duration = self:GetAbility():GetSpecialValueFor("debuff_duration") })
end

modifier_forged_spirit_melting_strike_custom_debuff = class({})

function modifier_forged_spirit_melting_strike_custom_debuff:IsPurgable() return false end

function modifier_forged_spirit_melting_strike_custom_debuff:OnCreated()
    self.armor = ability_manager:GetValueExort(self:GetAbility(), self:GetCaster(), "armor_per_attack")
    if not IsServer() then return end
    self:SetStackCount(1)
end

function modifier_forged_spirit_melting_strike_custom_debuff:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() < self:GetAbility():GetSpecialValueFor("max_armor_stacks") then
        self:IncrementStackCount()
    end
end

function modifier_forged_spirit_melting_strike_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_forged_spirit_melting_strike_custom_debuff:GetModifierPhysicalArmorBonus()
    return self.armor * self:GetStackCount()
end


LinkLuaModifier("modifier_invoker_chaos_meteor_custom_thinker", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_chaos_meteor_custom_burn", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)

invoker_chaos_meteor_custom = class({})

function invoker_chaos_meteor_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_chaos_meteor_burn_debuff.vpcf", context )
end

invoker_chaos_meteor_custom.modifier_invoker_3 = {-20,-30,-40}
invoker_chaos_meteor_custom.modifier_invoker_4 = {10,15,20}

function invoker_chaos_meteor_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_invoker_3") then
        bonus = self.modifier_invoker_3[self:GetCaster():GetTalentLevel("modifier_invoker_3")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function invoker_chaos_meteor_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_invoker_3") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function invoker_chaos_meteor_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()

    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end

    CreateModifierThinker( self:GetCaster(), self, "modifier_invoker_chaos_meteor_custom_thinker", {}, point, self:GetCaster():GetTeamNumber(), false )

    if self:GetCaster():HasModifier("modifier_invoker_5") then
        local direction = point - self:GetCaster():GetAbsOrigin()
        direction.z = 0
        direction = direction:Normalized()

        if self:GetCaster():GetTalentLevel("modifier_invoker_5") == 1 or self:GetCaster():GetTalentLevel("modifier_invoker_5") == 2 then
            CreateModifierThinker( self:GetCaster(), self, "modifier_invoker_chaos_meteor_custom_thinker", {}, RotatePosition(point, QAngle( 0, -90, 0 ), point+direction*200 ), self:GetCaster():GetTeamNumber(), false )
        end
        if self:GetCaster():GetTalentLevel("modifier_invoker_5") == 2 then
            CreateModifierThinker( self:GetCaster(), self, "modifier_invoker_chaos_meteor_custom_thinker", {}, RotatePosition(point, QAngle( 0, 90, 0 ), point+direction*200 ), self:GetCaster():GetTeamNumber(), false )
        end
    end
end

modifier_invoker_chaos_meteor_custom_thinker = class({})

function modifier_invoker_chaos_meteor_custom_thinker:IsHidden()
    return true
end

function modifier_invoker_chaos_meteor_custom_thinker:OnCreated(kv)
    if not IsServer() then return end
    self.caster_origin = self:GetCaster():GetOrigin()
    self.parent_origin = self:GetParent():GetOrigin()
    self.direction = self.parent_origin - self.caster_origin
    self.direction.z = 0
    self.direction = self.direction:Normalized()

    self.delay = self:GetAbility():GetSpecialValueFor("land_time")

    self.radius = self:GetAbility():GetSpecialValueFor("area_of_effect")

    self.distance = ability_manager:GetValueWex(self:GetAbility(), self:GetCaster(), "travel_distance")

    self.speed = self:GetAbility():GetSpecialValueFor("travel_speed")

    self.vision = self:GetAbility():GetSpecialValueFor("vision_distance")

    self.vision_duration = self:GetAbility():GetSpecialValueFor("end_vision_duration")


    self.interval = ability_manager:GetValueExort(self:GetAbility(), self:GetCaster(), "damage_interval")

    self.duration = self:GetAbility():GetSpecialValueFor("burn_duration")

    local damage = ability_manager:GetValueExort(self:GetAbility(), self:GetCaster(), "main_damage")

    self.fallen = false

    self.damageTable = 
    {
        attacker = self:GetCaster(),
        damage = damage,
        damage_type = self:GetAbility():GetAbilityDamageType(),
        ability = self:GetAbility(),
    }

    self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_FLY)
    self.nMoveStep = 0
    self:StartIntervalThink(self.delay)

    self:PlayEffects1()
end

function modifier_invoker_chaos_meteor_custom_thinker:OnDestroy()
    if IsServer() then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.vision, self.vision_duration, false)
        StopSoundOn("Hero_Invoker.ChaosMeteor.Loop", self:GetParent())
        if self.nLinearProjectile then
            ProjectileManager:DestroyLinearProjectile(self.nLinearProjectile)
        end
    end
end

function modifier_invoker_chaos_meteor_custom_thinker:OnIntervalThink()
    if not self.fallen then
        self.fallen = true
        self:StartIntervalThink(self.interval)
        self:Burn()
        self:PlayEffects2()
    else
        self:Move_Burn()
    end
end

function modifier_invoker_chaos_meteor_custom_thinker:Burn()
    if not IsServer() then return end
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for _, enemy in pairs(enemies) do
        self.damageTable.victim = enemy
        ApplyDamage(self.damageTable)
        enemy:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_invoker_chaos_meteor_custom_burn", { duration = self.duration } )
    end
end

function modifier_invoker_chaos_meteor_custom_thinker:Move_Burn()
    local parent = self:GetParent()
    local target = self.direction * self.speed * self.interval
    parent:SetOrigin(parent:GetOrigin() + target)
    self.nMoveStep = self.nMoveStep+1
    self:Burn()

    if self.nMoveStep and self.nMoveStep > 20 then
        self:Destroy()
        return
    end

    if (parent:GetOrigin() - self.parent_origin + target):Length2D() > self.distance then
        self:Destroy()
        return
    end
end

function modifier_invoker_chaos_meteor_custom_thinker:PlayEffects1()
    local height = 1000
    local height_target = -0
    local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self.caster_origin + Vector(0, 0, height))
    ParticleManager:SetParticleControl(effect_cast, 1, self.parent_origin + Vector(0, 0, height_target))
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(self.delay, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)
    EmitSoundOnLocationWithCaster(self.caster_origin, "Hero_Invoker.ChaosMeteor.Cast", self:GetCaster())
    self:GetParent():EmitSound( "Hero_Invoker.ChaosMeteor.Loop")
end

function modifier_invoker_chaos_meteor_custom_thinker:PlayEffects2()
    local meteor_projectile = 
    {
        Ability = self:GetAbility(),
        EffectName = "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf",
        vSpawnOrigin = self.parent_origin,
        fDistance = self.distance,
        fStartRadius = self.radius,
        fEndRadius = self.radius,
        Source = self:GetCaster(),
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_NONE,
        bDeleteOnHit = false,
        vVelocity = self.direction * self.speed,
        bProvidesVision = true,
        iVisionRadius = self.vision,
        iVisionTeamNumber = self:GetCaster():GetTeamNumber()
    }
    self.nLinearProjectile = ProjectileManager:CreateLinearProjectile(meteor_projectile)
    EmitSoundOnLocationWithCaster(self.parent_origin, "Hero_Invoker.ChaosMeteor.Impact", self:GetCaster())
end

modifier_invoker_chaos_meteor_custom_burn = class({})

function modifier_invoker_chaos_meteor_custom_burn:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_invoker_chaos_meteor_custom_burn:OnCreated(kv)
    if IsServer() then
        if self:GetAbility() and (not self:GetAbility():IsNull()) then
            local damage = ability_manager:GetValueExort(self:GetAbility(), self:GetCaster(), "burn_dps")
            if self:GetCaster():HasModifier("modifier_invoker_4") then
                damage = damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_invoker_4[self:GetCaster():GetTalentLevel("modifier_invoker_4")])
            end
            local delay = 1
            self.damageTable = {
                victim = self:GetParent(),
                attacker = self:GetCaster(),
                damage = damage,
                damage_type = self:GetAbility():GetAbilityDamageType(),
                ability = self:GetAbility(),
            }
            self:StartIntervalThink(delay)
        end
    end
end

function modifier_invoker_chaos_meteor_custom_burn:OnIntervalThink()
    if IsServer() then
        if self:GetParent() and self:GetAbility() and (not self:GetAbility():IsNull()) then
            ApplyDamage(self.damageTable)
            self:GetParent():EmitSound("Hero_Invoker.ChaosMeteor.Damage")
        end
    end
end

function modifier_invoker_chaos_meteor_custom_burn:GetEffectName()
    return "particles/units/heroes/hero_invoker/invoker_chaos_meteor_burn_debuff.vpcf"
end

function modifier_invoker_chaos_meteor_custom_burn:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

LinkLuaModifier("modifier_invoker_tornado_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_invoker_tornado_custom_twister", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_invoker_tornado_custom_twister_damage", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_BOTH)

invoker_tornado_custom = class({})

function invoker_tornado_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_tornado.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_tornado_child.vpcf", context )
end

invoker_tornado_custom.modifier_invoker_14 = -10

function invoker_tornado_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_invoker_14") then
        bonus = self.modifier_invoker_14
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function invoker_tornado_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()

    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end

    self.caster_origin = self:GetCaster():GetOrigin()

    self.parent_origin = point

    self.direction = self.parent_origin - self.caster_origin

    self.direction.z = 0

    self.direction = self.direction:Normalized()

    self.radius = self:GetSpecialValueFor("area_of_effect")
    self.distance = ability_manager:GetValueWex(self, self:GetCaster(), "travel_distance")
    self.speed = self:GetSpecialValueFor("travel_speed")
    self.vision = self:GetSpecialValueFor("vision_distance")
    self.vision_duration = self:GetSpecialValueFor("end_vision_duration")
    self.duration = ability_manager:GetValueQuas(self, self:GetCaster(), "lift_duration")

    local tornado_projectile = 
    {
        Ability = self,
        EffectName = "particles/units/heroes/hero_invoker/invoker_tornado.vpcf",
        vSpawnOrigin = self.caster_origin,
        fDistance = self.distance,
        fStartRadius = self.radius,
        fEndRadius = self.radius,
        Source = self:GetCaster(),
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bDeleteOnHit = false,
        vVelocity = self.direction * self.speed,
        bProvidesVision = true,
        iVisionRadius = self.vision,
        iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
        fExpireTime = GameRules:GetGameTime() + 10
    }
    self.tornados = self.tornados or {}
    local proj = ProjectileManager:CreateLinearProjectile(tornado_projectile)
    self.tornados[proj] = {self.caster_origin, self.caster_origin}
    EmitSoundOnLocationWithCaster(self.caster_origin, "Hero_Invoker.Tornado.Cast", self:GetCaster())
end

function invoker_tornado_custom:OnProjectileHit(hTarget, vLocation)
    if not hTarget then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), vLocation, self.vision, self.vision_duration, false)
        return nil
    end
    hTarget:AddNewModifier(self:GetCaster(), self, "modifier_invoker_tornado_custom", { duration = self.duration })
    return false
end

function invoker_tornado_custom:OnProjectileThinkHandle(iProjectileHandle)
    if self.tornados[iProjectileHandle] and self:GetCaster():HasModifier("modifier_invoker_14") then
        local vLocation = ProjectileManager:GetLinearProjectileLocation(iProjectileHandle)

        local distance_from_last = (vLocation - self.tornados[iProjectileHandle][2]):Length2D()
        local distance_from_start = (vLocation - self.tornados[iProjectileHandle][1]):Length2D()

        if distance_from_last >= self:GetSpecialValueFor("twister_distance_interval") then
            self.tornados[iProjectileHandle][2] = vLocation

            local base_duration = ability_manager:GetValueQuas(self, self:GetCaster(), "twister_duration")

            -- сколько торнадо ещё будет лететь
            local remaining_distance = math.max(0, self.distance - distance_from_start)
            local bonus_duration = remaining_distance / self.speed

            -- первый твистер живёт дольше всех, последний живёт только base_duration
            local duration = base_duration + bonus_duration

            CreateModifierThinker(
                self:GetCaster(),
                self,
                "modifier_invoker_tornado_custom_twister",
                { duration = duration },
                vLocation,
                self:GetCaster():GetTeamNumber(),
                false
            )
        end
    end
end

modifier_invoker_tornado_custom_twister = class({})

function modifier_invoker_tornado_custom_twister:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_twister.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, true)
end

function modifier_invoker_tornado_custom_twister:IsAura()
    return true
end

function modifier_invoker_tornado_custom_twister:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("twister_radius")
end

function modifier_invoker_tornado_custom_twister:GetModifierAura()
    return "modifier_invoker_tornado_custom_twister_damage"
end

function modifier_invoker_tornado_custom_twister:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_invoker_tornado_custom_twister:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_invoker_tornado_custom_twister_damage = class({})

function modifier_invoker_tornado_custom_twister_damage:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.25)
end

function modifier_invoker_tornado_custom_twister_damage:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self:GetCaster():GetAgility() * 0.25, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end


modifier_invoker_tornado_custom = class({})

function modifier_invoker_tornado_custom:IsMotionController()
    return true
end

function modifier_invoker_tornado_custom:GetMotionControllerPriority()
    return DOTA_MOTION_CONTROLLER_PRIORITY_HIGH
end

function modifier_invoker_tornado_custom:OnCreated(kv)
    if not IsServer() then return end
    EmitSoundOn("Hero_Invoker.Tornado.Target", self:GetParent())
    self:GetParent():Purge(true, false, false, false, false)
    local delay = 1
    self:GetParent():StartGesture(ACT_DOTA_FLAIL)
    self.angle = self:GetParent():GetAngles()
    self.abs = self:GetParent():GetAbsOrigin()
    self.cyc_pos = self:GetParent():GetAbsOrigin()
    self.tornado_spin_cycles = math.max(1, math.floor(self:GetDuration() * 2 + 0.5))
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_tornado_child.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(FrameTime())
end

function modifier_invoker_tornado_custom:OnIntervalThink()
    if self:GetParent():IsDebuffImmune() then return end
    if self:GetParent():IsMagicImmune() then return end
    self:ApplyHorizontalMotionController()
    self:ApplyVerticalMotionController()
end

function modifier_invoker_tornado_custom:OnDestroy()
    if not IsServer() then return end
    StopSoundOn("Hero_Invoker.Tornado.Target", self:GetParent())

    self:GetParent():EmitSound("Hero_Invoker.Tornado.LandDamage")

    self:GetParent():FadeGesture(ACT_DOTA_FLAIL)

    if not self:GetParent():IsDebuffImmune() then
        self:GetParent():SetAbsOrigin(self:GetParent():GetAbsOrigin())
        ResolveNPCPositions(self:GetParent():GetAbsOrigin(), 128)
    end
    self:GetParent():SetAbsAngles(self.angle[1], self.angle[2], self.angle[3])

    local damage = self:GetAbility():GetSpecialValueFor("base_damage") + ability_manager:GetValueWex(self:GetAbility(), self:GetCaster(), "wex_damage")

    if self:GetCaster() and self:GetAbility() then
        local damageTable = 
        { 
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = damage,
            damage_type = self:GetAbility():GetAbilityDamageType(),
            ability = self:GetAbility() 
        }
        ApplyDamage(damageTable)
    end
end

function modifier_invoker_tornado_custom:CheckState()
    local state =    
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
    return state
end

function modifier_invoker_tornado_custom:UpdateHorizontalMotion(unit, time)
    if not IsServer() then return end
end

function modifier_invoker_tornado_custom:UpdateVerticalMotion(unit, time)
    if not IsServer() then return end
    self:UpdateTornadoRotation()
    if self:GetElapsedTime() <= 0.3 then
        self.cyc_pos.z = self.cyc_pos.z + 50
        self:GetParent():SetAbsOrigin(self.cyc_pos)
    elseif self:GetDuration() - self:GetElapsedTime() < 0.3 then
        self.step = self.step or (self.cyc_pos.z - self.abs.z) / ((self:GetDuration() - self:GetElapsedTime()) / time)
        self.cyc_pos.z = self.cyc_pos.z - self.step
        self:GetParent():SetAbsOrigin(self.cyc_pos)
    else
        local pos = GetRandomPosition2D(self:GetParent():GetAbsOrigin(), 5)
        if (pos - self.abs):Length2D() < 50  then
            self:GetParent():SetAbsOrigin(pos)
        end
    end
end

function modifier_invoker_tornado_custom:UpdateTornadoRotation()
    local progress = math.min(self:GetElapsedTime() / math.max(self:GetDuration(), 0.01), 1)
    local yaw = self.angle[2] + 360 * self.tornado_spin_cycles * progress
    self:GetParent():SetAbsAngles(self.angle[1], yaw, self.angle[3])
end

function GetRandomPosition2D(point, distance)
    return point + RandomVector(distance)
end

LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_invoker_deafening_blast_custom", "heroes/npc_dota_hero_invoker_custom/invoker",LUA_MODIFIER_MOTION_NONE )

invoker_deafening_blast_custom = class({})

function invoker_deafening_blast_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_deafening_blast_knockback_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_deafening_blast_disarm_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_iceblast.vpcf", context )
end

invoker_deafening_blast_custom.modifier_invoker_9 = {-10,-20}
invoker_deafening_blast_custom.modifier_invoker_11 = {0.5,1}
invoker_deafening_blast_custom.modifier_invoker_19 = {0.8,1.6}

function invoker_deafening_blast_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_invoker_9") then
        bonus = self.modifier_invoker_9[self:GetCaster():GetTalentLevel("modifier_invoker_9")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function invoker_deafening_blast_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_invoker_9") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

invoker_deafening_blast_custom.modifier_invoker_19_damage_blast = {100,200}

function invoker_deafening_blast_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target_loc = self:GetCursorPosition()
    local caster_loc = caster:GetAbsOrigin()
    local distance = self:GetCastRange(caster_loc,caster)

    if target_loc == self:GetCaster():GetAbsOrigin() then
        target_loc = target_loc + self:GetCaster():GetForwardVector()
    end

    local direction = (target_loc - caster_loc):Normalized()

    local index = DoUniqueString("invoker_deafening_blast_custom")
    self[index] = {}

    local travel_distance = self:GetSpecialValueFor("travel_distance")
    local travel_speed = self:GetSpecialValueFor("travel_speed")
    local radius_start = self:GetSpecialValueFor("radius_start")
    local radius_end = self:GetSpecialValueFor("radius_end")

    local projectile =
    {
        Ability             = self,
        EffectName          = "particles/units/heroes/hero_invoker/invoker_deafening_blast.vpcf",
        vSpawnOrigin        = caster_loc,
        fDistance           = travel_distance,
        fStartRadius        = radius_start,
        fEndRadius          = radius_end,
        Source              = caster,
        bHasFrontalCone     = false,
        bReplaceExisting    = false,
        iUnitTargetTeam     = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType     = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        fExpireTime         = GameRules:GetGameTime() + 1.5,
        bDeleteOnHit        = false,
        vVelocity           = Vector(direction.x,direction.y,0) * travel_speed,
        bProvidesVision     = false,
        ExtraData           = {index = index, damage = damage}
    }

    if caster:HasModifier("modifier_invoker_11") then
        i = 0
        for var=1,13, 1 do
            ProjectileManager:CreateLinearProjectile(projectile)
            projectile.vVelocity = RotatePosition(Vector(0,0,0), QAngle(0,i,0), caster:GetForwardVector()) * travel_speed
            i = i + 30
        end
    else
        ProjectileManager:CreateLinearProjectile(projectile)
    end

    caster:EmitSound("Hero_Invoker.DeafeningBlast")
end

function invoker_deafening_blast_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
    if target then

        local was_hit = false

        for _, stored_target in ipairs(self[ExtraData.index]) do
            if target == stored_target then
                was_hit = true
                break
            end
        end

        if was_hit then
            return false
        end

        table.insert(self[ExtraData.index],target)

        local damage = ability_manager:GetValueExort(self, self:GetCaster(), "damage")
        local knockback_duration = ability_manager:GetValueQuas(self, self:GetCaster(), "knockback_duration")
        local knockback_distance = ability_manager:GetValueQuas(self, self:GetCaster(), "knockback_distance")
        local disarm_duration = ability_manager:GetValueWex(self, self:GetCaster(), "disarm_duration")

        if self:GetCaster():HasModifier("modifier_invoker_19") then
            damage = damage + self.modifier_invoker_19_damage_blast[self:GetCaster():GetTalentLevel("modifier_invoker_19")]
        end

        if self:GetCaster():HasModifier("modifier_invoker_11") then
            disarm_duration = disarm_duration + self.modifier_invoker_11[self:GetCaster():GetTalentLevel("modifier_invoker_11")]
        end

        if self:GetCaster():HasModifier("modifier_invoker_19") then
            knockback_duration = knockback_duration + self.modifier_invoker_19[self:GetCaster():GetTalentLevel("modifier_invoker_19")]
            knockback_distance = knockback_distance + (self.modifier_invoker_19[self:GetCaster():GetTalentLevel("modifier_invoker_19")] * 160)
        end

        local direction = (target:GetAbsOrigin() - location):Normalized()

        local knockback = target:AddNewModifier( self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = knockback_duration * (1-target:GetStatusResistance()), distance = knockback_distance, height = 0, direction_x = direction.x, direction_y = direction.y})

        ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})

        target:AddNewModifier(self:GetCaster(), self, "modifier_invoker_deafening_blast_custom", {duration = disarm_duration * (1 - target:GetStatusResistance())})

        if knockback then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_deafening_blast_knockback_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
            knockback:AddParticle(particle, false, false, -1, false, false)
        end
    else
        self[ExtraData.index]["count"] = self[ExtraData.index]["count"] or 0
        self[ExtraData.index]["count"] = self[ExtraData.index]["count"] + 1
        if self[ExtraData.index]["count"] == ExtraData.arrows then
            self[ExtraData.index] = nil
        end
    end
end

modifier_invoker_deafening_blast_custom = class({})

function modifier_invoker_deafening_blast_custom:IsPurgable()
    return false
end

function modifier_invoker_deafening_blast_custom:IsPurgeException()
    return false
end

function modifier_invoker_deafening_blast_custom:GetEffectName() return "particles/units/heroes/hero_invoker/invoker_deafening_blast_disarm_debuff.vpcf" end
function modifier_invoker_deafening_blast_custom:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_invoker_deafening_blast_custom:GetStatusEffectName() return "particles/status_fx/status_effect_iceblast.vpcf" end
function modifier_invoker_deafening_blast_custom:StatusEffectPriority() return 10 end

function modifier_invoker_deafening_blast_custom:CheckState() 
    local state = 
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
    return state
end

LinkLuaModifier("modifier_invoker_ice_wall_custom", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_ice_wall_custom_root", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_ice_wall_custom_slow", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_ice_wall_custom_aura", "heroes/npc_dota_hero_invoker_custom/invoker", LUA_MODIFIER_MOTION_NONE)

invoker_ice_wall_custom = class({})

invoker_ice_wall_custom.modifier_invoker_16 = {12,24,36}
invoker_ice_wall_custom.modifier_invoker_16_cooldown = {-3,-6,-9}
invoker_ice_wall_custom.modifier_invoker_18 = {50,100}

function invoker_ice_wall_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_invoker_21") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING + DOTA_ABILITY_BEHAVIOR_HIDDEN
    end
	return self.BaseClass.GetBehavior(self)
end

function invoker_ice_wall_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/invoker_ice_wall.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_ice_wall_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_frost.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_ice_wall_hero_shatter.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_glacierwall_marker.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_glacierwall.vpcf", context )
end

function invoker_ice_wall_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_invoker_21") then
		return 600
	end
end

function invoker_ice_wall_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_invoker_16") then
        bonus = self.modifier_invoker_16_cooldown[self:GetCaster():GetTalentLevel("modifier_invoker_16")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function invoker_ice_wall_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_invoker_21") then
		return
	end
    local caster = self:GetCaster()
    local caster_direction = caster:GetForwardVector()
    local ice_wall_duration = ability_manager:GetValueQuas(self, self:GetCaster(), "duration")
    local ice_wall_placement_distance = self:GetSpecialValueFor("wall_place_distance")
    local target_point = caster:GetAbsOrigin() + caster_direction * ice_wall_placement_distance
    caster:StartGesture(ACT_DOTA_CAST_ICE_WALL)
    caster:EmitSound("Hero_Invoker.IceWall.Cast")
    CreateModifierThinker(caster, self, "modifier_invoker_ice_wall_custom", {duration = ice_wall_duration}, target_point, caster:GetTeamNumber(), false)
end

function invoker_ice_wall_custom:OnVectorCastStart(vStartLocation, vDirection)
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_invoker_21") then
		local caster = self:GetCaster()
        local ice_wall_duration = ability_manager:GetValueQuas(self, self:GetCaster(), "duration")
        caster:StartGesture(ACT_DOTA_CAST_ICE_WALL)
        caster:EmitSound("Hero_Invoker.IceWall.Cast")
        local data = 
        {
            duration = ice_wall_duration,
            dir_1_x = vDirection.x,
            dir_1_y = vDirection.y,
            dir_2_x = -vDirection.x,
            dir_2_y = -vDirection.y
        }
        CreateModifierThinker(caster, self, "modifier_invoker_ice_wall_custom", data, vStartLocation, caster:GetTeamNumber(), false)
	end
end

modifier_invoker_ice_wall_custom = class({})

function modifier_invoker_ice_wall_custom:CreateWall(kv)
    if not IsServer() then return end
    local index = #self.walls + 1
    self.walls[index] = {}
    local caster_direction  = self.caster:GetForwardVector()
    local cast_direction = Vector(-caster_direction.y, caster_direction.x, caster_direction.z)
    local endpoint_distance_from_center   = (cast_direction * self.ice_wall_length) / 2
    local ice_wall_point = GetGroundPosition(self.parent:GetAbsOrigin(), nil)

    if (kv.start_x) then 
        self.walls[index].ice_wall_start_point = Vector(kv.start_x, kv.start_y, kv.start_z)
        self.walls[index].ice_wall_end_point = Vector(kv.end_x, kv.end_y, kv.end_z)
    else 
        self.walls[index].ice_wall_start_point = ice_wall_point - endpoint_distance_from_center
        self.walls[index].ice_wall_end_point  = ice_wall_point + endpoint_distance_from_center
    end

    local ice_wall_particle_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_ice_wall.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(ice_wall_particle_effect, 0, self.walls[index].ice_wall_start_point)
    ParticleManager:SetParticleControl(ice_wall_particle_effect, 1, self.walls[index].ice_wall_end_point  )
    self:AddParticle(ice_wall_particle_effect, false, false, -1, false, true)
    
    local ice_spikes_particle_effect  = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_ice_wall_b.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(ice_spikes_particle_effect, 0, self.walls[index].ice_wall_start_point)
    ParticleManager:SetParticleControl(ice_spikes_particle_effect, 1, self.walls[index].ice_wall_end_point  )
    self:AddParticle(ice_spikes_particle_effect, false, false, -1, false, true)

    if self:GetCaster():HasModifier("modifier_invoker_21") then
        ParticleManager:SetParticleControl(ice_wall_particle_effect, 3, Vector(1,1,1)  )
        ParticleManager:SetParticleControl(ice_spikes_particle_effect, 1, self.walls[index].ice_wall_end_point  )
    end
end

function modifier_invoker_ice_wall_custom:OnCreated(kv)
    if not IsServer() then return end
    self.ability = self:GetAbility()
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.modifier_invoker_21 = self.caster:HasModifier("modifier_invoker_21")
    self.hit_targets = {}
    self.walls = {}
    local num = 15
    local spacing = self:GetAbility():GetSpecialValueFor("wall_total_length") / num
    if self.modifier_invoker_21 then
        num = 20
    end
    local glacier_formation_delay = self:GetAbility():GetSpecialValueFor("glacier_formation_delay")
    local glacier_formation_speed = self:GetAbility():GetSpecialValueFor("glacier_formation_speed")
    self.ice_wall_length = spacing*num
    if self.modifier_invoker_21 then
        local wall_total_length = self:GetAbility():GetSpecialValueFor("wall_total_length")
        local wall_width = self:GetAbility():GetSpecialValueFor("wall_width")
        self.glacier_formation_delay = glacier_formation_delay
        self.glacier_formation_speed = glacier_formation_speed
        self.glacier_wall_width = wall_width
        self.glacier_wall_total_length = wall_total_length
        self.glacier_wall_half_length = wall_total_length / 2
        self.glacier_wall_created = false
        self.glacier_dir_1 = Vector(kv.dir_1_x or 1, kv.dir_1_y or 0, 0)
        if self.glacier_dir_1:Length2D() <= 0 then
            self.glacier_dir_1 = Vector(1, 0, 0)
        end
        self.glacier_dir_1 = self.glacier_dir_1:Normalized()
        self.glacier_dir_2 = Vector(kv.dir_2_x or -self.glacier_dir_1.x, kv.dir_2_y or -self.glacier_dir_1.y, 0)
        if self.glacier_dir_2:Length2D() <= 0 then
            self.glacier_dir_2 = Vector(-self.glacier_dir_1.x, -self.glacier_dir_1.y, 0)
        end
        self.glacier_dir_2 = self.glacier_dir_2:Normalized()
        self.glacier_marker_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_glacierwall_marker.vpcf", PATTACH_WORLDORIGIN, self.parent)
        ParticleManager:SetParticleControl(self.glacier_marker_particle, 0, self.parent:GetAbsOrigin())
        ParticleManager:SetParticleControlTransformForward(self.glacier_marker_particle, 0, self.parent:GetAbsOrigin(), self.glacier_dir_1)
        ParticleManager:SetParticleControl(self.glacier_marker_particle, 1, Vector(wall_total_length, wall_width, self:GetDuration()))
    else
        self:CreateWall(kv)
    end
    self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
    self.ice_wall_slow  = ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "slow")
    self.ice_wall_area_of_effect  = 35
    if self.modifier_invoker_21 then
        self.ice_wall_area_of_effect  = 75
    end
    self.search_area  = self.ice_wall_length + (self.ice_wall_area_of_effect * 2)
    self.origin  = self.parent:GetAbsOrigin()
    self.damage = ability_manager:GetValueExort(self:GetAbility(), self:GetCaster(), "damage_per_second")
    self.heroes_hit = false
    self.max_count = 1 
    self.interval = 0.05
    self.count = self.max_count
    self.root_duration = 1
    self.root_targets = {}
    self:OnIntervalThink()
    self:StartIntervalThink(self.interval)
end

function modifier_invoker_ice_wall_custom:OnIntervalThink()
    if not IsServer() then return end
    self.count = self.count + self.interval
    if self.modifier_invoker_21 and not self.glacier_wall_created and self:GetElapsedTime() >= self.glacier_formation_delay then
        self:CreateGlacierWall()
    end
    local nearby_enemy_units = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self.origin, nil, self.search_area, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    for _,enemy in pairs(nearby_enemy_units) do
        if self:IsUnitInProximity(enemy:GetAbsOrigin()) then
            if self.count >= 3 and self.modifier_invoker_21 and not self.hit_targets[enemy] then 
                enemy:AddNewModifier(self.caster, self.ability, "modifier_invoker_ice_wall_custom_root", {duration = (1 - enemy:GetStatusResistance())*1.5})
                if not self.hit_targets[enemy] then 
                    self.hit_targets[enemy] = true
                end 
                ApplyDamage({victim = enemy, attacker = self.caster, damage = 300, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability})
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_ice_wall_hero_shatter.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
                ParticleManager:ReleaseParticleIndex(particle)
            end
            enemy:AddNewModifier(self.caster, self.ability, "modifier_invoker_ice_wall_custom_slow", {duration = self.slow_duration * (1 - enemy:GetStatusResistance())})
        end
    end
end

function modifier_invoker_ice_wall_custom:CreateGlacierWall()
    self.glacier_wall_created = true
    self:DestroyGlacierMarker()
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_glacierwall.vpcf", PATTACH_WORLDORIGIN, self.parent)
    ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControlTransformForward(particle, 0, self.parent:GetAbsOrigin(), self.glacier_dir_1)
    ParticleManager:SetParticleControl(particle, 1, Vector(self.glacier_formation_speed, self.glacier_wall_width, self:GetDuration()))
    self:AddParticle(particle, false, false, -1, false, true)
end

function modifier_invoker_ice_wall_custom:DestroyGlacierMarker()
    if self.glacier_marker_particle then
        ParticleManager:DestroyParticle(self.glacier_marker_particle, false)
        ParticleManager:ReleaseParticleIndex(self.glacier_marker_particle)
        self.glacier_marker_particle = nil
    end
end

function modifier_invoker_ice_wall_custom:OnDestroy()
    if not IsServer() then return end
    self:DestroyGlacierMarker()
end

function modifier_invoker_ice_wall_custom:IsUnitInProximity(target_position)
    if self.modifier_invoker_21 then
        if self:GetElapsedTime() < self.glacier_formation_delay then
            return false
        end

        local formed_length = math.min(self.glacier_wall_half_length, self.glacier_formation_speed * (self:GetElapsedTime() - self.glacier_formation_delay))
        local center = self.parent:GetAbsOrigin()
        return self:IsUnitNearLine(target_position, center, center + self.glacier_dir_1 * formed_length) or self:IsUnitNearLine(target_position, center, center + self.glacier_dir_2 * formed_length)
    end

    local hit = false
    for _, data in pairs(self.walls) do
        if self:IsUnitNearLine(target_position, data.ice_wall_start_point, data.ice_wall_end_point) then
            hit = true
            break
        end
    end
    return hit
end

function modifier_invoker_ice_wall_custom:IsUnitNearLine(target_position, start_position, end_position)
    local ice_wall = end_position - start_position
    local ice_wall_length = ice_wall:Length2D()
    if ice_wall_length <= 0 then
        return (target_position - start_position):Length2D() <= self.ice_wall_area_of_effect * 3
    end

    local target_vector = target_position - start_position
    local ice_wall_normalized = ice_wall:Normalized()
    local ice_wall_dot_vector = target_vector:Dot(ice_wall_normalized)
    local search_point
    if ice_wall_dot_vector <= 0 then
        search_point = start_position
    elseif ice_wall_dot_vector >= ice_wall_length then
        search_point = end_position
    else
        search_point = start_position + (ice_wall_normalized * ice_wall_dot_vector)
    end

    local distance = target_position - search_point
    return distance:Length2D() <= self.ice_wall_area_of_effect * 3
end
    
modifier_invoker_ice_wall_custom_root = class({})
function modifier_invoker_ice_wall_custom_root:IsHidden() return true end
function modifier_invoker_ice_wall_custom_root:IsPurgable() return true end
function modifier_invoker_ice_wall_custom_root:CheckState()
    return
    {
    [MODIFIER_STATE_ROOTED] = true
    }
end

function modifier_invoker_ice_wall_custom_root:OnCreated()
    if not IsServer() then return end 
    self:GetParent():EmitSound("hero_Crystal.frostbite")
end

function modifier_invoker_ice_wall_custom_root:OnDestroy()
    if not IsServer() then return end 
    self:GetParent():StopSound("hero_Crystal.frostbite")
end

function modifier_invoker_ice_wall_custom_root:GetEffectName() return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf" end
function modifier_invoker_ice_wall_custom_root:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
function modifier_invoker_ice_wall_custom_root:GetStatusEffectName() return "particles/status_fx/status_effect_frost.vpcf" end
function modifier_invoker_ice_wall_custom_root:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end

modifier_invoker_ice_wall_custom_aura = class({})

function modifier_invoker_ice_wall_custom_aura:IsHidden() return true end
function modifier_invoker_ice_wall_custom_aura:IsPurgable() return false end

function modifier_invoker_ice_wall_custom_aura:OnCreated(kv)
    if IsServer() then
        self.slow_duration                      = kv.ice_wall_slow_duration
        self.ice_wall_slow                      = kv.ice_wall_slow
        self.GetTeam                            = self:GetParent():GetTeam()
        self.origin                             = self:GetParent():GetAbsOrigin()
        self.ability                            = self:GetAbility()
        self.ice_wall_particle_effect           = kv.ice_wall_particle_effect
        self:StartIntervalThink(0.1)
    end
end

function modifier_invoker_ice_wall_custom_aura:OnIntervalThink()
    if IsServer() then
        local nearby_enemy_units = FindUnitsInRadius( self.GetTeam,  self.origin,  nil,  650,  DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  0,  FIND_ANY_ORDER,  false)
        for _,enemy in pairs(nearby_enemy_units) do
            if enemy ~= nil and enemy:IsAlive() then
                local target_position = enemy:GetAbsOrigin()
                enemy:AddNewModifier(self:GetCaster(), self.ability, "modifier_invoker_ice_wall_custom_slow", {duration = self.slow_duration, enemy_slow = self.ice_wall_slow * (1 - enemy:GetStatusResistance())})
            end
        end
    end
end

function modifier_invoker_ice_wall_custom_aura:OnRemoved() 
    if self.ice_wall_particle_effect ~= nil then
        for effect in string.gmatch(self.ice_wall_particle_effect, "([^ ]+)") do
            ParticleManager:DestroyParticle(tonumber(effect), false)                
        end
    end
end

modifier_invoker_ice_wall_custom_slow = class({})

function modifier_invoker_ice_wall_custom_slow:IsPassive() return false end
function modifier_invoker_ice_wall_custom_slow:IsBuff() return false end
function modifier_invoker_ice_wall_custom_slow:IsDebuff() return true  end
function modifier_invoker_ice_wall_custom_slow:IsPurgable() return false end
function modifier_invoker_ice_wall_custom_slow:IsHidden() return false end
function modifier_invoker_ice_wall_custom_slow:GetEffectName() return "particles/units/heroes/hero_invoker/invoker_ice_wall_debuff.vpcf" end
function modifier_invoker_ice_wall_custom_slow:GetStatusEffectName() return "particles/status_fx/status_effect_frost.vpcf" end
function modifier_invoker_ice_wall_custom_slow:StatusEffectPriority() return 10 end

function modifier_invoker_ice_wall_custom_slow:OnCreated()
    if not IsServer() then return end
    self.origin = self:GetParent():GetAbsOrigin()
    self:StartIntervalThink(0.5)
end

function modifier_invoker_ice_wall_custom_slow:OnIntervalThink()
    if not IsServer() then return end
    local damage = ability_manager:GetValueExort(self:GetAbility(), self:GetCaster(), "damage_per_second")

    if self:GetCaster():HasModifier("modifier_invoker_16") then
        damage = damage + self:GetAbility().modifier_invoker_16[self:GetCaster():GetTalentLevel("modifier_invoker_16")]
    end

    if (self:GetParent():GetAbsOrigin() - self.origin):Length2D() > 0 then
        self.origin = self:GetParent():GetAbsOrigin()
        if self:GetCaster():HasModifier("modifier_invoker_18") then
            damage = damage + (damage / 100 * self:GetAbility().modifier_invoker_18[self:GetCaster():GetTalentLevel("modifier_invoker_18")])
        end
    end

    damage = damage * 0.5

    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_invoker_ice_wall_custom_slow:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
    return funcs
end

function modifier_invoker_ice_wall_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return ability_manager:GetValueQuas(self:GetAbility(), self:GetCaster(), "slow")
end