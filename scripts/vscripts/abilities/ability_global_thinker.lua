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
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
____exports.ability_global_thinker = __TS__Class()
local ability_global_thinker = ____exports.ability_global_thinker
ability_global_thinker.name = "ability_global_thinker"
__TS__ClassExtends(ability_global_thinker, BaseAbility)
function ability_global_thinker.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
	if not extraData then
		return
	end
	local ____type = extraData.type
	if ____type == 1 then
		if not IsValid(target) then
			return
		end
		if not target:CanReflectAbility() then
			return
		end
		local ____extraData_0 = extraData
		local source_ability_index = ____extraData_0.source_ability_index
		local source_unit_index = ____extraData_0.source_unit_index
		local is_custom_reflect = ____extraData_0.is_custom_reflect
		if is_custom_reflect == 1 then
			return
		end
		local source_ability = source_ability_index and EntIndexToHScript(source_ability_index)
		local source_unit = source_unit_index and EntIndexToHScript(source_unit_index)
		if not IsValid(source_unit) or not IsValid(source_ability) then
			return
		end
	elseif ____type == 2 then
		local bless = SLModules.Bless:GetBlessByUniqueName(extraData.bless_unique_name)
		if bless then
			if bless.OnProjectileHit then
				local source_unit_index = extraData.source_unit_index
				local source_unit = source_unit_index and EntIndexToHScript(source_unit_index)
				local result = SafelyCall(function()
					return bless:OnProjectileHit(source_unit, target, location, extraData)
				end)
				if result == true then
					return result
				end
			end
		end
	end
	return
end
function ability_global_thinker.prototype.OnProjectileThink_ExtraData(self, location, extraData)
	if not extraData then
		return
	end
	local ____type = extraData.type
	if ____type == 1 then
	elseif ____type == 2 then
		local bless = SLModules.Bless:GetBlessByUniqueName(extraData.bless_unique_name)
		if bless then
			if bless.OnProjectileThink then
				local source_unit_index = extraData.source_unit_index
				local source_unit = source_unit_index and EntIndexToHScript(source_unit_index)
				SafelyCall(function()
					return bless:OnProjectileThink(source_unit, location, extraData)
				end)
			end
		end
	end
	return
end
ability_global_thinker = __TS__Decorate({ registerAbility(nil) }, ability_global_thinker)
____exports.ability_global_thinker = ability_global_thinker
return ____exports