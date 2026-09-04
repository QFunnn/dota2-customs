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
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
____exports.item_0517 = __TS__Class()
local item_0517 = ____exports.item_0517
item_0517.name = "item_0517"
__TS__ClassExtends(item_0517, BaseItem_CS)
function item_0517.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0517.name
end
item_0517 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0517)
____exports.item_0517 = item_0517
____exports.modifier_item_0517 = __TS__Class()
local modifier_item_0517 = ____exports.modifier_item_0517
modifier_item_0517.name = "modifier_item_0517"
__TS__ClassExtends(modifier_item_0517, BaseModifier_CS)
function modifier_item_0517.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0517.prototype.IsHidden(self)
	return true
end
function modifier_item_0517.prototype.IsPurgable(self)
	return false
end
function modifier_item_0517.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, target) or target:IsBuilding() then
		return
	end
	local ability_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_trigger_chance_pct"))
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local ability_aoe_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_aoe_damage_pct"))
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	if ability_aoe_damage_pct <= 0 or ability_radius <= 0 then
		return
	end
	local str = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agi = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local int = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	local allStats = math.max(0, str + agi + int)
	local damage = allStats * (ability_aoe_damage_pct / 100)
	if damage <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
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
				ability = ability,
				damage = damage,
				damage_type = 1,
				extra_data = { custom_tag = "item_0517_void_slash", source_name = "裂空斩" },
			})
		end
		::__continue13::
	end
	self:PlayEffects1(parent, target)
end
function modifier_item_0517.prototype.PlayEffects1(self, parent, target)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		parent
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	local pfx2 = MyGameHeroParticleManager:CreateParticle(
		"particles/windrunner_tailwind_oneshot_arcana.vpcf",
		PATTACH_WORLDORIGIN,
		nil,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(pfx2, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx2)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", target)
end
modifier_item_0517 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0517)
____exports.modifier_item_0517 = modifier_item_0517
return ____exports