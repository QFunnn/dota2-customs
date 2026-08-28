--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local TRAP_SETTINGS = {
	{
		npc_name = "1_last_traps_move_npc",
		target_name = "1_last_traps_move_target",
		model_name = "1_last_traps_move_model",
		max_shots = 1,
		interval = 1,
		cooldown = 2.3,
		damage_prc = 150,
		damage = 0,
		shot_range = 2700,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
	{
		npc_name = "2_last_traps_move_npc",
		target_name = "2_last_traps_move_target",
		model_name = "2_last_traps_move_model",
		max_shots = 1,
		interval = 1,
		cooldown = 2.8,
		damage_prc = 150,
		damage = 0,
		shot_range = 2700,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
	{
		npc_name = "3_last_traps_move_npc",
		target_name = "3_last_traps_move_target",
		model_name = "3_last_traps_move_model",
		max_shots = 1,
		interval = 1,
		cooldown = 2,
		damage_prc = 150,
		damage = 0,
		shot_range = 2700,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
	{
		npc_name = "4_last_traps_move_npc",
		target_name = "4_last_traps_move_target",
		model_name = "4_last_traps_move_model",
		max_shots = 2,
		interval = 0.8,
		cooldown = 1.5,
		damage_prc = 150,
		damage = 0,
		shot_range = 2500,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
	{
		npc_name = "5_last_traps_move_npc",
		target_name = "5_last_traps_move_target",
		model_name = "5_last_traps_move_model",
		max_shots = 2,
		interval = 0.7,
		cooldown = 1.1,
		damage_prc = 150,
		damage = 0,
		shot_range = 2500,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
	{
		npc_name = "6_last_traps_move_npc",
		target_name = "6_last_traps_move_target",
		model_name = "6_last_traps_move_model",
		max_shots = 3,
		interval = 0.5,
		cooldown = 1,
		damage_prc = 150,
		damage = 0,
		shot_range = 2500,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
	{
		npc_name = "7_last_traps_move_npc",
		target_name = "7_last_traps_move_target",
		model_name = "7_last_traps_move_model",
		max_shots = 2,
		interval = 0.7,
		cooldown = 1.5,
		damage_prc = 150,
		damage = 0,
		shot_range = 2500,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
}

for _, trap in pairs(TRAP_SETTINGS) do
	trap.current_shots = trap.max_shots
end

local MOVE_TRAP_SETTINGS = {
	{
		npc_name = "1_last_traps_move_npc",
		model_name = "1_last_traps_move_model",
		min_x = 13500,
		max_x = 14900,
		speed = 500,
		direction = 1,
		npc_ent = nil,
		model_ent = nil,
	},
	{
		npc_name = "2_last_traps_move_npc",
		model_name = "2_last_traps_move_model",
		min_x = 13500,
		max_x = 14900,
		speed = 500,
		direction = -1,
		npc_ent = nil,
		model_ent = nil,
	},
}

function start_shot()
	for _, trap in pairs(MOVE_TRAP_SETTINGS) do
		trap.npc_ent = Entities:FindByName(nil, trap.npc_name)
		trap.model_ent = Entities:FindByName(nil, trap.model_name)
		if trap.npc_ent and trap.model_ent then
			trap.model_ent:SetParent(trap.npc_ent, "")
			trap.model_ent:SetAngles(0, 270, 0)
		end
	end

	thisEntity:SetContextThink("mine_zone_spawner", MineZoneSpawner, 0.5)
	thisEntity:SetContextThink("universal_trap_thinker", UniversalTrapThinker, 0.5)
	thisEntity:SetContextThink("MoveLogic", MoveTick, 0.03)
end

---------------------------------------------------------------------------------

LinkLuaModifier("modifier_mine_ultra_lua_thinker", "abilities/ultra_skills", LUA_MODIFIER_MOTION_NONE)

local MINE_ZONE_NAMES = {
	"mine_zone_1",
	"mine_zone_2",
}

function MineZoneSpawner()
	if not IsServer() then
		return -1
	end
	for _, zone_name in pairs(MINE_ZONE_NAMES) do
		local point = Entities:FindByName(nil, zone_name):GetAbsOrigin()
		for i = 1, 6 do
			local offset = RandomVector(1):Normalized() * RandomInt(200, 600)
			local spawn_pos = point + offset
			local mine = CreateUnitByName("npc_zone_8_creep_land_mines", spawn_pos, true, nil, nil, DOTA_TEAM_NEUTRALS)
			if mine then
				mine:AddNewModifier(nil, nil, "modifier_mine_ultra_lua_thinker", {})
				Timers:CreateTimer(3, function()
					if mine and not mine:IsNull() then
						UTIL_Remove(mine)
					end
				end)
			end
		end
	end
	return 3
end

---------------------------------------------------------------------------------

function MoveTick()
	local dt = 0.03

	for _, trap in pairs(MOVE_TRAP_SETTINGS) do
		local npc = trap.npc_ent
		if npc and not npc:IsNull() then
			local currentPos = npc:GetAbsOrigin()
			local nextX = currentPos.x + (trap.speed * dt * trap.direction)
			if nextX >= trap.max_x then
				nextX = trap.max_x
				trap.direction = -1
			elseif nextX <= trap.min_x then
				nextX = trap.min_x
				trap.direction = 1
			end
			local newPos = Vector(nextX, currentPos.y, currentPos.z)
			npc:SetAbsOrigin(newPos)

			-- if trap.model_ent and not trap.model_ent:IsNull() then
			--     trap.model_ent:SetAbsOrigin(newPos)
			-- end
		end
	end
	return dt
end

---------------------------------------------------------------------------------

function UniversalTrapThinker()
	if not IsServer() then
		return -1
	end
	local next_think = 0.1

	if GameRules:IsGamePaused() then
		return next_think
	end

	for _, trap in pairs(TRAP_SETTINGS) do
		if not trap.wait_until or GameRules:GetGameTime() >= trap.wait_until then
			if trap.current_shots > 0 then
				FireSingleTrap(trap)
				trap.current_shots = trap.current_shots - 1
				trap.wait_until = GameRules:GetGameTime() + trap.interval
			else
				trap.current_shots = trap.max_shots
				trap.wait_until = GameRules:GetGameTime() + trap.cooldown
			end
		end
	end
	return next_think
end

function FireSingleTrap(data)
	local npc = Entities:FindByName(nil, data.npc_name)
	local target = Entities:FindByName(nil, data.target_name)

	if npc and target then
		local ability = npc:FindAbilityByName("simple_trap_shot")
		if ability then
			ability.damage_prc = data.damage_prc
			ability.shot_range = data.shot_range
			ability.damage = data.damage
			ability.particle = data.particle
			-- ability.sound = "Dungeon.FireTrap"

			if data.model_name then
				DoEntFire(data.model_name, "SetAnimation", "bark_attack", 0.1, nil, nil)
			end
			npc:CastAbilityOnPosition(target:GetOrigin(), ability, -1)
		end
	end
end

---------------------------------------------------------------------

function circle_last_zone_off()
	local circle_traps = Entities:FindAllByName("npc_dota_last_circle")
	for _, trap in pairs(circle_traps) do
		if trap and IsValidEntity(trap) then
			if trap:IsAlive() then
				UTIL_Remove(trap)
				-- trap:ForceKill(false)
			end
		end
	end
	local triggerName = thisEntity:GetName()
	local button = triggerName .. "_button"
	DoEntFire(button, "SetAnimation", "ancient_trigger001_down", 0, self, self)
	DoEntFire(button, "SetAnimation", "ancient_trigger001_down_idle", 0.35, self, self)
end