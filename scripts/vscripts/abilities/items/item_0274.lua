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
____exports.item_0274 = __TS__Class()
local item_0274 = ____exports.item_0274
item_0274.name = "item_0274"
__TS__ClassExtends(item_0274, BaseItem_CS)
function item_0274.prototype.GetCooldown(self, _level)
	return 0
end
function item_0274.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0274_chorus.name
end
item_0274 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0274)
____exports.item_0274 = item_0274
____exports.modifier_item_0274_chorus = __TS__Class()
local modifier_item_0274_chorus = ____exports.modifier_item_0274_chorus
modifier_item_0274_chorus.name = "modifier_item_0274_chorus"
__TS__ClassExtends(modifier_item_0274_chorus, BaseModifier_CS)
function modifier_item_0274_chorus.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.remaining = 0
	self.tick = 0.5
	self.restorePerTick = 0
end
function modifier_item_0274_chorus.GetLocalizationCN(self)
	return { name = "齐鸣", description = "逐步恢复魔法值。" }
end
function modifier_item_0274_chorus.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0274_chorus.prototype.IsHidden(self)
	return self.remaining <= 0
end
function modifier_item_0274_chorus.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local itemAbility = self:GetAbility()
	if not itemAbility or not IsValidAlive(nil, parent) then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	if castAbility:IsToggle() then
		return
	end
	local manaCost = castAbility:GetEffectiveManaCost(castAbility:GetLevel() - 1)
	if manaCost <= 0 then
		return
	end
	local ability_mana_restore_pct = itemAbility:GetSpecialValue("item_0274", "ability_value_mana_restore_pct")
	local ability_duration = itemAbility:GetSpecialValue("item_0274", "ability_duration")
	local totalRestore = manaCost * (ability_mana_restore_pct / 100)
	if totalRestore <= 0 then
		return
	end
	self:AddManaRestore(totalRestore, ability_duration)
end
function modifier_item_0274_chorus.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:StopManaRestore()
		return
	end
	if self.remaining <= 0 then
		self:StopManaRestore()
		return
	end
	local amount = math.min(self.remaining, self.restorePerTick)
	local beforeMana = parent:GetMana()
	parent:GiveMana(amount)
	local actualRestore = math.max(0, parent:GetMana() - beforeMana)
	if actualRestore > 0 then
		Popups:manaGain(parent, math.floor(actualRestore))
	end
	self.remaining = self.remaining - amount
	if self.remaining <= 0 then
		self:StopManaRestore()
	end
end
function modifier_item_0274_chorus.prototype.IsDebuff(self)
	return false
end
function modifier_item_0274_chorus.prototype.IsPurgable(self)
	return false
end
function modifier_item_0274_chorus.prototype.GetTexture(self)
	return "item_spellslinger"
end
function modifier_item_0274_chorus.prototype.AddManaRestore(self, totalRestore, ability_duration)
	self.remaining = self.remaining + math.max(0, totalRestore)
	self.tick = 0.5
	local duration = math.max(0, ability_duration)
	local ____temp_0
	if duration > 0 then
		____temp_0 = math.max(1, math.floor(duration / self.tick))
	else
		____temp_0 = 1
	end
	local tickCount = ____temp_0
	local ____temp_1
	if tickCount > 0 then
		____temp_1 = self.remaining / tickCount
	else
		____temp_1 = self.remaining
	end
	self.restorePerTick = ____temp_1
	self:StartIntervalThink(self.tick)
end
function modifier_item_0274_chorus.prototype.StopManaRestore(self)
	self.remaining = 0
	self.restorePerTick = 0
	self:StartIntervalThink(-1)
end
modifier_item_0274_chorus = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0274_chorus)
____exports.modifier_item_0274_chorus = modifier_item_0274_chorus
return ____exports