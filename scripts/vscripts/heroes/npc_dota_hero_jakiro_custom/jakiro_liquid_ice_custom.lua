--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_generic_orb_effect_lua", "modifiers/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_orb_effect_lua_jakiro_frost", "modifiers/modifier_generic_orb_effect_lua_jakiro_frost", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_liquid_ice_custom", "heroes/npc_dota_hero_jakiro_custom/jakiro_liquid_ice_custom", LUA_MODIFIER_MOTION_NONE )

jakiro_liquid_ice_custom = class({})

jakiro_liquid_ice_custom.modifier_jakiro_11 = {8,16,24}
jakiro_liquid_ice_custom.modifier_jakiro_12 = {-1,-2}

function jakiro_liquid_ice_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_jakiro_12") then
        bonus = self.modifier_jakiro_12[self:GetCaster():GetTalentLevel("modifier_jakiro_12")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function jakiro_liquid_ice_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_jakiro_14") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function jakiro_liquid_ice_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_ice_projectile.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_ice.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_frost.vpcf", context)
end

function jakiro_liquid_ice_custom:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua_jakiro_frost"
end

function jakiro_liquid_ice_custom:GetProjectileName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_ice_projectile.vpcf"
end

function jakiro_liquid_ice_custom:OnOrbFire( params )
    if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Jakiro.LiquidFrost")
    self:UseResources( true, false, false, true )
    if self:GetCaster():HasModifier("modifier_jakiro_14") then return end
    local jakiro_liquid_fire_custom = self:GetCaster():FindAbilityByName("jakiro_liquid_fire_custom")
    if jakiro_liquid_fire_custom then
        jakiro_liquid_fire_custom:UseResources(false, false, false, true)
    end
end

function jakiro_liquid_ice_custom:OnOrbFail( params )
	self:OnOrbImpact( params )
end

function jakiro_liquid_ice_custom:OnOrbImpact( params )
	if not IsServer() then return end
    local target = params.target
	local duration = self:GetSpecialValueFor("duration")
	params.target:AddNewModifier( self:GetCaster(), self, "modifier_jakiro_liquid_ice_custom", { duration = duration * (1-params.target:GetStatusResistance()) } )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_jakiro/jakiro_liquid_ice.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_Jakiro.LiquidFrost")
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_jakiro_11") then
        damage = damage + self.modifier_jakiro_11[self:GetCaster():GetTalentLevel("modifier_jakiro_11")]
    end
    ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
end

modifier_jakiro_liquid_ice_custom = class({})

function modifier_jakiro_liquid_ice_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_jakiro_liquid_ice_custom:StatusEffectPriority()
    return 10
end

function modifier_jakiro_liquid_ice_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_jakiro_liquid_ice_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_slow")
end

function modifier_jakiro_liquid_ice_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if self:GetCaster() ~= params.attacker then return end
    if params.inflictor ~= nil and params.inflictor == self:GetAbility() then return end
    local bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_instance_damage_from_other_abilities")
    if self:GetCaster():HasModifier("modifier_jakiro_11") then
        bonus_damage = bonus_damage + self:GetAbility().modifier_jakiro_11[self:GetCaster():GetTalentLevel("modifier_jakiro_11")]
    end
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = bonus_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end