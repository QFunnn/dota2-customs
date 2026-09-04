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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 使物体/粒子围绕中心点做环绕运动。由中心点 + 当前位置计算旋转起始点（半径与起始方向）。
--
-- @param center 环绕中心（世界坐标）
-- @param startPosition 当前位置，即旋转起始点（与 center 的 2D 距离为半径，方向为起始朝向）
-- @param time 运动总时长（秒）
-- @param callback 每帧回调当前圆周上的世界坐标；运动结束后再调用一次传 null
-- @param options 可选：angularSpeed / interval / heightOffset
local function CircleMover(self, center, startPosition, time, callback, options)
	if options == nil then
		options = {}
	end
	local dx = startPosition.x - center.x
	local dy = startPosition.y - center.y
	local radius = math.sqrt(dx * dx + dy * dy) or 1
	local fwd = Vector(dx / radius, dy / radius, 0)
	local angularSpeed = options.angularSpeed or 90
	local interval = options.interval or 0.03
	local heightOffset = options.heightOffset or 0
	callback(nil, startPosition)
	local elapsed = interval
	Timers:CreateTimer(interval, function()
		local rawAngle = elapsed * angularSpeed
		local angleDeg = (rawAngle % 360 + 360) % 360
		local dir = RotateVector2D(nil, fwd, angleDeg)
		local pos = center:__add(dir:__mul(radius))
		pos.z = center.z + heightOffset
		callback(nil, pos)
		if elapsed >= time then
			callback(nil, nil)
			return nil
		end
		elapsed = elapsed + interval
		return interval
	end)
end
local phantome_ab5 = __TS__Class()
phantome_ab5.name = "phantome_ab5"
__TS__ClassExtends(phantome_ab5, MonsterAbility_CS)
function phantome_ab5.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self["end"] = false
	self.target = nil
end
function phantome_ab5.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 1,
		castDuration = 2.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local forward = caster:GetForwardVector()
			local target = caster:GetMinDistanceUnit(3500)
			local ____ = target and caster:LockTargetForSpeed(target, 1, 3)
			caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(-150)), 0.6)
			caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
		end,
		OnStart = function()
			return self:SpellStart()
		end,
	}
end
function phantome_ab5.prototype.SpellStart(self)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local center = origin:__add(forward:__mul(700))
	local start_point = origin:__add(forward:__mul(100))
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
	local pfx = ParticleManager:CreateParticle("particles/_2boss/hoodwink_boomerang_2.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, start_point)
	ParticleManager:SetParticleControl(pfx, 1, start_point)
	ParticleManager:SetParticleControl(pfx, 2, Vector(3400, 0, 0))
	caster:EmitSound("Hero_Huskar.Life_Break.Impact")
	ScreenShake(caster:GetAbsOrigin(), 8, 8, 2, 3000, 0, true)
	local old_pos = start_point
	CircleMover(nil, center, start_point, 1.2, function(____, pos)
		if pos then
			self:DamageArea(old_pos, 200, 10)
			old_pos = pos
			ParticleManager:SetParticleControl(pfx, 1, pos)
		else
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			caster:AddNewModifier(caster, self, "spirit_3_pre", { duration = 0.75 })
			caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
			self:Timer(0.65, function()
				self:ShootProjectiles()
			end)
		end
	end, { angularSpeed = 320, heightOffset = 120 })
end
function phantome_ab5.prototype.ShootProjectiles(self)
	local caster = self:GetCaster()
	ScreenShake(caster:GetAbsOrigin(), 8, 8, 0.8, 3000, 0, true)
	local forward = caster:GetForwardVector()
	local origin = caster:GetAbsOrigin():__add(Vector(0, 0, 150)):__add(forward:__mul(100))
	local arr = GetRotateVectors(nil, forward, 3, 25)
	caster:EmitSound("Hero_Broodmother.SilkenBola.Target")
	caster:StopSound("Greevil.BladeFuryStart")
	for ____, dir in ipairs(arr) do
		local projectile =
			ParticleManager:CreateParticle("particles/_2boss/hoodwink_boomerang_2.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(projectile, 0, origin)
		ParticleManager:SetParticleControl(projectile, 1, origin:__add(dir:__mul(2000)))
		ParticleManager:SetParticleControl(projectile, 2, Vector(1600, 0, 0))
		local origin_pos = origin
		local n = 0
		Timers:CreateTimer(0.05, function()
			if not IsServer() then
				ParticleManager:DestroyParticle(projectile, false)
				ParticleManager:ReleaseParticleIndex(projectile)
				return nil
			end
			origin_pos = origin_pos:__add(dir:__mul(1600 / 20))
			self:DamageArea(origin_pos:__add(dir:__mul(1600 / 20)), 200, 25)
			n = n + 1
			if n > 20 then
				ParticleManager:DestroyParticle(projectile, false)
				ParticleManager:ReleaseParticleIndex(projectile)
				return nil
			end
			return 0.05
		end)
	end
end
function phantome_ab5.prototype.DamageArea(self, origin, radius, damage)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		local time = GameRules:GetGameTime()
		if (tonumber(caster:GetContext("spirit_3_damage_area")) or 0) > time then
			return
		end
		caster:SetContextNum("spirit_3_damage_area", time + 0.2, 1)
		enemy:KnockBack(caster, self, {
			duration = 0.5,
			origin_pos = origin,
			stun = true,
			distance = 100,
			height = 1,
		})
		caster:MonsterDamage({ victim = enemy, damage_rate = damage, ability = self })
	end)
end
phantome_ab5 = __TS__DecorateLegacy({ registerAbility(nil) }, phantome_ab5)
local spirit_3_pre = __TS__Class()
spirit_3_pre.name = "spirit_3_pre"
__TS__ClassExtends(spirit_3_pre, BaseModifier_CS)
function spirit_3_pre.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
end
function spirit_3_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self:GetCaster():SetAnimation("attack_spin_effigy")
	local fow = caster:GetForwardVector()
	local lockTarget = caster:GetMinDistanceUnit(3600) or caster
	caster:LockTargetForSpeed(lockTarget, 0.3, 3)
	caster:Mover(caster:GetAbsOrigin():__add(fow:__mul(-150)), 0.3)
	self.pfx = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_linear.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(self.pfx, 0, caster:GetAbsOrigin():__add(Vector(0, 0, 200)))
	ParticleManager:SetParticleControl(
		self.pfx,
		1,
		caster:GetAbsOrigin():__add(fow:__mul(100)):__add(Vector(0, 0, 200))
	)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(300, 200, 800))
	ParticleManager:SetParticleControl(self.pfx, 4, fow)
	ParticleManager:SetParticleControl(self.pfx, 15, Vector(1, 0, 0))
	ParticleManager:SetParticleControlForward(self.pfx, 1, fow)
	self:StartIntervalThink(FrameTime())
end
function spirit_3_pre.prototype.GetEffectName(self)
	return "particles/econ/items/underlord/underlord_2021_immortal/underlord_2021_immortal_portal_buildup.vpcf"
end
function spirit_3_pre.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function spirit_3_pre.prototype.OnIntervalThink(self)
	if self.pfx then
		if not IsValidAlive(nil, self:GetCaster()) then
			return
		end
		local fow = self:GetCaster():GetForwardVector()
		self.num = self.num + 1
		ParticleManager:SetParticleControl(
			self.pfx,
			1,
			self:GetCaster():GetAbsOrigin():__add(fow:__mul(math.min(15, self.num) * 50)):__add(Vector(0, 0, 300))
		)
		ParticleManager:SetParticleControlForward(self.pfx, 1, fow)
	end
end
function spirit_3_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	caster:StopSound("Hero_Broodmother.SilkenBola.Target")
	ParticleManager:DestroyParticle(self.pfx, true)
	ParticleManager:ReleaseParticleIndex(self.pfx)
end
spirit_3_pre = __TS__DecorateLegacy({ registerModifier(nil) }, spirit_3_pre)
return ____exports