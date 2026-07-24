--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kunkka_x_marks_the_spot_custom_debuff", "heroes/npc_dota_hero_kunkka_custom/kunkka_x_marks_the_spot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_x_marks_the_spot_custom_buff", "heroes/npc_dota_hero_kunkka_custom/kunkka_x_marks_the_spot_custom", LUA_MODIFIER_MOTION_NONE)

kunkka_x_marks_the_spot_custom = class({})

function kunkka_x_marks_the_spot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_x_spot.vpcf", context )
end

kunkka_x_marks_the_spot_custom.modifier_kunkka_15 = {30,45,60}

function kunkka_x_marks_the_spot_custom:GetCooldown(level)
    return self.BaseClass.GetCooldown( self, level )
end

function kunkka_x_marks_the_spot_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_kunkka_15") then
        return 0
    end
    return self.BaseClass.GetCastPoint( self )
end

function kunkka_x_marks_the_spot_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function kunkka_x_marks_the_spot_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor("allied_duration")
    local fow_range = self:GetSpecialValueFor("fow_range")
    local fow_duration = self:GetSpecialValueFor("fow_duration")
    if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if target:TriggerSpellAbsorb(self) then return end
        duration = self:GetSpecialValueFor("duration")
    end
    target:EmitSound("Ability.XMarksTheSpot.Target")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kunkka_x_marks_the_spot_custom_buff", {})
    target:AddNewModifier(self:GetCaster(), self, "modifier_kunkka_x_marks_the_spot_custom_debuff", {duration = duration * (1-target:GetStatusResistance())})
    AddFOWViewer(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), fow_range, fow_duration, true)
end

kunkka_return_custom = class({})

function kunkka_return_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_kunkka_15") then
        return 0
    end
    return self.BaseClass.GetCastPoint( self )
end

function kunkka_return_custom:OnSpellStart()
    if not IsServer() then return end
    local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)

    for _,target in pairs(targets) do
        if target:HasModifier("modifier_kunkka_x_marks_the_spot_custom_debuff") then
            local modifiers = target:FindAllModifiersByName("modifier_kunkka_x_marks_the_spot_custom_debuff")
            for _, modifier in pairs( modifiers ) do
                if modifier:GetCaster() == self:GetCaster() and not modifier:IsNull() then
                    modifier:Destroy()
                end
            end
        end
    end

    for _, modifier in pairs( self:GetCaster():FindAllModifiersByName("modifier_kunkka_x_marks_the_spot_custom_buff") ) do
        if not modifier:IsNull() then
            modifier:Destroy()
        end
    end
end

modifier_kunkka_x_marks_the_spot_custom_debuff = class({})

function modifier_kunkka_x_marks_the_spot_custom_debuff:IsPurgable()
    return false
end

function modifier_kunkka_x_marks_the_spot_custom_debuff:IsDebuff()
    if self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
        return true
    end
    return false
end

function modifier_kunkka_x_marks_the_spot_custom_debuff:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_kunkka_x_marks_the_spot_custom_debuff:OnCreated( params )
    if not IsServer() then return end
    self.position = self:GetParent():GetAbsOrigin()
    self.origin = self:GetParent():GetAbsOrigin()
    self:GetParent():EmitSound("Ability.XMark.Target_Movement")
    self.x_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_kunkka/kunkka_spell_x_spot.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster())
    ParticleManager:SetParticleControlEnt(self.x_pfx, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(self.x_pfx, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(self.x_pfx, false, false, -1, false, false)
    self.buldoze = false
    if self:GetParent():HasModifier("modifier_spirit_breaker_bulldoze_custom") then
        self.buldoze = true
    end
    self:StartIntervalThink(0.25)
end

function modifier_kunkka_x_marks_the_spot_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_kunkka_15") then return end
    if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if self:GetParent():IsMagicImmune() then return end
        if self:GetParent():IsDebuffImmune() then return end
    end
    
    local vector_distance = self.origin - self:GetParent():GetAbsOrigin()
    local distance = (vector_distance):Length2D()

    if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        local heal = 0
        if distance <= 1500 and distance > 0 then
            heal = distance * self:GetAbility().modifier_kunkka_15[self:GetCaster():GetTalentLevel("modifier_kunkka_15")] / 100
        end
        self:GetParent():Heal(heal, self:GetAbility())
    else
        local damage = 0
        if distance <= 1500 and distance > 0 then
            damage = distance * self:GetAbility().modifier_kunkka_15[self:GetCaster():GetTalentLevel("modifier_kunkka_15")] / 100
        end
        ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL})
    end

    self.origin = self:GetParent():GetAbsOrigin()
end

function modifier_kunkka_x_marks_the_spot_custom_debuff:OnDestroy( params )
    if not IsServer() then return end
    local position = self.position

    if not ( self:GetParent():IsInvulnerable() ) and not self:GetParent():IsMagicImmune() and not self:GetParent():IsDebuffImmune() and not self.buldoze then
        local stopOrder =
        {
            UnitIndex = self:GetParent():entindex(),
            OrderType = DOTA_UNIT_ORDER_STOP
        }
        ExecuteOrderFromTable( stopOrder )

        FindClearSpaceForUnit(self:GetParent(), self.position, true)
    end

    self:GetParent():StopSound("Ability.XMark.Target_Movement")
    self:GetParent():EmitSound("Ability.XMarksTheSpot.Return")
end

modifier_kunkka_x_marks_the_spot_custom_buff = class({})

function modifier_kunkka_x_marks_the_spot_custom_buff:IsHidden()
    return true
end

function modifier_kunkka_x_marks_the_spot_custom_buff:IsPurgable()
    return false
end

function modifier_kunkka_x_marks_the_spot_custom_buff:RemoveOnDeath() return false end

function modifier_kunkka_x_marks_the_spot_custom_buff:OnCreated()
    if not IsServer() then return end
    self:GetParent():SwapAbilities("kunkka_x_marks_the_spot_custom", "kunkka_return_custom", false, true)
    self:StartIntervalThink(FrameTime())
end

function modifier_kunkka_x_marks_the_spot_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
    local has_targets = false
    for _,target in pairs(targets) do
        if target:HasModifier("modifier_kunkka_x_marks_the_spot_custom_debuff") then
            local modifiers = target:FindAllModifiersByName("modifier_kunkka_x_marks_the_spot_custom_debuff")
            for _, modifier in pairs( modifiers ) do
                if modifier:GetCaster() == self:GetCaster() and not modifier:IsNull() then
                    has_targets = true
                end
            end
        end
    end
    if not has_targets then
        self:Destroy()
    end
end

function modifier_kunkka_x_marks_the_spot_custom_buff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():SwapAbilities("kunkka_return_custom", "kunkka_x_marks_the_spot_custom", false, true)
end

function modifier_kunkka_x_marks_the_spot_custom_buff:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end