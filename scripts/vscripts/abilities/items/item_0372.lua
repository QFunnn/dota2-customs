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
____exports.item_0372 = __TS__Class()
local item_0372 = ____exports.item_0372
item_0372.name = "item_0372"
__TS__ClassExtends(item_0372, BaseItem_CS)
function item_0372.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0372_omni_strike.name
end
item_0372 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0372)
____exports.item_0372 = item_0372
____exports.modifier_item_0372_omni_strike = __TS__Class()
local modifier_item_0372_omni_strike = ____exports.modifier_item_0372_omni_strike
modifier_item_0372_omni_strike.name = "modifier_item_0372_omni_strike"
__TS__ClassExtends(modifier_item_0372_omni_strike, BaseModifier_CS)
function modifier_item_0372_omni_strike.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0372_omni_strike.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_all_stats_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_all_stats_damage_pct"))
	local damage = self:GetAllStats(parent) * (ability_all_stats_damage_pct / 100)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = parent,
		damage = damage,
		damage_type = 2,
		ability = ability,
	})
	self:PlayEffects1(target)
end
function modifier_item_0372_omni_strike.prototype.IsHidden(self)
	return true
end
function modifier_item_0372_omni_strike.prototype.IsPurgable(self)
	return false
end
function modifier_item_0372_omni_strike.prototype.GetAllStats(self, parent)
	local strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_item_0372_omni_strike.prototype.PlayEffects1(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/econ/items/faceless_void/faceless_void_arcana/faceless_void_arcana_maelstrom_v2_item.vpcf",
		PATTACH_POINT_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		self._caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self._caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", target)
end
modifier_item_0372_omni_strike = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0372_omni_strike)
____exports.modifier_item_0372_omni_strike = modifier_item_0372_omni_strike
return ____exports