--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/units/bless_10169_cat_ability_2.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/units/bless_10169_cat_ability_2.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "2:27",
		["15"] = "3:1",
		["16"] = "3:10",
		["18"] = "8:1",
		["19"] = "9:14",
		["20"] = "8:1",
		["21"] = "9:40",
		["23"] = "9:48",
		["24"] = "10:5",
		["25"] = "8:1",
		["26"] = "11:5",
		["27"] = "12:15",
		["28"] = "13:14",
		["31"] = "14:15",
		["32"] = "15:15",
		["33"] = "17:9",
		["34"] = "17:35",
		["35"] = "17:52",
		["36"] = "17:9",
		["37"] = "19:9",
		["38"] = "20:13",
		["39"] = "21:13",
		["40"] = "22:13",
		["41"] = "23:13",
		["42"] = "23:20",
		["43"] = "23:50",
		["44"] = "23:78",
		["45"] = "23:19",
		["46"] = "19:32",
		["47"] = "25:13",
		["48"] = "26:19",
		["49"] = "26:26",
		["50"] = "26:86",
		["51"] = "27:17",
		["52"] = "28:17",
		["53"] = "29:17",
		["54"] = "30:17",
		["55"] = "26:86",
		["56"] = "26:26",
		["57"] = "32:17",
		["58"] = "33:23",
		["59"] = "34:17",
		["60"] = "34:34",
		["61"] = "34:39",
		["62"] = "34:46",
		["63"] = "34:53",
		["64"] = "34:56",
		["65"] = "34:63",
		["66"] = "34:17",
		["69"] = "9:48",
		["70"] = "11:5",
		["71"] = "9:14",
		["72"] = "8:2",
		["73"] = "8:2",
		["74"] = "8:2",
		["76"] = "8:2",
		["77"] = "9:14",
		["79"] = "9:14",
		["80"] = "41:1",
		["81"] = "42:14",
		["82"] = "41:1",
		["83"] = "42:52",
		["84"] = "43:5",
		["85"] = "44:9",
		["86"] = "43:5",
		["87"] = "47:5",
		["88"] = "48:9",
		["89"] = "47:5",
		["90"] = "51:5",
		["91"] = "52:9",
		["92"] = "51:5",
		["93"] = "55:5",
		["94"] = "56:9",
		["95"] = "55:5",
		["96"] = "59:5",
		["97"] = "60:9",
		["98"] = "59:5",
		["99"] = "63:5",
		["100"] = "64:9",
		["101"] = "63:5",
		["102"] = "42:14",
		["103"] = "41:2",
		["104"] = "41:2",
		["105"] = "41:19",
		["106"] = "41:2",
		["108"] = "41:2",
		["109"] = "42:14",
		["111"] = "42:14",
	}
)
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____bless_10169_cat_ability_base = require("abilities.units._bless_10169_cat_ability_base")
local _bless_10169_cat_ability_base = _____bless_10169_cat_ability_base._bless_10169_cat_ability_base
--- 集火：使目标承受伤害+20%，持续10秒，可以对建筑使用
____exports.bless_10169_cat_ability_2 = __TS__Class()
local bless_10169_cat_ability_2 = ____exports.bless_10169_cat_ability_2
bless_10169_cat_ability_2.name = "bless_10169_cat_ability_2"
__TS__ClassExtends(bless_10169_cat_ability_2, _bless_10169_cat_ability_base)
function bless_10169_cat_ability_2.prototype.____constructor(self, ...)
	_bless_10169_cat_ability_base.prototype.____constructor(self, ...)
	self._command_particle = BLESS_PARTICLES.bless_10169_att_head
end
function bless_10169_cat_ability_2.prototype.OnSpellStart(self)
	local target = self:GetCursorTarget()
	if not IsValidAlive(target) then
		return
	end
	local caster = self:GetCaster()
	local player_id = caster:GetPlayerOwnerID()
	EmitAnnouncerSoundForTeam("cat_ability_2", caster:GetTeam())
	Custom_SendChatMessage({
		message = "#bless_10169_cat_ability_2_msg",
		send_player = player_id,
		team_only = true,
		args = {
			GetPlayerColorHex(player_id),
			"#" .. caster:GetUnitName(),
			"#" .. target:GetUnitName(),
		},
	})
	if IsValidAlive(target) then
		local buff = target:AddSLModifier(____exports.sl_modifier_bless_10169_cat_ability_2, {
			ability = self,
			caster = caster,
			duration = self:GetSpecialValueFor("dmg_dur"),
			no_error = true,
		})
		if IsValid(buff) then
			local pid = self:CreateParticle(BLESS_PARTICLES.bless_10169_att_buff, PATTACH_ABSORIGIN_FOLLOW, target)
			buff:AddParticle(pid, false, false, 5, false, false)
		end
	end
	_bless_10169_cat_ability_base.prototype.OnSpellStart(self)
end
bless_10169_cat_ability_2 = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, bless_10169_cat_ability_2)
____exports.bless_10169_cat_ability_2 = bless_10169_cat_ability_2
____exports.sl_modifier_bless_10169_cat_ability_2 = __TS__Class()
local sl_modifier_bless_10169_cat_ability_2 = ____exports.sl_modifier_bless_10169_cat_ability_2
sl_modifier_bless_10169_cat_ability_2.name = "sl_modifier_bless_10169_cat_ability_2"
__TS__ClassExtends(sl_modifier_bless_10169_cat_ability_2, SLModifierBase_Debuff)
function sl_modifier_bless_10169_cat_ability_2.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10169_cat_ability_2.prototype.IsPurgable(self)
	return false
end
function sl_modifier_bless_10169_cat_ability_2.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_bless_10169_cat_ability_2.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10169_cat_ability_2.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_bless_10169_cat_ability_2.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self:GetAbilitySpecialValueFor("dmg_pct")
end
sl_modifier_bless_10169_cat_ability_2 = __TS__Decorate(
	{ registerModifier(nil, "abilities/units/bless_10169_cat_ability_2", nil, getfenv()) },
	sl_modifier_bless_10169_cat_ability_2
)
____exports.sl_modifier_bless_10169_cat_ability_2 = sl_modifier_bless_10169_cat_ability_2
return ____exports