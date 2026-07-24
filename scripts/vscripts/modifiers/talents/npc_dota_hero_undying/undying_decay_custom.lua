--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_decay_custom_buff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_buff_counter", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_debuff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_debuff_counter", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_undying_decay_custom_agility_buff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_agility_buff_counter", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_agility_debuff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_agility_debuff_counter", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_undying_decay_custom_intellect_buff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_intellect_buff_counter", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_intellect_debuff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_decay_custom_intellect_debuff_counter", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )


--LinkLuaModifier("modifier_undying_decay_custom_strength_arena_buff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier("modifier_undying_decay_custom_agility_arena_buff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)
--LinkLuaModifier("modifier_undying_decay_custom_intellect_arena_buff", "heroes/npc_dota_hero_undying_custom/undying_decay_custom", LUA_MODIFIER_MOTION_NONE)

undying_decay_custom = class({}) 

function undying_decay_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_decay.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_decay_strength_xfer.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_decay_strength_buff.vpcf", context )
end

undying_decay_custom.modifier_undying_9 = {2,4}
undying_decay_custom.modifier_undying_16 = {5,10}
undying_decay_custom.modifier_undying_7 = 0
undying_decay_custom.modifier_undying_15 = {40,80}
undying_decay_custom.modifier_undying_2 = {50,100}
undying_decay_custom.modifier_undying_5 = {5,10}

function undying_decay_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function undying_decay_custom:GetManaCost(iLevel)
    return self.BaseClass.GetManaCost(self, iLevel)
end

function undying_decay_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_undying_12") then
        return 0
    else 
        return self.BaseClass.GetCastPoint( self )
    end
end

function undying_decay_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_undying_7") then
        bonus = self.modifier_undying_7
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function undying_decay_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:DecayCast(point, self:GetCaster())
    local caster = self:GetCaster()
    local ability = self
    if self:GetCaster():HasModifier("modifier_undying_12") then
        Timers:CreateTimer(3, function()
            ability:DecayCast(point, caster)
        end)
    end
end

function undying_decay_custom:DecayCast(point, sound_caster, bonus_radius)
    if not IsServer() then return end
    local radius = self:GetSpecialValueFor("radius")

    if bonus_radius ~= nil then
        radius = bonus_radius
    end

    local damage = self:GetSpecialValueFor("decay_damage")
    local duration = self:GetSpecialValueFor("decay_duration")
    if self:GetCaster():HasModifier("modifier_undying_5") then
        duration = duration + self.modifier_undying_5[self:GetCaster():GetTalentLevel("modifier_undying_5")]
    end

    if self:GetCaster():HasModifier("modifier_undying_15") then
        damage = damage + self.modifier_undying_15[self:GetCaster():GetTalentLevel("modifier_undying_15")]
    end

    sound_caster:EmitSound("Hero_Undying.Decay.Cast")
    
    local decay_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_decay.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(decay_particle, 0, point)
    ParticleManager:SetParticleControl(decay_particle, 1, Vector(radius, 0, 0))
    ParticleManager:SetParticleControl(decay_particle, 2, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(decay_particle)
    
    
    for _, enemy in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)) do
        if enemy:IsHero() and not enemy:IsIllusion() then
            enemy:EmitSound("Hero_Undying.Decay.Target")
            self:GetCaster():EmitSound("Hero_Undying.Decay.Transfer")

            local strength_transfer_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_decay_strength_xfer.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
            ParticleManager:SetParticleControlEnt(strength_transfer_particle, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(strength_transfer_particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(strength_transfer_particle)

            enemy:AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_debuff_counter", {duration = duration * (1-enemy:GetStatusResistance()) })
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_debuff", {duration = duration * (1-enemy:GetStatusResistance()) })
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_buff_counter", {duration = duration })
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_buff", {duration = duration })

            if self:GetCaster():HasModifier("modifier_undying_9") then
                for i=1, self.modifier_undying_9[self:GetCaster():GetTalentLevel("modifier_undying_9")] do
                    enemy:AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_agility_debuff_counter", {duration = duration * (1-enemy:GetStatusResistance()) })
                    enemy:AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_agility_debuff", {duration = duration * (1-enemy:GetStatusResistance()) })
                    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_agility_buff_counter", {duration = duration })
                    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_agility_buff", {duration = duration })
                    self:GetCaster():CalculateStatBonus(true)
                end
            end

            if self:GetCaster():HasModifier("modifier_undying_16") then
                for i=1, self.modifier_undying_16[self:GetCaster():GetTalentLevel("modifier_undying_16")] do
                    enemy:AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_intellect_debuff_counter", {duration = duration * (1-enemy:GetStatusResistance()) })
                    enemy:AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_intellect_debuff", {duration = duration * (1-enemy:GetStatusResistance()) })
                    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_intellect_buff_counter", {duration = duration })
                    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_decay_custom_intellect_buff", {duration = duration })
                    self:GetCaster():CalculateStatBonus(true)
                end
            end

            self:GetCaster():CalculateStatBonus(true)
            enemy:CalculateStatBonus(true)
            ApplyDamage({ victim = enemy, damage = damage, damage_type = self:GetAbilityDamageType(), damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self})
        end
        if enemy:IsHero() and enemy:IsIllusion() then
            ApplyDamage({ victim = enemy, damage = damage, damage_type = self:GetAbilityDamageType(), damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self})
        end
        if not enemy:IsHero() then
            ApplyDamage({ victim = enemy, damage = damage * self:GetSpecialValueFor("creep_damage_multiplier"), damage_type = self:GetAbilityDamageType(), damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self})
        end
        if self:GetCaster():HasModifier("modifier_undying_2") and enemy:IsHero() and not enemy:IsDebuffImmune() then
            local direction = (sound_caster:GetAbsOrigin() - enemy:GetAbsOrigin()):Normalized()
            local knockback = enemy:AddNewModifier( self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = 0.1, distance = self.modifier_undying_2[self:GetCaster():GetTalentLevel("modifier_undying_2")], height = 0, direction_x = direction.x, direction_y = direction.y})
        end
    end
end

modifier_undying_decay_custom_buff = class({})

function modifier_undying_decay_custom_buff:IsHidden() return true end
function modifier_undying_decay_custom_buff:IsPurgable() return false end
function modifier_undying_decay_custom_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_undying_decay_custom_debuff = class({})

function modifier_undying_decay_custom_debuff:IsHidden() return true end
function modifier_undying_decay_custom_debuff:IsPurgable() return false end
function modifier_undying_decay_custom_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end


modifier_undying_decay_custom_buff_counter = class({})

function modifier_undying_decay_custom_buff_counter:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_undying_decay_custom_buff_counter:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_undying_decay_custom_buff")

    local str_steal = self:GetAbility():GetSpecialValueFor("str_steal")
    --if GetMapName() == "arena" then
    --    str_steal = 1
    --end

    self:SetStackCount(#stack * str_steal)
end

function modifier_undying_decay_custom_buff_counter:IsPurgable()  return false end

function modifier_undying_decay_custom_buff_counter:GetEffectName()
    return "particles/units/heroes/hero_undying/undying_decay_strength_buff.vpcf"
end

function modifier_undying_decay_custom_buff_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    }
end

function modifier_undying_decay_custom_buff_counter:GetModifierBonusStats_Strength()
    return self:GetStackCount()
end

modifier_undying_decay_custom_debuff_counter = class({})

function modifier_undying_decay_custom_debuff_counter:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_undying_decay_custom_debuff_counter:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_undying_decay_custom_debuff")
    self:SetStackCount(#stack * self:GetAbility():GetSpecialValueFor("str_steal"))
end

function modifier_undying_decay_custom_debuff_counter:IsPurgable() return false end

function modifier_undying_decay_custom_debuff_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    }
end

function modifier_undying_decay_custom_debuff_counter:GetModifierBonusStats_Strength()
    return self:GetStackCount() * (-1)
end

modifier_undying_decay_custom_agility_buff = class({})

function modifier_undying_decay_custom_agility_buff:IsHidden() return true end
function modifier_undying_decay_custom_agility_buff:IsPurgable() return false end
function modifier_undying_decay_custom_agility_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_undying_decay_custom_agility_debuff = class({})

function modifier_undying_decay_custom_agility_debuff:IsHidden() return true end
function modifier_undying_decay_custom_agility_debuff:IsPurgable() return false end
function modifier_undying_decay_custom_agility_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end


modifier_undying_decay_custom_agility_buff_counter = class({})

function modifier_undying_decay_custom_agility_buff_counter:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_undying_decay_custom_agility_buff_counter:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_undying_decay_custom_agility_buff")
    self:SetStackCount(#stack)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_undying_decay_custom_agility_buff_counter:IsPurgable()  return false end

function modifier_undying_decay_custom_agility_buff_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    }
end

function modifier_undying_decay_custom_agility_buff_counter:GetModifierBonusStats_Agility()
    return self:GetStackCount()
end

modifier_undying_decay_custom_agility_debuff_counter = class({})

function modifier_undying_decay_custom_agility_debuff_counter:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_undying_decay_custom_agility_debuff_counter:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_undying_decay_custom_agility_debuff")
    self:SetStackCount(#stack)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_undying_decay_custom_agility_debuff_counter:IsPurgable() return false end

function modifier_undying_decay_custom_agility_debuff_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    }
end

function modifier_undying_decay_custom_agility_debuff_counter:GetModifierBonusStats_Agility()
    return self:GetStackCount() * (-1)
end


modifier_undying_decay_custom_intellect_buff = class({})

function modifier_undying_decay_custom_intellect_buff:IsHidden() return true end
function modifier_undying_decay_custom_intellect_buff:IsPurgable() return false end
function modifier_undying_decay_custom_intellect_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_undying_decay_custom_intellect_debuff = class({})

function modifier_undying_decay_custom_intellect_debuff:IsHidden() return true end
function modifier_undying_decay_custom_intellect_debuff:IsPurgable() return false end
function modifier_undying_decay_custom_intellect_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end


modifier_undying_decay_custom_intellect_buff_counter = class({})

function modifier_undying_decay_custom_intellect_buff_counter:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_undying_decay_custom_intellect_buff_counter:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_undying_decay_custom_intellect_buff")
    self:SetStackCount(#stack)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_undying_decay_custom_intellect_buff_counter:IsPurgable()  return false end

function modifier_undying_decay_custom_intellect_buff_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_undying_decay_custom_intellect_buff_counter:GetModifierBonusStats_Intellect()
    return self:GetStackCount()
end

modifier_undying_decay_custom_intellect_debuff_counter = class({})

function modifier_undying_decay_custom_intellect_debuff_counter:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_undying_decay_custom_intellect_debuff_counter:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_undying_decay_custom_intellect_debuff")
    self:SetStackCount(#stack)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_undying_decay_custom_intellect_debuff_counter:IsPurgable() return false end

function modifier_undying_decay_custom_intellect_debuff_counter:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_undying_decay_custom_intellect_debuff_counter:GetModifierBonusStats_Intellect()
    return self:GetStackCount() * (-1)
end

--modifier_undying_decay_custom_strength_arena_buff = class({})
--
--function modifier_undying_decay_custom_strength_arena_buff:IsPurgable() return false end
--
--function modifier_undying_decay_custom_strength_arena_buff:OnCreated()
--    if not IsServer() then return end
--    self:SetStackCount(1)
--end
--
--function modifier_undying_decay_custom_strength_arena_buff:OnRefresh()
--    if not IsServer() then return end
--    self:IncrementStackCount()
--end
--
--function modifier_undying_decay_custom_strength_arena_buff:DeclareFunctions()
--    return 
--    {
--        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
--    }
--end
--
--function modifier_undying_decay_custom_strength_arena_buff:GetModifierBonusStats_Strength()
--    return self:GetStackCount()
--end
--
--modifier_undying_decay_custom_agility_arena_buff = class({})
--
--function modifier_undying_decay_custom_agility_arena_buff:IsPurgable() return false end
--
--function modifier_undying_decay_custom_agility_arena_buff:OnCreated()
--    if not IsServer() then return end
--    self:SetStackCount(1)
--end
--
--function modifier_undying_decay_custom_agility_arena_buff:OnRefresh()
--    if not IsServer() then return end
--    self:IncrementStackCount()
--end
--
--function modifier_undying_decay_custom_agility_arena_buff:DeclareFunctions()
--    return 
--    {
--        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
--    }
--end
--
--function modifier_undying_decay_custom_agility_arena_buff:GetModifierBonusStats_Agility()
--    return self:GetStackCount()
--end
--
--modifier_undying_decay_custom_intellect_arena_buff = class({})
--
--function modifier_undying_decay_custom_intellect_arena_buff:IsPurgable() return false end
--
--function modifier_undying_decay_custom_intellect_arena_buff:OnCreated()
--    if not IsServer() then return end
--    self:SetStackCount(1)
--end
--
--function modifier_undying_decay_custom_intellect_arena_buff:OnRefresh()
--    if not IsServer() then return end
--    self:IncrementStackCount()
--end
--
--function modifier_undying_decay_custom_intellect_arena_buff:DeclareFunctions()
--    return 
--    {
--        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
--    }
--end
--
--function modifier_undying_decay_custom_intellect_arena_buff:GetModifierBonusStats_Intellect()
--    return self:GetStackCount()
--end