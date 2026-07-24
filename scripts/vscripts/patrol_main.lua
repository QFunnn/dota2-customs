--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function dota1x6:RandomUnit(unit1,max)

local n = RandomInt(1, max)
if n == unit1 then 
	return dota1x6:RandomUnit(unit1,max)
else 
	return n
end

end


function dota1x6:spawn_patrol(index, is_tormentor, is_portal, special_vision)

local units = {}
local count = 4
local second_tier = false
local patrol_item = "patrol_1"

local side = dota1x6.patrol_data[index].side
local current = dota1x6.patrol_data[index].current_team
local teams = dota1x6.patrol_data[index].teams
local map_teams = {}
local no_teams = true
local team = nil

if not teams then
	no_teams = false
	for team,tower in pairs(towers) do
		if special_vision then
			map_teams[tower.map_team] = special_vision[team]
		else
			map_teams[tower.map_team] = true
		end
	end
else
	for _,team in pairs(teams) do
		map_teams[team] = true
	end

	for _,tower in pairs(towers) do
		if map_teams[tower.map_team] then
			no_teams = false
			break
		end
	end
end

if no_teams and not test then return end

local base_unit = nil
if is_tormentor then
	base_unit = Entities:FindByName(nil, "tormentor_base_"..index)
else
	base_unit = Entities:FindByName(nil, "patrol_portal_"..index)
end

if not base_unit then return end

local point = base_unit:GetAbsOrigin()

if is_portal then
	local portal_point = point + Vector(0, 0, 80)
	
	for team,tower in pairs(towers) do 
		if map_teams[tower.map_team] then
		 	AddFOWViewer(team, portal_point, 500, PortalDelay+0.3, false)
			local count = 0

			Timers:CreateTimer(0, function()
				local id_players = dota1x6:FindPlayers(team)
				if id_players then
					GameRules:ExecuteTeamPing( team, portal_point.x, portal_point.y, players[id_players[1]], 0 )
				end
				count = count + 1
				if count <= 1 then
					return 1.5
				end
			end)
		end
	end

	local teleport_center = CreateUnitByName("npc_dota_companion", portal_point, false, nil, nil, 0)
	teleport_center:AddNewModifier(teleport_center, nil, "modifier_phased", {})
	teleport_center:AddNewModifier(teleport_center, nil, "modifier_invulnerable", {})
	teleport_center:AddNewModifier(teleport_center, nil, "modifier_unselect", {})

	EmitSoundOn("UI.Creep_portal_loop", teleport_center)

	teleport_center.nWarningFX = ParticleManager:CreateParticle( "particles/portals/portal_ground_spawn_endpoint.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( teleport_center.nWarningFX, 0, portal_point )

	Timers:CreateTimer(PortalDelay+0.3,function()
	    ParticleManager:DestroyParticle(teleport_center.nWarningFX, true)
	    ParticleManager:ReleaseParticleIndex(teleport_center.nWarningFX)
	    teleport_center:StopSound("UI.Creep_portal_loop")
	    teleport_center:EmitSound("UI.Creep_portal_end")
	    teleport_center:RemoveSelf()
	end)
	return
end

if teams then
	dota1x6.patrol_data[index].current_team = current + 1
	if dota1x6.patrol_data[index].current_team > #teams then 
		dota1x6.patrol_data[index].current_team = 1
	end
	team = tostring(teams[current])
end

if dota1x6.current_wave >= patrol_wave_2 then 
	second_tier  = true
	patrol_item  = "patrol_2"
elseif not is_tormentor and teams then
	local is_dire = IsDire(team)
	side = is_dire and 1 or 0
end

if is_tormentor == true then
	local unit = CreateUnitByName("npc_dota_tormentor_custom", point, false, nil, nil, DOTA_TEAM_NEUTRALS)
	unit.is_patrol_creep = true

	local reflect_ability = unit:FindAbilityByName("patrol_tormentor_reflect_custom")
	if reflect_ability then
		reflect_ability:SetLevel(1)
	end

	local shield_ability = unit:FindAbilityByName("patrol_tormentor_shield_custom")
	if shield_ability then
		shield_ability:SetLevel(1)
	end

	unit:AddNewModifier(unit, nil, "modifier_tormentor_custom", {side = side})
	unit.patrol_teams = map_teams

	for id,player in pairs(players) do
		if map_teams[player.map_team] then
			EmitAnnouncerSoundForPlayer("Tormentor.Spawn", id)
		end
	end
	return
end

for i = 1,count do 
	local name = ""
	if side == 0 then 
		name = i > 3 and "patrol_range_good" or "patrol_melee_good"
	else 
		name = i > 3 and "patrol_range_bad" or "patrol_melee_bad"
	end
	
	local new_point = point + RandomVector(RandomInt(-100, 100))
	units[i] = CreateUnitByName(name, new_point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	local pos_name = "patrol_position_"..index.."_"..tostring(i)
	local path_name = "patrol_path_"..index.."_1"
	if team then
		pos_name = "patrol_position_"..index.."_"..tostring(team).."_"..tostring(i)
		path_name = "patrol_path_"..index.."_"..(second_tier and "center" or tostring(team)).."_1"
	end

	local new_pos = units[i]:GetAbsOrigin()

	if second_tier == true then 
		pos_name = "patrol_position_"..index.."_"..i
	end

	if side == 0 then 
		units[i].radiant_patrol = true
	else 
		units[i].dire_patrol = true
	end

	local pos_unit = Entities:FindByName(nil, pos_name)
	if pos_unit then
		new_pos = pos_unit:GetAbsOrigin()
	end

	units[i].spawn = new_pos
	units[i]:AddNewModifier(units[i], nil, "modifier_patrol_death", {})
	units[i]:AddNewModifier(units[i], nil, "modifier_patrolupgrade", {})
	units[i].is_patrol_creep = true
	units[i].patrol_teams = map_teams

	units[i]:AddNewModifier(unit, nil, "modifier_patrol_start", {})
	units[i]:SetInitialWaypoint(path_name)
end

local unit_1 = RandomInt(1, #units)
units[unit_1].item = patrol_item

for _,unit in pairs(units) do 
	unit.friends = {}
	for _,friend in pairs(units) do 
		if friend ~= unit then 
			table.insert(unit.friends, friend)
		end
	end
end

end



