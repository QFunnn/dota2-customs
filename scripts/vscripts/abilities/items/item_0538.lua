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
____exports.item_0538 = __TS__Class()
local item_0538 = ____exports.item_0538
item_0538.name = "item_0538"
__TS__ClassExtends(item_0538, BaseItem_CS)
function item_0538.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0538_mana_surge.name
end
item_0538 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0538)
____exports.item_0538 = item_0538
--- 固有被动「魔涌」：释放真·英雄技能时消耗当前魔法 % 并按消耗量 × 当前魔法 % 对周围敌人造成魔法伤害。
____exports.modifier_item_0538_mana_surge = __TS__Class()
local modifier_item_0538_mana_surge = ____exports.modifier_item_0538_mana_surge
modifier_item_0538_mana_surge.name = "modifier_item_0538_mana_surge"
__TS__ClassExtends(modifier_item_0538_mana_surge, BaseModifier_CS)
function modifier_item_0538_mana_surge.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0538_mana_surge.prototype.IsHidden(self)
	return true
end
function modifier_item_0538_mana_surge.prototype.IsPurgable(self)
	return false
end
function modifier_item_0538_mana_surge.prototype.OnAfterAbilityFullyCast_CS(self, event)
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
	local mana = math.max(0, parent:GetMana())
	local costPct = math.max(0, ability:GetSpecialValueFor("ability_mana_cost_pct"))
	local cost = mana * (costPct / 100)
	if cost <= 0 then
		return
	end
	parent:SetMana(math.max(0, mana - cost))
	local dmgPerManaPct = math.max(0, ability:GetSpecialValueFor("ability_damage_per_mana_pct"))
	local damage = cost * (mana * (dmgPerManaPct / 100))
	if damage <= 0 then
		return
	end
	local radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue13
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					damage_tags = DamageTag.NO_PROC,
					source_name = self:GetName(),
				},
			})
		end
		::__continue13::
	end
end
modifier_item_0538_mana_surge = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0538_mana_surge)
____exports.modifier_item_0538_mana_surge = modifier_item_0538_mana_surge
return ____exports