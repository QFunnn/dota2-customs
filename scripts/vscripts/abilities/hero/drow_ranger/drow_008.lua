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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 射击间隔安全下限（秒），防攻速极高时高频 think 失控
local DROW_008_MIN_INTERVAL = 0.1
--- 符印「淬霜」：连射箭命中附加 1 层冰冻的触发概率键（ak_gems.csv hero_data；Ⅰ/Ⅱ/Ⅲ=50/75/100，>0 即启用）
local DROW_008_GEM_FROST_CHANCE_KEY = "drow_008_frost_chance_pct"
--- 淬霜冰冻持续秒数（与繁星子箭冰冻同口径）
local DROW_008_GEM_FROST_DURATION = 3
--- 卓尔游侠技能 008 - 寒霜连射
-- 被动（W 槽）：每隔基础间隔朝周围随机敌人射出一枚箭矢，走完整攻击管线（带弹道与攻击特效）。
-- 每拥有一档攻击速度按比例提升射击频率（线性，不取整，无门槛）。
____exports.drow_008 = __TS__Class()
local drow_008 = ____exports.drow_008
drow_008.name = "drow_008"
__TS__ClassExtends(drow_008, BaseHeroAbility)
function drow_008.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function drow_008.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_drow_008_frost_volley.name
end
function drow_008.prototype.GetBaseInterval(self)
	return self:GetSpecialValue("drow_008", "base_interval")
end
function drow_008.prototype.GetAttackSpeedPerBonus(self)
	return self:GetSpecialValue("drow_008", "attack_speed_per_bonus")
end
function drow_008.prototype.GetFrequencyBonusPct(self)
	return self:GetSpecialValue("drow_008", "frequency_bonus_pct")
end
function drow_008.prototype.GetSearchRadius(self)
	return self:GetSpecialValue("drow_008", "search_radius")
end
drow_008 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_008)
____exports.drow_008 = drow_008
____exports.modifier_drow_008_frost_volley = __TS__Class()
local modifier_drow_008_frost_volley = ____exports.modifier_drow_008_frost_volley
modifier_drow_008_frost_volley.name = "modifier_drow_008_frost_volley"
__TS__ClassExtends(modifier_drow_008_frost_volley, BaseHeroModifier)
function modifier_drow_008_frost_volley.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_drow_008_frost_volley.prototype.IsPermanent(self)
	return true
end
function modifier_drow_008_frost_volley.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(self:ComputeInterval())
end
function modifier_drow_008_frost_volley.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_drow_008_frost_volley.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local ____opt_0 = event.extra_data
	if (____opt_0 and ____opt_0.source_name) ~= "drow_008" then
		return
	end
	if not event.target or not IsValidAlive(nil, event.target) then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local ____math_max_5 = math.max
	local ____tonumber_4 = tonumber
	local ____opt_2 = parent.GetCustomValue
	local frostChance =
		____math_max_5(0, ____tonumber_4(____opt_2 and ____opt_2(parent, DROW_008_GEM_FROST_CHANCE_KEY) or 0) or 0)
	if frostChance <= 0 or not RollPercentage(math.min(100, frostChance)) then
		return
	end
	AddDeBuffStatus(
		nil,
		event.target,
		parent,
		ability,
		DebuffStatusType.ICE_SLOW,
		{
			stack = 1,
			duration = DROW_008_GEM_FROST_DURATION,
			effect_name = "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf",
			status_effect_name = "particles/status_fx/status_effect_drow_frost_arrow.vpcf",
		}
	)
end
function modifier_drow_008_frost_volley.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:FireVolleyArrow(parent)
	self:StartIntervalThink(self:ComputeInterval())
end
function modifier_drow_008_frost_volley.prototype.FireVolleyArrow(self, parent)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local enemies = __TS__ArrayFilter(
		self:FindMonsterEnemies(parent:GetAbsOrigin(), ability:GetSearchRadius()) or {},
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
	if #enemies == 0 then
		return
	end
	local target = enemies[RandomInt(0, #enemies - 1) + 1]
	if not target or not IsValidAlive(nil, target) then
		return
	end
	MyGameAttack:PerformAttack(
		parent,
		target,
		{ use_projectile = true, is_sub_attack = false, use_effect = true, extra_data = { source_name = "drow_008" } }
	)
end
function modifier_drow_008_frost_volley.prototype.ComputeInterval(self)
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not ability or not IsValid(nil, ability) or not IsValid(nil, parent) then
		return DROW_008_MIN_INTERVAL
	end
	local baseInterval = ability:GetBaseInterval()
	local attackSpeed = math.max(0, MyGameAttribute:GetAttribute(parent, "total_attack_speed") or 0)
	local bonusPct = attackSpeed / ability:GetAttackSpeedPerBonus() * ability:GetFrequencyBonusPct()
	return math.max(DROW_008_MIN_INTERVAL, baseInterval / (1 + bonusPct / 100))
end
modifier_drow_008_frost_volley = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_008_frost_volley)
____exports.modifier_drow_008_frost_volley = modifier_drow_008_frost_volley
return ____exports