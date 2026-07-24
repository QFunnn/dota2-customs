--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_eye_of_the_storm_custom", "heroes/npc_dota_hero_razor_custom/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_debuff", "heroes/npc_dota_hero_razor_custom/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_eye_of_the_storm_custom_cloud", "heroes/npc_dota_hero_razor_custom/razor_eye_of_the_storm_custom", LUA_MODIFIER_MOTION_NONE)

razor_eye_of_the_storm_custom = class({})
razor_eye_of_the_storm_custom.modifier_razor_7 = -0.1
razor_eye_of_the_storm_custom.modifier_razor_7_bonus_targets = 1 
razor_eye_of_the_storm_custom.modifier_razor_18 = {15,30,45}

function razor_eye_of_the_storm_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_razor_18") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function razor_eye_of_the_storm_custom:GetAOERadius()
    return self:GetSpecialValueFor( "radius" )
end

function razor_eye_of_the_storm_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf", context )
    PrecacheResource( "particle","particles/units/heroes/hero_razor/razor_rain_storm.vpcf", context )
end

function razor_eye_of_the_storm_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor( "duration" )
    if self:GetCaster():HasModifier("modifier_razor_18") then
        local target = self:GetCursorTarget()
        local point = self:GetCursorPosition()
        if not target then
            target = CreateModifierThinker(self:GetCaster(), self, "modifier_invulnerable", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
        end
        local razor_plasma_field_custom = self:GetCaster():FindAbilityByName("razor_plasma_field_custom")
        if razor_plasma_field_custom then
            razor_plasma_field_custom:OnSpellStart(target)
        end
        target:AddNewModifier(self:GetCaster(), self, "modifier_razor_eye_of_the_storm_custom",  { duration = duration } )
    else
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_razor_eye_of_the_storm_custom",  { duration = duration } )
    end
end

modifier_razor_eye_of_the_storm_custom = class({})
function modifier_razor_eye_of_the_storm_custom:IsHidden() return false end
function modifier_razor_eye_of_the_storm_custom:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_razor_eye_of_the_storm_custom:OnCreated( kv )
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.radius = self.ability:GetSpecialValueFor( "radius" )
    self.damage = self.ability:GetSpecialValueFor( "damage" )
    self.interval = self.ability:GetSpecialValueFor( "strike_interval" )
    self.max_targets = 1
    if self:GetCaster():HasModifier("modifier_razor_7") then
        self.interval = self.interval + self.ability.modifier_razor_7
        self.max_targets = self.max_targets + self.ability.modifier_razor_7_bonus_targets
    end
    if self:GetCaster():HasModifier("modifier_razor_18") then
        self.damage = self.damage + self.ability.modifier_razor_18[self:GetCaster():GetTalentLevel("modifier_razor_18")]
    end
    self.attack_count = 0
    if not IsServer() then return end
    self.cloud_unit = CreateUnitByName("npc_dota_companion", self.parent:GetAbsOrigin(), false, self.parent, nil, self.parent:GetTeam())
    self.cloud_unit:AddNewModifier(self.parent, self.ability, "modifier_phased", {})
    self.cloud_unit:AddNewModifier(self.parent, self.ability, "modifier_razor_eye_of_the_storm_custom_cloud", {})
    self.abilityDamageType = self.ability:GetAbilityDamageType()
    self.damageTable = { attacker = self.parent, damage = self.damage, damage_type = self.abilityDamageType, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK }
    if self:GetCaster():HasModifier("modifier_razor_18") then
        self.damageTable.damage_type = DAMAGE_TYPE_MAGICAL
    end
    self:SetStackCount(0) 
    self:StartIntervalThink( self.interval  )
    self:PlayEffects1()
end

function modifier_razor_eye_of_the_storm_custom:OnDestroy()
    if not IsServer() then return end 
    if self.cloud_unit and not self.cloud_unit:IsNull() then 
        UTIL_Remove(self.cloud_unit)
    end 
    self.parent:EmitSound("Hero_Razor.StormEnd")
    self.parent:StopSound("Hero_Razor.Storm.Loop")
end

function modifier_razor_eye_of_the_storm_custom:Show()
    if not IsServer() then return end
    if self.effect_cast then return end
    local particle_name = "particles/units/heroes/hero_razor/razor_rain_storm.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_ABSORIGIN_FOLLOW, self.parent )
    ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(self.radius, 1, 1) )
    self:AddParticle( self.effect_cast, false, false, -1, false, false )
end 

function modifier_razor_eye_of_the_storm_custom:Hide()
    if not IsServer() then return end
    if self.effect_cast then 
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
        self.effect_cast = nil
    end
end 

function modifier_razor_eye_of_the_storm_custom:OnIntervalThink()
    if not IsServer() then return end
    self.interval = self.ability:GetSpecialValueFor( "strike_interval" )
    local targets = {}
    local heroes = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )
    local creeps = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )
    local targets = {}
    local link_target = nil
    local mod = self.parent:FindModifierByName("modifier_razor_static_link_custom")
    if mod and mod.target and (self.parent:GetAbsOrigin() - mod.target:GetAbsOrigin()):Length2D() <= self.radius then 
        link_target = mod.target
        table.insert(targets, mod.target)
    end
    for _,hero in pairs(heroes) do 
        if #targets < self.max_targets then
            if not link_target or link_target ~= hero then 
                table.insert(targets, hero)
            end 
        else 
            break
        end 
    end 
    for _,creep in pairs(creeps) do 
        if #targets < self.max_targets then
            if (not link_target or link_target ~= creep) and creep:GetUnitName() ~= "npc_teleport" then 
                table.insert(targets, creep)
            end 
        else 
            break
        end 
    end 
    if #targets > 0 then 
        for _,enemy in pairs(targets) do 
            self:Hit(enemy)
        end
    end
    self:StartIntervalThink(self.interval)
end
 

function modifier_razor_eye_of_the_storm_custom:Hit(enemy)
    if not IsServer() then return end
    self.damageTable.victim = enemy
    ApplyDamage( self.damageTable )
    if not self:GetCaster():HasModifier("modifier_razor_18") then
        enemy:AddNewModifier(self.parent, self.ability,  "modifier_razor_eye_of_the_storm_custom_debuff", { duration = self:GetRemainingTime()})
    end
    self:PlayEffects2( enemy)
end 

function modifier_razor_eye_of_the_storm_custom:PlayEffects1()
    if not IsServer() then return end
    self:Show()
    self.parent:EmitSound("Hero_Razor.Storm.Cast")
    self.parent:EmitSound("Hero_Razor.Storm.Loop")
end

function modifier_razor_eye_of_the_storm_custom:PlayEffects2( enemy )
    if not IsServer() then return end
    local particle_name = "particles/units/heroes/hero_razor/razor_storm_lightning_strike.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_ABSORIGIN_FOLLOW, self.cloud_unit )
    ParticleManager:SetParticleControl( effect_cast, 0, self.cloud_unit:GetAbsOrigin() )
    ParticleManager:SetParticleControlEnt( effect_cast, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true  )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    enemy:EmitSound("Hero_razor.lightning")
end

modifier_razor_eye_of_the_storm_custom_debuff = class({})
function modifier_razor_eye_of_the_storm_custom_debuff:IsHidden() return false end
function modifier_razor_eye_of_the_storm_custom_debuff:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_debuff:OnCreated( kv )
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.armor = self.ability:GetSpecialValueFor("armor_reduction")
    if not IsServer() then return end 
    self.RemoveForDuel = true
    self:SetStackCount(1)
end

function modifier_razor_eye_of_the_storm_custom_debuff:OnRefresh( kv )
    if not IsServer() then return end
    local max_debuffs = self.ability:GetSpecialValueFor("max_debuffs")
    if not self:GetCaster():HasModifier("modifier_razor_7") then
        if self:GetStackCount() >= max_debuffs then return end
    end
    self:IncrementStackCount()
end

function modifier_razor_eye_of_the_storm_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
end

function modifier_razor_eye_of_the_storm_custom_debuff:GetModifierPhysicalArmorBonus()
    return self:GetStackCount() * self.armor
end

modifier_razor_eye_of_the_storm_custom_cloud = class({})
function modifier_razor_eye_of_the_storm_custom_cloud:IsHidden() return true end
function modifier_razor_eye_of_the_storm_custom_cloud:IsPurgable() return false end
function modifier_razor_eye_of_the_storm_custom_cloud:CheckState()
    return	
    {
        [MODIFIER_STATE_NO_TEAM_MOVE_TO] 	= true,
        [MODIFIER_STATE_NO_TEAM_SELECT] 	= true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] 		= true,
        [MODIFIER_STATE_MAGIC_IMMUNE] 		= true,
        [MODIFIER_STATE_INVULNERABLE] 		= true,
        [MODIFIER_STATE_UNSELECTABLE] 		= true,
        [MODIFIER_STATE_INVULNERABLE] 		= true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] 	= true,
        [MODIFIER_STATE_NO_HEALTH_BAR] 		= true,
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_razor_eye_of_the_storm_custom_cloud:OnCreated(table)
    if not IsServer() then return end 
    self.parent = self:GetCaster()
    self.cloud_unit = self:GetParent()
    self:SetStackCount(500)
    self:OnIntervalThink()
    self:StartIntervalThink(0.01)
end 

function modifier_razor_eye_of_the_storm_custom_cloud:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_VISUAL_Z_DELTA,
    }
end

function modifier_razor_eye_of_the_storm_custom_cloud:GetVisualZDelta()
    return self:GetStackCount()
end

function modifier_razor_eye_of_the_storm_custom_cloud:OnIntervalThink()
    if not IsServer() then return end
    if not self.parent or self.parent:IsNull() then return end
    self.cloud_unit:SetAbsOrigin(GetGroundPosition(self.parent:GetAbsOrigin(), nil))
end 

function modifier_razor_eye_of_the_storm_custom_cloud:OnDestroy()
    if not IsServer() then return end 
    if self.unit and not self.unit:IsNull() then 
        UTIL_Remove(self.unit)
    end 
end