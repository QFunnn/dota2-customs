--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function xrequire(path)
	local files = require(path .. "._loader")
	if not files then
		error("xrequire Failed to load" .. path)
	end

	if files and type(files) == "table" then
		for _, file in pairs(files) do
			require(path .. "." .. file)
		end
	elseif files and not type(files) == "table" then
		print(path, "doesnt return a table contains files to require, ignoring!!!!")
	end
end

function ConvertSteamID32_64(steamid32)
	if not tonumber(steamid32) then
		return nil
	end
	return "7656" .. tostring(tonumber(steamid32) + 1197960265728)
end

function SteamID2PlayerID(steamid)
	for i = 0, DOTA_MAX_TEAM_PLAYERS do
		if PlayerResource:GetSteamAccountID(i) == steamid then
			return i
		end
	end
end

function Hero2Player(hero)
	return PlayerResource:GetPlayer(hero:GetPlayerID())
end

function ID2Hero(id)
	return PlayerResource:GetPlayer(id):GetAssignedHero()
end

function ID2Player(id)
	return PlayerResource:GetPlayer(id)
end

function IsValidAlive(ent)
	return ent ~= nil and not ent:IsNull() and ent.IsAlive ~= nil and ent:IsAlive()
end

-- 将c++里传出来的str形式的vector转换为vector
function StringToVector(str)
	if str == nil then
		return
	end
	local table = string.split(str, " ")
	return Vector(tonumber(table[1]), tonumber(table[2]), tonumber(table[3])) or nil
end

function IsValid(h)
	return h ~= nil and not h:IsNull()
end