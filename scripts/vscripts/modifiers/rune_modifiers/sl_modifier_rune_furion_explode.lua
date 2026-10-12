--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_furion_explode.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_furion_explode.lua",
	{
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:10",
		["18"] = "9:1",
		["19"] = "10:14",
		["20"] = "9:1",
		["21"] = "10:46",
		["22"] = "11:5",
		["23"] = "12:9",
		["24"] = "11:5",
		["25"] = "15:5",
		["26"] = "16:9",
		["27"] = "16:16",
		["28"] = "18:13",
		["29"] = "19:13",
		["30"] = "16:16",
		["31"] = "15:5",
		["32"] = "23:5",
		["33"] = "24:15",
		["34"] = "24:24",
		["35"] = "26:13",
		["36"] = "27:13",
		["37"] = "24:24",
		["38"] = "29:15",
		["39"] = "29:24",
		["40"] = "31:13",
		["41"] = "32:13",
		["42"] = "29:24",
		["43"] = "34:9",
		["44"] = "23:5",
		["45"] = "37:5",
		["46"] = "38:9",
		["47"] = "37:5",
		["48"] = "41:5",
		["49"] = "42:9",
		["50"] = "41:5",
		["51"] = "45:5",
		["52"] = "10:54",
		["53"] = "47:14",
		["56"] = "48:9",
		["57"] = "49:13",
		["58"] = "50:13",
		["59"] = "51:13",
		["60"] = "52:23",
		["61"] = "53:22",
		["64"] = "54:23",
		["65"] = "55:22",
		["68"] = "56:23",
		["69"] = "57:22",
		["72"] = "58:23",
		["73"] = "59:23",
		["74"] = "60:23",
		["75"] = "61:23",
		["76"] = "62:23",
		["77"] = "63:17",
		["78"] = "63:36",
		["79"] = "63:53",
		["80"] = "64:26",
		["81"] = "64:43",
		["83"] = "65:27",
		["84"] = "70:25",
		["85"] = "71:25",
		["86"] = "72:25",
		["88"] = "74:21",
		["89"] = "75:27",
		["90"] = "76:27",
		["91"] = "77:25",
		["92"] = "78:25",
		["93"] = "79:25",
		["94"] = "80:25",
		["95"] = "76:37",
		["96"] = "76:37",
		["97"] = "76:37",
		["98"] = "76:37",
		["99"] = "85:25",
		["100"] = "76:37",
		["101"] = "87:27",
		["102"] = "88:21",
		["103"] = "89:25",
		["104"] = "90:29",
		["105"] = "91:29",
		["106"] = "92:29",
		["107"] = "93:29",
		["108"] = "94:29",
		["109"] = "95:29",
		["110"] = "89:37",
		["112"] = "98:21",
		["113"] = "63:53",
		["114"] = "63:17",
		["115"] = "51:13",
		["116"] = "101:13",
		["117"] = "48:9",
		["118"] = "45:5",
		["119"] = "105:5",
		["120"] = "106:14",
		["123"] = "107:9",
		["124"] = "105:5",
		["125"] = "10:14",
		["126"] = "9:2",
		["127"] = "9:2",
		["128"] = "9:19",
		["129"] = "9:2",
		["131"] = "9:2",
		["132"] = "10:14",
		["134"] = "10:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强，每点智力或力量提升{hp_per_int_str}生命值<br>
-- 召唤树人直接产生的小树人死亡或持续时间结束后，经过{explosion_delay}秒自爆，
-- 对{explosion_radius}码内敌人造成{explosion}×等级点魔法伤害（享受技能增强，不伤害建筑）
____exports.sl_modifier_rune_furion_explode = __TS__Class()
local sl_modifier_rune_furion_explode = ____exports.sl_modifier_rune_furion_explode
sl_modifier_rune_furion_explode.name = "sl_modifier_rune_furion_explode"
__TS__ClassExtends(sl_modifier_rune_furion_explode, sl_modifier_rune_base)
function sl_modifier_rune_furion_explode.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function sl_modifier_rune_furion_explode.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_furion_explode.prototype.GetModifierHealthBonus(self)
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
function sl_modifier_rune_furion_explode.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("explosion")
end
function sl_modifier_rune_furion_explode.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("explosion_radius")
end
function sl_modifier_rune_furion_explode.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	LocalEvents:Register(tostring(self), "unit_death", function(____, event)
		local unit = event.unit
		if not IsValid(unit) then
			return
		end
		local parent = self:GetParent()
		if not IsValid(parent) or unit:GetPlayerOwnerID() ~= parent:GetPlayerOwnerID() then
			return
		end
		local unit_name = unit:GetUnitName()
		if not __TS__ArrayIncludes(FURION_SMALL_TREANT_UNIT_NAMES, unit_name) then
			return
		end
		local explosion_delay = self:_GetRuneSpecialValue("explosion_delay")
		local explosion_radius = self:_GetRuneSpecialValue("explosion_radius")
		local explosion = self:_GetRuneSpecialValue("explosion")
		local pos = unit:GetAbsOrigin()
		local team = unit:GetTeam()
		Timers:CreateTimer(explosion_delay, function()
			if not IsValid(parent) then
				return nil
			end
			local pid = SParticleManager:CreateGenericParticle(
				GENERIC_PARTICLES.rune_furion_treant_explode,
				PATTACH_WORLDORIGIN,
				parent
			)
			if pid then
				SParticleManager:SetParticleControl(pid, 0, pos)
				SParticleManager:ReleaseParticleIndex(pid)
			end
			EmitSoundOnLocationWithCaster(pos, "rune_furion_treant_explode", parent)
			local damage = explosion * parent:GetLevel()
			local enemies = FindUnitsInRadius(
				team,
				pos,
				nil,
				explosion_radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			local inflictor = parent:FindAbilityByName("furion_force_of_nature")
			for ____, enemy in ipairs(enemies) do
				ApplyDamage({
					attacker = parent,
					victim = enemy,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = inflictor,
					damage_flags = DOTA_DAMAGE_FLAG_FORCE_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_NO_REFLECTION,
				})
			end
			return nil
		end)
	end, self)
end
function sl_modifier_rune_furion_explode.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	LocalEvents:Remove("unit_death", self)
end
sl_modifier_rune_furion_explode = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_furion_explode", nil, getfenv()) },
	sl_modifier_rune_furion_explode
)
____exports.sl_modifier_rune_furion_explode = sl_modifier_rune_furion_explode
return ____exports