--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_purification", "neutrals/woda_neutral_purification", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_purification = class({})

function woda_neutral_purification:GetIntrinsicModifierName()
	return "modifier_woda_neutral_purification"
end

function woda_neutral_purification:Precache(context)
    PrecacheResource( "particle", "particles/purification_red.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification_hit.vpcf", context )
end

modifier_woda_neutral_purification = class({})

function modifier_woda_neutral_purification:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_woda_neutral_purification:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetAbility():IsFullyCastable() then return end
	if self:GetParent():GetAggroTarget() == nil then return end
	self:GetAbility():UseResources(false, false, false, true)

	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_neutral_cast", {})

	local heal_persentage = self:GetAbility():GetSpecialValueFor("heal_persentage")
	local radius = self:GetAbility():GetSpecialValueFor("radius")
	local heal = self:GetCaster():GetMaxHealth() / 100 * heal_persentage

	Timers:CreateTimer(0, function() 
		if not self:GetCaster():IsAlive() then return end
		self:GetCaster():Heal( heal, self:GetAbility() ) 
		self:PlayEffects1( self:GetCaster(), radius )
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		
		local damageTable = {
			attacker = self:GetParent(),
			damage = heal,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self:GetAbility(),
		}

		for _,enemy in pairs(enemies) do
			damageTable.victim = enemy
			ApplyDamage(damageTable)
		end

		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
	self:GetCaster():MoveToPositionAggressive(self:GetParent():GetAbsOrigin())
end

function modifier_woda_neutral_purification:PlayEffects1( target, radius )
	local effect_target = ParticleManager:CreateParticle( "particles/purification_red.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_target, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_target )
	target:EmitSound("Hero_Omniknight.Purification")

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_woda_neutral_purification:PlayEffects2( origin, target )
	local effect_target = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_purification_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( effect_target, 0, origin, PATTACH_POINT_FOLLOW, "attach_hitloc", origin:GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( effect_target, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_target )
end