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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
--- 主动献祭，消耗生命后短时间提升攻击力。
____exports.item_0256 = __TS__Class()
local item_0256 = ____exports.item_0256
item_0256.name = "item_0256"
__TS__ClassExtends(item_0256, BaseItem_CS)
function item_0256.prototype.GetHealthCostValue(self)
	return self:GetSpecialValueFor("ability_health_cost")
end
function item_0256.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		healthCost = self:GetHealthCostValue(),
	}
end
function item_0256.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:AddNewModifier(
		caster,
		self,
		____exports.modifier_item_0256_buff.name,
		{ duration = self:GetSpecialValueFor("ability_duration") }
	)
	caster:EmitSound("DOTA_Item.ArcaneRing.Cast")
end
item_0256 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0256)
____exports.item_0256 = item_0256
____exports.modifier_item_0256_buff = __TS__Class()
local modifier_item_0256_buff = ____exports.modifier_item_0256_buff
modifier_item_0256_buff.name = "modifier_item_0256_buff"
__TS__ClassExtends(modifier_item_0256_buff, BaseModifier_CS)
function modifier_item_0256_buff.GetLocalizationCN(self)
	return { name = "休眠协议", description = "攻击力提高。" }
end
function modifier_item_0256_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_bonus_attack_damage")
	else
		____ability_0 = 0
	end
	local bonusAttackDamage = ____ability_0
	return { bonus_attack_damage = bonusAttackDamage }
end
function modifier_item_0256_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0256_buff.prototype.IsPurgable(self)
	return true
end
modifier_item_0256_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0256_buff)
____exports.modifier_item_0256_buff = modifier_item_0256_buff
return ____exports