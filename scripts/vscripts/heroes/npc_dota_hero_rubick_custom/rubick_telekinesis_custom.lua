--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rubick_telekinesis_custom", "heroes/npc_dota_hero_rubick_custom/rubick_telekinesis_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rubick_telekinesis_custom_buff", "heroes/npc_dota_hero_rubick_custom/rubick_telekinesis_custom", LUA_MODIFIER_MOTION_NONE)

rubick_telekinesis_custom = class({})

rubick_telekinesis_custom.modifier_rubick_14_range = 400
rubick_telekinesis_custom.modifier_rubick_14_cooldown = -6

rubick_telekinesis_custom.modifier_rubick_17 = 50
rubick_telekinesis_custom.modifier_rubick_17_intellect = {50,150,250}

rubick_telekinesis_custom.modifier_rubick_11_enemy = {10,20,30}
rubick_telekinesis_custom.modifier_rubick_11_friendly = {-10,20,-30}

rubick_telekinesis_custom.modifier_rubick_10_range_percentage = 35
rubick_telekinesis_custom.modifier_rubick_10_delay = 0.5

function rubick_telekinesis_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_telekinesis.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_telekinesis_marker.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_telekinesis_land.vpcf", context)
end

function rubick_telekinesis_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_rubick_14") then
        bonus = self.modifier_rubick_14_cooldown
    end
    return self.BaseClass.GetCooldown(self, level) + bonus
end
function rubick_telekinesis_custom:CastFilterResultTarget(hTarget)
    if self:GetCaster():HasModifier("modifier_rubick_10") then
        return UnitFilter(hTarget,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NONE,self:GetCaster():GetTeamNumber())
    end
    return UnitFilter(hTarget,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,DOTA_UNIT_TARGET_FLAG_NONE,self:GetCaster():GetTeamNumber())
end

function rubick_telekinesis_custom:OnSpellStart()
    if not IsServer() then return end
    self.targets_table = {}
    self:OnSpellStart_target(self:GetCursorTarget(), true)
end

function rubick_telekinesis_custom:OnSpellStart_target(target, shoud_swap)
	if target:TriggerSpellAbsorb( self ) then return end
    table.insert( self.targets_table, target )
    self:GetCaster():EmitSound("Hero_Rubick.Telekinesis.Cast")
    target:EmitSound("Hero_Rubick.Telekinesis.Target")
    local buff_duration = 0
    if self:GetCaster():HasModifier("modifier_rubick_10") and target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        buff_duration = self.modifier_rubick_10_delay + self:GetSpecialValueFor("fall_duration")
        target:AddNewModifier(self:GetCaster(), self, "modifier_rubick_telekinesis_custom", {duration = self.modifier_rubick_10_delay + self:GetSpecialValueFor("fall_duration")})
    else
        local duration = (self:GetSpecialValueFor("lift_duration") + self:GetSpecialValueFor("fall_duration")) * (1 - target:GetStatusResistance())
        buff_duration = duration
        target:AddNewModifier(self:GetCaster(), self, "modifier_rubick_telekinesis_custom", {duration = duration})
    end
    if buff_duration > 0 then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_rubick_telekinesis_custom_buff", {duration = buff_duration, target = target:entindex()})
    end
end

rubick_telekinesis_land_custom = class({})

function rubick_telekinesis_land_custom:OnSpellStart()
    local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("rubick_telekinesis_custom")
    if ability then
        for i = 1, #ability.targets_table do
            local target = ability.targets_table[i]
            local modifier = target:FindModifierByName("modifier_rubick_telekinesis_custom")
            if modifier then
                modifier:UpdateLandPosition(self:GetCursorPosition())
            end
        end
    end
end

rubick_telekinesis_land_self_custom = class({})

function rubick_telekinesis_land_self_custom:OnSpellStart()
    local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("rubick_telekinesis_custom")
    if ability then
        for i = 1, #ability.targets_table do
            local target = ability.targets_table[i]
            local modifier = target:FindModifierByName("modifier_rubick_telekinesis_custom")
            if modifier then
                modifier:UpdateLandPosition(self:GetCursorPosition())
            end
        end
    end
end

modifier_rubick_telekinesis_custom = class({})
function modifier_rubick_telekinesis_custom:IsHidden() return false end
function modifier_rubick_telekinesis_custom:IsDebuff() return self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() end
function modifier_rubick_telekinesis_custom:IsStunDebuff() return false end
function modifier_rubick_telekinesis_custom:RemoveOnDeath() return true end
function modifier_rubick_telekinesis_custom:DestroyOnExpire() return true end

function modifier_rubick_telekinesis_custom:OnCreated(kv)
    if not IsServer() then return end
    if not self:GetParent():IsDebuffImmune() then
        self:GetParent():InterruptMotionControllers(true)
    end
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.delta = 0
    self.throw_position = self.parent:GetAbsOrigin()
    self.start_position = self.parent:GetAbsOrigin()
    self.throw_direction = Vector(0,0,0)
    self.max_land_distance = self.ability:GetSpecialValueFor("max_land_distance")
    if self:GetCaster():HasModifier("modifier_rubick_14") then
        self.max_land_distance = self.max_land_distance + self:GetAbility().modifier_rubick_14_range
    end
    if self:GetCaster():HasModifier("modifier_rubick_10") and self:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then
        self.max_land_distance = self.max_land_distance * (1 + (self.ability.modifier_rubick_10_range_percentage / 100))
    end
    local pcf = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_telekinesis.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(pcf, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(pcf, 1, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(pcf, 2, Vector(self:GetRemainingTime(),0,0))
    self:AddParticle(pcf, false, false, -1, false, false)
    self:StartIntervalThink(0.03)
end

function modifier_rubick_telekinesis_custom:OnIntervalThink()
    if (self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber()) and self:GetParent():IsDebuffImmune() then 
        self.throw_position = self.parent:GetAbsOrigin()
        return 
    end
    if self:GetRemainingTime() > 0.3 then
        if self:GetElapsedTime() < 0.3 then
            self.delta = self.delta + 15
            local pos = self.parent:GetAbsOrigin()
            pos.z = GetGroundHeight(pos, self.parent) + self.delta
            self.parent:SetAbsOrigin(pos)
        end
    else
        if self.throw_direction ~= Vector(0,0,0) then
            self.delta = self.delta - 15
            local pos = self.parent:GetAbsOrigin() + self.throw_direction
            pos.z = GetGroundHeight(pos, self.parent) + self.delta
            self.parent:SetAbsOrigin(pos)
        else
            self.delta = self.delta - 15
            local pos = self.parent:GetAbsOrigin()
            pos.z = GetGroundHeight(pos, self.parent) + self.delta
            self.parent:SetAbsOrigin(pos)
        end
    end
end

function modifier_rubick_telekinesis_custom:UpdateLandPosition(new_pos)
    if (self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber()) and self:GetParent():IsDebuffImmune() then return end
    local direction = new_pos - self.parent:GetAbsOrigin()
    if direction:Length2D() > self.max_land_distance then
        local calc = new_pos - self.parent:GetAbsOrigin()
        self.throw_direction = calc:Normalized() * (self.max_land_distance * 0.03 / 0.3)
        self.throw_position = self.start_position + calc:Normalized() * self.max_land_distance
    else
        local calc = new_pos - self.parent:GetAbsOrigin()
        self.throw_direction = calc:Normalized() * (direction:Length2D() * 0.03 / 0.3)
        self.throw_position = self.start_position + calc:Normalized() * direction:Length2D()
    end
    if self.lant_pfx then
        ParticleManager:DestroyParticle(self.lant_pfx, true)
        ParticleManager:ReleaseParticleIndex(self.lant_pfx)
    end
    self.lant_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_telekinesis_marker.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
    ParticleManager:SetParticleControl(self.lant_pfx, 0, self.throw_position)
    ParticleManager:SetParticleControl(self.lant_pfx, 1, Vector(self:GetRemainingTime(), 0, 0))
    ParticleManager:SetParticleControl(self.lant_pfx, 2, self.parent:GetAbsOrigin())
end

function modifier_rubick_telekinesis_custom:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():RemoveModifierByName("modifier_rubick_telekinesis_custom_buff")
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self.throw_position, nil, self.ability:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _,enemy in pairs(enemies) do
        if (enemy ~= self.parent) then
            enemy:AddNewModifier(self:GetCaster(), self.ability, "modifier_stunned", {duration = self.ability:GetSpecialValueFor("stun_duration") * (1-enemy:GetStatusResistance())})
        end
        if self:GetCaster():HasModifier("modifier_rubick_17") then
            local damage = self.ability.modifier_rubick_17 + (self:GetCaster():GetIntellect(false) / 100 * self.ability.modifier_rubick_17_intellect[self:GetCaster():GetTalentLevel("modifier_rubick_17")])
            ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = 0, ability = self:GetAbility()})
        end
    end
    local pcf = ParticleManager:CreateParticle("particles/units/heroes/hero_rubick/rubick_telekinesis_land.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(pcf, 0, self.throw_position)
    ParticleManager:ReleaseParticleIndex(pcf)
    self.parent:EmitSound("Hero_Rubick.Telekinesis.Target.Land")
    self.parent:StopSound("Hero_Rubick.Telekinesis.Target")
    if (self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber()) and self:GetParent():IsDebuffImmune() then return end
    GridNav:DestroyTreesAroundPoint(self.throw_position, 100, true)
    if not self:GetParent():IsDebuffImmune() then
        FindClearSpaceForUnit(self.parent, self.throw_position, true)
    end
end

function modifier_rubick_telekinesis_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_rubick_telekinesis_custom:GetModifierIncomingDamage_Percentage()
    if not self:GetCaster():HasModifier("modifier_rubick_11") then return end
    if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        return self:GetAbility().modifier_rubick_11_enemy[self:GetCaster():GetTalentLevel("modifier_rubick_11")]
    else
        return self:GetAbility().modifier_rubick_11_friendly[self:GetCaster():GetTalentLevel("modifier_rubick_11")]
    end
end

function modifier_rubick_telekinesis_custom:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end

function modifier_rubick_telekinesis_custom:CheckState()
    if (self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber()) and self:GetParent():IsDebuffImmune() then return end
    return 
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

modifier_rubick_telekinesis_custom_buff = class({})
function modifier_rubick_telekinesis_custom_buff:IsHidden() return true end
function modifier_rubick_telekinesis_custom_buff:IsPurgable() return false end
function modifier_rubick_telekinesis_custom_buff:IsPurgeException() return false end
function modifier_rubick_telekinesis_custom_buff:OnCreated(params)
    if not IsServer() then return end
    self.target = EntIndexToHScript(params.target)
    self.back_ability = false
    local rubick_telekinesis_land_self_custom = self:GetCaster():FindAbilityByName("rubick_telekinesis_land_self_custom")
    local rubick_telekinesis_land_custom = self:GetCaster():FindAbilityByName("rubick_telekinesis_land_custom")
    if self.target == self:GetCaster() then
        if rubick_telekinesis_land_self_custom then
            rubick_telekinesis_land_self_custom:SetLevel(1)
            self:GetCaster():SwapAbilities("rubick_telekinesis_custom", "rubick_telekinesis_land_self_custom", false, true)
            self.back_ability = true
        end
    else
        if rubick_telekinesis_land_custom then
            rubick_telekinesis_land_custom:SetLevel(1)
            self:GetCaster():SwapAbilities("rubick_telekinesis_custom", "rubick_telekinesis_land_custom", false, true)
            self.back_ability = true
        end
    end
end

function modifier_rubick_telekinesis_custom_buff:OnDestroy()
    if not IsServer() then return end
    if self.back_ability then
        if self.target == self:GetCaster() then
            self:GetCaster():SwapAbilities("rubick_telekinesis_land_self_custom", "rubick_telekinesis_custom", false, true)
        else
            self:GetCaster():SwapAbilities("rubick_telekinesis_land_custom", "rubick_telekinesis_custom", false, true)
        end
    end
end