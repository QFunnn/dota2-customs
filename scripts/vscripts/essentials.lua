--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
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

	essentials.currentHpBar = false
end

function essentials:OnEntityHurt(t)
	local attacker_index = t.entindex_attacker_const
	local victim_index = t.entindex_victim_const
	if attacker_index and victim_index then
		local attacker = EntIndexToHScript(attacker_index)
		local victim = EntIndexToHScript(victim_index)
		if attacker and victim then
			if attacker:IsRealHero() then
				local pid = attacker:GetPlayerOwnerID()
				if pid and pid >= 0 then
					local hp = victim:GetHealth()
					local dmg = 0
					if attacker:IsAlive() then
						if t.damagetype_const == DAMAGE_TYPE_MAGICAL then
							dmg = t.damage - victim:GetBaseMagicalResistanceValue() / 100 * t.damage
							if dmg > hp then
								dmg = hp
							end
						elseif t.damagetype_const == DAMAGE_TYPE_PHYSICAL then
							local armor = victim:GetPhysicalArmorValue(false)
							local factor = 1 - ((0.06 * armor) / (1 + 0.06 * math.abs(armor)))
							dmg = t.damage * factor
							if dmg > hp then
								dmg = hp
							end
						elseif t.damagetype_const == DAMAGE_TYPE_PURE then
							dmg = t.damage
							if dmg > hp then
								dmg = hp
							end
						end
					end

					if _G.player_quest[pid]["damage_quest"] == nil then
						_G.player_quest[pid]["damage_quest"] = dmg
					else
						_G.player_quest[pid]["damage_quest"] = _G.player_quest[pid]["damage_quest"] + dmg
					end

					if essentials.dmgtable[pid] then
						essentials.dmgtable[pid].dealt = essentials.dmgtable[pid].dealt + dmg
					end
				end
			end

			-- received damage: victim is a real hero
			if victim:IsRealHero() then
				local pid = victim:GetPlayerOwnerID()
				if pid and pid >= 0 and essentials.dmgtable[pid] then
					essentials.dmgtable[pid].received = essentials.dmgtable[pid].received + t.damage
				end
			end
		end
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