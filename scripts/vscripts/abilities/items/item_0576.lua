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
local THINK_INTERVAL = 0.2
____exports.item_0576 = __TS__Class()
local item_0576 = ____exports.item_0576
item_0576.name = "item_0576"
__TS__ClassExtends(item_0576, BaseItem_CS)
function item_0576.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0576.name
end
item_0576 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0576)
____exports.item_0576 = item_0576
____exports.modifier_item_0576 = __TS__Class()
local modifier_item_0576 = ____exports.modifier_item_0576
modifier_item_0576.name = "modifier_item_0576"
__TS__ClassExtends(modifier_item_0576, BaseModifier_CS)
function modifier_item_0576.GetLocalizationCN(self)
	return { name = "诅火", description = "每具有一个负面状态，伤害加成和伤害抵抗提高。" }
end
function modifier_item_0576.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0576.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0576.prototype.IsHidden(self)
	return true
end
function modifier_item_0576.prototype.IsDebuff(self)
	return false
end
function modifier_item_0576.prototype.IsPurgable(self)
	return false
end
function modifier_item_0576.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	local ability_bonus_pct_per_debuff = math.max(0, ability:GetSpecialValueFor("ability_value_bonus_pct_per_debuff"))
	if ability_bonus_pct_per_debuff <= 0 then
		return {}
	end
	local debuffCount = self:CountDebuffs(parent)
	if debuffCount <= 0 then
		return {}
	end
	local ability_total_bonus_pct = debuffCount * ability_bonus_pct_per_debuff
	return { outgoing_damage_pct = ability_total_bonus_pct, damage_resistance_pct = ability_total_bonus_pct }
end
function modifier_item_0576.prototype.CountDebuffs(self, parent)
	local mods = parent:FindAllModifiers() or {}
	local n = 0
	for ____, m in ipairs(mods) do
		if m.IsDebuff and m:IsDebuff() then
			n = n + 1
		end
	end
	return n
end
modifier_item_0576 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0576)
____exports.modifier_item_0576 = modifier_item_0576
return ____exports