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
____exports.item_0563 = __TS__Class()
local item_0563 = ____exports.item_0563
item_0563.name = "item_0563"
__TS__ClassExtends(item_0563, BaseItem_CS)
function item_0563.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0563.name
end
item_0563 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0563)
____exports.item_0563 = item_0563
____exports.modifier_item_0563 = __TS__Class()
local modifier_item_0563 = ____exports.modifier_item_0563
modifier_item_0563.name = "modifier_item_0563"
__TS__ClassExtends(modifier_item_0563, BaseModifier_CS)
function modifier_item_0563.GetLocalizationCN(self)
	return {
		name = "洞窟诅咒",
		description = "闪避不再生效；攻击命中时，对目标追加一次(闪避率×敏捷)物理伤害。",
	}
end
function modifier_item_0563.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_EVASION_QUERY, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0563.prototype.IsHidden(self)
	return false
end
function modifier_item_0563.prototype.IsDebuff(self)
	return true
end
function modifier_item_0563.prototype.IsPurgable(self)
	return false
end
function modifier_item_0563.prototype.OnDamageEvasionQuery_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	event.force_hit = true
end
function modifier_item_0563.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local evasion = math.max(0, MyGameAttribute:GetAttribute(parent, "evasion_pct") or 0)
	local agility = math.max(0, MyGameAttribute:GetAttribute(parent, "total_agility") or 0)
	local coef = math.max(0, ability:GetSpecialValueFor("ability_dmg_coef"))
	local perHit = evasion * agility * coef
	if perHit <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = parent,
		damage = perHit,
		damage_type = 1,
		ability = ability,
		extra_data = { damage_tags = DamageTag.NO_PROC, source_name = "item_0563:洞窟诅咒" },
	})
end
modifier_item_0563 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0563)
____exports.modifier_item_0563 = modifier_item_0563
return ____exports