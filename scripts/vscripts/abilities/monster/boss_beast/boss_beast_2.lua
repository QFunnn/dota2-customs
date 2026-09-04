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
--- 兽-投掷石头 (boss_beast_2)
local CAST_POINT = 0.5
local CAST_DURATION = 6
local MAX_THINK_COUNT = 4
local SEARCH_RANGE = 2500
local ROAR_RADIUS = 500
local ROAR_KNOCKBACK_DISTANCE = 400
local DAMAGE_RATE = 18
local IMPACT_RADIUS = 180
local STUN_DURATION = 1
____exports.boss_beast_2 = __TS__Class()
local boss_beast_2 = ____exports.boss_beast_2
boss_beast_2.name = "boss_beast_2"
__TS__ClassExtends(boss_beast_2, MonsterAbility_CS)
function boss_beast_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:AddNewModifier(caster, self, "mo_mian_modfier", { duration = CAST_DURATION + 0.5 })
			caster:AddNewModifier(caster, self, "modifier_boss_beast_2_slow_gongsu", { duration = CAST_DURATION })
			caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_3, 0.8)
			local pxf_name = "particles/units/heroes/hero_beastmaster/beastmaster_primal_roar.vpcf"
			local roarPfx = ParticleManager:CreateParticle(pxf_name, PATTACH_CENTER_FOLLOW, caster)
			ParticleManager:SetParticleControlEnt(
				roarPfx,
				0,
				caster,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				Vector(0, 0, 0),
				true
			)
			ParticleManager:SetParticleControl(roarPfx, 1, caster:GetOrigin())
			local roarReleased = false
			local function releaseRoarPfx()
				if not IsServer() or roarReleased then
					return
				end
				roarReleased = true
				ParticleManager:DestroyParticle(roarPfx, false)
				ParticleManager:ReleaseParticleIndex(roarPfx)
			end
			Timers:CreateTimer(2.5, function()
				releaseRoarPfx(nil)
				return nil
			end)
			EmitSoundOn("Hero_PrimalBeast.Onslaught.Channel", caster)
			self:Timer(0.2, function()
				local loc = caster:GetAbsOrigin()
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					loc,
					nil,
					ROAR_RADIUS,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
					DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
					0,
					false
				)
				__TS__ArrayForEach(enemies, function(____, target)
					if not IsValidAlive(nil, target) then
						return
					end
					target:KnockBack(caster, self, {
						duration = 0.5,
						origin_pos = loc,
						stun = true,
						stunDuration = 0.8,
						distance = ROAR_KNOCKBACK_DISTANCE,
						height = 1,
					})
				end)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:AddNewModifier(caster, self, "modifier_boss_beast_2_thinker", { duration = CAST_DURATION })
		end,
	}
end
function boss_beast_2.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
	if target and extraData.dummy then
		local caster = self:GetCaster()
		local dummy = EntIndexToHScript(extraData.dummy)
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) or not IsValidAlive(nil, dummy) then
			return true
		end
		ScreenShake(target:GetAbsOrigin(), 4, 2, 2, 3000, 0, true)
		GridNav:DestroyTreesAroundPoint(target:GetAbsOrigin(), 300, false)
		dummy:EmitSound("Hero_PrimalBeast.RockThrow.Impact")
		local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CENTER_FOLLOW, caster)
		ParticleManager:SetParticleControl(effect_cast, 3, dummy:GetOrigin())
		ParticleManager:ReleaseParticleIndex(effect_cast)
		local enemies = self:FindHeroesInRadius(IMPACT_RADIUS, dummy:GetAbsOrigin())
		__TS__ArrayForEach(enemies, function(____, unit)
			if not IsValidAlive(nil, unit) then
				return
			end
			if not IsValidAlive(nil, caster) then
				return
			end
			unit:AddNewModifier(caster, self, "modifier_stunned", { duration = STUN_DURATION })
			unit:EmitSound("Hero_PrimalBeast.RockThrow.Stun")
			caster:MonsterDamage({ victim = unit, damage_rate = DAMAGE_RATE, ability = self })
		end)
		dummy:RemoveSelf()
		return true
	end
end
boss_beast_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_beast_2)
____exports.boss_beast_2 = boss_beast_2
--- 投石逻辑 Thinker
local modifier_boss_beast_2_thinker = __TS__Class()
modifier_boss_beast_2_thinker.name = "modifier_boss_beast_2_thinker"
__TS__ClassExtends(modifier_boss_beast_2_thinker, BaseModifier_CS)
function modifier_boss_beast_2_thinker.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.n = 0
end
function modifier_boss_beast_2_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1.5)
	self:OnIntervalThink()
end
function modifier_boss_beast_2_thinker.prototype.OnIntervalThink(self)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	self.n = self.n + 1
	if self.n >= MAX_THINK_COUNT then
		self:StartIntervalThink(-1)
		return
	end
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	if target then
		caster:LockTargetForSpeed(target, 1, 2)
	end
	self:StartRock(4 + self.n, self.n)
end
function modifier_boss_beast_2_thinker.prototype.StartRock(self, rock_num, n)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.5)
	self:Timer(1, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-150)), 0.3)
		local fow = caster:GetForwardVector()
		local speed = 1000
		local nearestEnemy = caster:GetMinDistanceUnit(SEARCH_RANGE)
		local ____math_max_1 = math.max
		local ____IsValidAlive_result_0
		if IsValidAlive(nil, nearestEnemy) then
			____IsValidAlive_result_0 = nearestEnemy:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Length2D()
		else
			____IsValidAlive_result_0 = 800
		end
		local distance = ____math_max_1(700, ____IsValidAlive_result_0)
		local centerPos = caster:GetOrigin():__add(fow:__mul(distance))
		local arr = GetRandomPointsInCircle(nil, centerPos, 600, 4, 200)
		local dumys = {}
		__TS__ArrayForEach(arr, function(____, item, index)
			local targetPos = item
			local dummy = CreateModifierThinker(
				caster,
				ability,
				"modifier_boss_beast_2_rock_preview",
				{ duration = targetPos:__sub(caster:GetOrigin()):Length2D() / speed },
				targetPos,
				caster:GetTeamNumber(),
				false
			)
			if IsValidAlive(nil, dummy) then
				dummy:SetOrigin(dummy:GetOrigin():__add(Vector(0, 0, 90)))
				dumys[#dumys + 1] = dummy
			end
		end)
		__TS__ArrayForEach(dumys, function(____, dummy)
			if not IsValidAlive(nil, dummy) then
				return
			end
			local info = {
				Target = dummy,
				Source = caster,
				Ability = ability,
				EffectName = "particles/primal_beast_rock_throw_arc.vpcf",
				iMoveSpeed = speed,
				bDodgeable = false,
				bVisibleToEnemies = true,
				ExtraData = { dummy = dummy:entindex() },
			}
			ProjectileManager:CreateTrackingProjectile(info)
		end)
	end)
end
modifier_boss_beast_2_thinker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_2_thinker)
--- 石头落点预警 Thinker
local modifier_boss_beast_2_rock_preview = __TS__Class()
modifier_boss_beast_2_rock_preview.name = "modifier_boss_beast_2_rock_preview"
__TS__ClassExtends(modifier_boss_beast_2_rock_preview, BaseModifier_CS)
function modifier_boss_beast_2_rock_preview.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local duration = params.duration
	local radius = 300
	WarningRing(nil, caster, parent:GetOrigin(), radius, duration)
end
modifier_boss_beast_2_rock_preview = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_2_rock_preview)
--- 攻速降低表现（为了匹配投石动作速度）
local modifier_boss_beast_2_slow_gongsu = __TS__Class()
modifier_boss_beast_2_slow_gongsu.name = "modifier_boss_beast_2_slow_gongsu"
__TS__ClassExtends(modifier_boss_beast_2_slow_gongsu, BaseModifier_CS)
function modifier_boss_beast_2_slow_gongsu.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function modifier_boss_beast_2_slow_gongsu.prototype.OnAttackLanded(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	local pfx_name = "particles/sandking_epicenter.vpcf"
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 1, Vector(1000, 1, 1))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_boss_beast_2_slow_gongsu.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return -70
end
function modifier_boss_beast_2_slow_gongsu.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:Mover(parent:GetAbsOrigin():__add(parent:GetForwardVector():__mul(100)), 0.1)
end
modifier_boss_beast_2_slow_gongsu = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_2_slow_gongsu)
return ____exports