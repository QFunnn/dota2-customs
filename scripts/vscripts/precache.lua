--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local ____exports = {}
local precacheEveryResourceInKV, precacheResource, precacheResString, precacheUnits, precacheItems, precacheEverythingFromTable, precacheParticleList
require("global.both.particle_list")
function precacheEveryResourceInKV(kvFileList, context)
	__TS__ArrayForEach(kvFileList, function(____, file)
		local kvTable = LoadKeyValues(file)
		precacheEverythingFromTable(kvTable, context)
	end)
end
function precacheResource(resourceList, context)
	__TS__ArrayForEach(resourceList, function(____, resource)
		precacheResString(resource, context)
	end)
end
function precacheResString(res, context)
	if __TS__StringEndsWith(res, ".vpcf") then
		PrecacheResource("particle", res, context)
	elseif __TS__StringEndsWith(res, ".vsndevts") then
		PrecacheResource("soundfile", res, context)
	elseif __TS__StringEndsWith(res, ".vmdl") then
		PrecacheResource("model", res, context)
	end
end
function precacheUnits(unitNamesList, context)
	if context ~= nil then
		__TS__ArrayForEach(unitNamesList, function(____, unitName)
			PrecacheUnitByNameSync(unitName, context)
		end)
	else
		__TS__ArrayForEach(unitNamesList, function(____, unitName)
			PrecacheUnitByNameAsync(unitName, function() end)
		end)
	end
end
function precacheItems(itemList, context)
	__TS__ArrayForEach(itemList, function(____, itemName)
		PrecacheItemByNameSync(itemName, context)
	end)
end
function precacheEverythingFromTable(kvTable, context)
	for k, v in pairs(kvTable) do
		if type(v) == "table" then
			precacheEverythingFromTable(v, context)
		elseif type(v) == "string" then
			precacheResString(v, context)
		end
	end
end
function precacheParticleList(context)
	for ____, list in ipairs({ ITEM_PARTICLES, GENERIC_PARTICLES, TEST_PARTICLES, BLESS_PARTICLES }) do
		for key in pairs(list) do
			local path = tostring(list[key])
			if __TS__StringEndsWith(path, ".vpcf") then
				PrecacheResource("particle", path, context)
			elseif __TS__StringEndsWith(path, ".vmdl") then
				PrecacheResource("model", path, context)
			else
				print((("[Precache] Unknown path: " .. key) .. " ") .. path)
			end
		end
	end
end
function ____exports.default(context)
	precacheResource({
		"soundevents/game_sounds.vsndevts",
		"soundevents/gameplay.vsndevts",
		"soundevents/bless.vsndevts",
		"soundevents/items.vsndevts",
		"soundevents/game_sounds_hero_pick.vsndevts",
	}, context)
	precacheEveryResourceInKV({ "./scripts/npc/npc_units_custom.txt" }, context)
	precacheUnits({}, context)
	precacheItems({}, context)
	precacheParticleList(context)
	print("[Precache] Precache finished.")
end
return ____exports