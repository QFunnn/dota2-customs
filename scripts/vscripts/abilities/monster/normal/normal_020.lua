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
local modifier_normal_020_frostbite
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 800
local CAST_POINT = 0.3
local CAST_DURATION = 0.1
local ROOT_DURATION = 2
local DAMAGE_INTERVAL = 1
local DAMAGE_PER_TICK = 10
local CAST_SOUND = "Hero_Crystal.Frostbite"
local ROOT_PARTICLE = "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
--- 普通技能020 - 寒霜禁锢：目标点冰冻，缠绕 2 秒并每秒造成 10 点伤害
____exports.normal_020 = __TS__Class()
local normal_020 = ____exports.normal_020
normal_020.name = "normal_020"
__TS__ClassExtends(normal_020, MonsterAbility_CS)
function normal_020.prototype.Precache(self, context)
	PrecacheResource("particle", ROOT_PARTICLE, context)
end
function normal_020.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		cooldown = 6,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = self:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				return
			end
			caster:LockTargetForSpeed(target, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local target = self:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				return
			end
			if target:GetTeamNumber() == caster:GetTeamNumber() then
				return
			end
			EmitSoundOn(CAST_SOUND, target)
			modifier_normal_020_frostbite:applys(target, caster, self, { duration = ROOT_DURATION })
		end,
	}
end
normal_020 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_020)
____exports.normal_020 = normal_020
modifier_normal_020_frostbite = __TS__Class()
modifier_normal_020_frostbite.name = "modifier_normal_020_frostbite"
__TS__ClassExtends(modifier_normal_020_frostbite, MonsterModifier_CS)
function modifier_normal_020_frostbite.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.damagePerTick = DAMAGE_PER_TICK
	self.interval = DAMAGE_INTERVAL
end
function modifier_normal_020_frostbite.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(self.interval)
end
function modifier_normal_020_frostbite.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	Damage:ApplyDamage({
		victim = parent,
		attacker = caster,
		damage = self.damagePerTick,
		damage_type = 2,
		ability = ability,
	})
end
function modifier_normal_020_frostbite.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true }
end
function modifier_normal_020_frostbite.prototype.GetEffectName(self)
	return ROOT_PARTICLE
end
function modifier_normal_020_frostbite.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_normal_020_frostbite.prototype.IsHidden(self)
	return false
end
function modifier_normal_020_frostbite.prototype.IsDebuff(self)
	return true
end
function modifier_normal_020_frostbite.prototype.IsPurgable(self)
	return true
end
modifier_normal_020_frostbite =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_020_frostbite") }, modifier_normal_020_frostbite)
return ____exports