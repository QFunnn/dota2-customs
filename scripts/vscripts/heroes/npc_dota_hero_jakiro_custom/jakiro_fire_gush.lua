--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_jakiro_fire_gush", "heroes/npc_dota_hero_jakiro_custom/jakiro_fire_gush", LUA_MODIFIER_MOTION_NONE)

jakiro_fire_gush = class({})

function jakiro_fire_gush:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/jakiro_custom/fire_gush.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context)
end

function jakiro_fire_gush:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()
    end
    local speed = self:GetSpecialValueFor("speed")
    local radius = self:GetSpecialValueFor("radius")
    local range = self:GetSpecialValueFor("range") + self:GetCaster():GetCastRangeBonus()
    local direction = point-caster:GetOrigin()
    direction.z = 0
    direction = direction:Normalized()
    local info = 
    {
        Source = caster,
        Ability = self,
        vSpawnOrigin = caster:GetAbsOrigin(),
        bDeleteOnHit = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        EffectName = "particles/jakiro_custom/fire_gush.vpcf",
        fDistance = range,
        fStartRadius = radius,
        fEndRadius = radius,
        vVelocity = direction * speed,
    }
    ProjectileManager:CreateLinearProjectile( info )
    self:GetCaster():EmitSound("Hero_Jakiro.DualBreath.Cast")
end

function jakiro_fire_gush:OnProjectileHit( target, location, data )
	if not target then return end
    local duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier( self:GetCaster(), self, "modifier_jakiro_fire_gush", { duration = duration * (1-target:GetStatusResistance()) } )
    local damage_base = self:GetSpecialValueFor("damage_base")
    local damage_strength = self:GetSpecialValueFor("damage_strength")
    local damage = damage_base + (self:GetCaster():GetStrength() / 100 * damage_strength)
	local damageTable = 
    {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}
	ApplyDamage(damageTable)
	return false
end

modifier_jakiro_fire_gush = class({})

function modifier_jakiro_fire_gush:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_jakiro_fire_gush:GetModifierIncomingDamage_Percentage()
    return self:GetAbility():GetSpecialValueFor("magic_debuff")
end

function modifier_jakiro_fire_gush:GetEffectName()
    return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_jakiro_fire_gush:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end