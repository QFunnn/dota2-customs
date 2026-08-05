--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_vengefulspirit_magic_missile_lua",
	"heroes/hero_vengefulspirit/hero_vengefulspirit",
	LUA_MODIFIER_MOTION_NONE
)

vengefulspirit_magic_missile_lua = class({})

function vengefulspirit_magic_missile_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	self:LaunchMissile(target, caster, false)
	self.talent5 = self:GetCaster():FindAbilityByName("special_bonus_unique_vengefulspirit_5")
	EmitSoundOn("Hero_VengefulSpirit.MagicMissile", caster)
end

function vengefulspirit_magic_missile_lua:LaunchMissile(hTarget, hSource, bIsBounce)
	local info = {
		Target = hTarget,
		Source = hSource,
		Ability = self,
		EffectName = "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("magic_missile_speed"),
		vSourceLoc = hSource:GetAbsOrigin(),
		bDrawsOnMinimap = false,
		bDodgeable = true,
		bIsAttack = false,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		flExpireTime = GameRules:GetGameTime() + 10,
		bProvidesVision = true,
		iVisionRadius = 400,
		iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
		ExtraData = { bounce = bIsBounce and 1 or 0 },
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function vengefulspirit_magic_missile_lua:OnProjectileHit_ExtraData(hTarget, vLocation, extraData)
	if not hTarget or hTarget:IsInvulnerable() or hTarget:IsMagicImmune() then
		return true
	end

	if hTarget:TriggerSpellAbsorb(self) then
		return true
	end

	EmitSoundOn("Hero_VengefulSpirit.MagicMissileImpact", hTarget)

	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("magic_missile_damage")
	local duration = self:GetSpecialValueFor("magic_missile_stun")

	ApplyDamage({
		victim = hTarget,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})
	hTarget:AddNewModifier(caster, self, "modifier_stunned", { duration = duration })

	if extraData.bounce == 0 and self.talent5 and self.talent5:GetLevel() > 0 then
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			hTarget:GetAbsOrigin(),
			hTarget,
			300,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			FIND_CLOSEST,
			false
		)

		for _, enemy in pairs(enemies) do
			if enemy ~= hTarget and enemy:IsAlive() then
				self:LaunchMissile(enemy, hTarget, true)
				break
			end
		end
	end

	return true
end

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_vengefulspirit_wave_of_terror_lua",
	"heroes/hero_vengefulspirit/hero_vengefulspirit",
	LUA_MODIFIER_MOTION_NONE
)

vengefulspirit_wave_of_terror_lua = class({})

function vengefulspirit_wave_of_terror_lua:OnSpellStart()
	local caster = self:GetCaster()
	local vCursorPos = self:GetCursorPosition()
	local vOrigin = caster:GetOrigin()

	local vDirection = vCursorPos - vOrigin
	if vDirection:Length2D() == 0 then
		vDirection = caster:GetForwardVector()
	end
	vDirection = vDirection:Normalized()

	self.wave_speed = self:GetSpecialValueFor("wave_speed")
	self.wave_width = self:GetSpecialValueFor("wave_width")
	self.vision_aoe = self:GetSpecialValueFor("vision_aoe")
	self.duration = self:GetSpecialValueFor("duration")
	self.wave_damage = self:GetSpecialValueFor("wave_damage")
	local distance = self:GetCastRange(vOrigin, nil) + caster:GetCastRangeBonus()

	local talent = caster:FindAbilityByName("special_bonus_unique_vengefulspirit_3")
	if talent and talent:GetLevel() > 0 then
		local angle = 5
		local dir_left = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), vDirection)
		local dir_right = RotatePosition(Vector(0, 0, 0), QAngle(0, -angle, 0), vDirection)

		self:Fire(dir_left * self.wave_speed, distance)
		self:Fire(dir_right * self.wave_speed, distance)
	else
		self:Fire(vDirection * self.wave_speed, distance)
	end

	EmitSoundOn("Hero_VengefulSpirit.WaveOfTerror", caster)
end

function vengefulspirit_wave_of_terror_lua:Fire(velocity, distance)
	local info = {
		EffectName = "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf",
		Ability = self,
		vSpawnOrigin = self:GetCaster():GetOrigin(),
		fStartRadius = self.wave_width,
		fEndRadius = self.wave_width,
		vVelocity = velocity,
		fDistance = distance,
		Source = self:GetCaster(),
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		bProvidesVision = true,
		iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
		iVisionRadius = self.vision_aoe,
	}
	ProjectileManager:CreateLinearProjectile(info)
end

function vengefulspirit_wave_of_terror_lua:OnProjectileHit(hTarget, vLocation)
	if hTarget ~= nil then
		ApplyDamage({
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = self.wave_damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self,
		})
		hTarget:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_vengefulspirit_wave_of_terror_lua",
			{ duration = self.duration }
		)
	end
	return false
end

--------------------------------------------------------------------------------
modifier_vengefulspirit_wave_of_terror_lua = class({})

function modifier_vengefulspirit_wave_of_terror_lua:IsDebuff()
	return true
end
function modifier_vengefulspirit_wave_of_terror_lua:IsPurgable()
	return true
end

function modifier_vengefulspirit_wave_of_terror_lua:OnCreated()
	self.armor_red = self:GetAbility():GetSpecialValueFor("armor_reduction")
end

function modifier_vengefulspirit_wave_of_terror_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_vengefulspirit_wave_of_terror_lua:GetModifierPhysicalArmorBonus()
	return -self.armor_red
end

function modifier_vengefulspirit_wave_of_terror_lua:GetEffectName()
	return "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf"
end

function modifier_vengefulspirit_wave_of_terror_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_vengefulspirit_command_aura_lua",
	"heroes/hero_vengefulspirit/hero_vengefulspirit",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_vengefulspirit_command_aura_effect_lua",
	"heroes/hero_vengefulspirit/hero_vengefulspirit",
	LUA_MODIFIER_MOTION_NONE
)

vengefulspirit_command_aura_lua = class({})

function vengefulspirit_command_aura_lua:GetIntrinsicModifierName()
	return "modifier_vengefulspirit_command_aura_lua"
end

--------------------------------------------------------------------------------

modifier_vengefulspirit_command_aura_lua = class({})

function modifier_vengefulspirit_command_aura_lua:IsHidden()
	return true
end
function modifier_vengefulspirit_command_aura_lua:IsPurgable()
	return false
end

function modifier_vengefulspirit_command_aura_lua:IsAura()
	return not self:GetParent():PassivesDisabled()
end

function modifier_vengefulspirit_command_aura_lua:GetModifierAura()
	return "modifier_vengefulspirit_command_aura_effect_lua"
end

function modifier_vengefulspirit_command_aura_lua:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_vengefulspirit_command_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_vengefulspirit_command_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP
end

function modifier_vengefulspirit_command_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

--------------------------------------------------------------------------------

modifier_vengefulspirit_command_aura_effect_lua = class({})

function modifier_vengefulspirit_command_aura_effect_lua:IsHidden()
	return true
end
function modifier_vengefulspirit_command_aura_effect_lua:IsPurgable()
	return false
end

function modifier_vengefulspirit_command_aura_effect_lua:OnCreated()
	self.bonus_damage_pct = self:GetAbility():GetSpecialValueFor("bonus_damage_pct")
end

function modifier_vengefulspirit_command_aura_effect_lua:OnRefresh()
	self.bonus_damage_pct = self:GetAbility():GetSpecialValueFor("bonus_damage_pct")
end

function modifier_vengefulspirit_command_aura_effect_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end

function modifier_vengefulspirit_command_aura_effect_lua:GetModifierBaseDamageOutgoing_Percentage()
	if self:GetCaster():PassivesDisabled() then
		return 0
	end
	return self.bonus_damage_pct
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_vengefulspirit_nether_swap_lua",
	"heroes/hero_vengefulspirit/hero_vengefulspirit",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_vengefulspirit_nether_swap_lua_effect",
	"heroes/hero_vengefulspirit/hero_vengefulspirit",
	LUA_MODIFIER_MOTION_NONE
)

vengefulspirit_nether_swap_lua = class({})

function vengefulspirit_nether_swap_lua:GetCooldown(level)
	local caster = self:GetCaster()
	local talent = caster:FindAbilityByName("special_bonus_unique_vengefulspirit_6")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 20
	end
	return self.BaseClass.GetCooldown(self, level)
end

function vengefulspirit_nether_swap_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function vengefulspirit_nether_swap_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()

	if hCaster == nil or hTarget == nil then
		return
	end

	local vPos2 = hTarget:GetOrigin()
	GridNav:DestroyTreesAroundPoint(vPos2, 300, false)
	hTarget:AddNewModifier(hCaster, self, "modifier_vengefulspirit_nether_swap_lua", { duration = 0.03 })
end

-------------------------------------------------

modifier_vengefulspirit_nether_swap_lua = class({})

function modifier_vengefulspirit_nether_swap_lua:IsHidden()
	return true
end

function modifier_vengefulspirit_nether_swap_lua:IsPurgable()
	return false
end

function modifier_vengefulspirit_nether_swap_lua:OnCreated(kv)
	local ability = self:GetAbility()
	local caster = self:GetCaster()
	local point = self:GetParent():GetOrigin()
	local parent = self:GetParent()

	local count = ability:GetSpecialValueFor("count")
	local duration = ability:GetSpecialValueFor("duration")

	local illusions = CreateIllusions(caster, caster, {
		outgoing_damage = 0,
		incoming_damage = -100,
		duration = duration,
	}, count, 50, false, true)

	if illusions then
		for _, illusion in pairs(illusions) do
			FindClearSpaceForUnit(illusion, point + RandomVector(RandomInt(0, 100)), true)
			illusion:AddNewModifier(caster, self, "modifier_vengefulspirit_nether_swap_lua_effect", {})
			local average_bonus_damage = caster:GetAverageTrueAttackDamage(nil)
			illusion:SetBaseDamageMin(average_bonus_damage - self:GetCaster():GetAgility())
			illusion:SetBaseDamageMax(average_bonus_damage - self:GetCaster():GetAgility())
		end
	end

	local nTargetFX = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_vengeful/vengeful_nether_swap_target.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControlEnt(
		nTargetFX,
		1,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		caster:GetOrigin(),
		false
	)
	ParticleManager:ReleaseParticleIndex(nTargetFX)

	EmitSoundOn("Hero_VengefulSpirit.NetherSwap", caster)
	EmitSoundOn("Hero_VengefulSpirit.NetherSwap", self:GetParent())

	caster:StartGesture(ACT_DOTA_CHANNEL_END_ABILITY_4)
end

----------------------------------

modifier_vengefulspirit_nether_swap_lua_effect = class({})

function modifier_vengefulspirit_nether_swap_lua_effect:IsHidden()
	return true
end

function modifier_vengefulspirit_nether_swap_lua_effect:IsDebuff()
	return false
end

function modifier_vengefulspirit_nether_swap_lua_effect:IsPurgable()
	return false
end

function modifier_vengefulspirit_nether_swap_lua_effect:OnRefresh(kv) end

function modifier_vengefulspirit_nether_swap_lua_effect:OnRemoved() end

function modifier_vengefulspirit_nether_swap_lua_effect:OnDestroy() end

function modifier_vengefulspirit_nether_swap_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
	return funcs
end

function modifier_vengefulspirit_nether_swap_lua_effect:GetModifierMoveSpeed_Absolute()
	return 550
end

function modifier_vengefulspirit_nether_swap_lua_effect:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
	}
	return state
end

function modifier_vengefulspirit_nether_swap_lua_effect:GetStatusEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_vengefulspirit_nether_swap_lua_effect:StatusEffectPriority()
	return 10001
end