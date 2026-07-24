--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bristleback_viscous_nasal_goo_custom", "abilities/bristleback_viscous_nasal_goo_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_viscous_nasal_goo_custom_stack", "abilities/bristleback_viscous_nasal_goo_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_viscous_nasal_goo_custom_count", "abilities/bristleback_viscous_nasal_goo_custom", LUA_MODIFIER_MOTION_NONE)

bristleback_viscous_nasal_goo_custom = class({})

function bristleback_viscous_nasal_goo_custom:Precache(context)
	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf", context )
	PrecacheResource( "particle", "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_proj.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_goo.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_stack.vpcf", context )
end

function bristleback_viscous_nasal_goo_custom:OnSpellStart(enemy, caster, double)
  	if not IsServer() then return end
	local pointer = self:GetCaster()
  	self:GetCaster():EmitSound("Hero_Bristleback.ViscousGoo.Cast")
    local projectile =
    {
      	Source = pointer,
      	Ability = self,
      	EffectName = "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf",
      	iMoveSpeed = self:GetSpecialValueFor("goo_speed"),
      	vSourceLoc = pointer:GetAbsOrigin(),
      	bDrawsOnMinimap = false,
      	bDodgeable = true,
      	bIsAttack = false,
      	bVisibleToEnemies = true,
      	bReplaceExisting = false,
      	flExpireTime = GameRules:GetGameTime() + 10,
      	bProvidesVision = false,
        ExtraData = {lotus = lotus, double = double_t}
    }

    self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_1)
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
    for _, enemy in pairs(enemies) do
        projectile.Target = enemy
        ProjectileManager:CreateTrackingProjectile(projectile)
    end
end

function bristleback_viscous_nasal_goo_custom:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	if hTarget == nil or not hTarget:IsAlive() or hTarget:IsMagicImmune() then return end
    local duration = self:GetSpecialValueFor("goo_duration")
    if hTarget:IsCreep() then 
      	duration = self:GetSpecialValueFor("goo_duration_creep")
    end
    hTarget:AddNewModifier(self:GetCaster(), self, "modifier_bristleback_viscous_nasal_goo_custom", {duration = duration * (1 - hTarget:GetStatusResistance())})
    hTarget:EmitSound("Hero_Bristleback.ViscousGoo.Target")
end

modifier_bristleback_viscous_nasal_goo_custom = class({})

function modifier_bristleback_viscous_nasal_goo_custom:GetEffectName()
  	return "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo_debuff.vpcf"
end

function modifier_bristleback_viscous_nasal_goo_custom:GetStatusEffectName()
  	return "particles/status_fx/status_effect_goo.vpcf"
end

function modifier_bristleback_viscous_nasal_goo_custom:StatusEffectPriority()
    return 10
end

function modifier_bristleback_viscous_nasal_goo_custom:OnCreated()
  	self.ability  = self:GetAbility()
  	self.caster   = self:GetCaster()
  	self.parent   = self:GetParent()
  	self.base_armor       = self.ability:GetSpecialValueFor("base_armor")
  	self.armor_per_stack    = self.ability:GetSpecialValueFor("armor_per_stack")
  	self.base_move_slow     = self.ability:GetSpecialValueFor("base_move_slow")
  	self.move_slow_per_stack  = self.ability:GetSpecialValueFor("move_slow_per_stack")
  	self.stack_limit      = self.ability:GetSpecialValueFor("stack_limit")
  	if not IsServer() then return end
  	self:SetStackCount(1)
	if self:GetParent():IsHero() then
  		self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
  		ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
  		self:AddParticle(self.particle, false, false, -1, false, false)
	end
	self:StartIntervalThink(1)
end

function modifier_bristleback_viscous_nasal_goo_custom:OnRefresh()
  	if not IsServer() then return end
  	if self:GetStackCount() < self.stack_limit then
    	self:IncrementStackCount()
        if self.particle then
    	    ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
        end
  	end
end

function modifier_bristleback_viscous_nasal_goo_custom:DeclareFunctions()
    return 
	{
    	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
end

function modifier_bristleback_viscous_nasal_goo_custom:GetModifierMoveSpeedBonus_Percentage()
    return ((self.base_move_slow + (self.move_slow_per_stack * self:GetStackCount())) * (-1))
end

function modifier_bristleback_viscous_nasal_goo_custom:GetModifierPhysicalArmorBonus()
    return ((self.base_armor + (self.armor_per_stack * self:GetStackCount())) * (-1))
end

modifier_bristleback_viscous_nasal_goo_custom_count = class({})
function modifier_bristleback_viscous_nasal_goo_custom_count:IsHidden() return true end
function modifier_bristleback_viscous_nasal_goo_custom_count:IsPurgable() return false end
function modifier_bristleback_viscous_nasal_goo_custom_count:OnCreated()
  	if not IsServer() then return end
  	self:IncrementStackCount()
end
function modifier_bristleback_viscous_nasal_goo_custom_count:OnRefresh()
  	if not IsServer() then return end
  	self:IncrementStackCount()
end

modifier_bristleback_viscous_nasal_goo_custom_stack = class({})
function modifier_bristleback_viscous_nasal_goo_custom_stack:IsHidden() return true end
function modifier_bristleback_viscous_nasal_goo_custom_stack:IsPurgable() return false end
function modifier_bristleback_viscous_nasal_goo_custom_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_bristleback_viscous_nasal_goo_custom_stack:OnDestroy()
	if not IsServer() then return end
	local mod = self:GetParent():FindModifierByName("modifier_bristleback_quill_spray_custom")
	if mod then 
  		mod:DecrementStackCount()
	end
end