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
--- 额外目标搜索半径 = 攻击距离 + 该缓冲，避免边缘目标因距离取整漏发
local ITEM_0323_SEARCH_RANGE_BUFFER = 100
--- 冰冻状态本体 modifier（DebuffStatusManager 的 ICE_SLOW 施加）
local ITEM_0323_FROZEN_MODIFIER = "modifier_generic_slow"
____exports.item_0323 = __TS__Class()
local item_0323 = ____exports.item_0323
item_0323.name = "item_0323"
__TS__ClassExtends(item_0323, BaseItem_CS)
function item_0323.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0323_multishot.name
end
function item_0323.prototype.GetExtraTargetCount(self)
	return math.floor(self:GetSpecialValue("item_0323", "ability_value_extra_target_count"))
end
item_0323 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0323)
____exports.item_0323 = item_0323
--- 固有被动「多重箭 + 凝心聚射」：攻击时额外射箭；冰冻且仅剩主目标时全部聚射该目标。
____exports.modifier_item_0323_multishot = __TS__Class()
local modifier_item_0323_multishot = ____exports.modifier_item_0323_multishot
modifier_item_0323_multishot.name = "modifier_item_0323_multishot"
__TS__ClassExtends(modifier_item_0323_multishot, BaseModifier_CS)
function modifier_item_0323_multishot.GetLocalizationCN(self)
	return {
		name = "多重箭",
		description = "攻击时，向攻击范围内的其他敌人各额外射出一支箭矢（目标数由装备词条决定）。",
	}
end
function modifier_item_0323_multishot.prototype.IsHidden(self)
	return true
end
function modifier_item_0323_multishot.prototype.IsPurgable(self)
	return false
end
function modifier_item_0323_multishot.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK }
end
function modifier_item_0323_multishot.prototype.OnAttack_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	if not event.target or not IsValidAlive(nil, event.target) then
		return
	end
	local ____this_1
	____this_1 = event.target
	local ____opt_0 = ____this_1.GetUnitType
	local targetType = ____opt_0 and ____opt_0(____this_1)
	if targetType == UnitType.BUILDING or targetType == UnitType.DESTRUCTIBLE then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local extraCount = math.floor(ability:GetExtraTargetCount())
	if extraCount <= 0 then
		return
	end
	local searchRange = (MyGameAttribute:GetAttribute(parent, "total_attack_range") or 0)
		+ ITEM_0323_SEARCH_RANGE_BUFFER
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		searchRange,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local others = {}
	for ____, enemy in ipairs(enemies) do
		do
			if enemy == event.target or not IsValidAlive(nil, enemy) then
				goto __continue17
			end
			local ____opt_2 = enemy.GetUnitType
			local enemyType = ____opt_2 and ____opt_2(enemy)
			if enemyType == UnitType.BUILDING or enemyType == UnitType.DESTRUCTIBLE then
				goto __continue17
			end
			others[#others + 1] = enemy
		end
		::__continue17::
	end
	if #others <= 0 then
		if not parent:HasModifier(ITEM_0323_FROZEN_MODIFIER) then
			return
		end
		do
			local i = 0
			while i < extraCount do
				self:FireExtraArrow(parent, event.target)
				i = i + 1
			end
		end
		return
	end
	local fired = 0
	for ____, enemy in ipairs(others) do
		if fired >= extraCount then
			break
		end
		self:FireExtraArrow(parent, enemy)
		fired = fired + 1
	end
end
function modifier_item_0323_multishot.prototype.FireExtraArrow(self, parent, target)
	MyGameAttack:PerformAttack(parent, target, {
		use_projectile = parent:IsRangedAttacker(),
		is_sub_attack = true,
		disable_celled = true,
		use_effect = true,
		projectile_name = parent:GetRangedProjectileName(),
		extra_data = { custom_tag = "item_0323_multishot", source_name = "item_0323" },
	})
end
modifier_item_0323_multishot = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0323_multishot)
____exports.modifier_item_0323_multishot = modifier_item_0323_multishot
return ____exports