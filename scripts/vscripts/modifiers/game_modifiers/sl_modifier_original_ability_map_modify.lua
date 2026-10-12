--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_original_ability_map_modify.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_original_ability_map_modify.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:54",
		["20"] = "8:62",
		["21"] = "23:5",
		["22"] = "7:1",
		["23"] = "9:5",
		["24"] = "10:9",
		["25"] = "9:5",
		["26"] = "13:5",
		["27"] = "14:14",
		["30"] = "13:5",
		["31"] = "17:5",
		["32"] = "18:14",
		["35"] = "20:9",
		["36"] = "17:5",
		["37"] = "25:5",
		["38"] = "26:14",
		["41"] = "28:15",
		["42"] = "29:14",
		["45"] = "30:15",
		["46"] = "31:9",
		["47"] = "32:19",
		["48"] = "33:19",
		["49"] = "34:17",
		["52"] = "25:5",
		["53"] = "39:5",
		["54"] = "40:9",
		["55"] = "39:5",
		["56"] = "8:14",
		["57"] = "7:2",
		["58"] = "7:2",
		["59"] = "7:19",
		["60"] = "7:2",
		["62"] = "7:2",
		["63"] = "8:14",
		["65"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 用于让原版技能增幅也享受到技能增幅因子修改的buff
____exports.sl_modifier_original_ability_map_modify = __TS__Class()
local sl_modifier_original_ability_map_modify = ____exports.sl_modifier_original_ability_map_modify
sl_modifier_original_ability_map_modify.name = "sl_modifier_original_ability_map_modify"
__TS__ClassExtends(sl_modifier_original_ability_map_modify, SLModifierBase)
function sl_modifier_original_ability_map_modify.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._modify_value = 0
end
function sl_modifier_original_ability_map_modify.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_original_ability_map_modify.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not IsServer() then
		return
	end
end
function sl_modifier_original_ability_map_modify.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(10)
end
function sl_modifier_original_ability_map_modify.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local items = parent:FindAllItemsBySlotType(2)
	for ____, item in ipairs(items) do
		local modifier_name = item:GetIntrinsicModifierName()
		local modifier = parent:FindModifierByNameAndCaster(modifier_name, parent)
		if IsValid(modifier) and modifier:HasFunction(MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE) then
		end
	end
end
function sl_modifier_original_ability_map_modify.prototype.IgnoreSpellAmplifyFactor(self)
	return true
end
sl_modifier_original_ability_map_modify = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_original_ability_map_modify", nil, getfenv()) },
	sl_modifier_original_ability_map_modify
)
____exports.sl_modifier_original_ability_map_modify = sl_modifier_original_ability_map_modify
return ____exports