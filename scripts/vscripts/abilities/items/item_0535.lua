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
local THINK_INTERVAL = 0.5
local BURNING_MODIFIER = "modifier_generic_burning"
____exports.item_0535 = __TS__Class()
local item_0535 = ____exports.item_0535
item_0535.name = "item_0535"
__TS__ClassExtends(item_0535, BaseItem_CS)
function item_0535.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("ability_radius")
end
function item_0535.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0535_blaze_bulwark.name
end
item_0535 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0535)
____exports.item_0535 = item_0535
____exports.modifier_item_0535_blaze_bulwark = __TS__Class()
local modifier_item_0535_blaze_bulwark = ____exports.modifier_item_0535_blaze_bulwark
modifier_item_0535_blaze_bulwark.name = "modifier_item_0535_blaze_bulwark"
__TS__ClassExtends(modifier_item_0535_blaze_bulwark, BaseModifier_CS)
function modifier_item_0535_blaze_bulwark.prototype.IsHidden(self)
	return true
end
function modifier_item_0535_blaze_bulwark.prototype.IsPurgable(self)
	return false
end
function modifier_item_0535_blaze_bulwark.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0535_blaze_bulwark.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0535_blaze_bulwark.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if not parent.GetCurrentEnergyShield or not parent.AddCurrentEnergyShield then
		return
	end
	local ____math_max_2 = math.max
	local ____opt_0 = parent.GetTotalEnergyShield
	local maxShield = ____math_max_2(
		0,
		____opt_0 and ____opt_0(parent) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	if maxShield <= 0 then
		return
	end
	local current = math.max(0, parent:GetCurrentEnergyShield())
	if current >= maxShield then
		return
	end
	local radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local burningWeight = self:CountBurningEnemyWeight(parent, ability, radius)
	if burningWeight <= 0 then
		return
	end
	local ability_value_shield_regen_pct_per_unit =
		math.max(0, ability:GetSpecialValueFor("ability_value_shield_regen_pct_per_unit"))
	local ability_shield_regen_max_pct = math.max(0, ability:GetSpecialValueFor("ability_value_shield_regen_max_pct"))
	local ability_regen_pct_per_second =
		math.min(ability_shield_regen_max_pct, ability_value_shield_regen_pct_per_unit * burningWeight)
	local restore = maxShield * (ability_regen_pct_per_second / 100) * THINK_INTERVAL
	if restore > 0 then
		parent:AddCurrentEnergyShield(restore)
	end
end
function modifier_item_0535_blaze_bulwark.prototype.CountBurningEnemyWeight(self, parent, ability, radius)
	if radius <= 0 then
		return 0
	end
	local ability_elite_count_weight = math.max(1, ability:GetSpecialValueFor("ability_elite_count_weight"))
	local ability_miniboss_count_weight = math.max(1, ability:GetSpecialValueFor("ability_miniboss_count_weight"))
	local ability_boss_count_weight = math.max(1, ability:GetSpecialValueFor("ability_boss_count_weight"))
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
	local count = 0
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue20
			end
			if not enemy:HasModifier(BURNING_MODIFIER) then
				goto __continue20
			end
			if enemy:IsBoss() then
				count = count + ability_boss_count_weight
			elseif enemy:IsMiniboss() then
				count = count + ability_miniboss_count_weight
			elseif enemy:IsElite() then
				count = count + ability_elite_count_weight
			else
				count = count + 1
			end
		end
		::__continue20::
	end
	return count
end
modifier_item_0535_blaze_bulwark = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0535_blaze_bulwark)
____exports.modifier_item_0535_blaze_bulwark = modifier_item_0535_blaze_bulwark
return ____exports