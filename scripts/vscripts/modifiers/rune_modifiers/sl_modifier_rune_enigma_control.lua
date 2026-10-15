--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_enigma_control.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_enigma_control.lua",
	{
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:10",
		["15"] = "4:7",
		["16"] = "5:7",
		["20"] = "12:1",
		["21"] = "13:14",
		["22"] = "12:1",
		["23"] = "13:46",
		["25"] = "13:54",
		["26"] = "15:5",
		["27"] = "12:1",
		["28"] = "18:5",
		["29"] = "19:9",
		["30"] = "18:5",
		["31"] = "22:5",
		["32"] = "23:15",
		["33"] = "23:24",
		["34"] = "25:13",
		["35"] = "26:13",
		["36"] = "23:24",
		["37"] = "28:15",
		["38"] = "28:24",
		["39"] = "30:13",
		["40"] = "31:13",
		["41"] = "28:24",
		["42"] = "33:9",
		["43"] = "22:5",
		["44"] = "36:5",
		["45"] = "37:9",
		["46"] = "36:5",
		["47"] = "40:5",
		["48"] = "41:9",
		["49"] = "40:5",
		["50"] = "44:5",
		["51"] = "13:54",
		["52"] = "46:14",
		["55"] = "47:15",
		["56"] = "48:14",
		["59"] = "50:9",
		["60"] = "51:9",
		["61"] = "51:53",
		["62"] = "51:83",
		["63"] = "53:22",
		["66"] = "54:21",
		["69"] = "55:23",
		["70"] = "56:23",
		["71"] = "57:23",
		["72"] = "58:23",
		["73"] = "59:17",
		["74"] = "60:21",
		["75"] = "61:21",
		["76"] = "62:21",
		["77"] = "63:21",
		["78"] = "64:21",
		["79"] = "65:21",
		["80"] = "59:29",
		["81"] = "67:21",
		["82"] = "68:21",
		["84"] = "52:20",
		["85"] = "51:9",
		["86"] = "78:9",
		["87"] = "79:13",
		["88"] = "80:13",
		["89"] = "81:13",
		["90"] = "82:23",
		["91"] = "83:22",
		["94"] = "84:22",
		["97"] = "85:22",
		["98"] = "85:22",
		["99"] = "85:50",
		["100"] = "85:22",
		["103"] = "86:23",
		["104"] = "87:22",
		["107"] = "88:17",
		["108"] = "81:13",
		["109"] = "90:13",
		["110"] = "78:9",
		["111"] = "92:9",
		["112"] = "93:13",
		["113"] = "94:13",
		["114"] = "95:13",
		["115"] = "96:23",
		["116"] = "97:22",
		["119"] = "98:17",
		["120"] = "95:13",
		["121"] = "100:13",
		["122"] = "101:13",
		["123"] = "92:9",
		["124"] = "103:9",
		["125"] = "104:13",
		["126"] = "105:13",
		["127"] = "106:13",
		["128"] = "107:22",
		["131"] = "108:23",
		["132"] = "109:22",
		["135"] = "110:23",
		["136"] = "111:22",
		["139"] = "112:21",
		["142"] = "113:23",
		["143"] = "114:21",
		["146"] = "115:17",
		["147"] = "116:23",
		["148"] = "117:21",
		["151"] = "118:17",
		["152"] = "106:13",
		["153"] = "127:13",
		["154"] = "128:13",
		["155"] = "103:9",
		["156"] = "44:5",
		["157"] = "132:5",
		["158"] = "133:15",
		["159"] = "134:14",
		["162"] = "135:9",
		["163"] = "136:13",
		["164"] = "137:13",
		["165"] = "138:13",
		["166"] = "139:13",
		["167"] = "140:13",
		["168"] = "141:13",
		["169"] = "142:13",
		["170"] = "135:102",
		["171"] = "132:5",
		["172"] = "146:5",
		["173"] = "147:14",
		["176"] = "148:13",
		["177"] = "149:13",
		["179"] = "151:9",
		["180"] = "152:15",
		["181"] = "153:13",
		["182"] = "154:19",
		["183"] = "155:13",
		["184"] = "156:13",
		["186"] = "146:5",
		["187"] = "13:14",
		["188"] = "12:2",
		["189"] = "12:2",
		["190"] = "12:19",
		["191"] = "12:2",
		["193"] = "12:2",
		["194"] = "13:14",
		["196"] = "13:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
local ENIGMA_CONTROL_PROJECTILE_SPEED = 900
local ENIGMA_CONTROL_LISTENER_PREFIX = "rune_enigma_control_"
--- 每点智力或力量提升{hp_per_int_str}生命值<br>
-- 虚灵被敌人击杀时向击杀者发射追踪投射物，命中后造成当前生命值{hps_pct}%魔法伤害并眩晕{stun}秒<br>
-- 敌人每次受到午夜凋零的首次伤害时眩晕{stun_mid}秒
____exports.sl_modifier_rune_enigma_control = __TS__Class()
local sl_modifier_rune_enigma_control = ____exports.sl_modifier_rune_enigma_control
sl_modifier_rune_enigma_control.name = "sl_modifier_rune_enigma_control"
__TS__ClassExtends(sl_modifier_rune_enigma_control, sl_modifier_rune_base)
function sl_modifier_rune_enigma_control.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._midnight_stunned = {}
end
function sl_modifier_rune_enigma_control.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_TOOLTIP, MODIFIER_PROPERTY_TOOLTIP2 }
end
function sl_modifier_rune_enigma_control.prototype.GetModifierHealthBonus(self)
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
function sl_modifier_rune_enigma_control.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("hps_pct")
end
function sl_modifier_rune_enigma_control.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("stun_mid")
end
function sl_modifier_rune_enigma_control.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	self._projectile_listener_id = ENIGMA_CONTROL_LISTENER_PREFIX .. tostring(self)
	SLModules.CustomProjectile:RegisterListener(self._projectile_listener_id, {
		OnHit = function(____, _source, target)
			if not IsValid(self) or not IsValid(parent) or not IsValidAlive(target) then
				return
			end
			if target:IsBuilding() or target:IsWard() then
				return
			end
			local hps_pct = self:_GetRuneSpecialValue("hps_pct")
			local stun = self:_GetRuneSpecialValue("stun")
			local damage = target:GetHealth() * hps_pct / 100
			local inflictor = parent:FindAbilityByName("enigma_demonic_conversion")
			ApplyDamage({
				attacker = parent,
				victim = target,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_NO_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
				ability = inflictor,
			})
			if stun > 0 and IsValidAlive(target) then
				target:AddSLModifier(
					"modifier_stunned",
					{ caster = parent, duration = stun, calculate_status_resistance = true, no_error = true }
				)
			end
		end,
	})
	LocalEvents:Register(tostring(self), "unit_death", function(____, event)
		local unit = event.unit
		if not IsValid(unit) then
			return
		end
		if not IsValid(parent) or unit:GetPlayerOwnerID() ~= parent:GetPlayerOwnerID() then
			return
		end
		if not __TS__StringIncludes(unit:GetUnitName(), "eidolon") then
			return
		end
		local killer = event.attacker
		if not IsValid(killer) or killer:GetTeam() == parent:GetTeam() then
			return
		end
		self:_OnEidolonDeath(parent, unit, killer)
	end, self)
	LocalEvents:Register(tostring(self), "ability_fully_cast", function(____, event)
		local ability = event.ability
		if not IsValid(ability) or ability:GetAbilityName() ~= "enigma_midnight_pulse" then
			return
		end
		self._midnight_stunned = {}
	end, self, parent:GetEntityIndex())
	LocalEvents:Register(tostring(self), "apply_damage", function(____, event)
		if not IsValid(parent) then
			return
		end
		local ability = event.inflictor
		if not IsValid(ability) or ability:GetAbilityName() ~= "enigma_midnight_pulse" then
			return
		end
		local target = event.unit
		if not IsValidAlive(target) or target:GetTeam() == parent:GetTeam() then
			return
		end
		if target:IsBuilding() or target:IsWard() then
			return
		end
		local ent = target:GetEntityIndex()
		if self._midnight_stunned[ent] then
			return
		end
		self._midnight_stunned[ent] = true
		local stun_mid = self:_GetRuneSpecialValue("stun_mid")
		if stun_mid <= 0 then
			return
		end
		target:AddSLModifier(
			"modifier_stunned",
			{ caster = parent, duration = stun_mid, calculate_status_resistance = true, no_error = true }
		)
	end, self, parent:GetEntityIndex())
end
function sl_modifier_rune_enigma_control.prototype._OnEidolonDeath(self, parent, eidolon, killer)
	local source_pos = eidolon:GetAbsOrigin()
	if not IsValidAlive(killer) then
		return
	end
	SLModules.CustomProjectile:CreateTrackingProjectileForListener(self._projectile_listener_id, {
		Source = eidolon,
		Target = killer,
		vSourceLoc = source_pos,
		EffectName = GENERIC_PARTICLES.rune_enigma_control_pjt,
		iMoveSpeed = ENIGMA_CONTROL_PROJECTILE_SPEED,
		bDodgeable = false,
		bVisibleToEnemies = true,
	})
end
function sl_modifier_rune_enigma_control.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._projectile_listener_id then
		SLModules.CustomProjectile:UnregisterListener(self._projectile_listener_id)
	end
	LocalEvents:Remove("unit_death", self)
	local parent = self:GetParent()
	if IsValid(parent) then
		local ent = parent:GetEntityIndex()
		LocalEvents:Remove("ability_fully_cast", self, ent)
		LocalEvents:Remove("apply_damage", self, ent)
	end
end
sl_modifier_rune_enigma_control = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_enigma_control", nil, getfenv()) },
	sl_modifier_rune_enigma_control
)
____exports.sl_modifier_rune_enigma_control = sl_modifier_rune_enigma_control
return ____exports