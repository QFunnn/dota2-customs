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
local ____sage_set = require("shared.sage_set")
local GetSageItems = ____sage_set.GetSageItems
local THINK_INTERVAL = 0.5
____exports.item_0526 = __TS__Class()
local item_0526 = ____exports.item_0526
item_0526.name = "item_0526"
__TS__ClassExtends(item_0526, BaseItem_CS)
function item_0526.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0526.name
end
item_0526 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0526)
____exports.item_0526 = item_0526
--- 常驻 intrinsic modifier，承载本装备词条「贤者共鸣」：
--  每件贤者装 +X% 魔法值、+Y% 技能伤害。
--  （大贤者之威整体放大被动已迁出至 item_0442；原「智识涌流」已迁出至 item_0518。）
____exports.modifier_item_0526 = __TS__Class()
local modifier_item_0526 = ____exports.modifier_item_0526
modifier_item_0526.name = "modifier_item_0526"
__TS__ClassExtends(modifier_item_0526, BaseModifier_CS)
function modifier_item_0526.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedSageCount = 0
end
function modifier_item_0526.GetLocalizationCN(self)
	return {
		name = "贤者共鸣",
		description = "每件【贤者】装备提高魔法值与技能伤害，最多生效3件（层数=当前生效件数）。",
	}
end
function modifier_item_0526.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.cachedSageCount = math.min(3, #GetSageItems(nil, self:GetParent()))
	self:SetStackCount(self.cachedSageCount)
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0526.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0526.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	local count = math.min(3, #GetSageItems(nil, self:GetParent()))
	if count ~= self.cachedSageCount then
		self.cachedSageCount = count
		self:SetStackCount(count)
		self:RefreshAttributes()
	end
end
function modifier_item_0526.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, self:GetParent()) then
		return {}
	end
	local count = self.cachedSageCount
	if count <= 0 then
		return {}
	end
	local bonus = {}
	local function add(____, key, value)
		if not value then
			return
		end
		bonus[key] = (bonus[key] or 0) + value
	end
	add(nil, "all_mana_pct", count * math.max(0, ability:GetSpecialValueFor("ability_value_mana_pct_per_sage")))
	add(nil, "spell_amplify_pct", count * math.max(0, ability:GetSpecialValueFor("ability_value_spell_amp_per_sage")))
	return bonus
end
function modifier_item_0526.prototype.IsHidden(self)
	return false
end
function modifier_item_0526.prototype.IsDebuff(self)
	return false
end
function modifier_item_0526.prototype.IsPurgable(self)
	return false
end
modifier_item_0526 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0526)
____exports.modifier_item_0526 = modifier_item_0526
return ____exports