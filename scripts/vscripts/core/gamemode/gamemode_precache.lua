--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Прекеш моделей/парктиклов/звуков
---@param context CScriptPrecacheContext
function GameMode:Precache(context)
    logger:Log("[Precache] Started")
    for _, shortCreepName in ipairs(tPrecacheList.CreepNames) do
        PrecacheUnitByNameAsync("npc_dota_" .. shortCreepName, function()
            logger:Log("[Precache] npc_dota_" .. shortCreepName .. " precached")
        end)
    end
    logger:Log("[Precache] Precache neutral creeps done.")

    for resourceType, resourceList in pairs(tDefaultPrecacheList) do
        for _, resourcePath in ipairs(resourceList) do
            PrecacheResource(resourceType, resourcePath, context)
        end
    end

    for _, value in pairs(ITEMS_LIST) do
        if value.preview_type == ITEMS_PREVIEW_TYPES.FX then
            PrecacheResource("particle", value.game_value, context)
        end
    end

    _G.tPrecacheList = nil
    _G.tDefaultPrecacheList = nil
    logger:Log("[Precache] Ended")
end