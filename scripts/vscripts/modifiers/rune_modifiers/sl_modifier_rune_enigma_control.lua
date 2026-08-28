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
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_enigma_control") },
	sl_modifier_rune_enigma_control
)
____exports.sl_modifier_rune_enigma_control = sl_modifier_rune_enigma_control
return ____exports