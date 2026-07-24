--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_wodahunt", "modifiers/modifier_wodahunt", LUA_MODIFIER_MOTION_NONE)

modifier_wodahunt = class({})

function modifier_wodahunt:IsHidden()
	return true 
end

function modifier_wodahunt:IsPurgable()
	return false 
end

function modifier_wodahunt:IsPurgeException()
	return false 
end

function modifier_wodahunt:RemoveOnDeath()
	return false 
end

function modifier_wodahunt:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH, MODIFIER_PROPERTY_PROVIDES_FOW_POSITION
	}
end

function modifier_wodahunt:CheckState()
	return 
	{
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
end

function modifier_wodahunt:GetModifierProvidesFOWVision()
	return 1
end

function modifier_wodahunt:OnDeath(params)

	if params.unit ~= self:GetParent() then 
		return 
	end

	if params.attacker == self:GetParent() then
		return 
	end

	if params.attacker:IsNeutralUnitType() then
		return
	end

    if params.reincarnate then return end

	self:RemoveTable()

	WodaTalents:AddPoint(params.attacker:GetPlayerOwnerID(),1) 

	local heroes = FindUnitsInRadius(params.attacker:GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, 1800, DOTA_UNIT_TARGET_TEAM_BOTH, 
	DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE+DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO+DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, 0, false)
	
	for _,hero in pairs(heroes) do
		WodaTalents:AddPoint(hero:GetPlayerOwnerID(),2)
	end

	self:Destroy()
end

function modifier_wodahunt:RemoveTable()
	local hunt_table = arena_system.HUNT_PLAYERS_LIST
	local hunt_table_new = {}
	for k,v in pairs(hunt_table) do
		table.insert(hunt_table_new,v)
	end

	for i = #hunt_table_new, 1, -1 do
		if hunt_table_new[i] ~= nil and tonumber(hunt_table_new[i].id) == tonumber(self:GetParent():GetPlayerID()) then 
			table.remove(hunt_table_new,i)
		end
	end

    arena_system.HUNT_PLAYERS_LIST = hunt_table_new
	CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "huntplayers", data = hunt_table_new})
end