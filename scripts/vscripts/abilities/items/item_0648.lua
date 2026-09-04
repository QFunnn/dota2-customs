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
local ROULETTE_CUSTOM_TAG = "item_0648_roulette"
____exports.item_0648 = __TS__Class()
local item_0648 = ____exports.item_0648
item_0648.name = "item_0648"
__TS__ClassExtends(item_0648, BaseItem_CS)
function item_0648.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0648.name
end
item_0648 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0648)
____exports.item_0648 = item_0648
--- 固有被动：造成暴击（含技能暴击）→ 单次掷骰追加一份等额魔法伤害（不暴击、不连锁）。
____exports.modifier_item_0648 = __TS__Class()
local modifier_item_0648 = ____exports.modifier_item_0648
modifier_item_0648.name = "modifier_item_0648"
__TS__ClassExtends(modifier_item_0648, BaseModifier_CS)
function modifier_item_0648.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0648.prototype.IsHidden(self)
	return true
end
function modifier_item_0648.prototype.IsPurgable(self)
	return false
end
function modifier_item_0648.prototype.GetMutexKey(self)
	return "lun_pan"
end
function modifier_item_0648.prototype.GetMutexPriority(self)
	return 200
end
function modifier_item_0648.prototype.OnTakeDamage_CS(self, event)
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
	if event.is_crit ~= true or event.is_cleave then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_0 = event.source
	if (____opt_0 and ____opt_0.custom_tag) == ROULETTE_CUSTOM_TAG then
		return
	end
	local victim = event.victim
	if not IsValidAlive(nil, victim) or victim:IsBuilding() then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local chance = math.max(0, math.min(100, ability:GetSpecialValueFor("ability_value_chain_chance_pct")))
	if chance <= 0 then
		return
	end
	if not RollPercentage(chance) then
		return
	end
	Damage:ApplyDamage({
		victim = victim,
		attacker = parent,
		damage = event.final_damage or 0,
		damage_type = 2,
		damage_flag = ApplyDamageFlag.HP_LOSS,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = ROULETTE_CUSTOM_TAG,
			source_name = "item_0648:轮盘连锁",
		},
	})
end
modifier_item_0648 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0648)
____exports.modifier_item_0648 = modifier_item_0648
return ____exports