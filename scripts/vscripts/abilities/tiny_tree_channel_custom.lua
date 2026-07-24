--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tiny_tree_channel_custom", "abilities/tiny_tree_channel_custom", LUA_MODIFIER_MOTION_NONE)

tiny_tree_channel_custom = class({})

function tiny_tree_channel_custom:GetAOERadius()
	return self:GetSpecialValueFor( "splash_radius" )
end

function tiny_tree_channel_custom:OnAbilityPhaseStart()
	if IsServer() then 
		self.radius = self:GetSpecialValueFor( "radius" )
		self.nWarnFXIndex1 = ParticleManager:CreateParticle( "particles/units/heroes/hero_tiny/tiny_tree_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
		ParticleManager:SetParticleControlEnt( self.nWarnFXIndex1, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )
		ParticleManager:SetParticleControl( self.nWarnFXIndex1, 2, Vector( self.radius, self.radius, 1 ) );
	end
	return true
end

function tiny_tree_channel_custom:OnAbilityPhaseInterrupted()
	if IsServer() then 
		if self.nWarnFXIndex1 then
			ParticleManager:DestroyParticle( self.nWarnFXIndex1, true )
		end
	end
end

function tiny_tree_channel_custom:OnSpellStart()
	if not IsServer() then return end
	self.vTargetPos = self:GetCursorPosition()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_tiny_tree_channel_custom", {})
end

function tiny_tree_channel_custom:OnChannelFinish(bInterrupted)
	if not IsServer() then return end
	if self.nWarnFXIndex1 then
		ParticleManager:DestroyParticle( self.nWarnFXIndex1, true )
	end
	self:GetCaster():RemoveModifierByName("modifier_tiny_tree_channel_custom")
end

function tiny_tree_channel_custom:OnProjectileHit( hTarget, vLocation )
	if not IsServer() then return end
	if self == nil then return end
	self.radius = self:GetSpecialValueFor( "splash_radius" )
	self:GetCaster():EmitSound("OgreTank.GroundSmash")
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
	for _,enemy in pairs( enemies ) do
		if enemy ~= nil and enemy:IsInvulnerable() == false and enemy:IsAttackImmune() == false then
			EmitSoundOn( "Hero_Tiny.Tree.Target", enemy )
			self:GetCaster():PerformAttack(enemy, true, true, true, true, false, false, true)
		end
	end
	return true
end

modifier_tiny_tree_channel_custom = class({})

function modifier_tiny_tree_channel_custom:IsHidden() return true end
function modifier_tiny_tree_channel_custom:IsPurgable() return false end
function modifier_tiny_tree_channel_custom:IsPurgeException() return false end

function modifier_tiny_tree_channel_custom:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))
end

function modifier_tiny_tree_channel_custom:OnIntervalThink()
	if not IsServer() then return end
	self.bone_speed = self:GetAbility():GetSpecialValueFor( "speed" )
	local vStartPos = self:GetCaster():GetAttachmentOrigin( self:GetCaster():ScriptLookupAttachment( "attach_attack1" ) )
	local vPos = self:GetAbility().vTargetPos
	local vDirection = vPos - vStartPos 
	local flDist2d = vDirection:Length2D()
	local flDist = vDirection:Length()
	vDirection = vDirection:Normalized()
	vDirection.z = 0.0

	local info = 
	{
		EffectName = "particles/units/heroes/hero_tiny/tiny_tree_linear_proj.vpcf",
		Ability = self:GetAbility(),
		vSpawnOrigin = vStartPos, 
		fStartRadius = 0,
		fEndRadius = 0,
		vVelocity = vDirection * self.bone_speed,
		fDistance = flDist2d,
		Source = self:GetCaster(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
	}

	ProjectileManager:CreateLinearProjectile( info )
	EmitSoundOn( "Hero_Tiny.Tree.Throw", self:GetCaster() )
end