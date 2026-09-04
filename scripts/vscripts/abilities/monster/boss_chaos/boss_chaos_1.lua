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
local __TS__ArraySetLength = ____lualib.__TS__ArraySetLength
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 混沌-4连斩击 (boss_chaos_1)
local px1 = "particles/faceless_void_arcana_time_walk_preimage_blue.vpcf"
local px2 = "particles/blue/terrorblade_sunder_ti8_swirl_rope_max.vpcf"
local px3 = "particles/faceless_void_arcana_time_walk_caustic_blue2.vpcf"
local px4 = "particles/blue/monkey_king_spring_cast_arcana_water_streaks.vpcf"
local px5 = "particles/blue/monkey_king_spring_water_ring_glow.vpcf"
local px6 = "particles/spirit_breaker_charge_iron.vpcf"
local px7 = "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_attack_hit_flash.vpcf"
local PORTAL_PFX = "particles/econ/items/underlord/underlord_2021_immortal/underlord_2021_immortal_portal_buildup.vpcf"
local SLASH1_HIT_KEY = "last_hit_chaos_1_1"
local FINAL_SLASH_HIT_KEY = "last_hit_chaos_1_4"
local CHAOS1_PORTAL_SOUND = "Hero_Spirit_Breaker.Charge.Impact"
local CHAOS1_SLASH1_SOUND = "Hero_Winter_Wyvern.SplinterBlast.Cast"
local CHAOS1_SPIN_SOUND = "Hero_WitchDoctor.Paralyzing_Cask_Cast"
local CHAOS1_LEAP_SOUND = "Hero_Windrunner.ShackleshotCast"
local CHAOS1_FINAL_PREP_SOUND = ""
local CHAOS1_FINAL_WAVE_SOUND = "Hero_Winter_Wyvern.ColdEmbrace.Cast"
____exports.boss_chaos_1 = __TS__Class()
local boss_chaos_1 = ____exports.boss_chaos_1
boss_chaos_1.name = "boss_chaos_1"
__TS__ClassExtends(boss_chaos_1, MonsterAbility_CS)
function boss_chaos_1.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.dis2 = 500
	self.speed = 1.35
	self.damage = 1
end
function boss_chaos_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.3,
		castDuration = 8 / self.speed,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		isNotMove = true,
		animationPlaybackRate = 0.765,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound(CHAOS1_PORTAL_SOUND)
			local target = caster:GetMinDistanceUnit(2500)
			self:playPortalBuildup(caster, 1)
			if target then
				caster:LockTargetForSpeed(target, 1.2 / self.speed, 3)
			end
			self:Timer(0.8 / self.speed, function()
				caster:Mover(caster:GetAbsOrigin():__sub(caster:GetForwardVector():__mul(100)), 0.7 / self.speed)
			end)
			____exports.modifier_boss_chaos_1_slash1_pre:applys(caster, caster, self, { duration = 1.45 / self.speed })
			self:Timer(1 / self.speed, function()
				return self:startFirstSlash(caster, target)
			end)
			self:Timer(2.5 / self.speed, function()
				return self:startSpinSlash(caster)
			end)
			self:Timer(3.6 / self.speed, function()
				return self:startLeapSlash(caster)
			end)
			self:Timer(4.8 / self.speed, function()
				return self:startFinalSlash(caster)
			end)
		end,
	}
end
function boss_chaos_1.prototype.playPortalBuildup(self, caster, duration)
	local pfx = ParticleManager:CreateParticle(PORTAL_PFX, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	local portalPfxDone = false
	local function releasePortalPfx()
		if not IsServer() or portalPfxDone then
			return
		end
		portalPfxDone = true
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
	Timers:CreateTimer(duration, function()
		releasePortalPfx(nil)
		return nil
	end)
end
function boss_chaos_1.prototype.startFirstSlash(self, caster, target)
	caster:EmitSound(CHAOS1_SLASH1_SOUND)
	self:Timer(0.45 / self.speed, function()
		local ____temp_0
		if target and caster.AiDistance then
			____temp_0 = caster:AiDistance(target, 650, 1300, -50, 50)
		else
			____temp_0 = 1000
		end
		local dis = ____temp_0
		local startPos = caster:GetOrigin()
		local endPos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(dis))
		caster:Mover(endPos, 0.6, function(____, pos)
			local searchPos = pos:__add(caster:GetForwardVector():__mul(100))
			__TS__ArrayForEach(self:findEnemies(searchPos, 300), function(____, enemy)
				self:damageWithCooldown(caster, enemy, SLASH1_HIT_KEY, 15 * self.damage)
			end)
			return false
		end)
		self:Timer(0.15, function()
			local pfx = ParticleManager:CreateParticle(px1, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(pfx, 0, startPos)
			ParticleManager:SetParticleControl(pfx, 1, endPos)
			ParticleManager:ReleaseParticleIndex(pfx)
		end)
		self:Timer(0.7, function()
			local newTarget = caster:GetMinDistanceUnit(2500)
			if newTarget then
				caster:LockTargetForSpeed(newTarget, 0.2, 3)
			end
		end)
	end)
end
function boss_chaos_1.prototype.startSpinSlash(self, caster)
	caster:EmitSound(CHAOS1_SPIN_SOUND)
	local movePos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(260))
	caster:Mover(movePos, 0.6 / self.speed)
	local target = caster:GetMinDistanceUnit(2500)
	if target then
		caster:LockTargetForSpeed(target, 1 / self.speed, 3 * self.speed)
	end
	local pfxSpin = ParticleManager:CreateParticle(px2, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(pfxSpin)
	self:Timer(0.4 / self.speed, function()
		local pfxGround = ParticleManager:CreateParticle(px3, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(pfxGround, 1, caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(pfxGround)
		local count = 0
		self:Timer(0, function()
			__TS__ArrayForEach(self:findEnemies(caster:GetOrigin(), 450), function(____, enemy)
				if not IsValidAlive(nil, enemy) then
					return
				end
				caster:MonsterDamage({
					victim = enemy,
					damage_rate = 20 * self.damage,
					ability = self,
					effectName = px7,
				})
				enemy:KnockBack(caster, self, {
					duration = 0.15,
					stun = true,
					stunDuration = 0.3,
					origin_pos = caster:GetAbsOrigin(),
					distance = 80,
					height = 0,
				})
			end)
			count = count + 1
			if count < 3 then
				return 0.1
			end
		end)
	end)
end
function boss_chaos_1.prototype.startLeapSlash(self, caster)
	caster:EmitSound(CHAOS1_LEAP_SOUND)
	local leapPos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-700))
	caster:Mover(Vector(leapPos.x, leapPos.y, 400), 0.6 / self.speed, nil, true)
	local target = caster:GetMinDistanceUnit(2500)
	if target then
		caster:LockTargetForSpeed(target, 1 / self.speed, 3 * self.speed)
	end
	self:Timer(0.12 / self.speed, function()
		local pfxJump = ParticleManager:CreateParticle(px4, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:ReleaseParticleIndex(pfxJump)
	end)
	self:Timer(0.45 / self.speed, function()
		local pfxJumpEnd = ParticleManager:CreateParticle(px5, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:ReleaseParticleIndex(pfxJumpEnd)
	end)
	____exports.modifier_boss_chaos_1_slash4_pre:applys(caster, caster, self, { duration = 1.2 / self.speed })
end
function boss_chaos_1.prototype.startFinalSlash(self, caster)
	caster:EmitSound(CHAOS1_FINAL_PREP_SOUND)
	local curTarget = caster:GetMinDistanceUnit(2500)
	local ____IsValidAlive_result_1
	if IsValidAlive(nil, curTarget) then
		____IsValidAlive_result_1 = curTarget:GetAbsOrigin()
	else
		____IsValidAlive_result_1 = caster:GetAbsOrigin()
	end
	local targetPos = ____IsValidAlive_result_1
	local dis = targetPos:__sub(caster:GetAbsOrigin()):Length2D() + math.random(20, 200)
	dis = math.max(300, math.min(self.dis2, dis))
	local movePos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(dis))
	caster:Mover(Vector(movePos.x, movePos.y, 100), 0.35 / self.speed)
	self:Timer(0.4 / self.speed, function()
		caster:EmitSound("Sounds.sword_end")
		local pfxImpact = ParticleManager:CreateParticle(px3, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(pfxImpact, 1, caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(pfxImpact)
		ScreenShake(caster:GetAbsOrigin(), 6, 3, 2, 2800, 0, true)
		____exports.modifier_boss_chaos_1_final_slash:applys(
			caster,
			caster,
			self,
			{ duration = 1, damage = self.damage }
		)
	end)
end
function boss_chaos_1.prototype.findEnemies(self, center, radius)
	return FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
end
function boss_chaos_1.prototype.damageWithCooldown(self, caster, enemy, hitKey, damageRate)
	local lastHitTime = enemy:GetCustomValue(hitKey) or 0
	if GameRules:GetGameTime() - lastHitTime <= 0.5 then
		return
	end
	caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self, effectName = px7 })
	enemy:KnockBack(caster, self, {
		duration = 0.15,
		stun = true,
		stunDuration = 0.3,
		origin_pos = caster:GetAbsOrigin(),
		distance = 80,
		height = 0,
	})
	enemy:SetCustomValue(hitKey, GameRules:GetGameTime())
end
boss_chaos_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_chaos_1)
____exports.boss_chaos_1 = boss_chaos_1
____exports.modifier_boss_chaos_1_slash1_pre = __TS__Class()
local modifier_boss_chaos_1_slash1_pre = ____exports.modifier_boss_chaos_1_slash1_pre
modifier_boss_chaos_1_slash1_pre.name = "modifier_boss_chaos_1_slash1_pre"
__TS__ClassExtends(modifier_boss_chaos_1_slash1_pre, BaseModifier_CS)
function modifier_boss_chaos_1_slash1_pre.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
function modifier_boss_chaos_1_slash1_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, self.dumy) then
		self:Destroy()
		return
	end
	self.dumy = CreateModifierThinker(
		caster,
		self:GetAbility(),
		"modifier_dummy_thinker",
		{ duration = 6 },
		caster:GetOrigin():__add(caster:GetForwardVector():__mul(100)),
		caster:GetTeamNumber(),
		false
	)
	self.pfx = ParticleManager:CreateParticleForTeam(
		"particles/primal_beast_onslaught_range_finder_max.vpcf",
		PATTACH_CENTER_FOLLOW,
		caster,
		DOTA_TEAM_GOODGUYS
	)
	ParticleManager:SetParticleControl(self.pfx, 0, caster:GetOrigin())
	ParticleManager:SetParticleControl(self.pfx, 1, self.dumy:GetOrigin())
	ParticleManager:SetParticleControl(self.pfx, 4, Vector(255, 0, 0))
	local pfxAmbient =
		ParticleManager:CreateParticle("particles/phoenix_ambient_red.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	self:AddParticle(pfxAmbient, false, false, -1, false, false)
	self:StartIntervalThink(0.03)
end
function modifier_boss_chaos_1_slash1_pre.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, self.dumy) then
		self:Destroy()
		return
	end
	self:IncrementStackCount()
	local dis = math.min(2500, self:GetStackCount() * 40)
	self.dumy:SetOrigin(caster:GetOrigin():__add(caster:GetForwardVector():__mul(dis)))
	ParticleManager:SetParticleControl(self.pfx, 1, self.dumy:GetOrigin())
end
function modifier_boss_chaos_1_slash1_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
	if self.dumy and IsValid(nil, self.dumy) and not self.dumy:IsNull() then
		self.dumy:RemoveSelf()
	end
end
modifier_boss_chaos_1_slash1_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_chaos_1_slash1_pre)
____exports.modifier_boss_chaos_1_slash1_pre = modifier_boss_chaos_1_slash1_pre
____exports.modifier_boss_chaos_1_slash4_pre = __TS__Class()
local modifier_boss_chaos_1_slash4_pre = ____exports.modifier_boss_chaos_1_slash4_pre
modifier_boss_chaos_1_slash4_pre.name = "modifier_boss_chaos_1_slash4_pre"
__TS__ClassExtends(modifier_boss_chaos_1_slash4_pre, BaseModifier_CS)
function modifier_boss_chaos_1_slash4_pre.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
end
function modifier_boss_chaos_1_slash4_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self.pfx = ParticleManager:CreateParticle(
		"particles/ui_mouseactions/range_finder_linear.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	local fow = caster:GetForwardVector()
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
function modifier_boss_chaos_1_slash4_pre.prototype.OnIntervalThink(self)
	if not self.pfx then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local fow = caster:GetForwardVector()
	self.num = self.num + 1
	ParticleManager:SetParticleControl(
		self.pfx,
		1,
		caster:GetAbsOrigin():__add(fow:__mul(math.min(50, self.num) * 30)):__add(Vector(0, 0, 200))
	)
	ParticleManager:SetParticleControlForward(self.pfx, 1, fow)
end
function modifier_boss_chaos_1_slash4_pre.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end
modifier_boss_chaos_1_slash4_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_chaos_1_slash4_pre)
____exports.modifier_boss_chaos_1_slash4_pre = modifier_boss_chaos_1_slash4_pre
____exports.modifier_boss_chaos_1_final_slash = __TS__Class()
local modifier_boss_chaos_1_final_slash = ____exports.modifier_boss_chaos_1_final_slash
modifier_boss_chaos_1_final_slash.name = "modifier_boss_chaos_1_final_slash"
__TS__ClassExtends(modifier_boss_chaos_1_final_slash, BaseModifier_CS)
function modifier_boss_chaos_1_final_slash.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.waveEntries = {}
	self.step = 0
	self.damage = 1.5
end
function modifier_boss_chaos_1_final_slash.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self.damage = params.damage or 1
	caster:EmitSound(CHAOS1_FINAL_WAVE_SOUND)
	for ____, direction in ipairs(GetRotateVectors(nil, caster:GetForwardVector(), 6, 20)) do
		local pfx = ParticleManager:CreateParticle(px6, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin():__add(direction))
		local ____self_waveEntries_2 = self.waveEntries
		____self_waveEntries_2[#____self_waveEntries_2 + 1] = { direction = direction, pfx = pfx }
	end
	self:StartIntervalThink(0.03)
end
function modifier_boss_chaos_1_final_slash.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	self.step = self.step + 1
	do
		local i = 0
		while i < #self.waveEntries do
			do
				local entry = self.waveEntries[i + 1]
				if not IsValidAlive(nil, caster) then
					goto __continue62
				end
				local point = caster:GetAbsOrigin():__add(entry.direction:__mul(50 + self.step * 45))
				ParticleManager:SetParticleControl(entry.pfx, 0, point)
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					point,
					nil,
					100,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					0,
					false
				)
				for ____, enemy in ipairs(enemies) do
					do
						local hitKey = (FINAL_SLASH_HIT_KEY .. "_") .. tostring(i)
						if not IsValidAlive(nil, enemy) then
							goto __continue64
						end
						local lastHitTime = enemy:GetCustomValue(hitKey) or 0
						if GameRules:GetGameTime() - lastHitTime <= 0.5 then
							goto __continue64
						end
						caster:MonsterDamage({
							victim = enemy,
							damage_rate = 20 * self.damage,
							ability = ability,
							effectName = px7,
						})
						enemy:KnockBack(caster, self:GetAbility(), {
							duration = 0.15,
							stun = true,
							stunDuration = 0.3,
							origin_pos = caster:GetAbsOrigin(),
							distance = 80,
							height = 0,
						})
						enemy:SetCustomValue(hitKey, GameRules:GetGameTime())
					end
					::__continue64::
				end
			end
			::__continue62::
			i = i + 1
		end
	end
	if self.step >= 30 then
		self:Destroy()
	end
end
function modifier_boss_chaos_1_final_slash.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	for ____, entry in ipairs(self.waveEntries) do
		ParticleManager:DestroyParticle(entry.pfx, false)
		ParticleManager:ReleaseParticleIndex(entry.pfx)
	end
	__TS__ArraySetLength(self.waveEntries, 0)
end
modifier_boss_chaos_1_final_slash = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_chaos_1_final_slash)
____exports.modifier_boss_chaos_1_final_slash = modifier_boss_chaos_1_final_slash
return ____exports