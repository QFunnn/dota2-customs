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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
--- 敌人越多攻速越高，按周围敌人数动态叠加攻击速度。
____exports.item_0253 = __TS__Class()
local item_0253 = ____exports.item_0253
item_0253.name = "item_0253"
__TS__ClassExtends(item_0253, BaseItem_CS)
function item_0253.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0253.name
end
item_0253 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0253)
____exports.item_0253 = item_0253
____exports.modifier_item_0253 = __TS__Class()
local modifier_item_0253 = ____exports.modifier_item_0253
modifier_item_0253.name = "modifier_item_0253"
__TS__ClassExtends(modifier_item_0253, BaseModifier_CS)
function modifier_item_0253.GetLocalizationCN(self)
	return { name = "决斗", description = "根据敌方单位数量提升攻击速度。" }
end
function modifier_item_0253.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateEnemyCount(true)
	self:StartIntervalThink(1)
end
function modifier_item_0253.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateEnemyCount(false)
end
function modifier_item_0253.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_attack_speed_per_enemy")
	else
		____ability_0 = 0
	end
	local attackSpeedPerEnemy = ____ability_0
	local enemyStacks = math.max(0, self:GetStackCount())
	return { attack_speed = enemyStacks * attackSpeedPerEnemy }
end
function modifier_item_0253.prototype.IsHidden(self)
	return false
end
function modifier_item_0253.prototype.IsPurgable(self)
	return false
end
function modifier_item_0253.prototype.RecalculateEnemyCount(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local radius = ability:GetSpecialValueFor("ability_aura_radius")
	local enemies = __TS__ArrayFilter(
		FindUnitsInRadius(parent:GetTeamNumber(), parent:GetAbsOrigin(), nil, radius, 2, 19, 0, 0, false),
		function(____, unit)
			return IsValidAlive(nil, unit) and not unit:IsBuilding()
		end
	)
	local enemyCount = #enemies
	if not forceRefresh and enemyCount == self:GetStackCount() then
		return
	end
	self:SetStackCount(enemyCount)
	self:RefreshAttributes()
end
modifier_item_0253 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0253)
____exports.modifier_item_0253 = modifier_item_0253
return ____exports