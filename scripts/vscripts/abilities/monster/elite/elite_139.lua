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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_elite_139_earthshock_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1000
local CAST_POINT = 0.7
local EARTHSHOCK_PARTICLE = "particles/units/heroes/hero_ursa/ursa_earthshock.vpcf"
local EARTHSHOCK_SOUND = "Hero_Ursa.Earthshock"
local URSA_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_ursa.vsndevts"
--- 精英技能139 - 幽爪熊王：向前跃击，落地时震击周围敌人并造成强减速
____exports.elite_139 = __TS__Class()
local elite_139 = ____exports.elite_139
elite_139.name = "elite_139"
__TS__ClassExtends(elite_139, MonsterAbility_CS)
function elite_139.prototype.Precache(self, context)
	PrecacheResource("particle", EARTHSHOCK_PARTICLE, context)
	PrecacheResource("soundfile", URSA_SOUND_EVENTS, context)
end
function elite_139.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = 0,
		castDuration = self:GetSpecialValueFor("leap_duration") + 0.1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.8,
		canCast = function()
			local target = self:FindTarget()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = self:FindTarget()
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				self.landPos = nil
				return
			end
			caster:LockTargetForSpeed(target, CAST_POINT, 8)
			local jumpData = self:GetJumpData(caster, target)
			self.landPos = jumpData.landPos
			self:WarningRingEffect(
				jumpData.landPos,
				self:GetSpecialValueFor("damage_radius"),
				CAST_POINT + self:GetSpecialValueFor("leap_duration")
			)
		end,
		OnStart = function()
			self:LeapForward()
		end,
		OnFinish = function()
			self.landPos = nil
		end,
		OnInterrupt = function()
			self.landPos = nil
		end,
	}
end
function elite_139.prototype.LeapForward(self)
	local caster = self:GetCaster()
	local target = self:FindTarget()
	if not IsValidAlive(nil, caster) then
		return
	end
	local jumpData = self:GetJumpData(caster, target)
	local landPos = self.landPos or jumpData.landPos
	self.landPos = nil
	caster:SetForwardVector(jumpData.direction)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local peak = origin:__add(Vector(0, 0, self:GetSpecialValueFor("jump_height")))
	local leapDuration = self:GetSpecialValueFor("leap_duration")
	caster:Bezier2Mover({ origin, peak, landPos }, leapDuration, nil, true, true)
	self:Timer(leapDuration, function()
		return self:ImpactAt(landPos)
	end)
end
function elite_139.prototype.ImpactAt(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local impactPos = GetGroundPosition(origin, caster)
	FindClearSpaceForUnit(caster, impactPos, false)
	EmitSoundOnLocationWithCaster(impactPos, EARTHSHOCK_SOUND, caster)
	self:PlayEarthshockEffect(impactPos)
	ScreenShake(impactPos, 10, 10, 0.3, 1200, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		impactPos,
		nil,
		self:GetSpecialValueFor("damage_radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local slowPct = self:GetSpecialValueFor("slow_movespeed_pct")
	local slowDuration = self:GetSpecialValueFor("slow_duration")
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue15
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = self:GetSpecialValueFor("damage_rate"),
				ability = self,
				damage_type = 2,
			})
			modifier_elite_139_earthshock_slow:applys(
				enemy,
				caster,
				self,
				{ duration = slowDuration, slow_pct = slowPct }
			)
		end
		::__continue15::
	end
end
function elite_139.prototype.PlayEarthshockEffect(self, origin)
	local particle = ParticleManager:CreateParticle(EARTHSHOCK_PARTICLE, PATTACH_WORLDORIGIN, nil)
	local radius = self:GetSpecialValueFor("damage_radius")
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius / 2, radius / 4))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_139.prototype.GetJumpData(self, caster, target)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local direction = caster:GetForwardVector()
	if IsValidAlive(nil, target) then
		direction = GetDirection(nil, GetGroundPosition(target:GetAbsOrigin(), target), origin)
	end
	direction = Vector(direction.x, direction.y, 0)
	if direction:Length2D() <= 0.01 then
		direction = Vector(1, 0, 0)
	end
	direction = direction:Normalized()
	local landPos = GetGroundPosition(origin:__add(direction:__mul(self:GetSpecialValueFor("jump_distance"))), caster)
	return { landPos = landPos, direction = direction }
end
function elite_139.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
elite_139 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_139)
____exports.elite_139 = elite_139
modifier_elite_139_earthshock_slow = __TS__Class()
modifier_elite_139_earthshock_slow.name = "modifier_elite_139_earthshock_slow"
__TS__ClassExtends(modifier_elite_139_earthshock_slow, MonsterModifier_CS)
function modifier_elite_139_earthshock_slow.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.slowPct = 0
end
function modifier_elite_139_earthshock_slow.prototype.OnCreated(self, params)
	self.slowPct = params.slow_pct or 0
end
function modifier_elite_139_earthshock_slow.prototype.OnRefresh(self, params)
	self.slowPct = params.slow_pct or 0
	self:RefreshAttributes()
end
function modifier_elite_139_earthshock_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -self.slowPct }
end
function modifier_elite_139_earthshock_slow.prototype.IsHidden(self)
	return false
end
function modifier_elite_139_earthshock_slow.prototype.IsDebuff(self)
	return true
end
function modifier_elite_139_earthshock_slow.prototype.IsPurgable(self)
	return true
end
function modifier_elite_139_earthshock_slow.prototype.GetTexture(self)
	return "ursa_earthshock"
end
function modifier_elite_139_earthshock_slow.GetLocalizationCN(self)
	return { name = "震地迟缓", description = "移动速度大幅降低。" }
end
modifier_elite_139_earthshock_slow = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_139_earthshock_slow") },
	modifier_elite_139_earthshock_slow
)
return ____exports