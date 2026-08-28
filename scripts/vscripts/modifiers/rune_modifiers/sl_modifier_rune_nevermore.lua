--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 影魂唤傀（necromastery）灵魂层数上限的兜底值（未取到技能特殊值时使用）
local NEVERMORE_DEFAULT_MAX_SOULS = 20
local NEVERMORE_NECROMASTERY_STACKS_MODIFIER = "modifier_nevermore_necromastery_stacks"
--- 恐惧期间重新下达逃跑指令的间隔
local NEVERMORE_FEAR_ORDER_INTERVAL = 0.2
--- 恐惧每次下达逃跑指令的距离
local NEVERMORE_FEAR_ORDER_DISTANCE = 300
--- 服务端同步灵魂层数到客户端的间隔
local NEVERMORE_SOUL_SYNC_INTERVAL = 0.1
local NEVERMORE_SHADOWRAZE_ABILITIES =
	{ nevermore_shadowraze1 = true, nevermore_shadowraze2 = true, nevermore_shadowraze3 = true }
--- 每点力量提升{hp_per_str}生命值，每点敏捷提升{batk_per_agi}基础攻击力，每点智力提升{amp_per_int}%技能增强<br>
-- 每个灵魂提供{jnzq}%技能增强；灵魂满层时，毁灭阴影消耗{soul}个灵魂并恐惧敌人{fear}秒，恐惧中心为影压中心
____exports.sl_modifier_rune_nevermore = __TS__Class()
local sl_modifier_rune_nevermore = ____exports.sl_modifier_rune_nevermore
sl_modifier_rune_nevermore.name = "sl_modifier_rune_nevermore"
__TS__ClassExtends(sl_modifier_rune_nevermore, sl_modifier_rune_base)
function sl_modifier_rune_nevermore.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._soul_count = 0
end
function sl_modifier_rune_nevermore.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function sl_modifier_rune_nevermore.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_nevermore.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_nevermore.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local int_amp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
	return int_amp + self._soul_count * self:_GetRuneSpecialValue("jnzq")
end
function sl_modifier_rune_nevermore.prototype._GetSoulCountServer(self)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return 0
	end
	local necromastery = self:_FindNecromasterySoulModifier(parent)
	local ____IsValid_result_0
	if IsValid(necromastery) then
		____IsValid_result_0 = necromastery:GetStackCount()
	else
		____IsValid_result_0 = 0
	end
	return ____IsValid_result_0
end
function sl_modifier_rune_nevermore.prototype._FindNecromasterySoulModifier(self, parent)
	local primary = parent:FindModifierByName("modifier_nevermore_necromastery")
	local stacks = parent:FindModifierByName(NEVERMORE_NECROMASTERY_STACKS_MODIFIER)
	if not IsValid(primary) then
		local ____IsValid_result_1
		if IsValid(stacks) then
			____IsValid_result_1 = stacks
		else
			____IsValid_result_1 = nil
		end
		return ____IsValid_result_1
	end
	if not IsValid(stacks) then
		return primary
	end
	local ____temp_2
	if stacks:GetStackCount() > primary:GetStackCount() then
		____temp_2 = stacks
	else
		____temp_2 = primary
	end
	return ____temp_2
end
function sl_modifier_rune_nevermore.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("jnzq")
end
function sl_modifier_rune_nevermore.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("fear")
end
function sl_modifier_rune_nevermore.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	self:StartIntervalThink(NEVERMORE_SOUL_SYNC_INTERVAL)
	self:OnIntervalThink()
	LocalEvents:Register(tostring(self), "ability_fully_cast", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or not NEVERMORE_SHADOWRAZE_ABILITIES[ability:GetAbilityName()] then
			return
		end
		self:_OnShadowraze(parent, ability)
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_nevermore.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local soul_count = self:_GetSoulCountServer()
	if soul_count == self._soul_count then
		return
	end
	self._soul_count = soul_count
	self:SendBuffRefreshToClients()
end
function sl_modifier_rune_nevermore.prototype._OnShadowraze(self, parent, ability)
	local necro_modifier = self:_FindNecromasterySoulModifier(parent)
	if not IsValid(necro_modifier) then
		return
	end
	local necromastery = parent:FindAbilityByName("nevermore_necromastery")
	local ____IsValid_result_3
	if IsValid(necromastery) then
		____IsValid_result_3 = necromastery:GetSpecialValueFor("necromastery_max_souls")
	else
		____IsValid_result_3 = NEVERMORE_DEFAULT_MAX_SOULS
	end
	local max_souls = ____IsValid_result_3
	local stack = necro_modifier:GetStackCount()
	if stack < max_souls then
		return
	end
	local soul = self:_GetRuneSpecialValue("soul")
	if soul <= 0 then
		return
	end
	necro_modifier:SetStackCount(math.max(0, stack - soul))
	self._soul_count = necro_modifier:GetStackCount()
	self:SendBuffRefreshToClients()
	local fear = self:_GetRuneSpecialValue("fear")
	if fear <= 0 then
		return
	end
	local raze_range = ability:GetSpecialValueFor("shadowraze_range")
	local raze_radius = ability:GetSpecialValueFor("shadowraze_radius")
	local center = parent:GetAbsOrigin() + parent:GetForwardVector() * raze_range
	local ____FindUnitsInRadius_6 = FindUnitsInRadius
	local ____temp_5 = parent:GetTeam()
	local ____temp_4
	if raze_radius > 0 then
		____temp_4 = raze_radius
	else
		____temp_4 = 250
	end
	local enemies = ____FindUnitsInRadius_6(
		____temp_5,
		center,
		nil,
		____temp_4,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if enemy:IsMagicImmune() then
				goto __continue29
			end
			enemy:AddSLModifier(____exports.sl_modifier_rune_nevermore_fear, {
				caster = parent,
				ability = ability,
				duration = fear,
				calculate_status_resistance = true,
				no_error = true,
				modifierTable = { center_x = center.x, center_y = center.y, center_z = center.z },
			})
		end
		::__continue29::
	end
end
function sl_modifier_rune_nevermore.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		LocalEvents:Remove("ability_fully_cast", self, parent:GetEntityIndex())
	end
end
function sl_modifier_rune_nevermore.prototype.HandleCustomTransmitterData(self, data)
	sl_modifier_rune_base.prototype.HandleCustomTransmitterData(self, data)
	local ____data_soul_count_7 = data
	if ____data_soul_count_7 ~= nil then
		____data_soul_count_7 = ____data_soul_count_7.soul_count
	end
	local ____data_soul_count_7_9 = ____data_soul_count_7
	if ____data_soul_count_7_9 == nil then
		____data_soul_count_7_9 = 0
	end
	self._soul_count = ____data_soul_count_7_9
end
function sl_modifier_rune_nevermore.prototype.AddCustomTransmitterData(self)
	return __TS__ObjectAssign(
		{},
		sl_modifier_rune_base.prototype.AddCustomTransmitterData(self),
		{ soul_count = self._soul_count }
	)
end
sl_modifier_rune_nevermore = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_nevermore") },
	sl_modifier_rune_nevermore
)
____exports.sl_modifier_rune_nevermore = sl_modifier_rune_nevermore
--- 满魂影压恐惧<br>
-- MODIFIER_STATE_FEARED 只是把单位标记为「被恐惧」，逃跑位移要自己驱动，
-- 因此这里每 {@link NEVERMORE_FEAR_ORDER_INTERVAL} 秒朝背离影压落点的方向重新下达一次移动指令
____exports.sl_modifier_rune_nevermore_fear = __TS__Class()
local sl_modifier_rune_nevermore_fear = ____exports.sl_modifier_rune_nevermore_fear
sl_modifier_rune_nevermore_fear.name = "sl_modifier_rune_nevermore_fear"
__TS__ClassExtends(sl_modifier_rune_nevermore_fear, SLModifierBase_Debuff)
function sl_modifier_rune_nevermore_fear.prototype.IsHidden(self)
	return false
end
function sl_modifier_rune_nevermore_fear.prototype.CheckState(self)
	return { [MODIFIER_STATE_FEARED] = true, [MODIFIER_STATE_COMMAND_RESTRICTED] = true }
end
function sl_modifier_rune_nevermore_fear.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:_StartFleeing(params)
end
function sl_modifier_rune_nevermore_fear.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_StartFleeing(params)
end
function sl_modifier_rune_nevermore_fear.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	local away_direction = SLVector:Normalized2D(origin:__sub(self._fear_center))
	parent:MoveToPosition(origin:__add(away_direction:__mul(NEVERMORE_FEAR_ORDER_DISTANCE)))
end
function sl_modifier_rune_nevermore_fear.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValidAlive(parent) then
		parent:Stop()
	end
end
function sl_modifier_rune_nevermore_fear.prototype._StartFleeing(self, params)
	self._fear_center = self:_ReadFearCenter(params)
	self:StartIntervalThink(NEVERMORE_FEAR_ORDER_INTERVAL)
	self:OnIntervalThink()
end
function sl_modifier_rune_nevermore_fear.prototype._ReadFearCenter(self, params)
	local ____params_center_x_10 = params
	if ____params_center_x_10 ~= nil then
		____params_center_x_10 = ____params_center_x_10.center_x
	end
	if ____params_center_x_10 ~= nil and params.center_y ~= nil then
		local ____params_center_x_13 = params.center_x
		local ____params_center_y_14 = params.center_y
		local ____params_center_z_12 = params.center_z
		if ____params_center_z_12 == nil then
			____params_center_z_12 = 0
		end
		return Vector(____params_center_x_13, ____params_center_y_14, ____params_center_z_12)
	end
	local caster = self:GetCaster()
	local ____IsValid_result_15
	if IsValid(caster) then
		____IsValid_result_15 = caster:GetAbsOrigin()
	else
		____IsValid_result_15 = self:GetParent():GetAbsOrigin()
	end
	return ____IsValid_result_15
end
sl_modifier_rune_nevermore_fear = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_nevermore") },
	sl_modifier_rune_nevermore_fear
)
____exports.sl_modifier_rune_nevermore_fear = sl_modifier_rune_nevermore_fear
return ____exports