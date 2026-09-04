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
local modifier_elite_329_non_item_heal_reduction
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local DEBUFF_DURATION = 8
local NON_ITEM_HEAL_REDUCTION_PCT = 50
local HIT_SOUND = "Hero_Ancient_Apparition.ChillingTouch.Target"
local DEBUFF_EFFECT = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf"
--- 精英技能329 - 寒霜断愈：攻击命中时降低目标非物品来源的生命恢复效果
____exports.elite_329 = __TS__Class()
local elite_329 = ____exports.elite_329
elite_329.name = "elite_329"
__TS__ClassExtends(elite_329, MonsterAbility_CS)
function elite_329.prototype.Precache(self, context)
	PrecacheResource("particle", DEBUFF_EFFECT, context)
end
function elite_329.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function elite_329.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_329_passive"
end
elite_329 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_329)
____exports.elite_329 = elite_329
local modifier_elite_329_passive = __TS__Class()
modifier_elite_329_passive.name = "modifier_elite_329_passive"
__TS__ClassExtends(modifier_elite_329_passive, MonsterModifier_CS)
function modifier_elite_329_passive.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_329_passive.prototype.OnAttackLanded_CS(self, event)
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
	if not self:IsValidEnemyTarget(parent, target) then
		return
	end
	modifier_elite_329_non_item_heal_reduction:applys(target, parent, self:GetAbility(), { duration = DEBUFF_DURATION })
	EmitSoundOn(HIT_SOUND, target)
end
function modifier_elite_329_passive.prototype.IsValidEnemyTarget(self, parent, target)
	if not target or not IsValidAlive(nil, target) then
		return false
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end
	local ____this_1
	____this_1 = target
	local ____opt_0 = ____this_1.GetUnitType
	local unitType = ____opt_0 and ____opt_0(____this_1)
	return unitType ~= UnitType.BUILDING and unitType ~= UnitType.DESTRUCTIBLE
end
function modifier_elite_329_passive.prototype.IsHidden(self)
	return true
end
function modifier_elite_329_passive.prototype.IsPurgable(self)
	return false
end
modifier_elite_329_passive =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_329_passive") }, modifier_elite_329_passive)
modifier_elite_329_non_item_heal_reduction = __TS__Class()
modifier_elite_329_non_item_heal_reduction.name = "modifier_elite_329_non_item_heal_reduction"
__TS__ClassExtends(modifier_elite_329_non_item_heal_reduction, MonsterModifier_CS)
function modifier_elite_329_non_item_heal_reduction.GetLocalizationCN(self)
	return { name = "寒霜断愈", description = "来自物品以外的生命恢复效果降低50%。" }
end
function modifier_elite_329_non_item_heal_reduction.prototype.GetAttributeBonus(self)
	return { non_item_heal_reduction_pct = NON_ITEM_HEAL_REDUCTION_PCT }
end
function modifier_elite_329_non_item_heal_reduction.prototype.IsHidden(self)
	return false
end
function modifier_elite_329_non_item_heal_reduction.prototype.IsDebuff(self)
	return true
end
function modifier_elite_329_non_item_heal_reduction.prototype.IsPurgable(self)
	return true
end
function modifier_elite_329_non_item_heal_reduction.prototype.GetTexture(self)
	return "ancient_apparition_chilling_touch"
end
function modifier_elite_329_non_item_heal_reduction.prototype.GetEffectName(self)
	return DEBUFF_EFFECT
end
function modifier_elite_329_non_item_heal_reduction.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_elite_329_non_item_heal_reduction = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_329_non_item_heal_reduction") },
	modifier_elite_329_non_item_heal_reduction
)
return ____exports