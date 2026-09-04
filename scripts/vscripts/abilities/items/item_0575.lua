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
____exports.item_0575 = __TS__Class()
local item_0575 = ____exports.item_0575
item_0575.name = "item_0575"
__TS__ClassExtends(item_0575, BaseItem_CS)
function item_0575.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0575.name
end
item_0575 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0575)
____exports.item_0575 = item_0575
--- 固有被动：自己的 DOT 每次结算 → 全技能减 CD（带节流）。
____exports.modifier_item_0575 = __TS__Class()
local modifier_item_0575 = ____exports.modifier_item_0575
modifier_item_0575.name = "modifier_item_0575"
__TS__ClassExtends(modifier_item_0575, BaseModifier_CS)
function modifier_item_0575.GetLocalizationCN(self)
	return {
		name = "腐蚀年轮",
		description = "你的持续伤害每次结算时，缩短自身所有非充能技能的冷却时间。",
	}
end
function modifier_item_0575.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_HP_LOSS, target = { scope = "global" } } }
end
function modifier_item_0575.prototype.IsHidden(self)
	return true
end
function modifier_item_0575.prototype.IsPurgable(self)
	return false
end
function modifier_item_0575.prototype.OnHpLoss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local victim = event.victim
	if not victim or victim == parent or not IsValidAlive(nil, victim) then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local source = event.source
	local isDotDamage = (source and source.debuff_status) == DebuffStatusType.BLEED
		or (source and source.debuff_status) == DebuffStatusType.POISON
		or (source and source.debuff_status) == DebuffStatusType.BURN
		or CheckTag(nil, source and source.damage_tags, DamageTag.DOT)
	if not isDotDamage then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	local ability = self:GetAbility()
	if not ability or not ability:IsCooldownReady() then
		return
	end
	local cdrSec = math.max(0, ability:GetSpecialValueFor("ability_cdr_per_tick"))
	if cdrSec <= 0 then
		return
	end
	local count = parent:GetAbilityCount()
	do
		local i = 0
		while i < count do
			do
				local ab = parent:GetAbilityByIndex(i)
				if not IsRealNonItemAbility(nil, ab) then
					goto __continue16
				end
				if MyGameAbilityChargeManager and MyGameAbilityChargeManager:IsCustomChargeAbility(ab) then
					goto __continue16
				end
				ReduceCooldown(nil, ab, cdrSec)
			end
			::__continue16::
			i = i + 1
		end
	end
	local throttle = math.max(0, ability:GetSpecialValueFor("ability_throttle_interval"))
	if throttle > 0 then
		ability:StartCooldown(throttle)
	end
end
modifier_item_0575 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0575)
____exports.modifier_item_0575 = modifier_item_0575
return ____exports