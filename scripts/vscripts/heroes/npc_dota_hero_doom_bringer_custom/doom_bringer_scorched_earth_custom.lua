--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_doom_bringer_scorched_earth_custom", "heroes/npc_dota_hero_doom_bringer_custom/doom_bringer_scorched_earth_custom", LUA_MODIFIER_MOTION_NONE )

doom_bringer_scorched_earth_custom = class({})

function doom_bringer_scorched_earth_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_doom_bringer/doom_scorched_earth.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_doom_bringer/doom_bringer_scorched_earth_debuff.vpcf', context )
end

doom_bringer_scorched_earth_custom.modifier_doom_bringer_1 = {6,12}
doom_bringer_scorched_earth_custom.modifier_doom_bringer_15 = {-4,-8,-12}

function doom_bringer_scorched_earth_custom:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor( "radius" )
end

function doom_bringer_scorched_earth_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_doom_bringer_15") then
		bonus = self.modifier_doom_bringer_15[self:GetCaster():GetTalentLevel("modifier_doom_bringer_15")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function doom_bringer_scorched_earth_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor( "duration" )
	self:GetCaster():RemoveModifierByName("modifier_doom_bringer_scorched_earth_custom")
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_doom_bringer_scorched_earth_custom", { duration = duration })
end

modifier_doom_bringer_scorched_earth_custom = class({})

function modifier_doom_bringer_scorched_earth_custom:OnCreated( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed_pct" )
	if not IsServer() then return end
	local interval = 1
	self.owner = kv.isProvidedByAura~=1
	if not self.owner then return end
	if not self:GetParent():IsAlive() then return end

	if self:GetCaster():HasModifier("modifier_doom_bringer_17") then
		damage = damage + (self:GetCaster():GetSpellAmplification(false) * 100)
	end

	self.damageTable = { attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility(), }
	self:StartIntervalThink( interval )
	self:PlayEffects1()
end

function modifier_doom_bringer_scorched_earth_custom:OnRefresh( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed_pct" )	
	if not IsServer() then return end
	if not self.owner then return end
	if not self:GetParent():IsAlive() then return end
	self.damageTable.damage = damage
end

function modifier_doom_bringer_scorched_earth_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
	return funcs
end

function modifier_doom_bringer_scorched_earth_custom:GetModifierConstantHealthRegen()
    return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_doom_bringer_scorched_earth_custom:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_doom_bringer_1") then
		bonus = self:GetAbility().modifier_doom_bringer_1[self:GetCaster():GetTalentLevel("modifier_doom_bringer_1")]
	end
	return self.ms_bonus + bonus
end

function modifier_doom_bringer_scorched_earth_custom:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetParent():IsAlive() then
        self:Destroy()
        return 
    end
	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		if enemy:IsAlive() then
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )
			self:PlayEffects2( enemy )
		end
	end
end

function modifier_doom_bringer_scorched_earth_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_DoomBringer.ScorchedEarthAura")
end

function modifier_doom_bringer_scorched_earth_custom:IsAura()
	return self.owner
end

function modifier_doom_bringer_scorched_earth_custom:GetModifierAura()
	return "modifier_doom_bringer_scorched_earth_custom"
end

function modifier_doom_bringer_scorched_earth_custom:GetAuraRadius()
	return self.radius
end

function modifier_doom_bringer_scorched_earth_custom:GetAuraDuration()
	return 0.5
end

function modifier_doom_bringer_scorched_earth_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_doom_bringer_scorched_earth_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_doom_bringer_scorched_earth_custom:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_doom_bringer_scorched_earth_custom:GetAuraEntityReject( hEntity )
	if not IsServer() then return end
	if hEntity==self:GetParent() then return true end
	return hEntity:GetPlayerOwnerID()~=self:GetParent():GetPlayerOwnerID()
end

function modifier_doom_bringer_scorched_earth_custom:GetEffectName()
	return "particles/units/heroes/hero_doom_bringer/doom_bringer_scorched_earth_buff.vpcf"
end

function modifier_doom_bringer_scorched_earth_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_doom_bringer_scorched_earth_custom:PlayEffects1()
	if not self:GetParent():IsAlive() then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_scorched_earth.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false  )
	self:GetParent():EmitSound("Hero_DoomBringer.ScorchedEarthAura")
end

function modifier_doom_bringer_scorched_earth_custom:PlayEffects2( target )
	if not self:GetParent():IsAlive() then return end
	if not target:IsAlive() then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_doom_bringer/doom_bringer_scorched_earth_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end