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
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local ReduceCooldown = ____item_0409_shared.ReduceCooldown
____exports.item_0518 = __TS__Class()
local item_0518 = ____exports.item_0518
item_0518.name = "item_0518"
__TS__ClassExtends(item_0518, BaseItem_CS)
function item_0518.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0518_insight.name
end
item_0518 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0518)
____exports.item_0518 = item_0518
--- 自身被动「智识涌流」：施放真·英雄主动技能时，自身所有非充能技能各减 ability_cdr_per_cast_sec 秒当前冷却。
____exports.modifier_item_0518_insight = __TS__Class()
local modifier_item_0518_insight = ____exports.modifier_item_0518_insight
modifier_item_0518_insight.name = "modifier_item_0518_insight"
__TS__ClassExtends(modifier_item_0518_insight, BaseModifier_CS)
function modifier_item_0518_insight.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0518_insight.prototype.IsHidden(self)
	return true
end
function modifier_item_0518_insight.prototype.IsPurgable(self)
	return false
end
function modifier_item_0518_insight.prototype.GetMutexKey(self)
	return "zhi_shi_yong_liu"
end
function modifier_item_0518_insight.prototype.GetMutexPriority(self)
	return 200
end
function modifier_item_0518_insight.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not IsRealNonItemAbility(nil, castAbility) then
		return
	end
	local chance = math.max(0, ability:GetSpecialValueFor("ability_value_trigger_chance_pct"))
	if not RollPercentage(math.min(100, chance)) then
		return
	end
	local reduceSec = math.max(0, ability:GetSpecialValueFor("ability_cdr_per_cast_sec"))
	if reduceSec <= 0 then
		return
	end
	Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		local count = parent:GetAbilityCount()
		do
			local i = 0
			while i < count do
				do
					local ab = parent:GetAbilityByIndex(i)
					if not IsRealNonItemAbility(nil, ab) then
						goto __continue17
					end
					if MyGameAbilityChargeManager and MyGameAbilityChargeManager:IsCustomChargeAbility(ab) then
						goto __continue17
					end
					ReduceCooldown(nil, ab, reduceSec)
				end
				::__continue17::
				i = i + 1
			end
		end
	end)
end
modifier_item_0518_insight = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0518_insight)
____exports.modifier_item_0518_insight = modifier_item_0518_insight
return ____exports