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
____exports.item_0391 = __TS__Class()
local item_0391 = ____exports.item_0391
item_0391.name = "item_0391"
__TS__ClassExtends(item_0391, BaseItem_CS)
function item_0391.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0391_frost_slow_aura.name
end
item_0391 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0391)
____exports.item_0391 = item_0391
--- 载体一：敌方减速光环；同时负责挂出载体二。
____exports.modifier_item_0391_frost_slow_aura = __TS__Class()
local modifier_item_0391_frost_slow_aura = ____exports.modifier_item_0391_frost_slow_aura
modifier_item_0391_frost_slow_aura.name = "modifier_item_0391_frost_slow_aura"
__TS__ClassExtends(modifier_item_0391_frost_slow_aura, BaseModifier_CS)
function modifier_item_0391_frost_slow_aura.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	____exports.modifier_item_0391_frost_stats_aura:applys(parent, parent, ability, {})
end
function modifier_item_0391_frost_slow_aura.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local carrier = parent:FindModifierByName(____exports.modifier_item_0391_frost_stats_aura.name)
	if carrier then
		carrier:Destroy()
	end
end
function modifier_item_0391_frost_slow_aura.prototype.IsAura(self)
	return true
end
function modifier_item_0391_frost_slow_aura.prototype.GetModifierAura(self)
	return ____exports.modifier_item_0391_frost_slow_debuff.name
end
function modifier_item_0391_frost_slow_aura.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(0, ability:GetSpecialValueFor("ability_aura_radius"))
	else
		____ability_0 = 0
	end
	return ____ability_0
end
function modifier_item_0391_frost_slow_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_0391_frost_slow_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_item_0391_frost_slow_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_0391_frost_slow_aura.prototype.GetAuraEntityReject(self, target)
	return not IsValidAlive(nil, target) or target:IsBuilding()
end
function modifier_item_0391_frost_slow_aura.prototype.IsHidden(self)
	return true
end
function modifier_item_0391_frost_slow_aura.prototype.IsPurgable(self)
	return false
end
modifier_item_0391_frost_slow_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0391_frost_slow_aura)
____exports.modifier_item_0391_frost_slow_aura = modifier_item_0391_frost_slow_aura
--- 载体二：友方全属性光环。
____exports.modifier_item_0391_frost_stats_aura = __TS__Class()
local modifier_item_0391_frost_stats_aura = ____exports.modifier_item_0391_frost_stats_aura
modifier_item_0391_frost_stats_aura.name = "modifier_item_0391_frost_stats_aura"
__TS__ClassExtends(modifier_item_0391_frost_stats_aura, BaseModifier_CS)
function modifier_item_0391_frost_stats_aura.prototype.IsAura(self)
	return true
end
function modifier_item_0391_frost_stats_aura.prototype.GetModifierAura(self)
	return ____exports.modifier_item_0391_frost_stats_buff.name
end
function modifier_item_0391_frost_stats_aura.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_1
	if ability then
		____ability_1 = math.max(0, ability:GetSpecialValueFor("ability_aura_radius"))
	else
		____ability_1 = 0
	end
	return ____ability_1
end
function modifier_item_0391_frost_stats_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_0391_frost_stats_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_item_0391_frost_stats_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_0391_frost_stats_aura.prototype.GetAuraEntityReject(self, target)
	return not IsValidAlive(nil, target) or target:IsBuilding()
end
function modifier_item_0391_frost_stats_aura.prototype.IsHidden(self)
	return true
end
function modifier_item_0391_frost_stats_aura.prototype.IsPurgable(self)
	return false
end
modifier_item_0391_frost_stats_aura =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0391_frost_stats_aura)
____exports.modifier_item_0391_frost_stats_aura = modifier_item_0391_frost_stats_aura
--- 敌方效果：攻速移速降低。
____exports.modifier_item_0391_frost_slow_debuff = __TS__Class()
local modifier_item_0391_frost_slow_debuff = ____exports.modifier_item_0391_frost_slow_debuff
modifier_item_0391_frost_slow_debuff.name = "modifier_item_0391_frost_slow_debuff"
__TS__ClassExtends(modifier_item_0391_frost_slow_debuff, BaseModifier_CS)
function modifier_item_0391_frost_slow_debuff.GetLocalizationCN(self)
	return { name = "霜寒", description = "攻击速度和移动速度降低。" }
end
function modifier_item_0391_frost_slow_debuff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_2
	if ability then
		____ability_2 = math.max(0, ability:GetSpecialValueFor("ability_value_slow_pct"))
	else
		____ability_2 = 0
	end
	local ability_value_slow_pct = ____ability_2
	return { attack_speed_pct = -ability_value_slow_pct, bonus_movespeed_pct = -ability_value_slow_pct }
end
function modifier_item_0391_frost_slow_debuff.prototype.IsDebuff(self)
	return true
end
function modifier_item_0391_frost_slow_debuff.prototype.IsPurgable(self)
	return false
end
modifier_item_0391_frost_slow_debuff =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0391_frost_slow_debuff)
____exports.modifier_item_0391_frost_slow_debuff = modifier_item_0391_frost_slow_debuff
--- 友方效果：全属性加成。
____exports.modifier_item_0391_frost_stats_buff = __TS__Class()
local modifier_item_0391_frost_stats_buff = ____exports.modifier_item_0391_frost_stats_buff
modifier_item_0391_frost_stats_buff.name = "modifier_item_0391_frost_stats_buff"
__TS__ClassExtends(modifier_item_0391_frost_stats_buff, BaseModifier_CS)
function modifier_item_0391_frost_stats_buff.GetLocalizationCN(self)
	return { name = "光环辅助", description = "获得额外全属性。" }
end
function modifier_item_0391_frost_stats_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return {
		bonus_all_stats = math.max(0, ability:GetSpecialValueFor("ability_value_aura_all_stats")),
	}
end
function modifier_item_0391_frost_stats_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0391_frost_stats_buff.prototype.IsPurgable(self)
	return false
end
modifier_item_0391_frost_stats_buff =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0391_frost_stats_buff)
____exports.modifier_item_0391_frost_stats_buff = modifier_item_0391_frost_stats_buff
return ____exports