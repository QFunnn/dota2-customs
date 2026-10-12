--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_furion_full.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_furion_full.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "3:1",
		["15"] = "3:10",
		["19"] = "10:1",
		["20"] = "11:14",
		["21"] = "10:1",
		["22"] = "11:43",
		["24"] = "11:51",
		["25"] = "12:5",
		["26"] = "14:5",
		["27"] = "10:1",
		["28"] = "16:5",
		["29"] = "17:9",
		["30"] = "17:16",
		["31"] = "17:16",
		["32"] = "17:16",
		["33"] = "17:16",
		["35"] = "17:16",
		["36"] = "16:5",
		["37"] = "26:5",
		["38"] = "27:9",
		["39"] = "27:16",
		["40"] = "29:13",
		["41"] = "30:13",
		["42"] = "27:16",
		["43"] = "26:5",
		["44"] = "34:5",
		["45"] = "35:15",
		["46"] = "35:25",
		["47"] = "37:13",
		["48"] = "38:13",
		["49"] = "35:25",
		["50"] = "40:15",
		["51"] = "40:25",
		["52"] = "42:13",
		["53"] = "43:13",
		["54"] = "40:25",
		["55"] = "45:9",
		["56"] = "34:5",
		["57"] = "48:5",
		["58"] = "49:13",
		["59"] = "49:13",
		["60"] = "49:13",
		["62"] = "49:13",
		["63"] = "49:13",
		["64"] = "49:13",
		["66"] = "49:13",
		["67"] = "50:13",
		["69"] = "52:9",
		["70"] = "48:5",
		["71"] = "55:5",
		["72"] = "56:9",
		["73"] = "55:5",
		["74"] = "59:5",
		["75"] = "60:9",
		["76"] = "59:5",
		["77"] = "63:5",
		["78"] = "11:51",
		["79"] = "65:14",
		["82"] = "66:15",
		["83"] = "67:14",
		["86"] = "68:15",
		["87"] = "69:9",
		["88"] = "70:18",
		["89"] = "70:53",
		["91"] = "71:19",
		["92"] = "72:17",
		["93"] = "72:41",
		["95"] = "73:13",
		["96"] = "74:19",
		["97"] = "75:19",
		["98"] = "76:13",
		["99"] = "77:17",
		["100"] = "77:43",
		["101"] = "77:59",
		["102"] = "77:70",
		["103"] = "77:17",
		["105"] = "79:13",
		["106"] = "69:28",
		["107"] = "83:9",
		["108"] = "84:13",
		["109"] = "85:13",
		["110"] = "86:13",
		["111"] = "87:46",
		["112"] = "87:25",
		["113"] = "87:31",
		["114"] = "88:21",
		["117"] = "89:21",
		["120"] = "90:23",
		["121"] = "91:22",
		["124"] = "93:17",
		["125"] = "94:17",
		["126"] = "99:17",
		["127"] = "99:36",
		["128"] = "99:42",
		["129"] = "100:26",
		["130"] = "100:61",
		["132"] = "101:26",
		["133"] = "102:25",
		["134"] = "103:25",
		["136"] = "105:21",
		["137"] = "99:42",
		["138"] = "99:17",
		["139"] = "86:13",
		["140"] = "108:13",
		["141"] = "109:13",
		["142"] = "83:9",
		["143"] = "111:9",
		["144"] = "112:13",
		["145"] = "113:13",
		["146"] = "114:13",
		["147"] = "116:21",
		["150"] = "117:55",
		["151"] = "117:25",
		["152"] = "117:35",
		["153"] = "117:46",
		["154"] = "118:21",
		["157"] = "119:21",
		["160"] = "120:21",
		["163"] = "121:23",
		["164"] = "122:23",
		["165"] = "123:21",
		["166"] = "124:21",
		["167"] = "126:21",
		["168"] = "127:25",
		["169"] = "128:25",
		["170"] = "129:25",
		["171"] = "130:25",
		["172"] = "131:25",
		["173"] = "126:33",
		["174"] = "133:21",
		["176"] = "114:13",
		["177"] = "136:13",
		["178"] = "137:13",
		["179"] = "111:9",
		["180"] = "63:5",
		["181"] = "141:5",
		["182"] = "142:14",
		["185"] = "143:15",
		["186"] = "144:13",
		["187"] = "145:13",
		["188"] = "146:13",
		["189"] = "146:32",
		["190"] = "146:57",
		["191"] = "146:63",
		["192"] = "146:13",
		["193"] = "147:13",
		["194"] = "147:32",
		["195"] = "147:48",
		["196"] = "147:54",
		["197"] = "147:13",
		["198"] = "148:13",
		["200"] = "141:5",
		["201"] = "11:14",
		["202"] = "10:2",
		["203"] = "10:2",
		["204"] = "10:19",
		["205"] = "10:2",
		["207"] = "10:2",
		["208"] = "11:14",
		["210"] = "11:14",
		["212"] = "154:1",
		["213"] = "155:14",
		["214"] = "154:1",
		["215"] = "155:50",
		["216"] = "156:5",
		["217"] = "157:9",
		["218"] = "156:5",
		["219"] = "155:14",
		["220"] = "154:2",
		["221"] = "154:2",
		["222"] = "154:19",
		["223"] = "154:2",
		["225"] = "154:2",
		["226"] = "155:14",
		["228"] = "155:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_debuff_immune = ____sl_modifier_simple.sl_modifier_debuff_immune
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强，每点智力或敏捷提升{batk_per_int_agi}基础攻击力<br>
-- 召唤树人直接产生的小树人继承先知{hp_pct}%生命值（SetSummonAmp）；传送施法期间减益免疫<br>
-- 自然之怒附带自身攻击力×{atk_pct}%魔法伤害；对建筑伤害降低{building_damage_penalty_pct}%
____exports.sl_modifier_rune_furion_full = __TS__Class()
local sl_modifier_rune_furion_full = ____exports.sl_modifier_rune_furion_full
sl_modifier_rune_furion_full.name = "sl_modifier_rune_furion_full"
__TS__ClassExtends(sl_modifier_rune_furion_full, sl_modifier_rune_base)
function sl_modifier_rune_furion_full.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._record_hp = -1
	self._applying_extra_damage = false
end
function sl_modifier_rune_furion_full.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function sl_modifier_rune_furion_full.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_furion_full.prototype.GetModifierBaseAttack_BonusDamage(self)
	local int_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_int_agi")
		end
	)
	local agi_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_int_agi")
		end
	)
	return int_atk + agi_atk
end
function sl_modifier_rune_furion_full.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____event_target_2 = event
	if ____event_target_2 ~= nil then
		____event_target_2 = ____event_target_2.target
	end
	local ____event_target_IsBuilding_result_0 = ____event_target_2
	if ____event_target_IsBuilding_result_0 ~= nil then
		____event_target_IsBuilding_result_0 = ____event_target_IsBuilding_result_0:IsBuilding()
	end
	if ____event_target_IsBuilding_result_0 then
		return -self:_GetRuneSpecialValue("building_damage_penalty_pct")
	end
	return 0
end
function sl_modifier_rune_furion_full.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("atk_pct")
end
function sl_modifier_rune_furion_full.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("hp_pct")
end
function sl_modifier_rune_furion_full.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local hp_pct = self:_GetRuneSpecialValue("hp_pct")
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValid(parent) then
			return nil
		end
		local hp = parent:GetMaxHealth()
		if hp == self._record_hp then
			return 1
		end
		self._record_hp = hp
		local amp = { hp_bonus = hp * hp_pct / 100 }
		local attr_manager = GlobalAttrManager:Get(parent:GetPlayerOwnerID())
		for ____, unit_name in ipairs(FURION_SMALL_TREANT_UNIT_NAMES) do
			attr_manager:SetSummonAmp(tostring(self), unit_name, amp)
		end
		return 1
	end)
	LocalEvents:Register(tostring(self), "modifier_added_parent", function(____, event)
		local ____event_4 = event
		local unit = ____event_4.unit
		local added_buff = ____event_4.added_buff
		if unit ~= parent or not IsValid(added_buff) then
			return
		end
		if added_buff:GetName() ~= "modifier_teleporting" then
			return
		end
		local ability = added_buff:GetAbility()
		if not IsValid(ability) or ability:GetAbilityName() ~= "furion_teleportation" then
			return
		end
		parent:RemoveSLModifierByType(____exports.sl_modifier_rune_furion_full_immune, parent)
		parent:AddSLModifier(
			____exports.sl_modifier_rune_furion_full_immune,
			{ caster = parent, no_error = true, modifierTable = { update_data = 1 } }
		)
		Timers:CreateTimer(0.03, function()
			if not IsValid(self) or not IsValid(parent) then
				return nil
			end
			if not IsValid(added_buff) then
				parent:RemoveSLModifierByType(____exports.sl_modifier_rune_furion_full_immune, parent)
				return nil
			end
			return 0.03
		end)
	end, self, parent:GetEntityIndex())
	LocalEvents:Register(tostring(self), "apply_damage", function(____, event)
		if self._applying_extra_damage then
			return
		end
		local ____event_5 = event
		local attacker = ____event_5.attacker
		local inflictor = ____event_5.inflictor
		local unit = ____event_5.unit
		if attacker ~= parent or not IsValid(inflictor) or not IsValidAlive(unit) then
			return
		end
		if inflictor:GetAbilityName() ~= "furion_wrath_of_nature" then
			return
		end
		if unit:IsBuilding() then
			return
		end
		local atk_pct = self:_GetRuneSpecialValue("atk_pct")
		local damage = parent:GetAverageTrueAttackDamage(nil) * atk_pct * 0.01
		if damage > 0 then
			self._applying_extra_damage = true
			ApplyDamage({
				attacker = parent,
				victim = unit,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = inflictor,
			})
			self._applying_extra_damage = false
		end
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_furion_full.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(parent) then
		GlobalAttrManager:Get(parent:GetPlayerOwnerID()):RemoveAllSummonAmpBySource(tostring(self))
		LocalEvents:Remove("modifier_added_parent", self, parent:GetEntityIndex())
		LocalEvents:Remove("apply_damage", self, parent:GetEntityIndex())
		parent:RemoveSLModifierByType(____exports.sl_modifier_rune_furion_full_immune, parent)
	end
end
sl_modifier_rune_furion_full = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_furion_full", nil, getfenv()) },
	sl_modifier_rune_furion_full
)
____exports.sl_modifier_rune_furion_full = sl_modifier_rune_furion_full
--- 传送引导期间减益免疫（绑定 modifier_teleporting，通用特效）
____exports.sl_modifier_rune_furion_full_immune = __TS__Class()
local sl_modifier_rune_furion_full_immune = ____exports.sl_modifier_rune_furion_full_immune
sl_modifier_rune_furion_full_immune.name = "sl_modifier_rune_furion_full_immune"
__TS__ClassExtends(sl_modifier_rune_furion_full_immune, sl_modifier_debuff_immune)
function sl_modifier_rune_furion_full_immune.prototype.IsHidden(self)
	return true
end
sl_modifier_rune_furion_full_immune = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_furion_full", nil, getfenv()) },
	sl_modifier_rune_furion_full_immune
)
____exports.sl_modifier_rune_furion_full_immune = sl_modifier_rune_furion_full_immune
return ____exports