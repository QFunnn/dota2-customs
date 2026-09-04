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
local modifier_elite_062_no_heal
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local LIFESTEAL_REDUCTION_DURATION = 5
local LIFESTEAL_AMP_REDUCTION_PCT = 50
local CHILLING_TOUCH_PROJECTILE =
	"particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile.vpcf"
local CHILLING_TOUCH_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts"
local CHILLING_TOUCH_HIT_SOUND = "Hero_Ancient_Apparition.ChillingTouch.Target"
--- 精英技能62 - 寒霜触击：被动，普攻改为寒霜弹道并在命中时降低吸血
____exports.elite_062 = __TS__Class()
local elite_062 = ____exports.elite_062
elite_062.name = "elite_062"
__TS__ClassExtends(elite_062, MonsterAbility_CS)
function elite_062.prototype.Precache(self, context)
	PrecacheResource("particle", CHILLING_TOUCH_PROJECTILE, context)
	PrecacheResource("soundfile", CHILLING_TOUCH_SOUND_EVENTS, context)
end
function elite_062.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function elite_062.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_062_passive"
end
elite_062 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_062)
____exports.elite_062 = elite_062
local modifier_elite_062_passive = __TS__Class()
modifier_elite_062_passive.name = "modifier_elite_062_passive"
__TS__ClassExtends(modifier_elite_062_passive, MonsterModifier_CS)
function modifier_elite_062_passive.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_062_passive.prototype.OnAttack_CS(self, event)
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
	event.projectile_name = CHILLING_TOUCH_PROJECTILE
end
function modifier_elite_062_passive.prototype.OnAttackLanded_CS(self, event)
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
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local ____opt_2 = target.GetUnitType
	local unitType = ____opt_2 and ____opt_2(target)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	modifier_elite_062_no_heal:applys(target, parent, self:GetAbility(), { duration = LIFESTEAL_REDUCTION_DURATION })
	EmitSoundOn(CHILLING_TOUCH_HIT_SOUND, target)
end
function modifier_elite_062_passive.prototype.IsHidden(self)
	return true
end
function modifier_elite_062_passive.prototype.IsPurgable(self)
	return false
end
modifier_elite_062_passive =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_062_passive") }, modifier_elite_062_passive)
modifier_elite_062_no_heal = __TS__Class()
modifier_elite_062_no_heal.name = "modifier_elite_062_no_heal"
__TS__ClassExtends(modifier_elite_062_no_heal, MonsterModifier_CS)
function modifier_elite_062_no_heal.GetLocalizationCN(self)
	return { name = "寒霜蚀血", description = "吸血效果降低50%。" }
end
function modifier_elite_062_no_heal.prototype.GetAttributeBonus(self)
	return { lifesteal_amp_pct = -LIFESTEAL_AMP_REDUCTION_PCT }
end
function modifier_elite_062_no_heal.prototype.IsDebuff(self)
	return true
end
function modifier_elite_062_no_heal.prototype.IsPurgable(self)
	return true
end
function modifier_elite_062_no_heal.prototype.GetTexture(self)
	return "ancient_apparition_chilling_touch"
end
modifier_elite_062_no_heal =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_062_no_heal") }, modifier_elite_062_no_heal)
return ____exports