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
		["66"] = "54:23",
		["67"] = "55:23",
		["68"] = "56:23",
		["69"] = "57:23",
		["70"] = "58:17",
		["71"] = "59:21",
		["72"] = "60:21",
		["73"] = "61:21",
		["74"] = "62:21",
		["75"] = "63:21",
		["76"] = "64:21",
		["77"] = "58:29",
		["78"] = "66:21",
		["79"] = "67:21",
		["81"] = "52:20",
		["82"] = "51:9",
		["83"] = "77:9",
		["84"] = "78:13",
		["85"] = "79:13",
		["86"] = "80:13",
		["87"] = "81:23",
		["88"] = "82:22",
		["91"] = "83:22",
		["94"] = "84:22",
		["95"] = "84:22",
		["96"] = "84:50",
		["97"] = "84:22",
		["100"] = "85:23",
		["101"] = "86:22",
		["104"] = "87:17",
		["105"] = "80:13",
		["106"] = "89:13",
		["107"] = "77:9",
		["108"] = "91:9",
		["109"] = "92:13",
		["110"] = "93:13",
		["111"] = "94:13",
		["112"] = "95:23",
		["113"] = "96:22",
		["116"] = "97:17",
		["117"] = "94:13",
		["118"] = "99:13",
		["119"] = "100:13",
		["120"] = "91:9",
		["121"] = "102:9",
		["122"] = "103:13",
		["123"] = "104:13",
		["124"] = "105:13",
		["125"] = "106:22",
		["128"] = "107:23",
		["129"] = "108:22",
		["132"] = "109:23",
		["133"] = "110:22",
		["136"] = "111:22",
		["139"] = "112:23",
		["140"] = "113:21",
		["143"] = "114:17",
		["144"] = "115:23",
		["145"] = "116:21",
		["148"] = "117:17",
		["149"] = "105:13",
		["150"] = "126:13",
		["151"] = "127:13",
		["152"] = "102:9",
		["153"] = "44:5",
		["154"] = "131:5",
		["155"] = "132:15",
		["156"] = "133:14",
		["159"] = "134:9",
		["160"] = "135:13",
		["161"] = "136:13",
		["162"] = "137:13",
		["163"] = "138:13",
		["164"] = "139:13",
		["165"] = "140:13",
		["166"] = "141:13",
		["167"] = "134:102",
		["168"] = "131:5",
		["169"] = "145:5",
		["170"] = "146:14",
		["173"] = "147:13",
		["174"] = "148:13",
		["176"] = "150:9",
		["177"] = "151:15",
		["178"] = "152:13",
		["179"] = "153:19",
		["180"] = "154:13",
		["181"] = "155:13",
		["183"] = "145:5",
		["184"] = "13:14",
		["185"] = "12:2",
		["186"] = "12:2",
		["187"] = "12:19",
		["188"] = "12:2",
		["190"] = "12:2",
		["191"] = "13:14",
		["193"] = "13:14",
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
			if stun > 0 and IsValidAlive(target) and target:IsCreature() then
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
		if not target:IsCreature() then
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