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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CYCLE_DURATION = 4
local CYCLE_COUNT = 3
local DASH_START_TIME = 1.5
local DASH_END_TIME = 2.4
local DASH_DURATION = DASH_END_TIME - DASH_START_TIME
local BUFF_DURATION = (CYCLE_COUNT - 1) * CYCLE_DURATION + DASH_END_TIME
local DASH_DISTANCE = 800
local SEARCH_RADIUS = 150
local DAMAGE_RATE = 30
local LIGHTWEIGHT_SPEED = 100
local POST_DASH_DURATION = CYCLE_DURATION - DASH_END_TIME
local SEARCH_ENEMY_RANGE = 2500
--- 精英技能46 - 动画突进：播放奔跑动画，1.5-2.4秒窗口内快速冲刺并对路径敌人造成伤害
____exports.elite_046 = __TS__Class()
local elite_046 = ____exports.elite_046
elite_046.name = "elite_046"
__TS__ClassExtends(elite_046, MonsterAbility_CS)
function elite_046.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.5,
		castDuration = BUFF_DURATION,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_Riki.Blink_Strike")
			____exports.modifier_elite_046_dash:applys(caster, caster, self, { duration = BUFF_DURATION })
		end,
	}
end
elite_046 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_046)
____exports.elite_046 = elite_046
____exports.modifier_elite_046_dash = __TS__Class()
local modifier_elite_046_dash = ____exports.modifier_elite_046_dash
modifier_elite_046_dash.name = "modifier_elite_046_dash"
__TS__ClassExtends(modifier_elite_046_dash, MonsterModifier_CS)
function modifier_elite_046_dash.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._currentStage = 0
	self._hitTargets = __TS__New(Set)
end
function modifier_elite_046_dash.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:SetAnimation("run_fast_desolation")
	self:StartLightweightMover(parent, DASH_START_TIME)
	self:StartIntervalThink(0.05)
end
function modifier_elite_046_dash.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local t = self:GetElapsedTime()
	if t >= BUFF_DURATION then
		self:Destroy()
		return
	end
	local newStage = self:ComputeStage(t)
	if newStage == self._currentStage then
		return
	end
	self._currentStage = newStage
	local isDash = newStage % 3 == 1
	if isDash then
		local ability = self:GetAbility()
		local targetPos = self:GetDashTarget(parent, DASH_DISTANCE)
		parent:Mover(targetPos, DASH_DURATION, function(____, pos)
			if not IsValidAlive(nil, parent) then
				return true
			end
			local enemies = FindUnitsInRadius(
				parent:GetTeamNumber(),
				pos,
				nil,
				SEARCH_RADIUS,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			for ____, enemy in ipairs(enemies) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue14
					end
					if self._hitTargets:has(enemy:GetEntityIndex()) then
						goto __continue14
					end
					self._hitTargets:add(enemy:GetEntityIndex())
					parent:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
				end
				::__continue14::
			end
			return false
		end, nil, true)
	elseif newStage % 3 == 0 then
		self:StartLightweightMover(parent, DASH_START_TIME)
	else
		self:StartLightweightMover(parent, POST_DASH_DURATION)
	end
end
function modifier_elite_046_dash.prototype.ComputeStage(self, t)
	local cycle = math.floor(t / CYCLE_DURATION)
	local ct = t - cycle * CYCLE_DURATION
	if ct < DASH_START_TIME then
		return cycle * 3
	end
	if ct < DASH_END_TIME then
		return cycle * 3 + 1
	end
	return cycle * 3 + 2
end
function modifier_elite_046_dash.prototype.GetDashTarget(self, parent, distance)
	local parentPos = parent:GetAbsOrigin()
	local enemy = parent:GetMinDistanceUnit(SEARCH_ENEMY_RANGE)
	local dir
	if IsValidAlive(nil, enemy) then
		dir = enemy:GetAbsOrigin():__sub(parentPos):Normalized()
	else
		dir = parent:GetForwardVector()
	end
	return parentPos:__add(dir:__mul(distance))
end
function modifier_elite_046_dash.prototype.StartLightweightMover(self, parent, duration)
	local distance = LIGHTWEIGHT_SPEED * duration
	if not IsValidAlive(nil, parent) then
		return
	end
	local targetPos = self:GetDashTarget(parent, distance)
	parent:Mover(targetPos, duration, nil, nil, true)
end
function modifier_elite_046_dash.prototype.OnDestroy(self)
	if IsServer() then
		self._hitTargets:clear()
		local parent = self:GetParent()
		if IsValidAlive(nil, parent) then
			parent:FadeGesture(ACT_DOTA_RUN)
		end
	end
end
function modifier_elite_046_dash.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = false, isPurgable = false }
end
function modifier_elite_046_dash.GetLocalizationCN(self)
	return { name = "突进", description = "快速向前突进，对路径上的敌人造成伤害。" }
end
modifier_elite_046_dash = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_046_dash)
____exports.modifier_elite_046_dash = modifier_elite_046_dash
return ____exports