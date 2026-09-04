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
____exports.item_0504 = __TS__Class()
local item_0504 = ____exports.item_0504
item_0504.name = "item_0504"
__TS__ClassExtends(item_0504, BaseItem_CS)
function item_0504.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0504.name
end
item_0504 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0504)
____exports.item_0504 = item_0504
____exports.modifier_item_0504 = __TS__Class()
local modifier_item_0504 = ____exports.modifier_item_0504
modifier_item_0504.name = "modifier_item_0504"
__TS__ClassExtends(modifier_item_0504, BaseModifier_CS)
function modifier_item_0504.GetLocalizationCN(self)
	return {
		name = "血池回响",
		description = "你的流血对敌人造成伤害时，将本次流血伤害的一定比例作为物理伤害直接结算，不计入流血池。",
	}
end
function modifier_item_0504.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_HP_LOSS, target = { scope = "global" } } }
end
function modifier_item_0504.prototype.OnHpLoss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local ____opt_0 = event.source
	if (____opt_0 and ____opt_0.debuff_status) ~= DebuffStatusType.BLEED then
		return
	end
	local victim = event.victim
	if not victim or not IsValidAlive(nil, victim) or victim == parent then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local pct = math.max(0, ability:GetSpecialValueFor("ability_value_bleed_to_physical_pct"))
	if pct <= 0 then
		return
	end
	local physDamage = math.max(0, event.final_damage) * pct / 100
	if physDamage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = victim,
		attacker = parent,
		damage = physDamage,
		damage_type = 1,
		ability = ability,
		extra_data = { damage_tags = DamageTag.NO_PROC, source_name = "item_0504:血池回响" },
	})
end
function modifier_item_0504.prototype.IsHidden(self)
	return true
end
function modifier_item_0504.prototype.IsDebuff(self)
	return false
end
function modifier_item_0504.prototype.IsPurgable(self)
	return false
end
modifier_item_0504 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0504)
____exports.modifier_item_0504 = modifier_item_0504
return ____exports