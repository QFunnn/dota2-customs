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
____exports.item_0315 = __TS__Class()
local item_0315 = ____exports.item_0315
item_0315.name = "item_0315"
__TS__ClassExtends(item_0315, BaseItem_CS)
function item_0315.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0315_king_backpack.name
end
item_0315 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0315)
____exports.item_0315 = item_0315
--- 王者背包：为范围内友军提供全属性光环。
____exports.modifier_item_0315_king_backpack = __TS__Class()
local modifier_item_0315_king_backpack = ____exports.modifier_item_0315_king_backpack
modifier_item_0315_king_backpack.name = "modifier_item_0315_king_backpack"
__TS__ClassExtends(modifier_item_0315_king_backpack, BaseModifier_CS)
function modifier_item_0315_king_backpack.prototype.IsHidden(self)
	return true
end
function modifier_item_0315_king_backpack.prototype.IsPurgable(self)
	return false
end
function modifier_item_0315_king_backpack.prototype.IsAura(self)
	return true
end
function modifier_item_0315_king_backpack.prototype.GetModifierAura(self)
	return ____exports.modifier_item_0315_king_backpack_aura.name
end
function modifier_item_0315_king_backpack.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_aura_radius")
	else
		____ability_0 = 0
	end
	return ____ability_0
end
function modifier_item_0315_king_backpack.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_0315_king_backpack.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_item_0315_king_backpack.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_0315_king_backpack.prototype.GetAuraEntityReject(self, target)
	return not IsValidAlive(nil, target) or target:IsBuilding()
end
modifier_item_0315_king_backpack = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0315_king_backpack)
____exports.modifier_item_0315_king_backpack = modifier_item_0315_king_backpack
____exports.modifier_item_0315_king_backpack_aura = __TS__Class()
local modifier_item_0315_king_backpack_aura = ____exports.modifier_item_0315_king_backpack_aura
modifier_item_0315_king_backpack_aura.name = "modifier_item_0315_king_backpack_aura"
__TS__ClassExtends(modifier_item_0315_king_backpack_aura, BaseModifier_CS)
function modifier_item_0315_king_backpack_aura.GetLocalizationCN(self)
	return { name = "君临", description = "获得额外全属性。" }
end
function modifier_item_0315_king_backpack_aura.prototype.IsHidden(self)
	return false
end
function modifier_item_0315_king_backpack_aura.prototype.IsDebuff(self)
	return false
end
function modifier_item_0315_king_backpack_aura.prototype.IsPurgable(self)
	return false
end
function modifier_item_0315_king_backpack_aura.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return { bonus_all_stats = ability:GetSpecialValueFor("ability_value_aura_all_stats") }
end
modifier_item_0315_king_backpack_aura =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0315_king_backpack_aura)
____exports.modifier_item_0315_king_backpack_aura = modifier_item_0315_king_backpack_aura
return ____exports