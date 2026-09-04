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
local ____modifier_generic_ignite = require("modifiers.debuff.modifier_generic_ignite")
local modifier_generic_ignite = ____modifier_generic_ignite.modifier_generic_ignite
____exports.item_0566 = __TS__Class()
local item_0566 = ____exports.item_0566
item_0566.name = "item_0566"
__TS__ClassExtends(item_0566, BaseItem_CS)
function item_0566.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0566_listener.name
end
item_0566 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0566)
____exports.item_0566 = item_0566
--- 固有监听：对点燃满层的敌人造成非 DOT 伤害时，挂【熔甲】debuff。
____exports.modifier_item_0566_listener = __TS__Class()
local modifier_item_0566_listener = ____exports.modifier_item_0566_listener
modifier_item_0566_listener.name = "modifier_item_0566_listener"
__TS__ClassExtends(modifier_item_0566_listener, BaseModifier_CS)
function modifier_item_0566_listener.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0566_listener.prototype.IsHidden(self)
	return true
end
function modifier_item_0566_listener.prototype.IsPurgable(self)
	return false
end
function modifier_item_0566_listener.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ignite = target:FindModifierByName(modifier_generic_ignite.name)
	if not ignite then
		return
	end
	local requiredStacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_required_stacks")))
	if ignite:GetStackCount() < requiredStacks then
		return
	end
	target:AddNewModifier(parent, ability, ____exports.modifier_item_0566_meltarmor.name, {})
end
modifier_item_0566_listener = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0566_listener)
____exports.modifier_item_0566_listener = modifier_item_0566_listener
--- 【熔甲】debuff：护甲降低 + 受到的魔法伤害提高（固定值），持续数秒；满层再触发即刷新持续时间。
____exports.modifier_item_0566_meltarmor = __TS__Class()
local modifier_item_0566_meltarmor = ____exports.modifier_item_0566_meltarmor
modifier_item_0566_meltarmor.name = "modifier_item_0566_meltarmor"
__TS__ClassExtends(modifier_item_0566_meltarmor, BaseModifier_CS)
function modifier_item_0566_meltarmor.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.armorReductionPct = 0
	self.magicalAmpPct = 0
end
function modifier_item_0566_meltarmor.GetLocalizationCN(self)
	return { name = "熔甲", description = "护甲降低，且受到的魔法伤害提高。" }
end
function modifier_item_0566_meltarmor.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
end
function modifier_item_0566_meltarmor.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
end
function modifier_item_0566_meltarmor.prototype.RefreshConfig(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(0, ability:GetSpecialValueFor("ability_armor_reduction_pct"))
	else
		____ability_0 = 0
	end
	self.armorReductionPct = ____ability_0
	local ____ability_1
	if ability then
		____ability_1 = math.max(0, ability:GetSpecialValueFor("ability_magical_amp_pct"))
	else
		____ability_1 = 0
	end
	self.magicalAmpPct = ____ability_1
	local ____ability_2
	if ability then
		____ability_2 = math.max(0, ability:GetSpecialValueFor("ability_duration"))
	else
		____ability_2 = 4
	end
	local duration = ____ability_2
	self:SetDuration(duration, true)
	self:RefreshAttributes()
end
function modifier_item_0566_meltarmor.prototype.GetAttributeBonus(self)
	return { base_armor_pct = -self.armorReductionPct, incoming_magical_damage_increase_pct = self.magicalAmpPct }
end
function modifier_item_0566_meltarmor.prototype.IsDebuff(self)
	return true
end
function modifier_item_0566_meltarmor.prototype.IsPurgable(self)
	return false
end
function modifier_item_0566_meltarmor.prototype.GetTexture(self)
	return "item_desolator"
end
modifier_item_0566_meltarmor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0566_meltarmor)
____exports.modifier_item_0566_meltarmor = modifier_item_0566_meltarmor
return ____exports