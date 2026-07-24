--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_generic_orb_effect_lua", "modifiers/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_orb_effect_lua_jakiro", "modifiers/modifier_generic_orb_effect_lua_jakiro", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_liquid_fire_custom", "heroes/npc_dota_hero_jakiro_custom/jakiro_liquid_fire_custom", LUA_MODIFIER_MOTION_NONE )

jakiro_liquid_fire_custom = class({})

jakiro_liquid_fire_custom.modifier_jakiro_8 = {12,24}
jakiro_liquid_fire_custom.modifier_jakiro_9 = {-1,-2}

function jakiro_liquid_fire_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_jakiro_9") then
        bonus = self.modifier_jakiro_9[self:GetCaster():GetTalentLevel("modifier_jakiro_9")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function jakiro_liquid_fire_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_jakiro_14") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function jakiro_liquid_fire_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context)
end

function jakiro_liquid_fire_custom:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua_jakiro"
end

function jakiro_liquid_fire_custom:GetProjectileName()
	return "particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf"
end

function jakiro_liquid_fire_custom:OnOrbFire( params )
	self:GetCaster():EmitSound("Hero_Jakiro.LiquidFire")
end

function jakiro_liquid_fire_custom:OnOrbFail( params )
	self:OnOrbImpact( params )
end

function jakiro_liquid_fire_custom:OnOrbFire()
    if not IsServer() then return end
    self:UseResources( true, false, false, true )
    if self:GetCaster():HasModifier("modifier_jakiro_14") then return end
    local jakiro_liquid_ice_custom = self:GetCaster():FindAbilityByName("jakiro_liquid_ice_custom")
    if jakiro_liquid_ice_custom then
        jakiro_liquid_ice_custom:UseResources(false, false, false, true)
    end
end

function jakiro_liquid_fire_custom:OnOrbImpact( params )
	if not IsServer() then return end
    local target = params.target
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor( "radius" )
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, 0, 0, false )
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_jakiro_liquid_fire_custom", { duration = duration * (1-enemy:GetStatusResistance()) } )
	end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_Jakiro.LiquidFire")
end

modifier_jakiro_liquid_fire_custom = class({})

function modifier_jakiro_liquid_fire_custom:OnCreated( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_jakiro_8") then
        damage = damage + self:GetAbility().modifier_jakiro_8[self:GetCaster():GetTalentLevel("modifier_jakiro_8")]
    end
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_pct" )
	if not IsServer() then return end
	self.damageTable = 
    {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage * 0.5,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}
	self:StartIntervalThink( 0.5 )
end

function modifier_jakiro_liquid_fire_custom:OnRefresh( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_jakiro_8") then
        damage = damage + self:GetAbility().modifier_jakiro_8[self:GetCaster():GetTalentLevel("modifier_jakiro_8")]
    end
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_pct" )
	if not IsServer() then return end
	self.damageTable.damage = damage * 0.5
end

function modifier_jakiro_liquid_fire_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_jakiro_liquid_fire_custom:GetModifierAttackSpeedBonus_Constant()
	return self.slow
end

function modifier_jakiro_liquid_fire_custom:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

function modifier_jakiro_liquid_fire_custom:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_jakiro_liquid_fire_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end