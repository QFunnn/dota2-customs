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
local ____modifier_generic_ignite = require("modifiers.debuff.modifier_generic_ignite")
local modifier_generic_ignite = ____modifier_generic_ignite.modifier_generic_ignite
local SEAL_CUSTOM_TAG = "item_0579_seal"
--- 四系通用 DOT modifier 名（流血/中毒/灼烧 + 点燃）。
local DOT_MODIFIER_NAMES =
	{ "modifier_generic_bleed", "modifier_generic_poison", "modifier_generic_burning", modifier_generic_ignite.name }
____exports.item_0579 = __TS__Class()
local item_0579 = ____exports.item_0579
item_0579.name = "item_0579"
__TS__ClassExtends(item_0579, BaseItem_CS)
function item_0579.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0579.name
end
item_0579 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0579)
____exports.item_0579 = item_0579
--- 固有监听：四系俱全的目标，其每次 DOT 结算追加等额比例的物理伤害。
____exports.modifier_item_0579 = __TS__Class()
local modifier_item_0579 = ____exports.modifier_item_0579
modifier_item_0579.name = "modifier_item_0579"
__TS__ClassExtends(modifier_item_0579, BaseModifier_CS)
function modifier_item_0579.GetLocalizationCN(self)
	return {
		name = "四疫之印",
		description = "同时身负你的流血、中毒、灼烧、点燃的目标，其承受的持续伤害每次结算都会追加一次物理伤害。",
	}
end
function modifier_item_0579.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_HP_LOSS, target = { scope = "global" } } }
end
function modifier_item_0579.prototype.IsHidden(self)
	return true
end
function modifier_item_0579.prototype.IsPurgable(self)
	return false
end
function modifier_item_0579.prototype.OnHpLoss_CS(self, event)
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
	if victim:IsBuilding() then
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
	local dotDamage = math.max(0, event.final_damage or 0)
	if dotDamage <= 0 then
		return
	end
	for ____, name in ipairs(DOT_MODIFIER_NAMES) do
		local dot = victim:FindModifierByName(name)
		if not dot or dot:GetCaster() ~= parent then
			return
		end
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local extraPct = math.max(0, ability:GetSpecialValueFor("ability_extra_pct"))
	if extraPct <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = victim,
		attacker = parent,
		damage = dotDamage * (extraPct / 100),
		damage_type = 1,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = SEAL_CUSTOM_TAG,
			source_name = "item_0579:四疫之印",
		},
	})
end
modifier_item_0579 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0579)
____exports.modifier_item_0579 = modifier_item_0579
return ____exports