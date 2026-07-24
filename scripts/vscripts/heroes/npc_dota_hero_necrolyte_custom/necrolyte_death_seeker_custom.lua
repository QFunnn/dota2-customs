--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_death_seeker_custom", "heroes/npc_dota_hero_necrolyte_custom/necrolyte_death_seeker_custom", LUA_MODIFIER_MOTION_NONE)

necrolyte_death_seeker_custom = class({})

function necrolyte_death_seeker_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function necrolyte_death_seeker_custom:GetHealthCost(iLevel)
    if self:GetCaster():HasModifier("modifier_necrolyte_2") then
        return self.BaseClass.GetManaCost(self, iLevel)
    end
    return 0
end

function necrolyte_death_seeker_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_necrolyte_11") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + DOTA_ABILITY_BEHAVIOR_HIDDEN
end

function necrolyte_death_seeker_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local target = self:GetCursorTarget()
    if target ~= nil then
        if target:TriggerSpellAbsorb(self) then return end
    end
    local direction = point - self:GetCaster():GetAbsOrigin()
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()
    local speed = self:GetCastRange(point, self:GetCaster()) * (self:GetSpecialValueFor("projectile_multiplier") / 100)
    local velocity = direction * speed
    local projectile =
    {
        Ability				= self,
        EffectName			= "particles/units/heroes/hero_necrolyte/necrolyte_death_seeker_linear_enemy.vpcf",
        vSpawnOrigin		= self:GetCaster():GetAbsOrigin(),
        fDistance			= distance,
        fStartRadius		= 0,
        fEndRadius			= 0,
        Source				= self:GetCaster(),
        bHasFrontalCone		= false,
        bReplaceExisting	= false,
        iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_NONE,
        iUnitTargetFlags	= DOTA_DAMAGE_FLAG_NONE,
        iUnitTargetType		= DOTA_UNIT_TARGET_NONE,
        fExpireTime 		= GameRules:GetGameTime() + 10.0,
        bDeleteOnHit		= false,
        vVelocity			= Vector(velocity.x,velocity.y,0),
        bProvidesVision		= false,
        ExtraData			= {}
    }
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_necrolyte_death_seeker_custom", {})
    ProjectileManager:CreateLinearProjectile(projectile)
end

function necrolyte_death_seeker_custom:OnProjectileHit(target, vLocation)
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_wodarelax_invul") then
        FindClearSpaceForUnit(self:GetCaster(), vLocation, true)
    end
    local modifier_necrolyte_death_seeker_custom = self:GetCaster():FindModifierByName("modifier_necrolyte_death_seeker_custom")
    if modifier_necrolyte_death_seeker_custom then
        modifier_necrolyte_death_seeker_custom:Destroy()
    end
    local necrolyte_death_pulse_custom = self:GetCaster():FindAbilityByName("necrolyte_death_pulse_custom")
    if necrolyte_death_pulse_custom then
        necrolyte_death_pulse_custom:OnSpellStart()
    end
end

modifier_necrolyte_death_seeker_custom = class({})

function modifier_necrolyte_death_seeker_custom:IsHidden() return true end
function modifier_necrolyte_death_seeker_custom:IsPurgable() return false end

function modifier_necrolyte_death_seeker_custom:OnCreated(data)
	if not IsServer() then return end
	ProjectileManager:ProjectileDodge(self:GetParent())
	self:GetParent():AddEffects(EF_NODRAW)
end

function modifier_necrolyte_death_seeker_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveEffects(EF_NODRAW)
end

function modifier_necrolyte_death_seeker_custom:CheckState()
	local state =
	{
		[MODIFIER_STATE_INVULNERABLE] 	= true,
		[MODIFIER_STATE_OUT_OF_GAME]	= true,
		[MODIFIER_STATE_UNSELECTABLE]	= true,
		[MODIFIER_STATE_DISARMED]	= true,
		[MODIFIER_STATE_ROOTED]	= true,
		[MODIFIER_STATE_NO_HEALTH_BAR]  = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
	}
	return state
end