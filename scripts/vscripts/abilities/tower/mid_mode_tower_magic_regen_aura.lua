--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/tower/mid_mode_tower_magic_regen_aura.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/tower/mid_mode_tower_magic_regen_aura.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "2:27",
		["15"] = "2:40",
		["16"] = "4:1",
		["17"] = "5:14",
		["18"] = "4:1",
		["19"] = "5:46",
		["20"] = "6:5",
		["21"] = "7:15",
		["22"] = "8:13",
		["23"] = "9:13",
		["25"] = "6:5",
		["26"] = "13:5",
		["27"] = "14:9",
		["28"] = "13:5",
		["29"] = "5:14",
		["30"] = "4:2",
		["31"] = "4:2",
		["32"] = "4:2",
		["34"] = "4:2",
		["35"] = "5:14",
		["37"] = "5:14",
		["38"] = "18:1",
		["39"] = "19:14",
		["40"] = "18:1",
		["41"] = "19:55",
		["42"] = "20:5",
		["43"] = "21:9",
		["44"] = "20:5",
		["45"] = "24:5",
		["46"] = "25:9",
		["47"] = "24:5",
		["48"] = "28:5",
		["49"] = "29:9",
		["50"] = "28:5",
		["51"] = "32:5",
		["52"] = "33:9",
		["53"] = "32:5",
		["54"] = "36:5",
		["55"] = "37:9",
		["56"] = "36:5",
		["57"] = "40:5",
		["58"] = "41:9",
		["59"] = "40:5",
		["60"] = "44:5",
		["61"] = "45:9",
		["62"] = "44:5",
		["63"] = "48:5",
		["64"] = "49:16",
		["66"] = "49:16",
		["68"] = "49:9",
		["69"] = "48:5",
		["70"] = "53:5",
		["71"] = "54:9",
		["72"] = "53:5",
		["73"] = "19:14",
		["74"] = "18:2",
		["75"] = "18:2",
		["76"] = "18:19",
		["77"] = "18:2",
		["79"] = "18:2",
		["80"] = "19:14",
		["82"] = "19:14",
		["83"] = "58:1",
		["84"] = "59:14",
		["85"] = "58:1",
		["86"] = "59:63",
		["87"] = "60:5",
		["88"] = "61:9",
		["89"] = "60:5",
		["90"] = "64:5",
		["91"] = "65:9",
		["92"] = "64:5",
		["93"] = "68:5",
		["94"] = "69:9",
		["95"] = "68:5",
		["96"] = "72:5",
		["97"] = "73:9",
		["98"] = "72:5",
		["99"] = "77:5",
		["100"] = "78:9",
		["101"] = "77:5",
		["102"] = "59:14",
		["103"] = "58:2",
		["104"] = "58:2",
		["105"] = "58:19",
		["106"] = "58:2",
		["108"] = "58:2",
		["109"] = "59:14",
		["111"] = "59:14",
	}
)
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.mid_mode_tower_magic_regen_aura = __TS__Class()
local mid_mode_tower_magic_regen_aura = ____exports.mid_mode_tower_magic_regen_aura
mid_mode_tower_magic_regen_aura.name = "mid_mode_tower_magic_regen_aura"
__TS__ClassExtends(mid_mode_tower_magic_regen_aura, BaseAbility)
function mid_mode_tower_magic_regen_aura.prototype.GetIntrinsicModifierName(self)
	local level = self:GetLevel()
	if level >= 1 then
		return ____exports.modifier_mid_mode_tower_magic_regen_aura.name
	end
end
function mid_mode_tower_magic_regen_aura.prototype.GetCastRange(self, location, target)
	return self:GetSpecialValueFor("aura_radius")
end
mid_mode_tower_magic_regen_aura =
	__TS__Decorate({ registerAbility(nil, nil, getfenv()) }, mid_mode_tower_magic_regen_aura)
____exports.mid_mode_tower_magic_regen_aura = mid_mode_tower_magic_regen_aura
____exports.modifier_mid_mode_tower_magic_regen_aura = __TS__Class()
local modifier_mid_mode_tower_magic_regen_aura = ____exports.modifier_mid_mode_tower_magic_regen_aura
modifier_mid_mode_tower_magic_regen_aura.name = "modifier_mid_mode_tower_magic_regen_aura"
__TS__ClassExtends(modifier_mid_mode_tower_magic_regen_aura, SLModifierBase)
function modifier_mid_mode_tower_magic_regen_aura.prototype.AllowIllusionDuplicate(self)
	return false
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.IsAura(self)
	return true
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetModifierAura(self)
	return ____exports.sl_modifier_mid_mode_tower_magic_regen_aura_buff.name
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraRadius(self)
	return self:GetAbilitySpecialValueFor("aura_radius")
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraOwner(self)
	local ____temp_0 = self:GetParent()
	if ____temp_0 == nil then
		____temp_0 = nil
	end
	return ____temp_0
end
function modifier_mid_mode_tower_magic_regen_aura.prototype.GetAuraDuration(self)
	return self:GetAbilitySpecialValueFor("sticky_time")
end
modifier_mid_mode_tower_magic_regen_aura = __TS__Decorate(
	{ registerModifier(nil, "abilities/tower/mid_mode_tower_magic_regen_aura", nil, getfenv()) },
	modifier_mid_mode_tower_magic_regen_aura
)
____exports.modifier_mid_mode_tower_magic_regen_aura = modifier_mid_mode_tower_magic_regen_aura
____exports.sl_modifier_mid_mode_tower_magic_regen_aura_buff = __TS__Class()
local sl_modifier_mid_mode_tower_magic_regen_aura_buff = ____exports.sl_modifier_mid_mode_tower_magic_regen_aura_buff
sl_modifier_mid_mode_tower_magic_regen_aura_buff.name = "sl_modifier_mid_mode_tower_magic_regen_aura_buff"
__TS__ClassExtends(sl_modifier_mid_mode_tower_magic_regen_aura_buff, SLModifierBase)
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.IsHidden(self)
	return false
end
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT, MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE }
end
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.GetModifierConstantManaRegen(self)
	return self:GetAbilitySpecialValueFor("mana_regen_constant")
end
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.GetModifierTotalPercentageManaRegen(self)
	return self:GetAbilitySpecialValueFor("mana_regen_total_pct")
end
function sl_modifier_mid_mode_tower_magic_regen_aura_buff.prototype.GetEffectName(self)
	return GENERIC_PARTICLES.mid_tower_mana_regen
end
sl_modifier_mid_mode_tower_magic_regen_aura_buff = __TS__Decorate(
	{ registerModifier(nil, "abilities/tower/mid_mode_tower_magic_regen_aura", nil, getfenv()) },
	sl_modifier_mid_mode_tower_magic_regen_aura_buff
)
____exports.sl_modifier_mid_mode_tower_magic_regen_aura_buff = sl_modifier_mid_mode_tower_magic_regen_aura_buff
return ____exports