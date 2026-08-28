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
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_original_ability_map_modify") },
	sl_modifier_original_ability_map_modify
)
____exports.sl_modifier_original_ability_map_modify = sl_modifier_original_ability_map_modify
return ____exports