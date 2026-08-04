--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_levelup_mirana_leap_buff", "abilities/levelup_mirana_leap", LUA_MODIFIER_MOTION_NONE)

local levelup_blink_common = require("abilities/levelup_blink_common")

levelup_mirana_leap = class({})

function levelup_mirana_leap:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_mirana_leap:GetManaCost(level)
	return levelup_blink_common.GetManaCost(self, level)
end

function levelup_mirana_leap:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()
	local direction = point - origin
	direction.z = 0

	local distance = direction:Length2D()
	if distance <= 0.01 then
		return
	end

	local leap_distance = self:GetSpecialValueFor("leap_distance")
	local leap_speed = self:GetSpecialValueFor("leap_speed")
	local leap_height = self:GetSpecialValueFor("leap_height")
	local min_duration = self:GetSpecialValueFor("leap_min_duration")
	local buff_duration = self:GetSpecialValueFor("leap_bonus_duration")

	direction = direction:Normalized()
	distance = math.min(distance, leap_distance)

	caster:Stop()
	caster:SetForwardVector(direction)
	caster:FaceTowards(origin + direction * distance)
	EmitSoundOn("LevelUp.Mirana.Leap", caster)

	local start_particle = LevelUpParticleManager:CreateParticle(
		"particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf",
		PATTACH_WORLDORIGIN,
		caster
	)
	LevelUpParticleManager:SetParticleControl(start_particle, 0, origin)
	LevelUpParticleManager:SetParticleControl(start_particle, 1, origin)
	LevelUpParticleManager:ReleaseParticleIndex(start_particle)

	caster:AddNewModifier(caster, self, "modifier_levelup_mirana_leap_buff", { duration = buff_duration })

	local duration = leap_speed > 0 and distance / leap_speed or 0
	duration = math.max(duration, min_duration)

	self:SetActivated(false)
	local trail_particle = LevelUpParticleManager:CreateParticle(
		"particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_trail.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	local arc = caster:AddNewModifier(caster, self, "modifier_generic_arc_lua", {
		distance = distance,
		duration = duration,
		height = leap_height,
		fix_end = 0,
		isForward = 1,
		dir_x = direction.x,
		dir_y = direction.y,
	})
	if arc then
		levelup_blink_common.OnSuccessfulBlink(caster, self)
		arc:SetEndCallback(function()
			LevelUpParticleManager:DestroyParticle(trail_particle, false)
			LevelUpParticleManager:ReleaseParticleIndex(trail_particle)
			if IsValid(caster) then
				caster:FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
				caster:StartGesture(ACT_MIRANA_LEAP_END)
				FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
			end
			if IsValid(self) then
				self:SetActivated(true)
			end
		end)
	else
		LevelUpParticleManager:DestroyParticle(trail_particle, false)
		LevelUpParticleManager:ReleaseParticleIndex(trail_particle)
		self:SetActivated(true)
	end
end

modifier_levelup_mirana_leap_buff = class({})

function modifier_levelup_mirana_leap_buff:IsHidden()
	return false
end

function modifier_levelup_mirana_leap_buff:IsDebuff()
	return false
end

function modifier_levelup_mirana_leap_buff:IsPurgable()
	return true
end

function modifier_levelup_mirana_leap_buff:OnCreated()
	self.move_speed_pct = 0
	self.attack_speed = 0

	local ability = self:GetAbility()
	if ability then
		self.move_speed_pct = ability:GetSpecialValueFor("leap_speedbonus")
		self.attack_speed = ability:GetSpecialValueFor("leap_speedbonus_as")
	end
end

function modifier_levelup_mirana_leap_buff:OnRefresh()
	self:OnCreated()
end

function modifier_levelup_mirana_leap_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
	}
end

function modifier_levelup_mirana_leap_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.move_speed_pct or 0
end

function modifier_levelup_mirana_leap_buff:GetModifierAttackSpeedPercentage()
	return self.attack_speed or 0
end