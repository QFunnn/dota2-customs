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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
--- 精英技能2 - 蓄力后一条线冲刺造成伤害
____exports.elite_002 = __TS__Class()
local elite_002 = ____exports.elite_002
elite_002.name = "elite_002"
__TS__ClassExtends(elite_002, MonsterAbility_CS)
function elite_002.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.stop = false
end
function elite_002.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		castPoint = 1,
		castDuration = 1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_RELAX_END,
		OnPhaseStart = function()
			self.stop = false
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, 0.5, 10)
			local caster_pos = self._caster:GetAbsOrigin()
			local target_pos = caster_pos:__add(self._caster:GetForwardVector():__mul(700))
			self._caster:Mover(caster_pos:__add(self._caster:GetForwardVector():__mul(-70)), 0.45)
			self:WarningEffect(origin, target_pos, 1, {
				getDirection = function()
					return self._caster:GetForwardVector()
				end,
				startWidth = 128,
				endWidth = 128,
				follow = true,
			})
			caster:EmitSound("Hero_Weaver.Swarm.Cast")
		end,
		OnStart = function()
			local caster_pos = self._caster:GetAbsOrigin()
			self._caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1)
			local target_pos = caster_pos:__add(self._caster:GetForwardVector():__mul(700))
			self._caster:AddNewModifier(self._caster, self, "modifier_elite_002", { duration = 0.5 })
			local speed = 1000 / 0.35
			self._caster:Mover(target_pos, 0.35, function()
				if self.stop then
					return true
				end
			end)
			self._caster:EmitSound("Hero_Windrunner.ShackleshotCast")
			ScreenShake(self._caster:GetAbsOrigin(), 5, 5, 1, 2000, 0, true)
			self:Timer(0.25, function()
				local pfx = ParticleManager:CreateParticle(
					"particles/bb/aoe_dmg_blade.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self._caster
				)
				ParticleManager:SetParticleControl(pfx, 0, self._caster:GetAbsOrigin())
				ParticleManager:SetParticleControl(pfx, 6, target_pos)
				ParticleManager:SetParticleControl(pfx, 11, Vector(100, 0, 0))
			end)
			CreateProjectile(nil, {
				ability = self,
				projectile_type = "linear",
				caster = self._caster,
				effect_name = "",
				projectile_speed = speed,
				target = target_pos,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				projectile_distance = 1000,
				projectile_range = 120,
				on_hit = function(____, target)
					if target then
						if not IsValidAlive(nil, self._caster) then
							return
						end
						self._caster:PerformAttack(target, true, true, true, false, true, false, true)
						self._caster:MonsterDamage({ victim = target, damage_rate = 10, ability = self })
						self.stop = true
						AddDeBuffStatus(nil, target, self._caster, self, DebuffStatusType.STUN, { duration = 0.65 })
						return false
					end
				end,
			})
		end,
	}
end
elite_002 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_002)
____exports.elite_002 = elite_002
____exports.modifier_elite_002 = __TS__Class()
local modifier_elite_002 = ____exports.modifier_elite_002
modifier_elite_002.name = "modifier_elite_002"
__TS__ClassExtends(modifier_elite_002, MonsterModifier_CS)
function modifier_elite_002.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
end
modifier_elite_002 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_002)
____exports.modifier_elite_002 = modifier_elite_002
return ____exports