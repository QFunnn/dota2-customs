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
--- 天怒法师奥术箭：发射 / 命中（与原生 Arcane Bolt 一致）
local ELITE_003_ARCANE_BOLT_CAST = "Hero_SkywrathMage.ConcussiveShot.Cast"
local ELITE_003_ARCANE_BOLT_IMPACT = "Hero_SkywrathMage.ArcaneBolt.Impact"
local function GetRandomPointInRange(self, pos, range)
	local random_angle = RandomFloat(0, 360)
	local random_distance = RandomFloat(range * 0.7, range * 1.3)
	local p = pos:__add(Vector(math.cos(random_angle), math.sin(random_angle), 0):__mul(random_distance))
	local dis = GridNav:FindPathLength(pos, p)
	if GridNav:IsTraversable(p) and dis > 0 then
		return p
	end
	return GetRandomPointInRange(nil, pos, range)
end
--- 精英技能3 - 蓄力后发射法球
____exports.elite_003 = __TS__Class()
local elite_003 = ____exports.elite_003
elite_003.name = "elite_003"
__TS__ClassExtends(elite_003, MonsterAbility_CS)
function elite_003.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = ____exports.elite_003.CAST_RANGE,
		castPoint = 0.9,
		castDuration = 1.4,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.5,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			local caster_pos = self._caster:GetAbsOrigin()
			if target then
				caster:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), caster_pos))
				caster:LockTargetForSpeed(target, 0.9)
			end
		end,
		OnStart = function()
			local count = 0
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, 0.9)
			self:Timer(0, function()
				local start_point = self._caster
					:GetAbsOrigin()
					:__add(Vector(0, 0, 128))
					:__add(self._caster:GetForwardVector():__mul(80))
				local caster = self:GetCaster()
				local forward_vector = self._caster:GetForwardVector()
				local target_pos = start_point:__add(
					RotateVector2D(nil, forward_vector, RandomFloat(-15, 15)):__mul(____exports.elite_003.CAST_RANGE)
				)
				EmitSoundOn(ELITE_003_ARCANE_BOLT_CAST, caster)
				CreateProjectile(nil, {
					ability = self,
					caster = caster,
					effect_name = "particles/boss/boss_001.vpcf",
					target = target_pos,
					start_point = start_point,
					projectile_type = "linear",
					projectile_speed = 700,
					projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
					projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
					projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
					projectile_distance = ____exports.elite_003.CAST_RANGE,
					projectile_range = 60,
					on_hit = function(____, hitTarget)
						if not IsValidAlive(nil, hitTarget) then
							return true
						end
						if not hitTarget or not hitTarget:IsAlive() then
							return true
						end
						if not IsValidAlive(nil, caster) then
							return true
						end
						EmitSoundOn(ELITE_003_ARCANE_BOLT_IMPACT, hitTarget)
						self:ApplyDamage(hitTarget, self:GetAllAttackDamage() * 2, 2)
						hitTarget:KnockBack(caster, self, {
							duration = 0.1,
							origin_pos = caster:GetAbsOrigin(),
							stun = false,
							distance = 30,
							height = 0,
						})
						return true
					end,
				})
				count = count + 1
				if count > 2 then
					return
				end
				self:Timer(0.1, function()
					caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
				end)
				return 0.35
			end)
		end,
	}
end
elite_003.CAST_RANGE = 2000
elite_003 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_003)
____exports.elite_003 = elite_003
return ____exports