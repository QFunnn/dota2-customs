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
--- 形态编号：1 狂攻 / 2 秘法 / 3 天命 / 4 磐石。
local FORM_ATTACK = 1
local FORM_SPELL = 2
local FORM_CRIT = 3
local FORM_DEFENSE = 4
____exports.item_0597 = __TS__Class()
local item_0597 = ____exports.item_0597
item_0597.name = "item_0597"
__TS__ClassExtends(item_0597, BaseItem_CS)
function item_0597.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0597.name
end
item_0597 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0597)
____exports.item_0597 = item_0597
--- 【全押之骰】（可见）：层数=当前形态（1狂攻/2秘法/3天命/4磐石），每次掷骰切换词条包。
____exports.modifier_item_0597 = __TS__Class()
local modifier_item_0597 = ____exports.modifier_item_0597
modifier_item_0597.name = "modifier_item_0597"
__TS__ClassExtends(modifier_item_0597, BaseModifier_CS)
function modifier_item_0597.GetLocalizationCN(self)
	return {
		name = "全押之骰",
		description = "掷骰形态（层数）：1【狂攻】物理伤害提高；2【秘法】技能伤害提高；3【天命】全域暴击率提高；4【磐石】受到伤害降低。",
	}
end
function modifier_item_0597.prototype.IsHidden(self)
	return false
end
function modifier_item_0597.prototype.IsPurgable(self)
	return false
end
function modifier_item_0597.prototype.GetTexture(self)
	return "item_octarine_core"
end
function modifier_item_0597.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RollForm()
	local ability = self:GetAbility()
	local ____math_max_1 = math.max
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_roll_interval")
	else
		____ability_0 = 10
	end
	local interval = ____math_max_1(1, ____ability_0)
	self:StartIntervalThink(interval)
end
function modifier_item_0597.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RollForm()
end
function modifier_item_0597.prototype.RollForm(self)
	self.form = RandomInt(FORM_ATTACK, FORM_DEFENSE)
	self:SetStackCount(self.form)
	self:RefreshAttributes()
end
function modifier_item_0597.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not self.form then
		return {}
	end
	if self.form == FORM_ATTACK then
		return {
			physical_damage_add_pct = math.max(0, ability:GetSpecialValueFor("ability_form_attack_pct")),
		}
	end
	if self.form == FORM_SPELL then
		return {
			spell_amplify_pct = math.max(0, ability:GetSpecialValueFor("ability_form_spell_pct")),
		}
	end
	if self.form == FORM_CRIT then
		return {
			omni_crit_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_form_crit_pct")),
		}
	end
	return {
		damage_reduction_pct = math.max(0, ability:GetSpecialValueFor("ability_form_defense_pct")),
	}
end
modifier_item_0597 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0597)
____exports.modifier_item_0597 = modifier_item_0597
return ____exports