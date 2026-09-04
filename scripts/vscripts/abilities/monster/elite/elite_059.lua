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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1450
local CAST_POINT = 0.45 * 2
local ICE_PATH_DISTANCE = 1500
local ICE_PATH_WIDTH = 170
local ICE_PATH_DURATION = 2
local STUN_DURATION = 2
local DAMAGE_RATE = 16
local DETECT_INTERVAL = 0.1
local ICE_PATH_PARTICLE = "particles/econ/items/jakiro/jakiro_ti7_immortal_head/jakiro_ti7_immortal_head_ice_path.vpcf"
local ICE_PATH_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts"
local ICE_PATH_CAST_SOUND = "Hero_Jakiro.IcePath.Cast"
local ICE_PATH_SOUND = "Hero_Jakiro.IcePath"
--- 精英技能59 - 寒冰路径：沿目标方向生成冰路，进入者眩晕，结束时爆发伤害
____exports.elite_059 = __TS__Class()
local elite_059 = ____exports.elite_059
elite_059.name = "elite_059"
__TS__ClassExtends(elite_059, MonsterAbility_CS)
function elite_059.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castDirection = nil
end
function elite_059.prototype.Precache(self, context)
	PrecacheResource("particle", ICE_PATH_PARTICLE, context)
	PrecacheResource("soundfile", ICE_PATH_SOUND_EVENTS, context)
end
function elite_059.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		animationPlaybackRate = 0.5,
		castDuration = 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, caster) then
				return
			end
			local dir = caster:GetForwardVector()
			self.castDirection = dir
			caster:LockTargetForSpeed(target, CAST_POINT - 0.2, 8)
			local origin = caster:GetAbsOrigin()
			local ____end = origin:__add(self.castDirection:__mul(ICE_PATH_DISTANCE))
			self:WarningEffect(origin, ____end, CAST_POINT - 0.2, {
				startWidth = ICE_PATH_WIDTH,
				endWidth = ICE_PATH_WIDTH,
				getDirection = function()
					self.castDirection = caster:GetForwardVector()
					return self.castDirection
				end,
			})
		end,
		OnStart = function()
			return self:CreateIcePath()
		end,
	}
end
function elite_059.prototype.CreateIcePath(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not self.castDirection then
		self.castDirection = nil
		return
	end
	local start = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local ____end = self:GetMapSafeEndPoint(start, self.castDirection, caster)
	self.castDirection = nil
	EmitSoundOn(ICE_PATH_CAST_SOUND, caster)
	CreateModifierThinker(caster, self, "modifier_elite_059_ice_path", {
		duration = ICE_PATH_DURATION,
		start_x = start.x,
		start_y = start.y,
		start_z = start.z,
		end_x = ____end.x,
		end_y = ____end.y,
		end_z = ____end.z,
	}, start, caster:GetTeamNumber(), false)
end
function elite_059.prototype.GetMapSafeEndPoint(self, start, direction, caster)
	local rawEnd = start:__add(direction:__mul(ICE_PATH_DISTANCE))
	return Vector(rawEnd.x, rawEnd.y, start.z)
end
elite_059 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_059)
____exports.elite_059 = elite_059
local modifier_elite_059_ice_path = __TS__Class()
modifier_elite_059_ice_path.name = "modifier_elite_059_ice_path"
__TS__ClassExtends(modifier_elite_059_ice_path, MonsterModifier_CS)
function modifier_elite_059_ice_path.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.startPos = Vector(0, 0, 0)
	self.endPos = Vector(0, 0, 0)
	self.stunnedUnits = {}
end
function modifier_elite_059_ice_path.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self.startPos = Vector(params.start_x or 0, params.start_y or 0, params.start_z or 0)
	self.endPos = Vector(params.end_x or 0, params.end_y or 0, params.end_z or 0)
	self.particleId = ParticleManager:CreateParticle(ICE_PATH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.particleId, 0, self.startPos)
	ParticleManager:SetParticleControl(self.particleId, 6, self.startPos)
	ParticleManager:SetParticleControl(self.particleId, 9, self.startPos)
	ParticleManager:SetParticleControl(self.particleId, 1, self.endPos)
	ParticleManager:SetParticleControl(self.particleId, 2, Vector(ICE_PATH_DURATION, 0, 0))
	EmitSoundOnLocationWithCaster(self.startPos, ICE_PATH_SOUND, caster)
	self:StartIntervalThink(DETECT_INTERVAL)
	self:OnIntervalThink()
end
function modifier_elite_059_ice_path.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local enemies = self:FindEnemiesInPath(caster)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue16
			end
			local entIndex = enemy:entindex()
			if self.stunnedUnits[entIndex] then
				goto __continue16
			end
			self.stunnedUnits[entIndex] = true
			AddDeBuffStatus(nil, enemy, caster, ability, DebuffStatusType.STUN, { duration = STUN_DURATION })
		end
		::__continue16::
	end
end
function modifier_elite_059_ice_path.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if ability and IsValidAlive(nil, caster) then
		local enemies = self:FindEnemiesInPath(caster)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue23
				end
				caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			end
			::__continue23::
		end
	end
	if self.particleId ~= nil then
		ParticleManager:DestroyParticle(self.particleId, false)
		ParticleManager:ReleaseParticleIndex(self.particleId)
		self.particleId = nil
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_059_ice_path.prototype.IsHidden(self)
	return true
end
function modifier_elite_059_ice_path.prototype.IsPurgable(self)
	return false
end
function modifier_elite_059_ice_path.prototype.FindEnemiesInPath(self, caster)
	if not IsValidAlive(nil, caster) then
		return {}
	end
	return FindUnitsInLine(
		caster:GetTeamNumber(),
		self.startPos,
		self.endPos,
		nil,
		ICE_PATH_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
end
modifier_elite_059_ice_path =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_059_ice_path") }, modifier_elite_059_ice_path)
return ____exports