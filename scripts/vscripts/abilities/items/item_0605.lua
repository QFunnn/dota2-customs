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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ROULETTE_CUSTOM_TAG = "item_0605_roulette"
--- 固有被动：造成暴击（含技能暴击）→ 单次掷骰追加一份等额伤害（不暴击、不连锁）。
____exports.modifier_item_0605 = __TS__Class()
local modifier_item_0605 = ____exports.modifier_item_0605
modifier_item_0605.name = "modifier_item_0605"
__TS__ClassExtends(modifier_item_0605, BaseModifier_CS)
function modifier_item_0605.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0605.prototype.IsHidden(self)
	return true
end
function modifier_item_0605.prototype.IsPurgable(self)
	return false
end
function modifier_item_0605.prototype.GetMutexKey(self)
	return "lun_pan"
end
function modifier_item_0605.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0218" and 200 or 100
end
function modifier_item_0605.prototype.OnTakeDamage_CS(self, event)
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
	local rolledChance = ability:GetSpecialValueFor("ability_value_chain_chance_pct")
	local ____math_max_4 = math.max
	local ____math_min_3 = math.min
	local ____temp_2
	if rolledChance > 0 then
		____temp_2 = rolledChance
	else
		____temp_2 = ability:GetSpecialValueFor("ability_chain_chance_pct")
	end
	local chance = ____math_max_4(0, ____math_min_3(100, ____temp_2))
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
		damage_type = 1,
		damage_flag = ApplyDamageFlag.HP_LOSS,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = ROULETTE_CUSTOM_TAG,
			source_name = "item_0605:轮盘连锁",
		},
	})
end
modifier_item_0605 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0605)
____exports.modifier_item_0605 = modifier_item_0605
return ____exports