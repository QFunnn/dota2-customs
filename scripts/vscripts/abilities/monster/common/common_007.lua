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
local COMMON_007_PROC_CHANCE_PCT = 30
local COMMON_007_DAMAGE_RATE = 15
local COMMON_007_PFX = "particles/units/heroes/hero_doom_bringer/doom_bringer_shard_bonus.vpcf"
local COMMON_007_SOUND = "Hero_DoomBringer.InfernalBlade.Target"
--- 怪物通用技能7 - 被动：普攻命中时有30%概率触发爆炸，对目标造成15点怪物伤害
____exports.common_007 = __TS__Class()
local common_007 = ____exports.common_007
common_007.name = "common_007"
__TS__ClassExtends(common_007, MonsterAbility_CS)
function common_007.prototype.Precache(self, context)
	PrecacheResource("particle", COMMON_007_PFX, context)
end
function common_007.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function common_007.prototype.GetIntrinsicModifierName(self)
	return "modifier_common_007"
end
common_007 = __TS__DecorateLegacy({ registerAbility(nil) }, common_007)
____exports.common_007 = common_007
local modifier_common_007 = __TS__Class()
modifier_common_007.name = "modifier_common_007"
__TS__ClassExtends(modifier_common_007, MonsterModifier_CS)
function modifier_common_007.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_common_007.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	if RollPercentage(COMMON_007_PROC_CHANCE_PCT) ~= true then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local ____opt_0 = target.GetUnitType
	local unitType = ____opt_0 and ____opt_0(target)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	parent:MonsterDamage({
		victim = target,
		damage_rate = COMMON_007_DAMAGE_RATE,
		ability = self:GetAbility(),
	})
	local pfx = ParticleManager:CreateParticle(COMMON_007_PFX, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn(COMMON_007_SOUND, target)
end
function modifier_common_007.prototype.IsHidden(self)
	return true
end
function modifier_common_007.prototype.IsPurgable(self)
	return false
end
modifier_common_007 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_common_007") }, modifier_common_007)
return ____exports