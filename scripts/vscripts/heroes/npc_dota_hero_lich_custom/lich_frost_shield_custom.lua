--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_frost_shield_custom", "heroes/npc_dota_hero_lich_custom/lich_frost_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_frost_shield_custom_debuff", "heroes/npc_dota_hero_lich_custom/lich_frost_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_frost_shield_custom_scream", "heroes/npc_dota_hero_lich_custom/lich_frost_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_frost_shield_custom_scream_cooldown", "heroes/npc_dota_hero_lich_custom/lich_frost_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_frost_shield_custom_armor_debuff", "heroes/npc_dota_hero_lich_custom/lich_frost_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_frost_shield_custom_armor_stack", "heroes/npc_dota_hero_lich_custom/lich_frost_shield_custom", LUA_MODIFIER_MOTION_NONE)

lich_frost_shield_custom = class({})

lich_frost_shield_custom.modifier_lich_9 = {8,16,24}
lich_frost_shield_custom.modifier_lich_13 = {-4,-8,-12}
lich_frost_shield_custom.modifier_lich_14 = 1
lich_frost_shield_custom.modifier_lich_14_cooldown = 10
lich_frost_shield_custom.modifier_lich_12_duration = 5
lich_frost_shield_custom.modifier_lich_12_max_stacks = 20
lich_frost_shield_custom.modifier_lich_12_armor = 1

function lich_frost_shield_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_lich_8") then
        return "lich_8"
    end
    return "lich_frost_shield"
end

function lich_frost_shield_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_lich_8") then
        return 0
    end
end

function lich_frost_shield_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_lich_8") then
        return 0
    end
end

function lich_frost_shield_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_lich_8") then
        return self:GetSpecialValueFor("radius")
    end
    return self.BaseClass.GetCastRange(self, vLocation, hTarget)
end

function lich_frost_shield_custom:CastFilterResultTarget( hTarget )
    if hTarget and hTarget:IsOther() and hTarget:GetUnitName() ~= "npc_dota_lich_ice_spire" then
        return UF_FAIL_OTHER
    end
    if hTarget and hTarget:GetUnitName() == "npc_filler_woda" then
        return UF_FAIL_BUILDING
    end
    if not IsServer() then return UF_SUCCESS end
    local nResult = UnitFilter(
        hTarget,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function lich_frost_shield_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_lich_8") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end

function lich_frost_shield_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor("duration")
    local modifier_lich_frost_shield_custom = target:FindModifierByName("modifier_lich_frost_shield_custom")
    if modifier_lich_frost_shield_custom and target:HasModifier("modifier_lich_8") then
        return
    end
    target:AddNewModifier(self:GetCaster(), self, "modifier_lich_frost_shield_custom", {duration = duration})
    target:EmitSound("Hero_Lich.IceAge")
end

function lich_frost_shield_custom:UpdateTalent()
    self:GetCaster():RemoveModifierByName("modifier_lich_frost_shield_custom")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lich_frost_shield_custom", {})
end

modifier_lich_frost_shield_custom = class({})

function modifier_lich_frost_shield_custom:IsPurgable() return not self:GetParent():HasModifier("modifier_lich_8") end
function modifier_lich_frost_shield_custom:IsPurgeException() return not self:GetParent():HasModifier("modifier_lich_8") end
function modifier_lich_frost_shield_custom:RemoveOnDeath() return not self:GetParent():HasModifier("modifier_lich_8") end

function modifier_lich_frost_shield_custom:OnCreated()
    if not IsServer() then return end
    self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
    local interval = self:GetAbility():GetSpecialValueFor("interval")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_age.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle, 2, Vector(self.radius,self.radius,self.radius))
    self.particle = particle
    self:AddParticle(particle, false, false, -1, false, false)

    if self:GetCaster():HasModifier("modifier_lich_8") then
        interval = 1 / self:GetParent():GetAttacksPerSecond(true)
        self:StartIntervalThink(interval)
        return
    end

    self:StartIntervalThink(interval)
end

function modifier_lich_frost_shield_custom:OnRefresh()
    self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
end

function modifier_lich_frost_shield_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_lich_ice_age.vpcf"
end

function modifier_lich_frost_shield_custom:GetEffectName()
    return "particles/units/heroes/hero_lich/lich_frost_armor.vpcf"
end

function modifier_lich_frost_shield_custom:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_lich_frost_shield_custom:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetAbility():GetSpecialValueFor("damage")
    if not self:GetParent():IsAlive() then
        if self.particle then
            ParticleManager:DestroyParticle(self.particle, true)
            self.particle = nil
        end
        return 
    end
    if self:GetCaster():HasModifier("modifier_wodawisp") then
        if self.particle then
            ParticleManager:DestroyParticle(self.particle, true)
            self.particle = nil
        end
    	return
    end
    if self:GetCaster():HasModifier("modifier_wodarelax") then
        return
    end
    if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
        if self.particle then
            ParticleManager:DestroyParticle(self.particle, true)
            self.particle = nil
        end
        return
    end

    if self:GetParent():GetUnitName() == "npc_dota_lich_ice_spire" then
        local modifier_lich_ice_spire_custom = self:GetParent():FindModifierByName("modifier_lich_ice_spire_custom")
        if modifier_lich_ice_spire_custom then
            modifier_lich_ice_spire_custom:HealPilar()
        end
    end
 
    if self:GetCaster():HasModifier("modifier_lich_16") then
        self:Destroy()
        return
    end

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_age_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle, 2, Vector(self.radius,self.radius,self.radius))
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetParent():EmitSound("Hero_Lich.IceAge.Tick")
    local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
    for _, enemy in pairs(enemies) do
        enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lich_frost_shield_custom_debuff", {duration = self.slow_duration * (1-enemy:GetStatusResistance())})
        if self:GetParent():HasModifier("modifier_lich_9") then
            damage = damage + (self:GetParent():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_lich_9[self:GetCaster():GetTalentLevel("modifier_lich_9")])
            ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility()})
        else
            ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
        end
        if self:GetCaster():HasModifier("modifier_lich_14") then
            if not enemy:HasModifier("modifier_lich_frost_shield_custom_scream_cooldown") then
                if not enemy:IsDebuffImmune() then
                    enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lich_frost_shield_custom_scream", {duration = self:GetAbility().modifier_lich_14})
                    enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lich_frost_shield_custom_scream_cooldown", {duration = self:GetAbility().modifier_lich_14_cooldown})
                end
            end
        end
        if self:GetCaster():HasModifier("modifier_lich_12") then
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lich_frost_shield_custom_armor_stack", {duration = self:GetAbility().modifier_lich_12_duration})
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lich_frost_shield_custom_armor_debuff", {duration = self:GetAbility().modifier_lich_12_duration})
        end
        if self:GetCaster():HasModifier("modifier_lich_8") then
            if enemy:GetUnitName() == "npc_woda_pig" or enemy:GetUnitName() == "npc_woda_frog" or enemy:GetUnitName() == "npc_woda_pig_pve" or enemy:GetUnitName() == "npc_woda_frog_pve" or enemy:GetUnitName() == "npc_dota_weaver_swarm" then
                if enemy:GetHealth() <= 1 then
                    enemy:Kill(self:GetAbility(), self:GetCaster())
                else
                    enemy:SetHealth(enemy:GetHealth() - 1)
                end
            end
        end
    end

    if self:GetCaster():HasModifier("modifier_lich_8") then
        local find_bug = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_OTHER, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
        for _, bug in pairs(find_bug) do
            if bug:GetUnitName() == "npc_dota_weaver_swarm" then
                self:GetCaster():PerformAttack(bug, true, true, true, true, false, false, true)
            end
        end
    end

    if self:GetCaster():HasModifier("modifier_lich_8") then
        self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
        local old_radius = self.radius
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
        local interval = 1 / self:GetParent():GetAttacksPerSecond(true)
        if old_radius ~= self.radius or self.particle == nil then
            if self.particle then
                ParticleManager:DestroyParticle(self.particle, true)
            end
            if self:GetParent():IsAlive() then
                local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_age.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
                ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
                ParticleManager:SetParticleControl(particle, 2, Vector(self.radius,self.radius,self.radius))
                self.particle = particle
                self:AddParticle(particle, false, false, -1, false, false)
            end
        end
        self:StartIntervalThink(interval)
    end
end

function modifier_lich_frost_shield_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE
    }
end

function modifier_lich_frost_shield_custom:GetModifierIncomingPhysicalDamage_Percentage(params)
    local bonus = 0
    if self:GetParent():HasModifier("modifier_lich_13") then
        bonus = self:GetAbility().modifier_lich_13[self:GetCaster():GetTalentLevel("modifier_lich_13")]
    end
    return self.damage_reduction + bonus
end

modifier_lich_frost_shield_custom_debuff = class({})

function modifier_lich_frost_shield_custom_debuff:OnCreated()
    self.movement_slow = self:GetAbility():GetSpecialValueFor("movement_slow")
end

function modifier_lich_frost_shield_custom_debuff:OnRefresh()
    self.movement_slow = self:GetAbility():GetSpecialValueFor("movement_slow")
end

function modifier_lich_frost_shield_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_lich_ice_age.vpcf"
end

function modifier_lich_frost_shield_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_lich_frost_shield_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.movement_slow
end

modifier_lich_frost_shield_custom_scream = class({})

function modifier_lich_frost_shield_custom_scream:GetTexture() return "lich_14" end

function modifier_lich_frost_shield_custom_scream:CheckState()
    return
    {
        [MODIFIER_STATE_FEARED] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    }
end

function modifier_lich_frost_shield_custom_scream:OnCreated()
	if not IsServer() then return end
    if self:GetParent():IsDebuffImmune() then return end
	local pos = (self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin())
	pos.z = 0
	pos = pos:Normalized()
	self.position = self:GetParent():GetAbsOrigin() + pos * 3000
	if not self:GetParent():IsHero() then
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disarmed", {duration = 0.1})
		self:GetParent():SetAggroTarget(nil)
	end
	self:GetParent():MoveToPosition( self.position )
end

function modifier_lich_frost_shield_custom_scream:GetEffectName()
    return "particles/lich_fear_debuff.vpcf"
end

function modifier_lich_frost_shield_custom_scream:OnIntervalThink()
	if not IsServer() then return end
    if self:GetParent():IsDebuffImmune() then return end
	self:GetParent():MoveToPosition( self.position )
end

modifier_lich_frost_shield_custom_scream_cooldown = class({})
function modifier_lich_frost_shield_custom_scream_cooldown:IsPurgable() return false end
function modifier_lich_frost_shield_custom_scream_cooldown:IsPurgeException() return false end
function modifier_lich_frost_shield_custom_scream_cooldown:RemoveOnDeath() return false end
function modifier_lich_frost_shield_custom_scream_cooldown:IsHidden() return true end


modifier_lich_frost_shield_custom_armor_stack = class({})
function modifier_lich_frost_shield_custom_armor_stack:IsHidden() return true end
function modifier_lich_frost_shield_custom_armor_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_lich_frost_shield_custom_armor_debuff = class({})
function modifier_lich_frost_shield_custom_armor_debuff:GetTexture() return "lich_12" end
function modifier_lich_frost_shield_custom_armor_debuff:OnCreated()
    if not IsServer() then return end
    if self:GetParent():IsHero() then
        self.particle = ParticleManager:CreateParticle("particles/lich_armor_debuff.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
        self:AddParticle(self.particle, false, false, -1, false, true)
    end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end
function modifier_lich_frost_shield_custom_armor_debuff:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_lich_frost_shield_custom_armor_stack")
    self:SetStackCount(math.min(#stack, self:GetAbility().modifier_lich_12_max_stacks))
    self:GetCaster():CalculateStatBonus(true)
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(0,self:GetStackCount(),0))
    end
end
function modifier_lich_frost_shield_custom_armor_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end
function modifier_lich_frost_shield_custom_armor_debuff:GetModifierPhysicalArmorBonus()
    return (self:GetStackCount() * -1) * self:GetAbility().modifier_lich_12_armor
end

