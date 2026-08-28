--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_no_heal", "modifiers/modifier_no_heal", LUA_MODIFIER_MOTION_NONE)

local TRAP_SETTINGS = {
	{
		npc_name = "zone_2_trap_1",
		target_name = "zone_2_target_1",
		model_name = "zone_2_trap_model_1",
		max_shots = 3,
		interval = 0.3,
		cooldown = 1.7,
		damage_prc = 35,
		damage = 0,
		shot_range = 1000,
		particle = "particles/traps_zone_2/auto_shot_trap.vpcf",
	},
	{
		npc_name = "zone_2_trap_2",
		target_name = "zone_2_target_2",
		model_name = "zone_2_trap_model_2",
		max_shots = 2,
		interval = 0.2,
		cooldown = 0.9,
		damage_prc = 35,
		damage = 0,
		shot_range = 700,
		particle = "particles/traps_zone_2/auto_shot_trap.vpcf",
	},
	{
		npc_name = "zone_2_trap_3",
		target_name = "zone_2_target_3",
		model_name = "zone_2_trap_model_3",
		max_shots = 3,
		interval = 0.3,
		cooldown = 1.1,
		damage_prc = 35,
		damage = 0,
		shot_range = 1000,
		particle = "particles/traps_zone_2/auto_shot_trap.vpcf",
	},
	{
		npc_name = "zone_2_trap_4",
		target_name = "zone_2_target_4",
		model_name = "zone_2_trap_model_4",
		max_shots = 3,
		interval = 0.3,
		cooldown = 2.1,
		damage_prc = 35,
		damage = 0,
		shot_range = 1100,
		particle = "particles/traps_zone_2/auto_shot_trap.vpcf",
	},
	{
		npc_name = "zone_2_trap_5",
		target_name = "zone_2_target_5",
		model_name = "zone_2_trap_model_5",
		max_shots = 1,
		interval = 0.3,
		cooldown = 1.3,
		damage_prc = 200,
		damage = 0,
		shot_range = 1800,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
	{
		npc_name = "zone_2_trap_6",
		target_name = "zone_2_target_6",
		model_name = "zone_2_trap_model_6",
		max_shots = 2,
		interval = 0.3,
		cooldown = 1.2,
		damage_prc = 35,
		damage = 0,
		shot_range = 1300,
		particle = "particles/traps_zone_2/auto_shot_trap.vpcf",
	},
	{
		npc_name = "zone_2_trap_7",
		target_name = "zone_2_target_7",
		model_name = "zone_2_trap_model_7",
		max_shots = 1,
		interval = 0.5,
		cooldown = 0.5,
		damage_prc = 200,
		damage = 0,
		shot_range = 1200,
		particle = "particles/traps/temple_trap_arrow.vpcf",
	},
	{
		npc_name = "zone_2_trap_8",
		target_name = "zone_2_target_8",
		model_name = "zone_2_trap_model_8",
		max_shots = 2,
		interval = 0.3,
		cooldown = 1.5,
		damage_prc = 35,
		damage = 0,
		shot_range = 1100,
		particle = "particles/traps_zone_2/auto_shot_trap.vpcf",
	},
	{
		npc_name = "zone_2_trap_9",
		target_name = "zone_2_target_9",
		model_name = "zone_2_trap_model_9",
		max_shots = 2,
		interval = 0.3,
		cooldown = 2.4,
		damage_prc = 35,
		damage = 0,
		shot_range = 900,
		particle = "particles/traps_zone_2/auto_shot_trap.vpcf",
	},
}

for _, trap in pairs(TRAP_SETTINGS) do
	trap.current_shots = trap.max_shots
end

_G.Fast_shot = true
_G.All_traps_zone_2 = true

function start_shot()
	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayerID(nPlayerID) and PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
			local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
			if hero then
				if not hero:IsAlive() then
					local point = hero:GetAbsOrigin()
					hero:RespawnHero(false, false)
					hero:SetAbsOrigin(point)
					FindClearSpaceForUnit(hero, point, false)
				end

				hero:SetHealth(hero:GetMaxHealth())
				hero:SetMana(hero:GetMaxMana())
				hero:Purge(false, true, false, true, false)
				hero:Stop()

				if not hero:HasModifier("modifier_no_heal") then
					hero:AddNewModifier(hero, nil, "modifier_no_heal", {})
				end
			end
		end
	end

	if quest_system then
		quest_system:StartQuest("additional", 103)
	end
	thisEntity:SetContextThink("universal_trap_thinker", UniversalTrapThinker, 0.5)
end

function UniversalTrapThinker()
	if not IsServer() or not _G.All_traps_zone_2 then
		local circle_traps = Entities:FindAllByName("npc_dota_first_circle_trap")
		for _, trap in pairs(circle_traps) do
			if trap and IsValidEntity(trap) then
				if trap:IsAlive() then
					trap:ForceKill(false)
				end
			end
		end

		for _, trap in pairs(TRAP_SETTINGS) do
			local npc = Entities:FindByName(nil, trap.npc_name)
			if npc then
				UTIL_Remove(npc)
			end
		end
		return -1
	end

	if GameRules:IsGamePaused() then
		return 0.1
	end

	local next_think = 0.1

	for _, trap in pairs(TRAP_SETTINGS) do
		if trap.npc_name == "zone_2_trap_7" and _G.Fast_shot == false then
		else
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

			if data.model_name then
				DoEntFire(data.model_name, "SetAnimation", "bark_attack", 0.1, nil, nil)
			end
			npc:CastAbilityOnPosition(target:GetOrigin(), ability, -1)
		end
	end
end

---------------------------------------------------------------------

function DisableFastTrap()
	_G.Fast_shot = false
	local triggerName = thisEntity:GetName()
	local button = triggerName .. "_button"
	DoEntFire(button, "SetAnimation", "ancient_trigger001_down", 0, self, self)
	DoEntFire(button, "SetAnimation", "ancient_trigger001_down_idle", 0.35, self, self)
end

function DisableAllTrap()
	_G.All_traps_zone_2 = false

	if _G.players_quest_progress and _G.players_quest_progress["additional"][103] then
		_G.players_quest_progress["additional"][103].completed = true
		quest_system:RemoveQuest("additional", 103, "success")
	end

	local heroes = HeroList:GetAllHeroes()
	for _, hero in pairs(heroes) do
		if hero:IsRealHero() and hero:GetTeam() == DOTA_TEAM_GOODGUYS then
			hero:RemoveModifierByName("modifier_no_heal")
		end
	end
end

---------------------------------------------------------------------

local triggerActive = true

function OnStartTouch(trigger)
	local triggerName = thisEntity:GetName()
	local button = triggerName .. "_button"

	if not triggerActive then
		return
	end

	local npc_name = "zone_2_trap_10"
	local target_name = "zone_2_target_10"
	local model_name = "zone_2_trap_model_10"
	local damage_prc = 0
	local damage = 1
	local shot_range = 1300
	local particle = "particles/traps_zone_2/auto_shot_trap.vpcf"

	triggerActive = false

	local npc = Entities:FindByName(nil, npc_name)
	local target = Entities:FindByName(nil, target_name)

	if npc and target then
		local ability = npc:FindAbilityByName("simple_trap_shot")
		if ability then
			ability.damage_prc = damage_prc
			ability.shot_range = shot_range
			ability.damage = damage
			ability.particle = particle

			DoEntFire(button, "SetAnimation", "ancient_trigger001_down", 0, self, self)
			DoEntFire(button, "SetAnimation", "ancient_trigger001_down_idle", 0.35, self, self)

			if model_name then
				DoEntFire(model_name, "SetAnimation", "bark_attack", 0.1, nil, nil)
				ResetButtonModel(button)
			end
			npc:CastAbilityOnPosition(target:GetOrigin(), ability, -1)
		end
	end
end

function ResetButtonModel(button)
	DoEntFire(button, "SetAnimation", "ancient_trigger001_up", 0.5, self, self)
	DoEntFire(button, "SetAnimation", "ancient_trigger001_idle", 0.6, self, self)
	triggerActive = true
end

---------------------------------------------------------------------

_G.buttons = {
	trigger_box_1 = { state = false, entity = nil },
	trigger_box_2 = { state = false, entity = nil },
	trigger_box_3 = { state = false, entity = nil },
	trigger_box_4 = { state = false, entity = nil },
}

function CheckAllButtonsPressed()
	for _, button in pairs(buttons) do
		if not button.state then
			return false
		end
	end
	return true
end

function OnButton(trigger)
	local triggerName = thisEntity:GetName()
	local entity = trigger.activator

	if not entity:IsIllusion() and buttons[triggerName].state == false then
		local button = triggerName .. "_button"
		DoEntFire(button, "SetAnimation", "ancient_trigger001_down", 0, self, self)
		DoEntFire(button, "SetAnimation", "ancient_trigger001_down_idle", 0.35, self, self)
		local npc = Entities:FindByName(nil, button)
		npc:SetSkin(1)

		buttons[triggerName].state = true
		buttons[triggerName].entity = entity

		if CheckAllButtonsPressed() then
			local hRelay = Entities:FindByName(nil, "trap_2_logic")
			hRelay:Trigger(nil, nil)
		end
	end
end

function OffButton(trigger)
	local triggerName = thisEntity:GetName()
	local entity = trigger.activator

	if not entity:IsIllusion() and buttons[triggerName].state == true and buttons[triggerName].entity == entity then
		local button = triggerName .. "_button"
		DoEntFire(button, "SetAnimation", "ancient_trigger001_up", 0.5, self, self)
		DoEntFire(button, "SetAnimation", "ancient_trigger001_idle", 0.6, self, self)
		local npc = Entities:FindByName(nil, button)
		npc:SetSkin(2)

		buttons[triggerName].state = false
		buttons[triggerName].entity = nil
	end
end