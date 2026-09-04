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
--- 【侵蚀】衰减节拍（秒）：每 tick 流逝 max(1, floor(层数×decay%))。
local DECAY_TICK_INTERVAL = 1
____exports.item_0593 = __TS__Class()
local item_0593 = ____exports.item_0593
item_0593.name = "item_0593"
__TS__ClassExtends(item_0593, BaseItem_CS)
function item_0593.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0593.name
end
item_0593 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0593)
____exports.item_0593 = item_0593
--- 固有被动：自己的 DOT 每次结算 → 叠 1 层【侵蚀】（刷新时长）。
____exports.modifier_item_0593 = __TS__Class()
local modifier_item_0593 = ____exports.modifier_item_0593
modifier_item_0593.name = "modifier_item_0593"
__TS__ClassExtends(modifier_item_0593, BaseModifier_CS)
function modifier_item_0593.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_HP_LOSS, target = { scope = "global" } }, BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0593.prototype.IsHidden(self)
	return true
end
function modifier_item_0593.prototype.IsPurgable(self)
	return false
end
function modifier_item_0593.prototype.OnHpLoss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local source = event.source
	local isDotDamage = (source and source.debuff_status) == DebuffStatusType.BLEED
		or (source and source.debuff_status) == DebuffStatusType.BURN
		or CheckTag(nil, source and source.damage_tags, DamageTag.DOT)
	if not isDotDamage then
		return
	end
	self:TryGainErode(event.victim, event.final_damage)
end
function modifier_item_0593.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local source = event.source
	local isDotDamage = (source and source.debuff_status) == DebuffStatusType.POISON
		or CheckTag(nil, source and source.damage_tags, DamageTag.DOT)
	if not isDotDamage then
		return
	end
	self:TryGainErode(event.victim, event.final_damage)
end
function modifier_item_0593.prototype.TryGainErode(self, victim, finalDamage)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not victim or victim == parent or not IsValidAlive(nil, victim) then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if (finalDamage or 0) <= 0 then
		return
	end
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0593_erode.name, {})
end
modifier_item_0593 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0593)
____exports.modifier_item_0593 = modifier_item_0593
--- 【侵蚀】：可见叠层 buff，每层提高全域暴击率与暴击伤害；永续，每秒流逝 decay%（最少1层），流逝尽即消失。
____exports.modifier_item_0593_erode = __TS__Class()
local modifier_item_0593_erode = ____exports.modifier_item_0593_erode
modifier_item_0593_erode.name = "modifier_item_0593_erode"
__TS__ClassExtends(modifier_item_0593_erode, BaseModifier_CS)
function modifier_item_0593_erode.GetLocalizationCN(self)
	return {
		name = "侵蚀",
		description = "持续伤害结算叠层，每层提高全域暴击率与暴击伤害；每秒流逝少量层数。",
	}
end
function modifier_item_0593_erode.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
	self:StartIntervalThink(DECAY_TICK_INTERVAL)
end
function modifier_item_0593_erode.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
end
function modifier_item_0593_erode.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0593_erode.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local stacks = self:GetStackCount()
	if stacks <= 0 then
		self:Destroy()
		return
	end
	local ____ability_10
	if ability then
		____ability_10 = math.max(0, ability:GetSpecialValueFor("ability_erode_decay_pct"))
	else
		____ability_10 = 5
	end
	local decayPct = ____ability_10
	local decay = math.max(1, math.floor(stacks * decayPct / 100))
	local remain = stacks - decay
	if remain <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(remain)
	self:RefreshAttributes()
end
function modifier_item_0593_erode.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local stacks = self:GetStackCount()
	if not ability or stacks <= 0 then
		return {}
	end
	return {
		omni_crit_chance_pct = stacks * math.max(0, ability:GetSpecialValueFor("ability_crit_per_stack")),
		crit_damage_pct = stacks * math.max(0, ability:GetSpecialValueFor("ability_critdmg_per_stack")),
	}
end
function modifier_item_0593_erode.prototype.IsHidden(self)
	return false
end
function modifier_item_0593_erode.prototype.IsDebuff(self)
	return false
end
function modifier_item_0593_erode.prototype.IsPurgable(self)
	return false
end
function modifier_item_0593_erode.prototype.GetTexture(self)
	return "item_crystalys"
end
function modifier_item_0593_erode.prototype.AddOneStack(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local maxStacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_max_stacks")))
	self:SetStackCount(math.min(self:GetStackCount() + 1, maxStacks))
	self:RefreshAttributes()
end
modifier_item_0593_erode = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0593_erode)
____exports.modifier_item_0593_erode = modifier_item_0593_erode
return ____exports