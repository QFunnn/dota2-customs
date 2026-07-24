--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_treant_leech_seed_custom", "heroes/hero_treant/treant_leech_seed_custom", LUA_MODIFIER_MOTION_NONE)

treant_leech_seed_custom = class({})

function treant_leech_seed_custom:GetAOERadius()
	return self:GetSpecialValueFor("aoe_radius")
end

function treant_leech_seed_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local radius = self:GetSpecialValueFor("aoe_radius")
	self:GetCaster():EmitSound("Hero_Treant.LeechSeed.Cast")

	if true then
		local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(targets) do
			self:CastAbility(enemy)
		end
	else
		self:CastAbility(target)
	end
end

function treant_leech_seed_custom:CastAbility(target)
	target:EmitSound("Hero_Treant.LeechSeed.Target")
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack1")))
	ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)
	target:AddNewModifier(self:GetCaster(), self, "modifier_treant_leech_seed_custom", {duration = self:GetSpecialValueFor("duration") - FrameTime()})
end

function treant_leech_seed_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
	if target == nil then return end
	local heal = self:GetSpecialValueFor("leech_damage")
	target:Heal(heal, self)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, heal, nil)
end

modifier_treant_leech_seed_custom = class({})

function modifier_treant_leech_seed_custom:IsPurgable() return true end
function modifier_treant_leech_seed_custom:RemoveOnDeath() return false end

function modifier_treant_leech_seed_custom:OnCreated()
	self.damage_interval = self:GetAbility():GetSpecialValueFor("damage_interval")
	self.leech_damage = self:GetAbility():GetSpecialValueFor("leech_damage")
	self.movement_slow = self:GetAbility():GetSpecialValueFor("movement_slow")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.projectile_speed = self:GetAbility():GetSpecialValueFor("projectile_speed")
	if not IsServer() then return end
	self:OnIntervalThink()
	self:StartIntervalThink(self.damage_interval)
end

function modifier_treant_leech_seed_custom:OnIntervalThink()
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Treant.LeechSeed.Tick")
	local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
	
	print(#heroes)

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(particle)

	ApplyDamage({ victim = self:GetParent(), damage = self.leech_damage * self.damage_interval, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self:GetCaster(), ability = self:GetAbility() })

	for _, hero in pairs(heroes) do
		ProjectileManager:CreateTrackingProjectile({
			EffectName			= "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf",
			Ability				= self:GetAbility(),
			Source				= self:GetParent(),
			vSourceLoc			= self:GetParent():GetAbsOrigin(),
			Target				= hero,
			iMoveSpeed			= self.projectile_speed,
			flExpireTime		= nil,
			bDodgeable			= false,
			bIsAttack			= false,
			bReplaceExisting	= false,
			iSourceAttachment	= nil,
			bDrawsOnMinimap		= nil,
			bVisibleToEnemies	= true,
			bProvidesVision		= false,
			iVisionRadius		= nil,
			iVisionTeamNumber	= nil,
			ExtraData			= {}
		})
	end
end

function modifier_treant_leech_seed_custom:DeclareFunctions()
	return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end

function modifier_treant_leech_seed_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.movement_slow
end