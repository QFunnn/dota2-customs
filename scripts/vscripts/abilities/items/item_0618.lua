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
local ____item_0614 = require("abilities.items.item_0614")
local AddDebt = ____item_0614.AddDebt
local ClearDebt = ____item_0614.ClearDebt
____exports.item_0618 = __TS__Class()
local item_0618 = ____exports.item_0618
item_0618.name = "item_0618"
__TS__ClassExtends(item_0618, BaseItem_CS)
function item_0618.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0618.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0618.name
end
function item_0618.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound("DOTA_Item.Armlet.Activate")
	local stacks = ClearDebt(nil, caster)
	if stacks <= 0 then
		return
	end
	local base = (MyGameAttribute:GetAttribute(caster, "total_strength") or 0)
		+ (MyGameAttribute:GetAttribute(caster, "total_agility") or 0)
		+ (MyGameAttribute:GetAttribute(caster, "total_intelligence") or 0)
	local burstPct = math.max(0, self:GetSpecialValueFor("ability_value_burst_pct"))
	local damage = stacks * base * (burstPct / 100)
	if damage <= 0 then
		return
	end
	local radius = math.max(0, self:GetSpecialValueFor("ability_burst_radius"))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue9
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = self,
				extra_data = { damage_tags = DamageTag.NO_PROC, source_name = "item_0618:宣告破产·衡" },
			})
		end
		::__continue9::
	end
end
item_0618 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0618)
____exports.item_0618 = item_0618
--- 固有被动：造成直接伤害欠 1 层【债】（DOT 跳与衍生伤害不记账）。
____exports.modifier_item_0618 = __TS__Class()
local modifier_item_0618 = ____exports.modifier_item_0618
modifier_item_0618.name = "modifier_item_0618"
__TS__ClassExtends(modifier_item_0618, BaseModifier_CS)
function modifier_item_0618.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0618.prototype.OnTakeDamage_CS(self, event)
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
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.NO_PROC) then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	AddDebt(nil, parent, ability, 1)
end
function modifier_item_0618.prototype.IsHidden(self)
	return true
end
function modifier_item_0618.prototype.IsPurgable(self)
	return false
end
modifier_item_0618 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0618)
____exports.modifier_item_0618 = modifier_item_0618
return ____exports