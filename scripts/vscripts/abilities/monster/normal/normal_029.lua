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
local modifier_normal_029_mana_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local BONUS_MAGIC_DAMAGE_PCT = 30
local MANA_BURN_MAX_MANA_PCT = 5
local MANA_SLOW_PCT = 50
local MANA_SLOW_DURATION = 3
--- 普通技能29：攻击命中时附加魔法伤害，并根据目标法力决定扣蓝或减速
____exports.normal_029 = __TS__Class()
local normal_029 = ____exports.normal_029
normal_029.name = "normal_029"
__TS__ClassExtends(normal_029, MonsterAbility_CS)
function normal_029.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_029.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_029"
end
normal_029 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_029)
____exports.normal_029 = normal_029
local modifier_normal_029 = __TS__Class()
modifier_normal_029.name = "modifier_normal_029"
__TS__ClassExtends(modifier_normal_029, MonsterModifier_CS)
function modifier_normal_029.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_029.prototype.OnAttackLanded_CS(self, event)
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
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	self:DealBonusMagicDamage(parent, target, ability, event.final_damage)
	self:BurnManaOrSlow(parent, target, ability)
end
function modifier_normal_029.prototype.DealBonusMagicDamage(self, parent, target, ability, attackFinalDamage)
	local bonusDamage = math.max(0, attackFinalDamage) * (BONUS_MAGIC_DAMAGE_PCT / 100)
	if bonusDamage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = bonusDamage,
		damage_type = 2,
		ability = ability,
	})
end
function modifier_normal_029.prototype.IsValidEnemyTarget(self, parent, target)
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
function modifier_normal_029.prototype.BurnManaOrSlow(self, parent, target, ability)
	local maxMana = math.max(0, target:GetMaxMana())
	local manaCost = maxMana * MANA_BURN_MAX_MANA_PCT / 100
	if manaCost <= 0 then
		return
	end
	local currentMana = math.max(0, target:GetMana())
	if currentMana >= manaCost then
		target:SetMana(math.max(0, currentMana - manaCost))
		return
	end
	modifier_normal_029_mana_slow:applys(target, parent, ability, { duration = MANA_SLOW_DURATION })
end
function modifier_normal_029.prototype.IsHidden(self)
	return true
end
function modifier_normal_029.prototype.IsPurgable(self)
	return false
end
modifier_normal_029 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_029") }, modifier_normal_029)
modifier_normal_029_mana_slow = __TS__Class()
modifier_normal_029_mana_slow.name = "modifier_normal_029_mana_slow"
__TS__ClassExtends(modifier_normal_029_mana_slow, MonsterModifier_CS)
function modifier_normal_029_mana_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -MANA_SLOW_PCT }
end
function modifier_normal_029_mana_slow.prototype.IsHidden(self)
	return false
end
function modifier_normal_029_mana_slow.prototype.IsDebuff(self)
	return true
end
function modifier_normal_029_mana_slow.prototype.IsPurgable(self)
	return true
end
function modifier_normal_029_mana_slow.prototype.GetTexture(self)
	return "generic_hidden"
end
function modifier_normal_029_mana_slow.GetLocalizationCN(self)
	return { name = "虚空迟缓", description = "移动速度降低50%。" }
end
modifier_normal_029_mana_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_029_mana_slow") }, modifier_normal_029_mana_slow)
return ____exports