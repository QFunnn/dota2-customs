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
local modifier_elite_012_laser_thinker
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local LASER_RANGE = 800
local LASER_WIDTH = 120
local CAST_POINT = 1.2
local LASER_DURATION = 2.5
local BURN_DURATION = 1
local BURN_TICK = 0.5
local DAMAGE_RATE_PER_TICK = 5
--- 精英技能12 - 幽灵激光：固定方向发射激光，路径敌人受到持续灼烧
____exports.elite_012 = __TS__Class()
local elite_012 = ____exports.elite_012
elite_012.name = "elite_012"
__TS__ClassExtends(elite_012, MonsterAbility_CS)
function elite_012.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = LASER_RANGE - 100,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		castDuration = LASER_DURATION,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local target = self:GetMinDistanceUnit(LASER_RANGE, origin)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			self._startPos = origin
			local forward = caster:GetForwardVector()
			local warnEnd = origin:__add(forward:__mul(LASER_RANGE))
			self:WarningEffect(origin, warnEnd, CAST_POINT, {
				getDirection = function(self)
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local start = origin
			local ____end = origin:__add(forward:__mul(LASER_RANGE))
			self._startPos = start
			self._endPos = ____end
			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_tinker/tinker_laser.vpcf",
				PATTACH_WORLDORIGIN,
				caster
			)
			ParticleManager:SetParticleControl(pfx, 9, start + Vector(0, 0, 85))
			ParticleManager:SetParticleControl(pfx, 1, ____end + Vector(0, 0, 85))
			modifier_elite_012_laser_thinker:applys(caster, caster, self, { duration = LASER_DURATION, pfx_id = pfx })
			local enemies = FindUnitsInLine(
				caster:GetTeamNumber(),
				start,
				____end,
				nil,
				LASER_WIDTH,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE
			)
			for ____, enemy in ipairs(enemies) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue9
					end
					enemy:AddNewModifier(caster, self, "modifier_elite_012_laser_burn", { duration = BURN_DURATION })
					AddDeBuffStatus(
						nil,
						enemy,
						caster,
						self,
						DebuffStatusType.ICE_SLOW,
						{ stack = 5, duration = BURN_DURATION }
					)
				end
				::__continue9::
			end
			caster:EmitSound("Hero_Tinker.Laser")
		end,
	}
end
elite_012 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_012)
____exports.elite_012 = elite_012
modifier_elite_012_laser_thinker = __TS__Class()
modifier_elite_012_laser_thinker.name = "modifier_elite_012_laser_thinker"
__TS__ClassExtends(modifier_elite_012_laser_thinker, MonsterModifier_CS)
function modifier_elite_012_laser_thinker.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.pfxId = params.pfx_id
end
function modifier_elite_012_laser_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.pfxId ~= nil then
		ParticleManager:DestroyParticle(self.pfxId, false)
		ParticleManager:ReleaseParticleIndex(self.pfxId)
		self.pfxId = nil
	end
end
function modifier_elite_012_laser_thinker.prototype.IsHidden(self)
	return true
end
modifier_elite_012_laser_thinker = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_012_laser_thinker") },
	modifier_elite_012_laser_thinker
)
local modifier_elite_012_laser_burn = __TS__Class()
modifier_elite_012_laser_burn.name = "modifier_elite_012_laser_burn"
__TS__ClassExtends(modifier_elite_012_laser_burn, MonsterModifier_CS)
function modifier_elite_012_laser_burn.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(BURN_TICK)
end
function modifier_elite_012_laser_burn.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	caster:MonsterDamage({
		victim = parent,
		damage_rate = DAMAGE_RATE_PER_TICK,
		ability = self:GetAbility(),
	})
end
function modifier_elite_012_laser_burn.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_tinker/tinker_laser.vpcf"
end
function modifier_elite_012_laser_burn.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_elite_012_laser_burn =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_012_laser_burn") }, modifier_elite_012_laser_burn)
return ____exports