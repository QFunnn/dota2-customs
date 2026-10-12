--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_lycan_wolf.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_lycan_wolf.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["16"] = "8:1",
		["17"] = "9:14",
		["18"] = "8:1",
		["19"] = "9:42",
		["21"] = "9:50",
		["22"] = "10:5",
		["23"] = "11:5",
		["24"] = "12:5",
		["25"] = "8:1",
		["26"] = "14:5",
		["27"] = "15:9",
		["28"] = "14:5",
		["29"] = "18:5",
		["30"] = "19:9",
		["31"] = "19:16",
		["32"] = "21:13",
		["33"] = "22:13",
		["34"] = "19:16",
		["35"] = "18:5",
		["36"] = "26:5",
		["37"] = "27:15",
		["38"] = "27:25",
		["39"] = "29:13",
		["40"] = "30:13",
		["41"] = "27:25",
		["42"] = "32:15",
		["43"] = "32:25",
		["44"] = "34:13",
		["45"] = "35:13",
		["46"] = "32:25",
		["47"] = "37:9",
		["48"] = "26:5",
		["49"] = "40:5",
		["50"] = "41:9",
		["51"] = "40:5",
		["52"] = "44:5",
		["53"] = "45:9",
		["54"] = "44:5",
		["55"] = "48:5",
		["56"] = "9:50",
		["57"] = "50:14",
		["60"] = "51:15",
		["61"] = "52:15",
		["62"] = "53:15",
		["63"] = "54:9",
		["64"] = "55:18",
		["65"] = "55:53",
		["67"] = "56:19",
		["68"] = "57:19",
		["69"] = "58:19",
		["70"] = "59:17",
		["71"] = "60:17",
		["73"] = "62:13",
		["74"] = "63:13",
		["75"] = "64:13",
		["76"] = "65:19",
		["77"] = "70:19",
		["78"] = "71:13",
		["79"] = "72:17",
		["80"] = "72:43",
		["81"] = "72:59",
		["82"] = "72:70",
		["83"] = "72:17",
		["85"] = "74:13",
		["86"] = "54:28",
		["87"] = "48:5",
		["88"] = "78:5",
		["89"] = "79:14",
		["92"] = "80:15",
		["93"] = "81:14",
		["96"] = "82:9",
		["97"] = "78:5",
		["98"] = "9:14",
		["99"] = "8:2",
		["100"] = "8:2",
		["101"] = "8:19",
		["102"] = "8:2",
		["104"] = "8:2",
		["105"] = "9:14",
		["107"] = "9:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点力量提升{hp_per_str}生命值，每点力量或敏捷提升{batk_per_str_agi}基础攻击力<br>
-- 召狼直接产生的狼继承狼人{wolf_atk_pct}%攻击速度和攻击力、{wolf_hp_pct}%生命值（SetSummonAmp，同蛇影）
____exports.sl_modifier_rune_lycan_wolf = __TS__Class()
local sl_modifier_rune_lycan_wolf = ____exports.sl_modifier_rune_lycan_wolf
sl_modifier_rune_lycan_wolf.name = "sl_modifier_rune_lycan_wolf"
__TS__ClassExtends(sl_modifier_rune_lycan_wolf, sl_modifier_rune_base)
function sl_modifier_rune_lycan_wolf.prototype.____constructor(self, ...)
	sl_modifier_rune_base.prototype.____constructor(self, ...)
	self._record_as = -1
	self._record_atk = -1
	self._record_hp = -1
end
function sl_modifier_rune_lycan_wolf.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function sl_modifier_rune_lycan_wolf.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_lycan_wolf.prototype.GetModifierBaseAttack_BonusDamage(self)
	local str_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_str_agi")
		end
	)
	local agi_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_str_agi")
		end
	)
	return str_atk + agi_atk
end
function sl_modifier_rune_lycan_wolf.prototype.OnTooltip(self)
	return self:_GetRuneSpecialValue("wolf_atk_pct")
end
function sl_modifier_rune_lycan_wolf.prototype.OnTooltip2(self)
	return self:_GetRuneSpecialValue("wolf_hp_pct")
end
function sl_modifier_rune_lycan_wolf.prototype.OnCreated(self, params)
	sl_modifier_rune_base.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local wolf_atk_pct = self:_GetRuneSpecialValue("wolf_atk_pct")
	local wolf_hp_pct = self:_GetRuneSpecialValue("wolf_hp_pct")
	Timers:CreateTimer(function()
		if not IsValid(self) or not IsValid(parent) then
			return nil
		end
		local as_display = parent:GetAttackSpeed(true) * 100
		local atk = parent:GetAverageTrueAttackDamage(nil)
		local hp = parent:GetMaxHealth()
		if as_display == self._record_as and atk == self._record_atk and hp == self._record_hp then
			return 1
		end
		self._record_as = as_display
		self._record_atk = atk
		self._record_hp = hp
		local amp = {
			as_bonus = as_display * (wolf_atk_pct / 100),
			atk_bonus = atk * (wolf_atk_pct / 100),
			hp_bonus = hp * (wolf_hp_pct / 100),
		}
		local attr_manager = GlobalAttrManager:Get(parent:GetPlayerOwnerID())
		for ____, unit_name in ipairs(LYCAN_WOLF_UNIT_NAMES) do
			attr_manager:SetSummonAmp(tostring(self), unit_name, amp)
		end
		return 1
	end)
end
function sl_modifier_rune_lycan_wolf.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	GlobalAttrManager:Get(parent:GetPlayerOwnerID()):RemoveAllSummonAmpBySource(tostring(self))
end
sl_modifier_rune_lycan_wolf = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_lycan_wolf", nil, getfenv()) },
	sl_modifier_rune_lycan_wolf
)
____exports.sl_modifier_rune_lycan_wolf = sl_modifier_rune_lycan_wolf
return ____exports