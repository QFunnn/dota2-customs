--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_grappling_claw_custom", "heroes/npc_dota_hero_kez_custom/kez_grappling_claw_custom", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_kez_grappling_claw_custom_debuff", "heroes/npc_dota_hero_kez_custom/kez_grappling_claw_custom", LUA_MODIFIER_MOTION_NONE)

kez_grappling_claw_custom = class({})
kez_grappling_claw_custom.modifier_kez_19 = {1,2}

function kez_grappling_claw_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_kunai.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_rod_of_atos_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_rod_of_atos_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/bird_samurai_beak_buster_debuff.vpcf", context )
end

function kez_grappling_claw_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local is_tree = false
    if not target:IsBaseNPC() then
        target = CreateModifierThinker(self:GetCaster(), self, "modifier_invulnerable", {duration = 3}, target:GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
        is_tree = true
    end
    if target:TriggerSpellAbsorb(self) then return end

    local direction = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    local length = direction:Length2D()
    direction = direction:Normalized()

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_kunai.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 3, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)

    self:GetCaster():EmitSound("Hero_Kez.GrapplingClaw.Katana.Cast")

    local modifier_kez_grappling_claw_custom = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_grappling_claw_custom", {length = length, target = target:entindex()})
    if modifier_kez_grappling_claw_custom then
        modifier_kez_grappling_claw_custom.target = target
    end

    ---------------------------------------------------------------------------------------------
    if self:GetCaster():HasModifier("modifier_kez_21") then return end
    local kez_talon_toss_custom = self:GetCaster():FindAbilityByName("kez_talon_toss_custom")
    if kez_talon_toss_custom then
        kez_talon_toss_custom:UseResources(false, false, false, true)
    end
end

modifier_kez_grappling_claw_custom = class({})
function modifier_kez_grappling_claw_custom:IsHidden() return true end
function modifier_kez_grappling_claw_custom:IsPurgeException() return false end
function modifier_kez_grappling_claw_custom:IsPurgable() return false end
function modifier_kez_grappling_claw_custom:OnCreated(params)
    if not IsServer() then return end
    print("modifier_kez_grappling_claw_custom")
    self.target = EntIndexToHScript(params.target)
    self.land_distance = self:GetAbility():GetSpecialValueFor("land_distance") * 2
    self.length = math.max(params.length - self.land_distance, 0)
    self.speed = self:GetAbility():GetSpecialValueFor("grapple_speed")
    self.max_distance_break = self:GetAbility():GetSpecialValueFor("max_distance_break")
    self.bonus_flat_lifesteal = self:GetAbility():GetSpecialValueFor("bonus_flat_lifesteal")
    local projectile_speed = self:GetAbility():GetSpecialValueFor("projectile_speed")
    local start_interval = self.length / projectile_speed
    local debuff_duration = self:GetAbility():GetSpecialValueFor("debuff_duration")
    if self:GetCaster():HasModifier("modifier_kez_19") then
        debuff_duration = debuff_duration + self:GetAbility().modifier_kez_19[self:GetCaster():GetTalentLevel("modifier_kez_19")]
    end
    self.modifier_kez_grappling_claw_custom_debuff = self.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_kez_grappling_claw_custom_debuff", {duration = debuff_duration * (1-self.target:GetStatusResistance())})
    self:StartIntervalThink(start_interval)
end

function modifier_kez_grappling_claw_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:ApplyHorizontalMotionController() == false then 
        self:Destroy()
        return
    end
    if self.target:GetUnitName() ~= "npc_dota_thinker" then
        self:GetParent():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_2)
    end
    self:SetStackCount(1)
    self:StartIntervalThink(-1)
    self.target:EmitSound("Hero_Kez.GrapplingClaw.Katana.Target")
end

function modifier_kez_grappling_claw_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():InterruptMotionControllers( true )
end

function modifier_kez_grappling_claw_custom:OnDestroy()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_kez_19") then
        if self.modifier_kez_grappling_claw_custom_debuff and not self.modifier_kez_grappling_claw_custom_debuff:IsNull() then
            self.modifier_kez_grappling_claw_custom_debuff:Destroy()
        end
    end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    if self.attack and self.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
        if self.target:IsNull() or not self.target:IsAlive() then
            return
        end
        if self.target:GetUnitName() == "npc_dota_thinker" then
            return
        end
        self:GetParent():PerformAttack(self.target, true, true, true, false, false, false, true)
    end
end

function modifier_kez_grappling_claw_custom:CheckState()
	return
    {
		[MODIFIER_STATE_STUNNED] = self:GetStackCount() == 1,
        [MODIFIER_STATE_DISARMED] = self:GetStackCount() == 1,
	}
end

function modifier_kez_grappling_claw_custom:UpdateHorizontalMotion( me, dt )
    if self.length <= 0 then
        self.attack = true
        self:Destroy()
        return
    end
    if self.target:IsNull() or not self.target:IsAlive() then
        self:Destroy()
        return
    end
    local direction = (self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin())
    direction.z = 0
    local length = direction:Length2D()
    self.length = length
    direction = direction:Normalized()
    if length <= self.land_distance then
        self.attack = true
        self:Destroy()
        return
    end
    if length > self.max_distance_break then
        self:Destroy()
        return
    end
    local new_position = self:GetParent():GetAbsOrigin() + direction * (self.speed * dt)
    new_position = GetGroundPosition(new_position, nil)
    self.length = self.length - self.speed * dt
    self:GetParent():SetOrigin(new_position)
end

function modifier_kez_grappling_claw_custom:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

modifier_kez_grappling_claw_custom_debuff = class({})

function modifier_kez_grappling_claw_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_kez_grappling_claw_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("katana_ms_slow_pct")
end