--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_npc_dota_hero_queenofpain_spell1_slow",
	"heroes/hero_qop/npc_dota_hero_queenofpain_spell1",
	LUA_MODIFIER_MOTION_NONE
)

npc_dota_hero_queenofpain_spell1 = class({})

function npc_dota_hero_queenofpain_spell1:OnSpellStart()
	local point = self:GetCursorPosition()
	local count = self:GetSpecialValueFor("count")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_qop_tal_2")
	if ability ~= nil and ability:GetLevel() > 0 then
		count = count + 3
	end

	local delay = 0
	for i = 1, count do
		Timers:CreateTimer(delay, function()
			local caster = self:GetCaster()
			EmitSoundOn("Hero_QueenOfPain.ShadowStrike", self:GetCaster())

			pos = point + self:GetCaster():GetRightVector() * RandomInt(-150, 150)

			local direction = pos - caster:GetAbsOrigin()
			direction.z = 0
			local projectile_direction = direction:Normalized()

			ProjectileManager:CreateLinearProjectile({
				Ability = self,
				EffectName = "particles/qop1.vpcf",
				vSpawnOrigin = caster:GetAbsOrigin(),
				fDistance = 700 + self:GetCaster():GetCastRangeBonus(),
				fStartRadius = 40,
				fEndRadius = 40,
				Source = caster,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				bDeleteOnHit = true,
				vVelocity = projectile_direction * 900,
				bProvidesVision = true,
				iVisionRadius = 100,
				iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
			})
		end)
		delay = delay + 0.2
	end
end

function npc_dota_hero_queenofpain_spell1:OnProjectileHitHandle(target, location, projectile)
	if not IsServer() then
		return
	end
	if not target then
		return
	end
	self.damage = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")
	local ability = self:GetCaster():FindAbilityByName("special_bonus_qop_tal_1")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.damage = self.damage + 60
	end

	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbilityDamageType(),
	}
	ProjectileManager:DestroyLinearProjectile(projectile)
	ApplyDamage(damageTable)
	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_npc_dota_hero_queenofpain_spell1_slow",
		{ duration = self:GetSpecialValueFor("duration") }
	)
	self:PlayEffects(target)
end

function npc_dota_hero_queenofpain_spell1:PlayEffects(target)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(
		effect_cast,
		1,
		(self:GetCaster():GetOrigin() - target:GetOrigin()):Normalized()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

--------------------------------

modifier_npc_dota_hero_queenofpain_spell1_slow = class({})

function modifier_npc_dota_hero_queenofpain_spell1_slow:IsHidden()
	return true
end

function modifier_npc_dota_hero_queenofpain_spell1_slow:IsPurgable()
	return true
end

function modifier_npc_dota_hero_queenofpain_spell1_slow:RemoveOnDeath()
	return true
end

function modifier_npc_dota_hero_queenofpain_spell1_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_npc_dota_hero_queenofpain_spell1_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("slow")
end