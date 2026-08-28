--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


if essentials == nil then
	essentials = class({})
end

function essentials:Init()
	local m = GameRules:GetGameModeEntity()
	CustomGameEventManager:RegisterListener("startreq", Dynamic_Wrap(self, "StartReq"))

	GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(essentials, "OnEntityHurt"), self)
	essentials.dmgtable = {}
	for i = 0, 4 do
		essentials.dmgtable[i] = { dealt = 0, received = 0 }
	end

	essentials.hero_index = {}
	ListenToGameEvent("npc_spawned", function(event)
		local unit = EntIndexToHScript(event.entindex)
		if unit and unit:IsRealHero() then
			local pid = unit:GetPlayerOwnerID()
			if pid and pid >= 0 then
				essentials.hero_index[event.entindex] = pid
				return
			end
		end
		essentials.hero_index[event.entindex] = nil
	end, nil)

	essentials.currentHpBar = false
end

function essentials:OnEntityHurt(t)
	local attacker_index = t.entindex_attacker_const
	local victim_index = t.entindex_victim_const
	if not attacker_index or not victim_index then
		return true
	end

	local hero_index = essentials.hero_index
	local attacker_pid = hero_index[attacker_index]
	local victim_pid = hero_index[victim_index]

	if attacker_pid == nil and victim_pid == nil then
		return true
	end

	if attacker_pid ~= nil then
		local attacker = EntIndexToHScript(attacker_index)
		local victim = EntIndexToHScript(victim_index)
		if attacker and victim then
			local dmg = 0
			if attacker:IsAlive() then
				local damage_type = t.damagetype_const
				if damage_type == DAMAGE_TYPE_MAGICAL then
					dmg = t.damage - victim:GetBaseMagicalResistanceValue() / 100 * t.damage
				elseif damage_type == DAMAGE_TYPE_PHYSICAL then
					local armor = victim:GetPhysicalArmorValue(false)
					local factor = 1 - ((0.06 * armor) / (1 + 0.06 * math.abs(armor)))
					dmg = t.damage * factor
				elseif damage_type == DAMAGE_TYPE_PURE then
					dmg = t.damage
				end

				local hp = victim:GetHealth()
				if dmg > hp then
					dmg = hp
				end
			end

			local quest = _G.player_quest[attacker_pid]
			if quest then
				quest["damage_quest"] = (quest["damage_quest"] or 0) + dmg
			end

			if essentials.dmgtable[attacker_pid] then
				essentials.dmgtable[attacker_pid].dealt = essentials.dmgtable[attacker_pid].dealt + dmg
			end
		end
	end

	if victim_pid ~= nil and essentials.dmgtable[victim_pid] then
		essentials.dmgtable[victim_pid].received = essentials.dmgtable[victim_pid].received + t.damage
	end

	return true
end

function essentials:ResetDmgTable(pid)
	essentials.dmgtable[pid] = { dealt = 0, received = 0 }
end

function essentials:ShowNewLoc(name, name2, image, time)
	CustomGameEventManager:Send_ServerToAllClients(
		"showLoc",
		{ name = name, name2 = name2, image = image, time = time }
	)
end

function essentials:createCustomHpBarFor(unit)
	if unit and not unit:IsNull() and unit:IsAlive() then
		essentials.currentHpBar = unit
		CustomGameEventManager:Send_ServerToAllClients("showHpBar", { unit = unit:entindex() })
	end
end

function essentials:StartReq(t)
	local unit = essentials.currentHpBar

	if not unit or unit:IsNull() or not unit:IsAlive() then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "showHpBar", { unit = unit })
end