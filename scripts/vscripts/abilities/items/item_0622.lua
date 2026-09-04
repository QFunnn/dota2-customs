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
____exports.item_0622 = __TS__Class()
local item_0622 = ____exports.item_0622
item_0622.name = "item_0622"
__TS__ClassExtends(item_0622, BaseItem_CS)
function item_0622.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0622.name
end
item_0622 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0622)
____exports.item_0622 = item_0622
--- 固有被动「碎星」：物理伤害暴击时有概率给目标挂 1 层易伤。
____exports.modifier_item_0622 = __TS__Class()
local modifier_item_0622 = ____exports.modifier_item_0622
modifier_item_0622.name = "modifier_item_0622"
__TS__ClassExtends(modifier_item_0622, BaseModifier_CS)
function modifier_item_0622.GetLocalizationCN(self)
	return { name = "碎星", description = "物理伤害暴击时，有概率为目标施加1层易伤。" }
end
function modifier_item_0622.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0622.prototype.OnTakeDamage_CS(self, event)
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
	local ability_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_trigger_chance_pct"))
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.VULNERABLE, {
		stack = 1,
		duration = ability:GetSpecialValueFor("ability_vulnerable_duration"),
	})
	local ability_cooldown = math.max(0, ability:GetCooldown(ability:GetLevel()))
	if ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
	end
end
function modifier_item_0622.prototype.IsHidden(self)
	return true
end
function modifier_item_0622.prototype.IsPurgable(self)
	return false
end
modifier_item_0622 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0622)
____exports.modifier_item_0622 = modifier_item_0622
return ____exports