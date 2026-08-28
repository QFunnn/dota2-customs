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
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_warlock_shadow_word") },
	sl_modifier_rune_warlock_shadow_word
)
____exports.sl_modifier_rune_warlock_shadow_word = sl_modifier_rune_warlock_shadow_word
return ____exports