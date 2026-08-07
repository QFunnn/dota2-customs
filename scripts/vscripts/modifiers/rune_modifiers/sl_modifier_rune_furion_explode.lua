--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__Decorate = ____lualib.__TS__Decorate
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
			for ____, enemy in ipairs(enemies) do
				ApplyDamage({
					attacker = parent,
					victim = enemy,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
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
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_furion_explode") },
	sl_modifier_rune_furion_explode
)
____exports.sl_modifier_rune_furion_explode = sl_modifier_rune_furion_explode
return ____exports