--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "reload"
local b = require("lualib_bundle")
local c = b.__TS__ArrayForEach
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["5"] = 1,
		["6"] = 2,
		["7"] = 2,
		["8"] = 2,
		["9"] = 3,
		["10"] = 2,
		["11"] = 2,
		["12"] = 5,
		["13"] = 5,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 5,
		["18"] = 8,
		["19"] = 9,
		["20"] = 11,
		["21"] = 12,
		["22"] = 12,
		["23"] = 12,
		["24"] = 13,
		["25"] = 12,
		["26"] = 12,
		["27"] = 15,
		["28"] = 17,
		["29"] = 18,
		["30"] = 19,
		["31"] = 21,
		["32"] = 21,
		["33"] = 21,
		["34"] = 21,
		["35"] = 21,
		["36"] = 21,
		["37"] = 21,
		["38"] = 21,
		["39"] = 21,
		["40"] = 21,
		["41"] = 21,
		["42"] = 22,
		["43"] = 23,
		["44"] = 24,
		["45"] = 25,
		["47"] = 26,
		["48"] = 26,
		["49"] = 26,
		["50"] = 26,
		["51"] = 26,
		["52"] = 26,
		["54"] = 27,
		["55"] = 27,
		["56"] = 28,
		["57"] = 29,
		["58"] = 30,
		["59"] = 31,
		["60"] = 32,
		["63"] = 27,
		["68"] = 86,
		["71"] = 90,
	}
)
if Activated then
	c(GameEventListenerIDs, function(e, f)
		StopListeningToGameEvent(f)
	end)
	c(CustomUIEventListenerIDs, function(e, f)
		CustomGameEventManager:UnregisterListener(f)
	end)
	_G.GameEventListenerIDs = {}
	_G.CustomUIEventListenerIDs = {}
	if IsServer() then
		c(TimerEventListenerIDs, function(e, f)
			StopTimer(f)
		end)
		_G.TimerEventListenerIDs = {}
		if GameRules:State_Get() > DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
			GameRules:Playtesting_UpdateAddOnKeyValues()
			FireGameEvent("client_reload_game_keyvalues", {})
			local g = FindUnitsInRadius(
				DOTA_TEAM_GOODGUYS,
				vec3_zero,
				nil,
				-1,
				DOTA_UNIT_TARGET_TEAM_BOTH,
				DOTA_UNIT_TARGET_ALL,
				DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
					+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
					+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
				0,
				false
			)
			for e, h in ipairs(g) do
				if IsValid(h) then
					while h:HasModifier("modifier_common") do
						h:RemoveModifierByName("modifier_common")
					end
					h:AddNewModifier(h, h:GetDummyAbility(), "modifier_common", nil)
					do
						local i = 0
						while i <= h:GetAbilityCount() - 1 do
							local j = h:GetAbilityByIndex(i)
							if IsValid(j) then
								if j:GetIntrinsicModifierName() ~= nil and j:GetIntrinsicModifierName() ~= "" then
									h:RemoveModifierByName(j:GetIntrinsicModifierName())
									j:RefreshIntrinsicModifier()
								end
							end
							i = i + 1
						end
					end
				end
			end
			print("Reload Scripts")
		end
	end
	CModule:reload()
end