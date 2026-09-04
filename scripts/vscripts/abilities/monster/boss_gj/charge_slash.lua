--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local TARGET_SEARCH_RANGE = 1600
local WARNING_DELAY = 2
local WARNING_DURATION = 0.9
local HIT_RADIUS = 300
local HIT_DAMAGE_RATE = 30
local HIT_COUNT = 3
local HIT_INTERVAL = 0.3
local EMERGE_POINT_RETRY_COUNT = 16
local function createParticleAt(self, particleName, control, position)
	local pfx = ParticleManager:CreateParticle(particleName, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, control, position)
	return pfx
end
local function releaseParticle(self, pfx, destroy)
	if destroy == nil then
		destroy = false
	end
	if destroy then
		ParticleManager:DestroyParticle(pfx, true)
	end
	ParticleManager:ReleaseParticleIndex(pfx)
end
local function findNearbyWalkablePoint(self, point, radius)
	do
		local i = 0
		while i < 12 do
			local angle = i / 12 * 360
			local offset = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), Vector(radius, 0, 0))
			local candidate = GetGroundPosition(point:__add(offset), nil)
			if GridNav:IsTraversable(candidate) and not GridNav:IsBlocked(candidate) then
				return candidate
			end
			i = i + 1
		end
	end
	return GetGroundPosition(point, nil)
end
____exports.charge_slash = __TS__Class()
local charge_slash = ____exports.charge_slash
charge_slash.name = "charge_slash"
__TS__ClassExtends(charge_slash, MonsterAbility_CS)
function charge_slash.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0,
		castDuration = 5.5,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castRange = 2500,
		OnStart = function()
			return self:StartChargeSlash()
		end,
	}
end
function charge_slash.prototype.StartChargeSlash(self)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	caster:EmitSound("Hero_NagaSiren.ReelIn.Cast")
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.3)
	local warnPfx = createParticleAt(
		nil,
		"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash_group_a.vpcf",
		0,
		origin:__add(Vector(0, 0, 10))
	)
	self:Timer(1, function()
		return releaseParticle(nil, warnPfx, true)
	end)
	self:Timer(0.5, function()
		return self:StartDive(origin)
	end)
	self:Timer(WARNING_DELAY, function()
		return self:StartEmergeWarning()
	end)
end
function charge_slash.prototype.isValidBlinkPoint(self, origin, point)
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	if GridNav:FindPathLength(origin, point) == -1 then
		return false
	end
	return true
end
function charge_slash.prototype.StartDive(self, origin)
	local caster = self:GetCaster()
	local treePfx =
		ParticleManager:CreateParticle("particles/tiny_prestige_tree_spawn_form.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(treePfx, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(treePfx)
	createParticleAt(
		nil,
		"particles/dev/library/base_dust_hit_smoke.vpcf",
		0,
		caster:GetAbsOrigin():__add(Vector(0, 0, 30))
	)
	createParticleAt(
		nil,
		"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_wave_b.vpcf",
		0,
		caster:GetAbsOrigin():__add(Vector(0, 0, 10))
	)
	createParticleAt(
		nil,
		"particles/econ/courier/courier_kunkka_parrot/courier_kunkka_parrot_splash_ring.vpcf",
		0,
		caster:GetAbsOrigin():__add(Vector(0, 0, 10))
	)
	self:Timer(0.2, function()
		____exports.modifier_charge_slash_submerged:applys(caster, caster, self, { duration = 3.3 })
		local divePoint = origin:__sub(caster:GetForwardVector()):__sub(Vector(0, 0, 600))
		caster:Mover(divePoint, 1, nil, true, false, true)
	end)
	self:Timer(0.5, function()
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1.1)
	end)
end
function charge_slash.prototype.StartEmergeWarning(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(TARGET_SEARCH_RANGE) or caster
	if not IsValidAlive(nil, target) then
		return
	end
	local targetPoint = self:FindValidEmergePoint(caster:GetAbsOrigin(), target:GetAbsOrigin())
	local warningPfx = createParticleAt(
		nil,
		"particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash_group_a.vpcf",
		0,
		targetPoint:__add(Vector(0, 0, 10))
	)
	self:Timer(WARNING_DURATION, function()
		releaseParticle(nil, warningPfx, true)
		self:EmergeAndSlash(target, targetPoint)
	end)
end
function charge_slash.prototype.FindValidEmergePoint(self, origin, targetOrigin)
	do
		local i = 0
		while i < EMERGE_POINT_RETRY_COUNT do
			local angle = RandomFloat(0, 360)
			local distance = RandomInt(50, 300)
			local offset = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), Vector(distance, 0, 0))
			local candidate = findNearbyWalkablePoint(nil, targetOrigin:__add(offset), 300)
			if self:isValidBlinkPoint(origin, candidate) then
				return candidate
			end
			i = i + 1
		end
	end
	local fallbackPoint = findNearbyWalkablePoint(nil, targetOrigin, 300)
	local ____table_isValidBlinkPoint_result_0
	if self:isValidBlinkPoint(origin, fallbackPoint) then
		____table_isValidBlinkPoint_result_0 = fallbackPoint
	else
		____table_isValidBlinkPoint_result_0 = targetOrigin
	end
	return ____table_isValidBlinkPoint_result_0
end
function charge_slash.prototype.EmergeAndSlash(self, target, targetPoint)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or caster:IsNull() or not IsValidAlive(nil, target) or target:IsNull() then
		return
	end
	StopSoundOn("Hero_NagaSiren.ReelIn.Cast", caster)
	caster:EmitSound("Hero_NagaSiren.MirrorImage")
	local splashPfx = createParticleAt(
		nil,
		"particles/econ/items/kunkka/kunkka_torrent_base/kunkka_spell_torrent_splash_econ.vpcf",
		0,
		targetPoint:__add(Vector(0, 0, 10))
	)
	caster:SetAbsOrigin(targetPoint:__add(Vector(100, 0, -400)))
	local faceDirection = target:GetOrigin():__sub(targetPoint):Normalized()
	caster:SetForwardVector(Vector(faceDirection.x, faceDirection.y, 0))
	caster:Mover(
		caster:GetOrigin():__sub(caster:GetForwardVector()):__add(Vector(0, 0, 450)),
		0.3,
		nil,
		true,
		false,
		true
	)
	self:Timer(0.6, function()
		self:StartSlashHits(splashPfx)
	end)
end
function charge_slash.prototype.StartSlashHits(self, splashPfx)
	local caster = self:GetCaster()
	local count = 0
	local function doHit()
		if not IsValidAlive(nil, caster) then
			return
		end
		if count == 0 then
			self:Timer(0.25, function()
				FindClearSpaceForUnit(caster, caster:GetOrigin(), true)
				releaseParticle(nil, splashPfx, true)
			end)
		end
		local hitPoint = caster:GetOrigin():__add(caster:GetForwardVector():__mul(400 * count + 200))
		local impactPfx = createParticleAt(
			nil,
			"particles/econ/items/kunkka/kunkka_immortal/kunkka_immortal_ghost_ship_impact.vpcf",
			3,
			hitPoint:__add(Vector(0, 0, 25))
		)
		self:Timer(2, function()
			return releaseParticle(nil, impactPfx)
		end)
		self:DamageArea(hitPoint, HIT_RADIUS, HIT_DAMAGE_RATE)
		count = count + 1
		if count < HIT_COUNT then
			return HIT_INTERVAL
		end
	end
	Timers:CreateTimer(0, function()
		return SafelyCall(nil, function()
			return doHit(nil)
		end)
	end)
end
function charge_slash.prototype.DamageArea(self, origin, radius, damageRate)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
		if not enemy:HasModifier("modifier_immune") then
			enemy:KnockBack(caster, self, {
				duration = 0.3,
				stun = true,
				stunDuration = 0.2,
				distance = 0,
				height = 300,
			})
		end
	end)
end
charge_slash = __TS__DecorateLegacy({ registerAbility(nil) }, charge_slash)
____exports.charge_slash = charge_slash
____exports.modifier_charge_slash_submerged = __TS__Class()
local modifier_charge_slash_submerged = ____exports.modifier_charge_slash_submerged
modifier_charge_slash_submerged.name = "modifier_charge_slash_submerged"
__TS__ClassExtends(modifier_charge_slash_submerged, BaseModifier_CS)
function modifier_charge_slash_submerged.prototype.IsHidden(self)
	return true
end
function modifier_charge_slash_submerged.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_charge_slash_submerged.prototype.GetModifierInvisibilityLevel(self)
	return 1
end
function modifier_charge_slash_submerged.prototype.IsPurgable(self)
	return false
end
function modifier_charge_slash_submerged.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
modifier_charge_slash_submerged = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_charge_slash_submerged)
____exports.modifier_charge_slash_submerged = modifier_charge_slash_submerged
return ____exports