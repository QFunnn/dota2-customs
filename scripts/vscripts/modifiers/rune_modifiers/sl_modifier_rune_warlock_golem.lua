--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_warlock_golem.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_warlock_golem.lua",
	{
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:10",
		["15"] = "3:1",
		["16"] = "3:10",
		["17"] = "5:7",
		["18"] = "6:7",
		["20"] = "8:7",
		["24"] = "15:1",
		["25"] = "16:14",
		["26"] = "15:1",
		["27"] = "16:45",
		["29"] = "16:53",
		["30"] = "17:5",
		["31"] = "15:1",
		["32"] = "19:5",
		["33"] = "20:9",
		["34"] = "19:5",
		["35"] = "23:5",
		["36"] = "24:9",
		["37"] = "24:16",
		["38"] = "26:13",
		["39"] = "27:13",
		["40"] = "24:16",
		["41"] = "23:5",
		["42"] = "31:5",
		["43"] = "32:15",
		["44"] = "32:24",
		["45"] = "34:13",
		["46"] = "35:13",
		["47"] = "32:24",
		["48"] = "37:15",
		["49"] = "37:24",
		["50"] = "39:13",
		["51"] = "40:13",
		["52"] = "37:24",
		["53"] = "42:9",
		["54"] = "31:5",
		["55"] = "45:5",
		["56"] = "46:9",
		["57"] = "45:5",
		["58"] = "49:5",
		["59"] = "50:9",
		["60"] = "49:5",
		["61"] = "53:5",
		["62"] = "16:53",
		["63"] = "55:14",
		["66"] = "56:15",
		["67"] = "57:15",
		["68"] = "60:9",
		["69"] = "61:18",
		["70"] = "61:53",
		["72"] = "62:19",
		["73"] = "63:17",
		["74"] = "63:41",
		["76"] = "64:13",
		["77"] = "65:19",
		["78"] = "66:13",
		["79"] = "67:17",
		["80"] = "68:17",
		["81"] = "82:17",
		["82"] = "66:13",
		["83"] = "84:13",
		["84"] = "60:28",
		["85"] = "87:9",
		["86"] = "88:13",
		["87"] = "89:13",
		["88"] = "90:13",
		["89"] = "91:23",
		["90"] = "92:22",
		["93"] = "93:22",
		["96"] = "94:22",
		["97"] = "94:22",
		["98"] = "94:56",
		["99"] = "94:22",
		["102"] = "96:17",
		["103"] = "96:17",
		["104"] = "96:76",
		["105"] = "97:21",
		["106"] = "98:21",
		["107"] = "96:76",
		["108"] = "96:17",
		["109"] = "90:13",
		["110"] = "103:13",
		["111"] = "87:9",
		["112"] = "53:5",
		["113"] = "107:5",
		["114"] = "108:14",
		["117"] = "109:9",
		["118"] = "110:15",
		["119"] = "111:14",
		["122"] = "112:9",
		["123"] = "112:55",
		["124"] = "112:82",
		["125"] = "112:9",
		["126"] = "107:5",
		["127"] = "16:14",
		["128"] = "15:2",
		["129"] = "15:2",
		["130"] = "15:19",
		["131"] = "15:2",
		["133"] = "15:2",
		["134"] = "16:14",
		["136"] = "16:14",
		["138"] = "123:1",
		["139"] = "124:14",
		["140"] = "123:1",
		["141"] = "124:53",
		["143"] = "124:61",
		["144"] = "125:5",
		["145"] = "127:5",
		["146"] = "123:1",
		["147"] = "129:5",
		["148"] = "130:9",
		["149"] = "129:5",
		["150"] = "133:5",
		["151"] = "134:9",
		["152"] = "133:5",
		["153"] = "137:5",
		["154"] = "138:28",
		["156"] = "138:28",
		["158"] = "138:9",
		["159"] = "139:9",
		["160"] = "140:14",
		["163"] = "141:9",
		["164"] = "142:9",
		["165"] = "137:5",
		["166"] = "145:5",
		["167"] = "146:14",
		["170"] = "147:9",
		["171"] = "145:5",
		["172"] = "150:5",
		["173"] = "151:15",
		["174"] = "152:14",
		["177"] = "153:15",
		["178"] = "154:27",
		["179"] = "154:27",
		["180"] = "154:45",
		["182"] = "154:83",
		["184"] = "154:15",
		["185"] = "155:15",
		["186"] = "156:13",
		["189"] = "157:9",
		["190"] = "158:9",
		["191"] = "160:9",
		["192"] = "160:9",
		["193"] = "160:9",
		["195"] = "150:5",
		["196"] = "163:5",
		["197"] = "164:15",
		["198"] = "165:15",
		["199"] = "166:13",
		["200"] = "166:85",
		["202"] = "167:13",
		["203"] = "167:73",
		["205"] = "168:9",
		["206"] = "163:5",
		["207"] = "171:5",
		["208"] = "172:15",
		["209"] = "173:15",
		["210"] = "174:15",
		["211"] = "175:13",
		["212"] = "176:13",
		["214"] = "178:13",
		["215"] = "179:13",
		["217"] = "181:9",
		["218"] = "171:5",
		["219"] = "184:5",
		["220"] = "185:9",
		["221"] = "186:9",
		["222"] = "184:5",
		["223"] = "189:5",
		["224"] = "190:9",
		["225"] = "189:5",
		["226"] = "124:14",
		["227"] = "123:2",
		["228"] = "123:2",
		["229"] = "123:19",
		["230"] = "123:2",
		["232"] = "123:2",
		["233"] = "124:14",
		["235"] = "124:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
local ABILITY_FLAMING_FISTS = "warlock_golem_flaming_fists"
local ABILITY_PERMANENT_IMMOLATION = "warlock_golem_permanent_immolation"
--- 烈焰之拳被动 modifier：改 damage KV 后需 ForceRefresh 才会吃到新值
local MODIFIER_FLAMING_FISTS = "modifier_warlock_golem_flaming_fists"
--- 每点智力提升{amp_per_int}%技能增强，每点智力或力量提升{hp_per_int_str}生命值<br>
-- 地狱火继承术士{golem_hp_inherit_pct}%生命值（AbilityAmp 加算 golem_hp）；
-- 烈焰之拳 / 永久献祭各自 + 最大生命值×{dmg_hp_pct}% 伤害（先计入英雄技能增强后覆写技能 KV，每秒重算）
____exports.sl_modifier_rune_warlock_golem = __TS__Class()
local sl_modifier_rune_warlock_golem = ____exports.sl_modifier_rune_warlock_golem
sl_modifier_rune_warlock_golem.name = "sl_modifier_rune_warlock_golem"
__TS__ClassExtends(sl_modifier_rune_warlock_golem, sl_modifier_rune_base)
function sl_modifier_rune_warlock_golem.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._record_hp = -1
end
function sl_modifier_rune_warlock_golem.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function sl_modifier_rune_warlock_golem.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_warlock_golem.prototype.GetModifierHealthBonus(self)
	local int_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_int_str")
		end
	)
	local str_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_int_str")
		end
	)
	return int_hp + str_hp
end
function sl_modifier_rune_warlock_golem.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("golem_hp_inherit_pct")
end
function sl_modifier_rune_warlock_golem.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("dmg_hp_pct")
end
function sl_modifier_rune_warlock_golem.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local golem_hp_inherit_pct = self:_GetRuneSpecialValue("golem_hp_inherit_pct")
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValid(parent) then
			return nil
		end
		local hp = parent:GetMaxHealth()
		if hp == self._record_hp then
			return 1
		end
		self._record_hp = hp
		local bonus = hp * golem_hp_inherit_pct / 100
		SLModules.AbilityAmp:SetAbilityAmpBySource(
			parent:GetPlayerOwnerID(),
			{
				warlock_rain_of_chaos = {
					golem_hp = { b = { all_level_values = bonus } },
					golem_hp_scepter = { b = { all_level_values = bonus } },
				},
			},
			tostring(self)
		)
		return 1
	end)
	LocalEvents:Register(tostring(self), "unit_spawn", function(____, event)
		local unit = event.unit
		if not IsValid(unit) or unit:IsHero() then
			return
		end
		if not IsValid(parent) or unit:GetOwner() ~= parent then
			return
		end
		if not __TS__ArrayIncludes(WARLOCK_GOLEM_UNIT_NAMES, unit:GetUnitName()) then
			return
		end
		unit:AddSLModifier(____exports.sl_modifier_rune_warlock_golem_ability, {
			caster = parent,
			modifierTable = { dmg_hp_pct = self:_GetRuneSpecialValue("dmg_hp_pct") },
		})
	end, self)
end
function sl_modifier_rune_warlock_golem.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	LocalEvents:Remove("unit_spawn", self)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	SLModules.AbilityAmp:RemoveAbilityAmpBySource(parent:GetPlayerOwnerID(), tostring(self))
end
sl_modifier_rune_warlock_golem = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_golem", nil, getfenv()) },
	sl_modifier_rune_warlock_golem
)
____exports.sl_modifier_rune_warlock_golem = sl_modifier_rune_warlock_golem
--- 地狱火技能 KV 覆写：每秒按主人技能增强重算额外伤害，写入烈焰之拳 damage / 永久献祭 aura_damage
____exports.sl_modifier_rune_warlock_golem_ability = __TS__Class()
local sl_modifier_rune_warlock_golem_ability = ____exports.sl_modifier_rune_warlock_golem_ability
sl_modifier_rune_warlock_golem_ability.name = "sl_modifier_rune_warlock_golem_ability"
__TS__ClassExtends(sl_modifier_rune_warlock_golem_ability, SLModifierBase)
function sl_modifier_rune_warlock_golem_ability.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._dmg_hp_pct = 0
	self._bonus_damage = 0
end
function sl_modifier_rune_warlock_golem_ability.prototype.IsHidden(self)
	return true
end
function sl_modifier_rune_warlock_golem_ability.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL, MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE }
end
function sl_modifier_rune_warlock_golem_ability.prototype.OnCreated(self, params)
	local ____params_dmg_hp_pct_0 = params.dmg_hp_pct
	if ____params_dmg_hp_pct_0 == nil then
		____params_dmg_hp_pct_0 = 0
	end
	self._dmg_hp_pct = ____params_dmg_hp_pct_0
	self:SetHasCustomTransmitterData(true)
	if not IsServer() then
		return
	end
	self:_RecalcBonusDamage()
	self:StartIntervalThink(1)
end
function sl_modifier_rune_warlock_golem_ability.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:_RecalcBonusDamage()
end
function sl_modifier_rune_warlock_golem_ability.prototype._RecalcBonusDamage(self)
	local golem = self:GetParent()
	if not IsValidAlive(golem) then
		return
	end
	local caster = self:GetCaster()
	local ____IsValid_result_1
	if IsValid(caster) then
		____IsValid_result_1 = caster:GetSpellAmplification(false)
	else
		____IsValid_result_1 = 0
	end
	local spell_amp = ____IsValid_result_1
	local next_bonus = golem:GetMaxHealth() * (self._dmg_hp_pct / 100) * (1 + spell_amp)
	if next_bonus == self._bonus_damage then
		return
	end
	self._bonus_damage = next_bonus
	self:SendBuffRefreshToClients()
	local ____golem_FindModifierByName_result_ForceRefresh_result_2 = golem:FindModifierByName(MODIFIER_FLAMING_FISTS)
	if ____golem_FindModifierByName_result_ForceRefresh_result_2 ~= nil then
		____golem_FindModifierByName_result_ForceRefresh_result_2 =
			____golem_FindModifierByName_result_ForceRefresh_result_2:ForceRefresh()
	end
end
function sl_modifier_rune_warlock_golem_ability.prototype.GetModifierOverrideAbilitySpecial(self, event)
	local ability_name = event.ability:GetAbilityName()
	local key = event.ability_special_value
	if ability_name == ABILITY_PERMANENT_IMMOLATION and key == "aura_damage" then
		return 1
	end
	if ability_name == ABILITY_FLAMING_FISTS and key == "damage" then
		return 1
	end
	return 0
end
function sl_modifier_rune_warlock_golem_ability.prototype.GetModifierOverrideAbilitySpecialValue(self, event)
	local ability = event.ability
	local original = ability:GetLevelSpecialValueNoOverride(event.ability_special_value, event.ability_special_level)
	local ability_name = ability:GetAbilityName()
	if ability_name == ABILITY_PERMANENT_IMMOLATION and event.ability_special_value == "aura_damage" then
		return original + self._bonus_damage
	end
	if ability_name == ABILITY_FLAMING_FISTS and event.ability_special_value == "damage" then
		return original + self._bonus_damage
	end
	return original
end
function sl_modifier_rune_warlock_golem_ability.prototype.HandleCustomTransmitterData(self, data)
	self._bonus_damage = data.bonus_damage
	self._dmg_hp_pct = data.dmg_hp_pct
end
function sl_modifier_rune_warlock_golem_ability.prototype.AddCustomTransmitterData(self)
	return { bonus_damage = self._bonus_damage, dmg_hp_pct = self._dmg_hp_pct }
end
sl_modifier_rune_warlock_golem_ability = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_golem", nil, getfenv()) },
	sl_modifier_rune_warlock_golem_ability
)
____exports.sl_modifier_rune_warlock_golem_ability = sl_modifier_rune_warlock_golem_ability
return ____exports