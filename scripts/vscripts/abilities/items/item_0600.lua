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
--- 距离阶梯步长（码）：每满一步提高一档伤害。
local STEP_RANGE = 100
____exports.item_0600 = __TS__Class()
local item_0600 = ____exports.item_0600
item_0600.name = "item_0600"
__TS__ClassExtends(item_0600, BaseItem_CS)
function item_0600.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0600.name
end
item_0600 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0600)
____exports.item_0600 = item_0600
--- 固有被动：技能伤害按施放者与目标的距离阶梯增幅。
____exports.modifier_item_0600 = __TS__Class()
local modifier_item_0600 = ____exports.modifier_item_0600
modifier_item_0600.name = "modifier_item_0600"
__TS__ClassExtends(modifier_item_0600, BaseModifier_CS)
function modifier_item_0600.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER }
end
function modifier_item_0600.prototype.IsHidden(self)
	return true
end
function modifier_item_0600.prototype.IsPurgable(self)
	return false
end
function modifier_item_0600.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.ctx.spec.is_base_attack then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.ctx.spec.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.NO_PROC) then
		return
	end
	local victim = event.ctx.spec.victim
	if not victim or not IsValidAlive(nil, victim) or victim:IsBuilding() then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local perPct = math.max(0, ability:GetSpecialValueFor("ability_amp_per_100"))
	local maxPct = math.max(0, ability:GetSpecialValueFor("ability_amp_max_pct"))
	if perPct <= 0 or maxPct <= 0 then
		return
	end
	local distance = (parent:GetAbsOrigin() - victim:GetAbsOrigin()):Length2D()
	local steps = math.floor(distance / STEP_RANGE)
	local amp = math.min(maxPct, steps * perPct)
	if amp <= 0 then
		return
	end
	local ____event_final_3, ____mul_4 = event.final, "mul"
	if ____event_final_3[____mul_4] == nil then
		____event_final_3[____mul_4] = {}
	end
	local ____event_final_mul_5 = event.final.mul
	____event_final_mul_5[#____event_final_mul_5 + 1] = { value = 1 + amp / 100, source = "item_0600:远山狙杀" }
end
modifier_item_0600 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0600)
____exports.modifier_item_0600 = modifier_item_0600
return ____exports