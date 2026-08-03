--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local levelup_blink_common = require("abilities/levelup_blink_common")

levelup_blink = class({})

function levelup_blink:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_blink:GetManaCost(level)
	return levelup_blink_common.GetManaCost(self, level)
end

function levelup_blink:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local base_max_range = self:GetSpecialValueFor("base_max_range")
	local movement_speed = self:GetSpecialValueFor("movement_speed")
	local direction = (point - caster:GetAbsOrigin())
	direction.z = 0
	local distance = direction:Length2D()
	if distance <= 0.01 then
		return
	end
	direction = direction:Normalized()
	caster:SetForwardVector(direction)
	if distance > base_max_range then
		distance = base_max_range
	end
	caster:Stop()
	caster:EmitSound("Hero_FacelessVoid.TimeWalk.Aeons")
	-- Может потом поменяем взял как у них эффект
	local particle = LevelUpParticleManager:CreateParticle(
		"particles/econ/items/faceless_void/faceless_void_arcana/faceless_void_arcana_time_walk_combined.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	LevelUpParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	Timers:CreateTimer(0.25, function()
		LevelUpParticleManager:DestroyParticle(particle, false)
		LevelUpParticleManager:ReleaseParticleIndex(particle)
	end)

	local target_position = caster:GetAbsOrigin() + direction * distance
	caster:AddNewModifier(caster, self, "modifier_levelup_movement", {
		target_x = target_position.x,
		target_y = target_position.y,
		distance = distance,
		speed = movement_speed,
	})

	levelup_blink_common.OnSuccessfulBlink(caster, self)
end