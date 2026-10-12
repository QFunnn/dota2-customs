--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_shadow_shaman.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_shadow_shaman.lua",
	{
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:10",
		["17"] = "8:1",
		["18"] = "9:14",
		["19"] = "8:1",
		["20"] = "9:45",
		["22"] = "9:53",
		["23"] = "36:5",
		["24"] = "8:1",
		["25"] = "10:5",
		["26"] = "11:9",
		["27"] = "10:5",
		["28"] = "14:5",
		["29"] = "15:9",
		["30"] = "15:16",
		["31"] = "17:13",
		["32"] = "18:13",
		["33"] = "15:16",
		["34"] = "14:5",
		["35"] = "22:5",
		["36"] = "23:15",
		["37"] = "23:24",
		["38"] = "25:13",
		["39"] = "26:13",
		["40"] = "23:24",
		["41"] = "28:15",
		["42"] = "28:24",
		["43"] = "30:13",
		["44"] = "31:13",
		["45"] = "28:24",
		["46"] = "33:9",
		["47"] = "22:5",
		["48"] = "38:5",
		["49"] = "9:53",
		["50"] = "40:14",
		["53"] = "42:15",
		["54"] = "43:15",
		["55"] = "44:9",
		["56"] = "45:18",
		["57"] = "46:17",
		["59"] = "49:19",
		["60"] = "50:17",
		["61"] = "51:17",
		["62"] = "52:17",
		["63"] = "54:23",
		["64"] = "55:17",
		["65"] = "56:21",
		["66"] = "56:47",
		["67"] = "56:63",
		["68"] = "56:74",
		["69"] = "56:21",
		["71"] = "58:17",
		["73"] = "60:13",
		["74"] = "44:28",
		["75"] = "38:5",
		["76"] = "64:5",
		["77"] = "65:9",
		["78"] = "64:5",
		["79"] = "68:5",
		["80"] = "9:53",
		["81"] = "70:31",
		["82"] = "70:31",
		["83"] = "70:31",
		["85"] = "70:9",
		["86"] = "68:5",
		["87"] = "73:5",
		["88"] = "74:9",
		["89"] = "74:16",
		["90"] = "9:53",
		["91"] = "74:16",
		["92"] = "74:16",
		["93"] = "73:5",
		["94"] = "9:14",
		["95"] = "8:2",
		["96"] = "8:2",
		["97"] = "8:19",
		["98"] = "8:2",
		["100"] = "8:2",
		["101"] = "9:14",
		["103"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点智力提升{amp_per_int}%技能增强，每点智力或力量提升{hp_per_int_str}生命值<br>
-- 每1%技能增强，群蛇守卫和巨蛇守卫攻击力+{ward_atkp_per_amp}%（SetSummonAmp 每秒重算）
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
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_shadow_shaman", nil, getfenv()) },
	sl_modifier_rune_shadow_shaman
)
____exports.sl_modifier_rune_shadow_shaman = sl_modifier_rune_shadow_shaman
return ____exports