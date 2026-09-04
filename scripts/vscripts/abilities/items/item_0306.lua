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
____exports.item_0306 = __TS__Class()
local item_0306 = ____exports.item_0306
item_0306.name = "item_0306"
__TS__ClassExtends(item_0306, BaseItem_CS)
function item_0306.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0306.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("ability_radius")
end
function item_0306.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0306_steal_fish.name
end
item_0306 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0306)
____exports.item_0306 = item_0306
____exports.modifier_item_0306_steal_fish = __TS__Class()
local modifier_item_0306_steal_fish = ____exports.modifier_item_0306_steal_fish
modifier_item_0306_steal_fish.name = "modifier_item_0306_steal_fish"
__TS__ClassExtends(modifier_item_0306_steal_fish, BaseModifier_CS)
function modifier_item_0306_steal_fish.prototype.IsHidden(self)
	return true
end
function modifier_item_0306_steal_fish.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0306_steal_fish.prototype.OnAttackLanded_CS(self, event)
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
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local bonusDamage = 10 + agility * (50 / 100)
	if bonusDamage <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = parent,
		damage = bonusDamage,
		damage_type = 4,
		ability = ability,
	})
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_beastmaster/beastmaster_drums_of_slom_hit.vpcf",
		PATTACH_POINT_FOLLOW,
		event.target,
		parent
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		event.target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		event.target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		3,
		event.target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		event.target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", event.target)
	parent:CustomHeal(bonusDamage, { ability = ability, source = "attack_lifesteal" })
end
function modifier_item_0306_steal_fish.prototype.IsDebuff(self)
	return false
end
function modifier_item_0306_steal_fish.prototype.IsPurgable(self)
	return true
end
function modifier_item_0306_steal_fish.prototype.GetEffectName(self)
	return "particles/hero/axe/axe_culling_buffa.vpcf"
end
modifier_item_0306_steal_fish = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0306_steal_fish)
____exports.modifier_item_0306_steal_fish = modifier_item_0306_steal_fish
return ____exports