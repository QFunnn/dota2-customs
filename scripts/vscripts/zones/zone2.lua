--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function quest_start(data)
	quest_system:StartQuest("main", 3)
end

function creep_spawn()
	random_ability = passive[RandomInt(1, #passive)]

	local unit_types = { "npc_dota_zone_2_unit_2", "npc_dota_zone_2_unit_3", "npc_dota_zone_2_unit_4" }
	local modifiers_to_remove = {
		"modifier_invulnerable",
		"modifier_medusa_stone_gaze_stone",
		"modifier_magic_immune",
	}

	for _, unit_name in ipairs(unit_types) do
		local units = Entities:FindAllByName(unit_name)
		for _, unit in pairs(units) do
			rules:aura_dif(unit, random_ability)
			for _, mod_name in ipairs(modifiers_to_remove) do
				unit:RemoveModifierByName(mod_name)
			end
		end
	end

	if _G.Game_Difficulty >= 12 then
		Timers:CreateTimer(3, function()
			Notifications:TopToAll({ text = "#usilenie", duration = 3, style = { color = "red" } })
			Notifications:TopToAll({ text = "#DOTA_Tooltip_ability_" .. random_ability, duration = 3 })
			rules:updateExtraAbility("creeps", random_ability)
		end)
	end

	for i = 9, 18 do
		local point = Entities:FindByName(nil, "crate" .. i):GetAbsOrigin()
		for j = 1, 4 do
			CreateUnitByName("npc_dota_crate", point + RandomVector(50), true, nil, nil, DOTA_TEAM_NEUTRALS)
		end
	end

	rules:clear_zone("crate", 9, 18)
end

-------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_bad_vision", "modifiers/modifier_bad_vision", LUA_MODIFIER_MOTION_NONE)

function visions(trigger)
	local ent = trigger.activator
	if not ent or not ent:IsRealHero() then
		return
	end
	ent:AddNewModifier(ent, nil, "modifier_bad_vision", {})
end