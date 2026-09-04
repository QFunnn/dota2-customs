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
local pfx4 = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf"
local elite_104 = __TS__Class()
elite_104.name = "elite_104"
__TS__ClassExtends(elite_104, MonsterAbility_CS)
function elite_104.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.8,
		castRange = 1100,
		castDuration = 0.1,
		animationPlaybackRate = 1.1,
		castAnimation = ACT_DOTA_ATTACK,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local forward = caster:GetForwardVector()
			local target = caster:GetMinDistanceUnit(3500)
			local ____ = target and caster:LockTargetForSpeed(target, 1, 3)
			local backward = caster:GetAbsOrigin():__add(forward:__mul(-50))
			caster:Mover(backward, 0.3)
			self:WarningEffect(backward, caster:GetAbsOrigin():__add(forward:__mul(1600)), 0.8, {
				getDirection = function()
					return caster:GetForwardVector()
				end,
				startWidth = 250,
				endWidth = 250,
			})
		end,
		OnStart = function()
			return self:SpellStart()
		end,
	}
end
function elite_104.prototype.SpellStart(self)
	local caster = self:GetCaster()
	caster:EmitSound("Hero_Invoker.DeafeningBlast")
	local fow = caster:GetForwardVector()
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
	ScreenShake(caster:GetAbsOrigin(), 10, 10, 1, 3000, 0, true)
	local info = {
		vSpawnOrigin = caster:GetAbsOrigin():__add(Vector(0, 0, 120)):__add(fow:__mul(100)),
		vVelocity = caster:GetForwardVector() * 1500,
		vAcceleration = Vector(0, 0, 0),
		fMaxSpeed = 1500,
		fDistance = 1500,
		fStartRadius = 250,
		fEndRadius = 250,
		fExpireTime = GameRules:GetGameTime() + 1,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		bIgnoreSource = true,
		bHasFrontalCone = true,
		bDrawsOnMinimap = false,
		bVisibleToEnemies = true,
		EffectName = "particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6.vpcf",
		Ability = self,
		Source = caster,
		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(info)
end
function elite_104.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
	if not IsValidAlive(nil, target) then
		return true
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return true
	end
	caster:MonsterDamage({ victim = target, damage_rate = 15, ability = self, effectName = pfx4 })
	return false
end
elite_104 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_104)
return ____exports