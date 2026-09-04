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
local ____item_0330 = require("abilities.items.item_0330")
local RegenShieldWithHealthRegenPct = ____item_0330.RegenShieldWithHealthRegenPct
local BU_MIE_MUTEX_KEY = ____item_0330.BU_MIE_MUTEX_KEY
local THINK_INTERVAL = 0.2
____exports.item_0531 = __TS__Class()
local item_0531 = ____exports.item_0531
item_0531.name = "item_0531"
__TS__ClassExtends(item_0531, BaseItem_CS)
function item_0531.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0531_eternal_medal.name
end
item_0531 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0531)
____exports.item_0531 = item_0531
____exports.modifier_item_0531_eternal_medal = __TS__Class()
local modifier_item_0531_eternal_medal = ____exports.modifier_item_0531_eternal_medal
modifier_item_0531_eternal_medal.name = "modifier_item_0531_eternal_medal"
__TS__ClassExtends(modifier_item_0531_eternal_medal, BaseModifier_CS)
function modifier_item_0531_eternal_medal.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._lastRegenAmpPct = -1
end
function modifier_item_0531_eternal_medal.prototype.IsHidden(self)
	return true
end
function modifier_item_0531_eternal_medal.prototype.IsPurgable(self)
	return false
end
function modifier_item_0531_eternal_medal.prototype.GetMutexKey(self)
	return BU_MIE_MUTEX_KEY
end
function modifier_item_0531_eternal_medal.prototype.GetMutexPriority(self)
	return 210
end
function modifier_item_0531_eternal_medal.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self._lastRegenAmpPct = -1
	self:StartIntervalThink(THINK_INTERVAL)
	self:RefreshAttributes()
end
function modifier_item_0531_eternal_medal.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0531_eternal_medal.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	RegenShieldWithHealthRegenPct(nil, self:GetParent(), self:GetAbility(), THINK_INTERVAL)
	local next = self:ComputeRegenAmpPct()
	if next ~= self._lastRegenAmpPct then
		self._lastRegenAmpPct = next
		self:RefreshAttributes()
	end
end
function modifier_item_0531_eternal_medal.prototype.GetAttributeBonus(self)
	return { regen_amp_pct = self:ComputeRegenAmpPct() }
end
function modifier_item_0531_eternal_medal.prototype.ComputeRegenAmpPct(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return 0
	end
	local maxHp = math.max(1, parent:GetMaxHealth())
	local hp = math.max(0, parent:GetHealth())
	local missingPct = math.max(0, math.min(100, math.floor((maxHp - hp) * 100 / maxHp)))
	local step = math.max(1, ability:GetSpecialValueFor("ability_regen_amp_missing_health_step_pct"))
	local perStep = math.max(0, ability:GetSpecialValueFor("ability_regen_amp_pct_per_missing_health_pct"))
	local maxAmp = math.max(0, ability:GetSpecialValueFor("ability_regen_amp_max_pct"))
	local stepCount = math.floor(missingPct / step)
	local amp = stepCount * perStep
	local ____temp_0
	if maxAmp > 0 then
		____temp_0 = math.min(amp, maxAmp)
	else
		____temp_0 = amp
	end
	return ____temp_0
end
modifier_item_0531_eternal_medal = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0531_eternal_medal)
____exports.modifier_item_0531_eternal_medal = modifier_item_0531_eternal_medal
return ____exports