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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local GetAllStats = ____item_0409_shared.GetAllStats
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
____exports.item_0415 = __TS__Class()
local item_0415 = ____exports.item_0415
item_0415.name = "item_0415"
__TS__ClassExtends(item_0415, BaseItem_CS)
function item_0415.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0415_gaze.name
end
item_0415 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0415)
____exports.item_0415 = item_0415
____exports.modifier_item_0415_gaze = __TS__Class()
local modifier_item_0415_gaze = ____exports.modifier_item_0415_gaze
modifier_item_0415_gaze.name = "modifier_item_0415_gaze"
__TS__ClassExtends(modifier_item_0415_gaze, BaseModifier_CS)
function modifier_item_0415_gaze.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE, { event = BusinessEvents.ON_HP_LOSS, target = { scope = "global" } } }
end
function modifier_item_0415_gaze.prototype.IsHidden(self)
	return true
end
function modifier_item_0415_gaze.prototype.IsPurgable(self)
	return false
end
function modifier_item_0415_gaze.prototype.OnHpLoss_CS(self, event)
	self:TryTriggerGaze(event)
end
function modifier_item_0415_gaze.prototype.OnTakeDamage_CS(self, event)
	self:TryTriggerGaze(event)
end
function modifier_item_0415_gaze.prototype.TryTriggerGaze(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local target = event.victim
	if not IsValidEnemyUnit(nil, parent, target) then
		return
	end
	if not self:IsDotDamage(event) or (event.final_damage or 0) <= 0 then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_value_trigger_chance_pct =
		math.min(100, math.max(0, ability:GetSpecialValueFor("ability_value_trigger_chance_pct")))
	if not RollPercentage(ability_value_trigger_chance_pct) then
		return
	end
	local ability_value_all_stats_damage_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_all_stats_damage_pct"))
	local damage = GetAllStats(nil, parent) * (ability_value_all_stats_damage_pct / 100)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = damage,
		damage_type = 4,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = self:GetName(),
			source_name = self:GetName(),
		},
	})
	local ability_vulnerable_duration = math.max(0, ability:GetSpecialValueFor("ability_vulnerable_duration"))
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.VULNERABLE,
		{ duration = ability_vulnerable_duration, stack = 1 }
	)
end
function modifier_item_0415_gaze.prototype.IsDotDamage(self, event)
	local source = event.source
	return (source and source.debuff_status) == DebuffStatusType.BLEED
		or (source and source.debuff_status) == DebuffStatusType.POISON
		or (source and source.debuff_status) == DebuffStatusType.BURN
		or CheckTag(nil, source and source.damage_tags, DamageTag.DOT)
end
modifier_item_0415_gaze = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0415_gaze)
____exports.modifier_item_0415_gaze = modifier_item_0415_gaze
return ____exports