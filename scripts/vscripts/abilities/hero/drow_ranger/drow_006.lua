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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 层数流逝间隔（秒）
local DROW_006_STACK_DECAY_INTERVAL = 1
--- 卓尔游侠技能 006 - 凛冬狂热
-- 被动：每次攻击命中获得 1 层凛冬狂热，每层提供固定攻击速度，层数达到上限后不再增加；每秒流逝 1 层。
____exports.drow_006 = __TS__Class()
local drow_006 = ____exports.drow_006
drow_006.name = "drow_006"
__TS__ClassExtends(drow_006, BaseHeroAbility)
function drow_006.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN }
end
function drow_006.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_drow_006_winter_fervor.name
end
function drow_006.prototype.GetAttackSpeedPerStack(self)
	return self:GetSpecialValue("drow_006", "attack_speed_per_stack")
end
function drow_006.prototype.GetMaxStack(self)
	return self:GetSpecialValue("drow_006", "max_stack")
end
drow_006 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_006)
____exports.drow_006 = drow_006
____exports.modifier_drow_006_winter_fervor = __TS__Class()
local modifier_drow_006_winter_fervor = ____exports.modifier_drow_006_winter_fervor
modifier_drow_006_winter_fervor.name = "modifier_drow_006_winter_fervor"
__TS__ClassExtends(modifier_drow_006_winter_fervor, BaseHeroModifier)
function modifier_drow_006_winter_fervor.GetLocalizationCN(self)
	return { name = "凛冬狂热", description = "攻击会叠加攻击速度，每秒流逝 1 层。" }
end
function modifier_drow_006_winter_fervor.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_drow_006_winter_fervor.prototype.GetModifierConfig(self)
	return {
		isHidden = self:GetStackCount() <= 0,
		isDebuff = false,
		isPurgable = false,
		isPurgeException = false,
	}
end
function modifier_drow_006_winter_fervor.prototype.IsPermanent(self)
	return true
end
function modifier_drow_006_winter_fervor.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:StartIntervalThink(-1)
end
function modifier_drow_006_winter_fervor.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local previousStack = self:GetStackCount()
	local nextStack = math.min(self:GetStackCount() + 1, ability:GetMaxStack())
	self:SetStackCount(nextStack)
	self:RefreshAttributes()
	if previousStack <= 0 and nextStack > 0 then
		self:StartIntervalThink(DROW_006_STACK_DECAY_INTERVAL)
	end
end
function modifier_drow_006_winter_fervor.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStack = math.max(self:GetStackCount() - 1, 0)
	self:SetStackCount(nextStack)
	self:RefreshAttributes()
	if nextStack <= 0 then
		self:StartIntervalThink(-1)
	end
end
function modifier_drow_006_winter_fervor.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local stacks = self:GetStackCount()
	return { attack_speed = stacks * ability:GetAttackSpeedPerStack() }
end
function modifier_drow_006_winter_fervor.prototype.GetTexture(self)
	return "drow_06"
end
modifier_drow_006_winter_fervor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_006_winter_fervor)
____exports.modifier_drow_006_winter_fervor = modifier_drow_006_winter_fervor
return ____exports