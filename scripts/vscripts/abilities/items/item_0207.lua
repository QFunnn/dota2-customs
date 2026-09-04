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
____exports.item_0207 = __TS__Class()
local item_0207 = ____exports.item_0207
item_0207.name = "item_0207"
__TS__ClassExtends(item_0207, BaseItem_CS)
function item_0207.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0207"
end
item_0207 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0207)
____exports.item_0207 = item_0207
____exports.modifier_item_0207 = __TS__Class()
local modifier_item_0207 = ____exports.modifier_item_0207
modifier_item_0207.name = "modifier_item_0207"
__TS__ClassExtends(modifier_item_0207, BaseModifier_CS)
function modifier_item_0207.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0207.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local attacker = self:GetParent()
	if event.attacker ~= attacker then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, attacker) or not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == attacker:GetTeamNumber() then
		return
	end
	local ____opt_0 = attacker.IsRangedAttacker
	if (____opt_0 and ____opt_0(attacker)) == true then
		return
	end
	local ability_cleave_distance = ability:GetSpecialValueFor("ability_cleave_distance")
	local ability_cleave_angle = ability:GetSpecialValueFor("ability_cleave_angle")
	local ability_hero_damage_pct = ability:GetSpecialValueFor("ability_hero_damage_pct")
	local ability_creep_damage_pct = ability:GetSpecialValueFor("ability_creep_damage_pct")
	local attackDamage = MyGameAttribute:GetAttribute(attacker, "total_attack_damage") or 0
	if attackDamage <= 0 then
		return
	end
	local attackerPos = attacker:GetAbsOrigin()
	local targetPos = target:GetAbsOrigin()
	local forward = (targetPos - attackerPos):Normalized()
	local enemies = FindUnitsInCone(
		nil,
		attacker:GetTeamNumber(),
		attackerPos,
		nil,
		ability_cleave_distance,
		forward,
		ability_cleave_angle,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue12
			end
			if enemy == target then
				goto __continue12
			end
			local damagePct = ability_creep_damage_pct
			local damage = attackDamage * damagePct * 0.01
			if damage <= 0 then
				goto __continue12
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = attacker,
				damage = damage,
				damage_type = 1,
				ability = ability,
			})
		end
		::__continue12::
	end
end
modifier_item_0207 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0207)
____exports.modifier_item_0207 = modifier_item_0207
return ____exports