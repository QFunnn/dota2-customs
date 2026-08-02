--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


SummonsRegistry = SummonsRegistry or {}

require("libraries/summons/declarations")

function SummonsRegistry:Init()
	EventDriver:Listen("Events:npc_spawned", SummonsRegistry.OnSpawn, SummonsRegistry)
	EventDriver:Listen("EventProxy:OnModifierAdded", SummonsRegistry.OnModifierAdded, SummonsRegistry)
end

function SummonsRegistry:OnSpawn(event, skip_summon_check)
	local unit = event.unit

	if not IsValidEntity(unit) or not unit.GetUnitName then
		return
	end

	if not skip_summon_check and not SummonsRegistry:IsSummon(unit:GetUnitName()) then
		return
	end

	SummonsRegistry:UpdateSummon(unit)
end

function SummonsRegistry:UpdateSummon(unit)
	local player_owner_id = unit:GetPlayerOwnerID()
	if not IsValidPlayerID(player_owner_id) then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(player_owner_id)
	if IsValidEntity(hero) and hero.ApplySummonPower then
		hero:ApplySummonPower(unit)
	end
end

--- Checks whether specific unit name is (supposed to be) a summon
---@param unit_name string
function SummonsRegistry:IsSummon(unit_name)
	return SUMMONS[unit_name] ~= nil
end

--- Returns multipliers for health / damage / attack speed for specific summon, if any
---@param summon_name string
function SummonsRegistry:GetSummonMultipliers(summon_name)
	return SUMMONS[summon_name] or { 1, 1, 1 }
end

function SummonsRegistry:OnModifierAdded(event)
	local modifier = event.added_buff
	if modifier:GetName() ~= "modifier_dominated" then
		return
	end

	SummonsRegistry:OnSpawn({
		unit = event.unit,
	}, true)
end

SummonsRegistry:Init()