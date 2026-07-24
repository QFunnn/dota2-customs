--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_morphling_waveform_custom", "heroes/npc_dota_hero_morphling_custom/morphling_waveform_custom", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_morphling_waveform_custom_buff", "heroes/npc_dota_hero_morphling_custom/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_waveform_custom_reverse", "heroes/npc_dota_hero_morphling_custom/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE)

morphling_waveform_custom = class({})

function morphling_waveform_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_waveform.vpcf", context )
    PrecacheResource( "particle", "particles/econ/events/ti7/phase_boots_ti7.vpcf", context )
end

morphling_waveform_custom.modifier_morphling_5 = 25
morphling_waveform_custom.modifier_morphling_5_duration = 2
morphling_waveform_custom.modifier_morphling_10 = {-1.5,-3}
morphling_waveform_custom.modifier_morphling_12_mana = {33,66,100}
morphling_waveform_custom.modifier_morphling_12_range = {50,100,150}
morphling_waveform_custom.modifier_morphling_13 = 1.5

function morphling_waveform_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_morphling_10") then
        bonus = self.modifier_morphling_10[self:GetCaster():GetTalentLevel("modifier_morphling_10")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function morphling_waveform_custom:GetManaCost(level)
    local manacost = self.BaseClass.GetManaCost(self, level)
    if self:GetCaster():HasModifier("modifier_morphling_12") then
        manacost = manacost - (manacost / 100 * self.modifier_morphling_12_mana[self:GetCaster():GetTalentLevel("modifier_morphling_12")])
    end
    return manacost
end

function morphling_waveform_custom:GetCastRange(vLocation, hTarget)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_morphling_12") then
        bonus = self.modifier_morphling_12_range[self:GetCaster():GetTalentLevel("modifier_morphling_12")]
    end
    return self.BaseClass.GetCastRange(self, vLocation, hTarget) + bonus
end

function morphling_waveform_custom:OnSpellStart(new_point)
    if not IsServer() then return end
    
    local point = self:GetCursorPosition()
    if new_point then
        point = new_point
    end

    local dir = point - self:GetCaster():GetAbsOrigin()
    dir.z = 0
    local distance = dir:Length2D()
    dir = dir:Normalized()

    local speed = self:GetSpecialValueFor("speed")
    local width = self:GetSpecialValueFor("width")

    if self:GetCaster():HasModifier("modifier_morphling_13") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_morphling_waveform_custom_reverse", {duration = self.modifier_morphling_13 + (distance / speed), x = self:GetCaster():GetAbsOrigin().x, y = self:GetCaster():GetAbsOrigin().y, z = self:GetCaster():GetAbsOrigin().z})
    end
    
    local info = 
    {
        EffectName = "particles/units/heroes/hero_morphling/morphling_waveform.vpcf",
        Ability = self,
        vSpawnOrigin = self:GetCaster():GetOrigin(), 
        fStartRadius = width,
        fEndRadius = width,
        vVelocity = dir * speed,
        fDistance = distance,
        Source = self:GetCaster(),
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        iUnitTargetFlags = DOTA_DAMAGE_FLAG_NONE,
    }

    local proj = ProjectileManager:CreateLinearProjectile( info )

    self:GetCaster():EmitSound("Hero_Morphling.Waveform")

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_morphling_waveform_custom", {x = point.x, y = point.y, z = point.z, proj = proj})
end

function morphling_waveform_custom:OnProjectileHit(target, vLocation)
    if target then 
        self:GetCaster():MoveToTargetToAttack(target)
        local damage = self:GetSpecialValueFor("damage")
        ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
        if self:GetCaster():HasModifier("modifier_morphling_11") then
            self:GetCaster():PerformAttack(target, true, true, true, false, true, false, false)
        end
    end
    if target == nil then
        self:GetCaster():RemoveModifierByName("modifier_morphling_waveform_custom")
        if self:GetCaster():HasModifier("modifier_morphling_5") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_morphling_waveform_custom_buff", {duration = self.modifier_morphling_5_duration})
        end
    end
end 

modifier_morphling_waveform_custom = class({})

function modifier_morphling_waveform_custom:IsPurgable() return false end
function modifier_morphling_waveform_custom:IsHidden() return true end
function modifier_morphling_waveform_custom:IgnoreTenacity() return true end
function modifier_morphling_waveform_custom:IsMotionController() return true end
function modifier_morphling_waveform_custom:GetMotionControllerPriority() return DOTA_MOTION_CONTROLLER_PRIORITY_MEDIUM end

function modifier_morphling_waveform_custom:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_morphling_waveform_custom:OnCreated(params)
    if not IsServer() then return end
    self:GetCaster():AddNoDraw()
    self.proj = params.proj
    local position = GetGroundPosition(Vector(params.x, params.y, params.z), nil)
    local distance = (self:GetCaster():GetAbsOrigin() - position):Length2D()
    self.velocity = self:GetAbility():GetSpecialValueFor("speed")
    self.direction = (position - self:GetCaster():GetAbsOrigin()):Normalized()
    self:StartIntervalThink(0.01)
    if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end
end

function modifier_morphling_waveform_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveHorizontalMotionController( self )
    if self.proj and ProjectileManager:IsValidProjectile(self.proj) then
        ProjectileManager:DestroyLinearProjectile(self.proj)
    end
    if self:GetElapsedTime() <= 0.1 then
        FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    end
    self:GetParent():StartGesture(ACT_WAVEFORM_END)
    self:GetCaster():RemoveNoDraw()
end

function modifier_morphling_waveform_custom:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_morphling_waveform_custom:OnIntervalThink()
    if not IsServer() then return end
    self:GetCaster():SetAbsOrigin(self:GetParent():GetAbsOrigin() + self.direction * (self.velocity * 0.01))
end

function modifier_morphling_waveform_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE
    }
end

function modifier_morphling_waveform_custom:GetIgnoreCastAngle()
    return 1
end

modifier_morphling_waveform_custom_buff = class({})

function modifier_morphling_waveform_custom_buff:GetTexture() return "morphling_5" end

function modifier_morphling_waveform_custom_buff:GetEffectName()
    return "particles/econ/events/ti7/phase_boots_ti7.vpcf"
end

function modifier_morphling_waveform_custom_buff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_morphling_waveform_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_morphling_waveform_custom_buff:CheckState()
    return
    {
        [MODIFIER_STATE_UNSLOWABLE] = true,
    }
end

function modifier_morphling_waveform_custom_buff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_morphling_5
end

modifier_morphling_waveform_custom_reverse = class({})

function modifier_morphling_waveform_custom_reverse:IsHidden() return true end
function modifier_morphling_waveform_custom_reverse:IsPurgable() return false end
function modifier_morphling_waveform_custom_reverse:IsPurgeException() return false end
function modifier_morphling_waveform_custom_reverse:RemoveOnDeath() return false end

function modifier_morphling_waveform_custom_reverse:OnCreated(params)
    if not IsServer() then return end
    local morphling_waveform_reverse_custom = self:GetCaster():FindAbilityByName("morphling_waveform_reverse_custom")
    if morphling_waveform_reverse_custom then
        morphling_waveform_reverse_custom:SetLevel(1)
    end
    print(morphling_waveform_reverse_custom)
    self.point = Vector(params.x, params.y, params.z)
    self:GetCaster():SwapAbilities("morphling_waveform_custom", "morphling_waveform_reverse_custom", false, true)
end

function modifier_morphling_waveform_custom_reverse:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():SwapAbilities("morphling_waveform_reverse_custom", "morphling_waveform_custom", false, true)
end

morphling_waveform_reverse_custom = class({})

function morphling_waveform_reverse_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_morphling_waveform_custom") then return end
    local modifier_morphling_waveform_custom_reverse = self:GetCaster():FindModifierByName("modifier_morphling_waveform_custom_reverse")
    if modifier_morphling_waveform_custom_reverse then
        local point = modifier_morphling_waveform_custom_reverse.point
        local morphling_waveform_custom = self:GetCaster():FindAbilityByName("morphling_waveform_custom")
        if morphling_waveform_custom then
            morphling_waveform_custom:OnSpellStart(point)
        end
        modifier_morphling_waveform_custom_reverse:Destroy()
    end
end