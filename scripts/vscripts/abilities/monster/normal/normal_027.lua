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
local CAST_RANGE = 700
local BURROW_DELAY = 0.15
local BURROW_LINE_WIDTH = 140
local STUN_DURATION = 1
local BURROWSTRIKE_PARTICLE = "particles/units/heroes/hero_sandking/sandking_burrowstrike.vpcf"
local BURROWSTRIKE_SOUND = "Ability.SandKing_BurrowStrike"
--- 普通技能27：绝地穿刺，延迟后穿刺到目标位置并眩晕路径敌人
____exports.normal_027 = __TS__Class()
local normal_027 = ____exports.normal_027
normal_027.name = "normal_027"
__TS__ClassExtends(normal_027, MonsterAbility_CS)
function normal_027.prototype.Precache(self, context)
	PrecacheResource("particle", BURROWSTRIKE_PARTICLE, context)
end
function normal_027.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = 0.5,
		castDuration = 0,
		cooldown = 6,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.6,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(BURROWSTRIKE_SOUND, caster)
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not target or not IsValidAlive(nil, target) then
				return
			end
			local startPos = caster:GetAbsOrigin()
			local direction = GetDirection(nil, target:GetAbsOrigin(), startPos)
			local endPos = GetGroundPosition(startPos:__add(direction:__mul(CAST_RANGE)), caster)
			self:PlayBurrowstrikeEffect(startPos, endPos)
			self:Timer(BURROW_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:StunLineEnemies(startPos, endPos)
				FindClearSpaceForUnit(caster, endPos, true)
			end)
		end,
	}
end
function normal_027.prototype.PlayBurrowstrikeEffect(self, startPos, endPos)
	local effect = ParticleManager:CreateParticle(BURROWSTRIKE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, startPos)
	ParticleManager:SetParticleControl(effect, 1, endPos)
	ParticleManager:ReleaseParticleIndex(effect)
end
function normal_027.prototype.StunLineEnemies(self, startPos, endPos)
	local caster = self:GetCaster()
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		startPos,
		endPos,
		nil,
		BURROW_LINE_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue11
			end
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
		end
		::__continue11::
	end
end
normal_027 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_027)
____exports.normal_027 = normal_027
return ____exports