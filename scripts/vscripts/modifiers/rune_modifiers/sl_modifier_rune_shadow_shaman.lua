--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
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
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强，每点智力或力量提升{hp_per_int_str}生命值<br>每2%技能增强，大招和魔晶的蛇棒攻击力+1%
____exports.sl_modifier_rune_shadow_shaman = __TS__Class()
local sl_modifier_rune_shadow_shaman = ____exports.sl_modifier_rune_shadow_shaman
sl_modifier_rune_shadow_shaman.name = "sl_modifier_rune_shadow_shaman"
__TS__ClassExtends(sl_modifier_rune_shadow_shaman, sl_modifier_rune_base)
function sl_modifier_rune_shadow_shaman.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._record_amp = 0
end
function sl_modifier_rune_shadow_shaman.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_HEALTH_BONUS, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_rune_shadow_shaman.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_shadow_shaman.prototype.GetModifierHealthBonus(self)
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
function sl_modifier_rune_shadow_shaman.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ward_atkp_per_amp = self:_GetRuneSpecialValue("ward_atkp_per_amp")
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValid(parent) then
			return nil
		end
		local update_amp = parent:GetSpellAmplification(false)
		if update_amp ~= self._record_amp then
			self._record_amp = update_amp
			self._ward_atkp_pct = update_amp * 100 * ward_atkp_per_amp
			local attr_manager = GlobalAttrManager:Get(parent:GetPlayerOwnerID())
			for ____, ward_name in ipairs(SHADOW_SHAMAN_WARD_NAMES) do
				attr_manager:SetSummonAmp(tostring(self), ward_name, { atk_bonus_pct = self._ward_atkp_pct })
			end
			self:SendBuffRefreshToClients()
		end
		return 1
	end)
end
function sl_modifier_rune_shadow_shaman.prototype.OnTooltip(self)
	return self._ward_atkp_pct
end
function sl_modifier_rune_shadow_shaman.prototype.HandleCustomTransmitterData(self, data)
	sl_modifier_rune_base.prototype.HandleCustomTransmitterData(self, data)
	local ____data_ward_atkp_pct_0 = data
	if ____data_ward_atkp_pct_0 ~= nil then
		____data_ward_atkp_pct_0 = ____data_ward_atkp_pct_0.ward_atkp_pct
	end
	self._ward_atkp_pct = ____data_ward_atkp_pct_0
end
function sl_modifier_rune_shadow_shaman.prototype.AddCustomTransmitterData(self)
	return __TS__ObjectAssign(
		{},
		sl_modifier_rune_base.prototype.AddCustomTransmitterData(self),
		{ ward_atkp_pct = self._ward_atkp_pct }
	)
end
sl_modifier_rune_shadow_shaman = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_shadow_shaman") },
	sl_modifier_rune_shadow_shaman
)
____exports.sl_modifier_rune_shadow_shaman = sl_modifier_rune_shadow_shaman
return ____exports