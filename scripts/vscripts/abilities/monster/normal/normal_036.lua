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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_RANGE = 1000
local CAST_POINT = 2
local TOTAL_DURATION = 5
local CAST_DURATION = TOTAL_DURATION - CAST_POINT
local ORB_COUNT = 8
local ORB_INTERVAL = 0.1
local ORB_EXPLODE_DELAY = 1.7
local EXPLOSION_RADIUS = 200
local DAMAGE_RATE = 12
local ORB_EFFECT = "particles/dd/engy_tiny_explor.vpcf"
local ORB_SPAWN_SOUND = "Hero_Grimstroke.InkCreature.Cast"
local EXPLOSION_SOUND = "Hero_StormSpirit.StaticRemnantExplode"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
--- 普通技能36 - 爆裂魔球：长时间蓄力后，在周围生成多个带独立预警的延迟爆炸伤害区域
____exports.normal_036 = __TS__Class()
local normal_036 = ____exports.normal_036
normal_036.name = "normal_036"
__TS__ClassExtends(normal_036, MonsterAbility_CS)
function normal_036.prototype.Precache(self, context)
	PrecacheResource("particle", ORB_EFFECT, context)
end
function normal_036.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 8,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			do
				local i = 0
				while i < ORB_COUNT do
					self:Timer(i * ORB_INTERVAL, function()
						if not IsValidAlive(nil, caster) then
							return
						end
						self:CreateExplodeOrb(caster)
					end)
					i = i + 1
				end
			end
		end,
	}
end
function normal_036.prototype.CreateExplodeOrb(self, caster)
	local position = self:GetRandomOrbPosition(caster)
	self:WarningRingEffect(position, EXPLOSION_RADIUS, ORB_EXPLODE_DELAY)
	EmitSoundOnLocationWithCaster(position, ORB_SPAWN_SOUND, caster)
	local pfx = ParticleManager:CreateParticle(ORB_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	self:Timer(ORB_EXPLODE_DELAY, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		if not IsValidAlive(nil, caster) then
			return
		end
		self:ExplodeOrb(caster, position)
	end)
end
function normal_036.prototype.GetRandomOrbPosition(self, caster)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local offset = RandomVector(RandomFloat(0, CAST_RANGE))
	return getGroundPosition(nil, origin:__add(offset), caster)
end
function normal_036.prototype.ExplodeOrb(self, caster, position)
	EmitSoundOnLocationWithCaster(position, EXPLOSION_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue15
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
		end
		::__continue15::
	end
end
normal_036 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_036)
____exports.normal_036 = normal_036
return ____exports