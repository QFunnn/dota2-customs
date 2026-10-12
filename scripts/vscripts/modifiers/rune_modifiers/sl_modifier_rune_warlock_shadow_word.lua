--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_warlock_shadow_word.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_warlock_shadow_word.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["16"] = "8:1",
		["17"] = "9:14",
		["18"] = "8:1",
		["19"] = "9:51",
		["21"] = "9:59",
		["22"] = "10:5",
		["23"] = "11:5",
		["24"] = "8:1",
		["25"] = "13:5",
		["26"] = "14:9",
		["27"] = "13:5",
		["28"] = "17:5",
		["29"] = "18:9",
		["30"] = "18:16",
		["31"] = "20:13",
		["32"] = "21:13",
		["33"] = "18:16",
		["34"] = "17:5",
		["35"] = "25:5",
		["36"] = "26:15",
		["37"] = "26:24",
		["38"] = "28:13",
		["39"] = "29:13",
		["40"] = "26:24",
		["41"] = "31:15",
		["42"] = "31:24",
		["43"] = "33:13",
		["44"] = "34:13",
		["45"] = "31:24",
		["46"] = "36:9",
		["47"] = "25:5",
		["48"] = "39:5",
		["49"] = "40:9",
		["50"] = "39:5",
		["51"] = "43:5",
		["52"] = "9:59",
		["53"] = "45:14",
		["56"] = "46:15",
		["57"] = "47:14",
		["60"] = "48:15",
		["61"] = "50:9",
		["62"] = "51:13",
		["63"] = "52:13",
		["64"] = "53:13",
		["65"] = "54:21",
		["68"] = "55:55",
		["69"] = "55:25",
		["70"] = "55:35",
		["71"] = "55:46",
		["72"] = "56:21",
		["75"] = "57:21",
		["78"] = "58:23",
		["79"] = "59:21",
		["82"] = "60:17",
		["83"] = "61:17",
		["84"] = "63:29",
		["85"] = "65:34",
		["87"] = "65:34",
		["89"] = "61:17",
		["90"] = "62:21",
		["91"] = "63:21",
		["92"] = "64:21",
		["93"] = "65:21",
		["94"] = "66:21",
		["95"] = "61:29",
		["96"] = "68:17",
		["97"] = "53:13",
		["98"] = "70:13",
		["99"] = "71:13",
		["100"] = "50:9",
		["101"] = "74:9",
		["102"] = "75:13",
		["103"] = "76:13",
		["104"] = "77:13",
		["105"] = "78:21",
		["108"] = "79:51",
		["109"] = "79:25",
		["110"] = "79:31",
		["111"] = "79:42",
		["112"] = "80:21",
		["114"] = "80:68",
		["116"] = "80:68",
		["118"] = "80:21",
		["120"] = "80:21",
		["123"] = "81:21",
		["126"] = "82:21",
		["129"] = "83:23",
		["130"] = "84:21",
		["133"] = "85:17",
		["134"] = "86:17",
		["135"] = "91:17",
		["136"] = "77:13",
		["137"] = "93:13",
		["138"] = "94:13",
		["139"] = "74:9",
		["140"] = "43:5",
		["141"] = "99:5",
		["142"] = "100:15",
		["143"] = "101:13",
		["144"] = "101:31",
		["146"] = "102:15",
		["147"] = "103:26",
		["148"] = "103:26",
		["149"] = "103:46",
		["151"] = "103:62",
		["153"] = "103:15",
		["154"] = "104:9",
		["155"] = "99:5",
		["156"] = "107:5",
		["157"] = "108:14",
		["160"] = "109:15",
		["161"] = "110:14",
		["164"] = "111:15",
		["165"] = "112:9",
		["166"] = "113:9",
		["167"] = "107:5",
		["168"] = "9:14",
		["169"] = "8:2",
		["170"] = "8:2",
		["171"] = "8:19",
		["172"] = "8:2",
		["174"] = "8:2",
		["175"] = "9:14",
		["177"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强，每点智力或力量提升{hp_per_int_str}生命值<br>
-- 暗言术每秒额外治疗或伤害目标最大生命值的{heal_dmg_hp}%（监听 apply_damage / apply_heal 追加，不改技能 KV）
____exports.sl_modifier_rune_warlock_shadow_word = __TS__Class()
local sl_modifier_rune_warlock_shadow_word = ____exports.sl_modifier_rune_warlock_shadow_word
sl_modifier_rune_warlock_shadow_word.name = "sl_modifier_rune_warlock_shadow_word"
__TS__ClassExtends(sl_modifier_rune_warlock_shadow_word, sl_modifier_rune_base)
function sl_modifier_rune_warlock_shadow_word.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._applying_extra_damage = false
	self._applying_extra_heal = false
end
function sl_modifier_rune_warlock_shadow_word.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_rune_warlock_shadow_word.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_warlock_shadow_word.prototype.GetModifierHealthBonus(self)
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
function sl_modifier_rune_warlock_shadow_word.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("heal_dmg_hp")
end
function sl_modifier_rune_warlock_shadow_word.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local ent = parent:GetEntityIndex()
	LocalEvents:Register(tostring(self), "apply_damage", function(____, event)
		if self._applying_extra_damage then
			return
		end
		local ____event_0 = event
		local attacker = ____event_0.attacker
		local inflictor = ____event_0.inflictor
		local unit = ____event_0.unit
		if attacker ~= parent or not IsValid(inflictor) or not IsValidAlive(unit) then
			return
		end
		if inflictor:GetAbilityName() ~= "warlock_shadow_word" then
			return
		end
		local amount = self:_CalcExtraAmount(unit, inflictor)
		if amount <= 0 then
			return
		end
		self._applying_extra_damage = true
		local ____ApplyDamage_3 = ApplyDamage
		local ____unit_2 = unit
		local ____event_damage_type_1 = event.damage_type
		if ____event_damage_type_1 == nil then
			____event_damage_type_1 = DAMAGE_TYPE_MAGICAL
		end
		____ApplyDamage_3({
			attacker = parent,
			victim = ____unit_2,
			damage = amount,
			damage_type = ____event_damage_type_1,
			ability = inflictor,
		})
		self._applying_extra_damage = false
	end, self, ent)
	LocalEvents:Register(tostring(self), "apply_heal", function(____, event)
		if self._applying_extra_heal then
			return
		end
		local ____event_4 = event
		local unit = ____event_4.unit
		local inflictor = ____event_4.inflictor
		local gain = ____event_4.gain
		local ____temp_6 = not IsValid(inflictor) or not IsValidAlive(unit)
		if not ____temp_6 then
			local ____gain_5 = gain
			if ____gain_5 == nil then
				____gain_5 = 0
			end
			____temp_6 = ____gain_5 <= 0
		end
		if ____temp_6 then
			return
		end
		if inflictor:GetAbilityName() ~= "warlock_shadow_word" then
			return
		end
		if inflictor:GetCaster() ~= parent then
			return
		end
		local amount = self:_CalcExtraAmount(unit, inflictor)
		if amount <= 0 then
			return
		end
		self._applying_extra_heal = true
		CustomHeal(unit, amount, { source = parent, inflictor = inflictor, particle_path = "" })
		self._applying_extra_heal = false
	end, self, ent)
end
function sl_modifier_rune_warlock_shadow_word.prototype._CalcExtraAmount(self, target, ability)
	local heal_dmg_hp = self:_GetRuneSpecialValue("heal_dmg_hp")
	if heal_dmg_hp <= 0 then
		return 0
	end
	local tick_interval = ability:GetSpecialValueFor("tick_interval")
	local ____temp_7
	if tick_interval > 0 then
		____temp_7 = tick_interval
	else
		____temp_7 = 0.5
	end
	local interval = ____temp_7
	return target:GetMaxHealth() * heal_dmg_hp * interval / 100
end
function sl_modifier_rune_warlock_shadow_word.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local ent = parent:GetEntityIndex()
	LocalEvents:Remove("apply_damage", self, ent)
	LocalEvents:Remove("apply_heal", self, ent)
end
sl_modifier_rune_warlock_shadow_word = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_shadow_word", nil, getfenv()) },
	sl_modifier_rune_warlock_shadow_word
)
____exports.sl_modifier_rune_warlock_shadow_word = sl_modifier_rune_warlock_shadow_word
return ____exports