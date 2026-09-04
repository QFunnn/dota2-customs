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
____exports.item_0217 = __TS__Class()
local item_0217 = ____exports.item_0217
item_0217.name = "item_0217"
__TS__ClassExtends(item_0217, BaseItem_CS)
function item_0217.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0217_pojun.name
end
item_0217 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0217)
____exports.item_0217 = item_0217
--- 固有被动「破军」：物理伤害暴击时有概率给目标施加易伤和破甲。
____exports.modifier_item_0217_pojun = __TS__Class()
local modifier_item_0217_pojun = ____exports.modifier_item_0217_pojun
modifier_item_0217_pojun.name = "modifier_item_0217_pojun"
__TS__ClassExtends(modifier_item_0217_pojun, BaseModifier_CS)
function modifier_item_0217_pojun.GetLocalizationCN(self)
	return { name = "破军", description = "物理伤害暴击时，有概率使目标受到易伤并叠加破甲。" }
end
function modifier_item_0217_pojun.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0217_pojun.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if not event.is_crit or event.damage_type ~= 1 then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.DOT) then
		return
	end
	local target = event.victim
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_value_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_value_trigger_chance_pct"))
	if not RollPercentage(ability_value_trigger_chance_pct) then
		return
	end
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.VULNERABLE, {
		stack = 1,
		duration = ability:GetSpecialValueFor("ability_vulnerable_duration"),
	})
	____exports.modifier_item_0217_armor_break:applys(
		target,
		parent,
		ability,
		{ duration = ability:GetSpecialValueFor("ability_armor_duration") }
	)
	local ability_cooldown = math.max(0, ability:GetCooldown(ability:GetLevel()))
	if ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
	end
end
function modifier_item_0217_pojun.prototype.IsHidden(self)
	return true
end
function modifier_item_0217_pojun.prototype.IsPurgable(self)
	return false
end
modifier_item_0217_pojun = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0217_pojun)
____exports.modifier_item_0217_pojun = modifier_item_0217_pojun
--- 【破甲】：每层按百分比降低目标护甲，重复触发时叠层并刷新持续时间。
____exports.modifier_item_0217_armor_break = __TS__Class()
local modifier_item_0217_armor_break = ____exports.modifier_item_0217_armor_break
modifier_item_0217_armor_break.name = "modifier_item_0217_armor_break"
__TS__ClassExtends(modifier_item_0217_armor_break, BaseModifier_CS)
function modifier_item_0217_armor_break.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_armor_reduction_pct_per_stack = 0
	self.ability_value_armor_max_stacks = 1
end
function modifier_item_0217_armor_break.GetLocalizationCN(self)
	return { name = "破甲", description = "护甲按层数降低。" }
end
function modifier_item_0217_armor_break.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(1)
	self:RefreshAttributes()
end
function modifier_item_0217_armor_break.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(math.min(self.ability_value_armor_max_stacks, self:GetStackCount() + 1))
	self:RefreshAttributes()
end
function modifier_item_0217_armor_break.prototype.RefreshConfig(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.ability_armor_reduction_pct_per_stack =
		math.max(0, ability:GetSpecialValueFor("ability_armor_reduction_pct_per_stack"))
	self.ability_value_armor_max_stacks =
		math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_armor_max_stacks")))
end
function modifier_item_0217_armor_break.prototype.GetAttributeBonus(self)
	return {
		base_armor_pct = -self.ability_armor_reduction_pct_per_stack * math.max(1, self:GetStackCount()),
	}
end
function modifier_item_0217_armor_break.prototype.IsDebuff(self)
	return true
end
function modifier_item_0217_armor_break.prototype.IsPurgable(self)
	return true
end
function modifier_item_0217_armor_break.prototype.GetTexture(self)
	return "item_desolator"
end
modifier_item_0217_armor_break = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0217_armor_break)
____exports.modifier_item_0217_armor_break = modifier_item_0217_armor_break
return ____exports