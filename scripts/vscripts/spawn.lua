--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



function dota1x6:shuffle(tbl)
for i = #tbl, 2, -1 do
  local j = RandomInt(1, i)
  tbl[i], tbl[j] = tbl[j], tbl[i]
end

return tbl
end


---
function dota1x6:initiate_waves()
local first = {}
local second = {}
local boss = {}
local used_numbers = {}
local random_factor = 0


for i = 2,#wave_types do
	local data = wave_types[i]
	if data then
		local creeps_type = data.creeps_type
		if creeps_type == 0 then
			first[#first+1] = i
		elseif creeps_type == 1 then
			second[#second+1] = i
		elseif creeps_type == 2 then
			boss[#boss+1] = i
		end
	end
end


first = dota1x6:shuffle(first)
second = dota1x6:shuffle(second)
boss = dota1x6:shuffle(boss)

first[1] = 1

for i = 1,7 do
	waves[#waves + 1] = first[i]
end

for i = 1,#second do
	waves[#waves + 1] = second[i]
end

for i = 1,#waves do
	local data = wave_types[waves[i]]
	if data then
		if data.creeps[1] == "npc_goodsiege" and i ~= 16 then
			local buffer = waves[16]
			waves[16] = waves[i]
			waves[i] = buffer
			break
		end
	end
end

for i = 1,#waves do
	local data = wave_types[waves[i]]
	if data then
		if data.creeps[1] == "npc_badsiege" and i ~= 18 then
			local buffer = waves[18]
			waves[18] = waves[i]
			waves[i] = buffer
			break
		end
	end
end

for i = 1,2 do
	repeat random_factor = RandomInt(1, #boss)
  until not self:check_used(used_numbers,random_factor)
	used_numbers[#used_numbers + 1] = random_factor
	boss_waves[#boss_waves + 1] = boss[random_factor]
end

if test_wave ~= 0 then 
  for i = 1,#waves do  
  	waves[i] = test_wave
  end
  for i = 1,#boss_waves do  
  	boss_waves[i] = test_wave 
  end
end

if test then
	for i = 1,#waves do
		local data = wave_types[waves[i]]
		if data and data.creeps then
			--print(i,  data.creeps[1])
		end
	end
	for i = 1,#boss_waves do  
		local data = wave_types[boss_waves[i]]
		if data and data.creeps then
			--print(i,  data.creeps[1])
		end
	end
end

end

function dota1x6:GetMkb( index, is_boss )

local array = waves
if is_boss then
	array = boss_waves
end
if not array[index] then return end

local data = wave_types[array[index]]

if not data or not data.mkb then return 0 end
return data.mkb
end	



function dota1x6:GetSkills( index, is_boss )
local array = waves
if is_boss then
	array = boss_waves
end
local skills = {}
if array[index] then
	local data = wave_types[array[index]]
	if data and data.skills then
		skills = data.skills
	end
end

return skills
end


function dota1x6:GetWave( index, is_boss )
local array = waves
if is_boss then
	array = boss_waves
end
local name = ""
if array[index] then 
	local data = wave_types[array[index]]
	if data and data.creeps then
		name = data.creeps[1]
	end
end
return name 
end	



function dota1x6:SpawnNecro(team, caster_team, damage_out, damage_inc)
if not IsServer() then return end
if not teleports[team] then return end 

local number = tonumber(teleports[team]:GetName())
local ally = {}

for i = 1,#necro_wave_info do 
	local spawner = Entities:FindByName( nil, "spawner_team" ..number ):GetAbsOrigin()+RandomVector(RandomInt(-1, 1) + 125)
  local unit = dota1x6:CreateUnitCustom(necro_wave_info[i], spawner, true, nil, nil, DOTA_TEAM_CUSTOM_5, function(unit) 

  	unit.host_team = team
  	unit.is_necro_creep = true

  	unit:AddNewModifier(unit, nil, "modifier_waveupgrade", {wave = wave_number})
  	ally[#ally + 1] = unit 

  	if i == #necro_wave_info then
  		for j = 1,#ally do 
  			ally[j].ally = ally
  			ally[j]:AddNewModifier(ally[j], nil, "modifier_item_patrol_necro_creeps", {caster_team = caster_team, damage_out = damage_out, damage_inc = damage_inc})
  		end 
  	end 
  end)
end 

end 


function dota1x6:spawn_wave( team , wave_number, boss, lownet, more_gold, trap_wave, show_gold)
if not teleports[team] then return end 

local ids = dota1x6:FindPlayers(team)
if not ids then return end

local current_wave = {}
local array = waves
if boss then
	After_Lich = true
	array = boss_waves
end
if not array[wave_number] then return end

local data = wave_types[array[wave_number]]

if not data or not data.creeps then return end

for i = 1,#data.creeps do
	table.insert(current_wave, data.creeps[i])
end

local max = #current_wave
local current_wave_number = dota1x6.current_wave
local allys = {}
local spawned_count = 0
local has_mkb = 0
if data.mkb then
	has_mkb = data.mkb
end

if max == 0 then return end

for _,id in pairs(ids) do
	local player = players[id]
	if player then
		player.reward = nil
		player.ActiveWave = {}
	end
end

local number = tonumber(teleports[team]:GetName())

for _,creep_name in pairs(current_wave) do

	local spawner = Entities:FindByName( nil, "spawner_team" ..number ):GetAbsOrigin()+RandomVector(RandomInt(-1, 1) + 125)
	local unit = dota1x6:CreateUnitCustom(creep_name, spawner, true, nil, nil, DOTA_TEAM_CUSTOM_5, function(unit) 

		local index = spawned_count + 1
		spawned_count = index

		unit.isboss = boss
		unit.max = max
		unit.wave_number = wave_number
		unit.host_team = team
		unit.number = index
		unit.more_gold = more_gold
		unit.show_gold = show_gold
		unit.lownet = lownet
		unit.mkb = has_mkb
		unit.current_wave_number = current_wave_number

		if unit.more_gold then 
			local gold = unit:GetMinimumGoldBounty()
			unit:SetMinimumGoldBounty(gold*unit.more_gold/100)
			unit:SetMaximumGoldBounty(gold*unit.more_gold/100)
		end

		allys[index] = unit

		if not DontUpgradeCreeps then
			if not boss or (unit:GetUnitName() == "npc_necro_melle" or unit:GetUnitName() == "npc_necro_range") then 
				unit:AddNewModifier(unit, nil, "modifier_waveupgrade", {wave = wave_number})
			else 
				unit:AddNewModifier(unit, nil, "modifier_waveupgrade_boss", {wave = wave_number})
			end
		end

		if index == max then

			for count = 1,index do
				allys[count].ally = allys 		
			end

			for _,id in pairs(ids) do
				local player = players[id]
				if player then 
					local next_wave = dota1x6:GetWave(wave_number, boss)
					local skills = dota1x6:GetSkills(wave_number, boss)
					local mkb = dota1x6:GetMkb(wave_number, boss)
					local reward = dota1x6:GetReward(current_wave_number, player)
					player.ActiveWave = {units = max, units_max = max, time = -1, max = -1, name = next_wave, skills = skills, mkb = mkb, reward = reward, gold = more_gold, show_gold = show_gold, number = dota1x6.current_wave, hide = false}
		      CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(player:GetId()), 'timer_progress',  player.ActiveWave)    
		    end
			end
		end

		if trap_wave == true then 
	    unit:EmitSound("UI.Creeps_trap_active")
			unit:AddNewModifier(unit, nil, "modifier_creeps_trap", {duration = Trap_Duration, team = team})
		end
	end)
end


end





function dota1x6:spawn_portal( team, necro_caster )

local number = tonumber(teleports[team]:GetName())
local point = Entities:FindByName( nil, "spawner_team" ..number ):GetAbsOrigin()
local teleport_center = CreateUnitByName("npc_dota_companion", point, false, nil, nil, 0)
teleport_center:AddNewModifier(teleport_center, nil, "modifier_phased", {})
teleport_center:AddNewModifier(teleport_center, nil, "modifier_invulnerable", {})
teleport_center:AddNewModifier(teleport_center, nil, "modifier_unselect", {})

if necro_caster then
	AddFOWViewer(necro_caster, point, 500, PortalDelay + 0.1, false)
end

Timers:CreateTimer(0.1, function()
	if IsValid(teleport_center) then
		teleport_center:EmitSound("UI.Creep_portal_loop")
	end
end)

teleport_center.nWarningFX = ParticleManager:CreateParticle( "particles/portals/portal_ground_spawn_endpoint.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( teleport_center.nWarningFX, 0, teleport_center:GetAbsOrigin() )

Timers:CreateTimer(PortalDelay+0.3,function()
	ParticleManager:DestroyParticle(teleport_center.nWarningFX, true)
	teleport_center:StopSound("UI.Creep_portal_loop")
	teleport_center:EmitSound("UI.Creep_portal_end")
	teleport_center:Destroy()
end)


end



