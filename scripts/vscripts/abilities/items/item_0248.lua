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
local ITEM_0248_PROJECTILE = "particles/units/heroes/hero_venomancer/venomancer_noxious_plague_projectile.vpcf"
local ITEM_0248_PROJECTILE_CAST_SOUND = "Hero_VenomancerWard.Attack"
local ITEM_0248_PROJECTILE_HIT_SOUND = "Hero_Venomancer.VenomousGaleImpact"
____exports.item_0248 = __TS__Class()
local item_0248 = ____exports.item_0248
item_0248.name = "item_0248"
__TS__ClassExtends(item_0248, BaseItem_CS)
function item_0248.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0248_PROJECTILE, context)
end
function item_0248.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0248"
end
item_0248 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0248)
____exports.item_0248 = item_0248
____exports.modifier_item_0248 = __TS__Class()
local modifier_item_0248 = ____exports.modifier_item_0248
modifier_item_0248.name = "modifier_item_0248"
__TS__ClassExtends(modifier_item_0248, BaseModifier_CS)
function modifier_item_0248.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_UNIT_DEATH_BEFORE }
end
function modifier_item_0248.prototype.OnUnitDeathBefore_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	local target = event.victim
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValid(nil, target) then
		return
	end
	local ability_min_poison_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_min_poison_stacks")))
	local ability_infection_radius = math.max(0, ability:GetSpecialValueFor("ability_infection_radius"))
	local ability_projectile_speed = math.max(1, ability:GetSpecialValueFor("ability_projectile_speed"))
	local poisonStacks = self:GetTotalPoisonStacks(target)
	if poisonStacks < ability_min_poison_stacks then
		return
	end
	local targetPos = target:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		targetPos,
		nil,
		ability_infection_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if enemy == target then
				goto __continue10
			end
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue10
			end
			parent:EmitSound(ITEM_0248_PROJECTILE_CAST_SOUND)
			CreateProjectile(nil, {
				caster = parent,
				projectile_type = "tracking",
				effect_name = ITEM_0248_PROJECTILE,
				target = enemy,
				start_point = targetPos,
				projectile_speed = ability_projectile_speed,
				ability = ability,
				extra_data = { poison_stack = poisonStacks },
				on_hit = function(____, hitTarget, _location, extraData)
					if not IsServer() then
						return
					end
					if not IsValidAlive(nil, parent) or not IsValidAlive(nil, hitTarget) or hitTarget:IsBuilding() then
						return
					end
					if hitTarget:GetTeamNumber() == parent:GetTeamNumber() then
						return
					end
					hitTarget:EmitSound(ITEM_0248_PROJECTILE_HIT_SOUND)
					local spreadStack = math.max(1, math.floor(extraData and extraData.poison_stack or poisonStacks))
					AddDeBuffStatus(
						nil,
						hitTarget,
						parent,
						ability,
						DebuffStatusType.POISON,
						{
							stack = spreadStack,
							effect_name = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf",
						}
					)
				end,
			})
		end
		::__continue10::
	end
end
function modifier_item_0248.prototype.IsHidden(self)
	return true
end
function modifier_item_0248.prototype.GetTotalPoisonStacks(self, target)
	if not target or not target.FindAllModifiers then
		return 0
	end
	local stacks = 0
	local allModifiers = target:FindAllModifiers()
	for ____, modifier in ipairs(allModifiers) do
		do
			if modifier:GetName() ~= "modifier_generic_poison" then
				goto __continue21
			end
			stacks = stacks + modifier:GetStackCount()
		end
		::__continue21::
	end
	return stacks
end
modifier_item_0248 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0248)
____exports.modifier_item_0248 = modifier_item_0248
return ____exports