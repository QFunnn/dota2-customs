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
local ____canxiang_set = require("shared.canxiang_set")
local CountCanxiangItems = ____canxiang_set.CountCanxiangItems
local CANXIANG_ECHO_TAG = ____canxiang_set.CANXIANG_ECHO_TAG
local ____canxiang_echo = require("abilities.items.canxiang_echo")
local ScheduleEcho = ____canxiang_echo.ScheduleEcho
____exports.item_0571 = __TS__Class()
local item_0571 = ____exports.item_0571
item_0571.name = "item_0571"
__TS__ClassExtends(item_0571, BaseItem_CS)
function item_0571.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0571.name
end
item_0571 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0571)
____exports.item_0571 = item_0571
--- 固有被动：普攻命中 → 按套装件数决定比例，延迟追加一次残响纯粹伤害。
____exports.modifier_item_0571 = __TS__Class()
local modifier_item_0571 = ____exports.modifier_item_0571
modifier_item_0571.name = "modifier_item_0571"
__TS__ClassExtends(modifier_item_0571, BaseModifier_CS)
function modifier_item_0571.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0571.prototype.IsHidden(self)
	return true
end
function modifier_item_0571.prototype.IsPurgable(self)
	return false
end
function modifier_item_0571.prototype.OnTakeDamage_CS(self, event)
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
	if not event.is_base_attack or event.is_cleave then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_0 = event.source
	if (____opt_0 and ____opt_0.custom_tag) == CANXIANG_ECHO_TAG then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local isFullSet = CountCanxiangItems(nil, parent) >= 2
	local pct = math.max(0, ability:GetSpecialValueFor(isFullSet and "ability_echo_pct_full" or "ability_echo_pct"))
	local delay = math.max(0, ability:GetSpecialValueFor("ability_echo_delay"))
	local echo = (event.final_damage or 0) * (pct / 100)
	local capPct = math.max(0, ability:GetSpecialValueFor("ability_echo_cap_agi_pct"))
	if capPct > 0 then
		local agility = math.max(0, MyGameAttribute:GetAttribute(parent, "total_agility") or 0)
		echo = math.min(echo, agility * (capPct / 100))
	end
	ScheduleEcho(nil, parent, target, ability, echo, delay, 1)
end
modifier_item_0571 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0571)
____exports.modifier_item_0571 = modifier_item_0571
return ____exports