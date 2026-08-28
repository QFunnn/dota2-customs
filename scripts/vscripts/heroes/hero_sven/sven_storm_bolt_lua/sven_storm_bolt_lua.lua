--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_sven_storm_bolt_lua",
	"heroes/hero_sven/sven_storm_bolt_lua/sven_storm_bolt_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_sven_storm_bolt_buff_lua",
	"heroes/hero_sven/sven_storm_bolt_lua/sven_storm_bolt_lua",
	LUA_MODIFIER_MOTION_NONE
)

sven_storm_bolt_lua = class({})

function sven_storm_bolt_lua:GetAOERadius()
	return self:GetSpecialValueFor("bolt_aoe")
end

function sven_storm_bolt_lua:OnAbilityPhaseStart()
	local nFXIndex = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sven/sven_spell_storm_bolt_lightning.vpcf",
		PATTACH_CUSTOMORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		nFXIndex,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_sword",
		self:GetCaster():GetOrigin(),
		true
	)

	local vLightningOffset = self:GetCaster():GetOrigin() + Vector(0, 0, 1600)
	ParticleManager:SetParticleControl(nFXIndex, 1, vLightningOffset)

	ParticleManager:ReleaseParticleIndex(nFXIndex)
	return true
end

function sven_storm_bolt_lua:OnSpellStart()
	local vision_radius = self:GetSpecialValueFor("vision_radius")
	local bolt_speed = self:GetSpecialValueFor("bolt_speed")

	local info = {
		EffectName = "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf",
		Ability = self,
		iMoveSpeed = bolt_speed,
		Source = self:GetCaster(),
		Target = self:GetCursorTarget(),
		bDodgeable = true,
		bProvidesVision = true,
		iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
		iVisionRadius = vision_radius,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
	}

	ProjectileManager:CreateTrackingProjectile(info)
	EmitSoundOn("Hero_Sven.StormBolt", self:GetCaster())
end

function sven_storm_bolt_lua:OnProjectileHit(hTarget, vLocation)
	if hTarget ~= nil and (not hTarget:IsInvulnerable()) and (not hTarget:TriggerSpellAbsorb(self)) then
		EmitSoundOn("Hero_Sven.StormBoltImpact", hTarget)
		local bolt_aoe = self:GetSpecialValueFor("bolt_aoe")
		local bolt_damage = self:GetSpecialValueFor("bolt_damage")

		local ability = self:GetCaster():FindAbilityByName("special_bonus_sven_tal2")
		if ability ~= nil and ability:GetLevel() > 0 then
			bolt_damage = bolt_damage + 175
		end

		local bolt_stun_duration = self:GetSpecialValueFor("bolt_stun_duration")

		self:GetCaster()
			:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_sven_storm_bolt_buff_lua",
				{ duration = bolt_stun_duration }
			)

		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			hTarget:GetOrigin(),
			hTarget,
			bolt_aoe,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		if #enemies > 0 then
			for _, enemy in pairs(enemies) do
				if enemy ~= nil and (not enemy:IsMagicImmune()) and (not enemy:IsInvulnerable()) then
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = bolt_damage,
						damage_type = DAMAGE_TYPE_MAGICAL,
					}

					ApplyDamage(damage)
					enemy:AddNewModifier(
						self:GetCaster(),
						self,
						"modifier_sven_storm_bolt_lua",
						{ duration = bolt_stun_duration }
					)
				end
			end
		end
	end

	return true
end

--------------------------------------------------------------------------------

modifier_sven_storm_bolt_lua = class({})

function modifier_sven_storm_bolt_lua:IsDebuff()
	return true
end

function modifier_sven_storm_bolt_lua:IsHidden()
	return true
end

function modifier_sven_storm_bolt_lua:IsStunDebuff()
	return true
end

function modifier_sven_storm_bolt_lua:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_sven_storm_bolt_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_sven_storm_bolt_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
	return funcs
end

function modifier_sven_storm_bolt_lua:GetOverrideAnimation(params)
	return ACT_DOTA_DISABLED
end

function modifier_sven_storm_bolt_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

--------------------------------------------------------------------------------

modifier_sven_storm_bolt_buff_lua = class({})

function modifier_sven_storm_bolt_buff_lua:IsHidden()
	return true
end

function modifier_sven_storm_bolt_buff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_sven_storm_bolt_buff_lua:GetModifierMoveSpeedBonus_Percentage(params)
	return self:GetAbility():GetSpecialValueFor("buff")
end

function modifier_sven_storm_bolt_buff_lua:GetModifierAttackSpeedBonus_Constant(params)
	return self:GetAbility():GetSpecialValueFor("buff")
end