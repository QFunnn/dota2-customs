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
____exports.item_0421 = __TS__Class()
local item_0421 = ____exports.item_0421
item_0421.name = "item_0421"
__TS__ClassExtends(item_0421, BaseItem_CS)
function item_0421.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0421.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = math.max(0, self:GetSpecialValueFor("ability_duration"))
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0421_void_scale.name, { duration = ability_duration })
	self:PlayEffects1(caster)
end
function item_0421.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.Refresher.Activate")
end
item_0421 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0421)
____exports.item_0421 = item_0421
____exports.modifier_item_0421_void_scale = __TS__Class()
local modifier_item_0421_void_scale = ____exports.modifier_item_0421_void_scale
modifier_item_0421_void_scale.name = "modifier_item_0421_void_scale"
__TS__ClassExtends(modifier_item_0421_void_scale, BaseModifier_CS)
function modifier_item_0421_void_scale.GetLocalizationCN(self)
	return { name = "虚空刻度", description = "魔法消耗增加，技能伤害提高。" }
end
function modifier_item_0421_void_scale.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0421_void_scale.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0421_void_scale.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_value_spell_amplify_pct = math.max(0, ability:GetSpecialValueFor("ability_value_spell_amplify_pct"))
	return { spell_amplify_pct = ability_value_spell_amplify_pct }
end
function modifier_item_0421_void_scale.prototype.GetTagModifierRules(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_value_mana_cost_pct = math.max(0, ability:GetSpecialValueFor("ability_value_mana_cost_pct"))
	if ability_value_mana_cost_pct <= 0 then
		return {}
	end
	return { { id = "item_0421_mana_cost_up", statKey = 6, op = 1, value = ability_value_mana_cost_pct } }
end
function modifier_item_0421_void_scale.prototype.IsDebuff(self)
	return false
end
function modifier_item_0421_void_scale.prototype.IsPurgable(self)
	return true
end
modifier_item_0421_void_scale = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0421_void_scale)
____exports.modifier_item_0421_void_scale = modifier_item_0421_void_scale
return ____exports