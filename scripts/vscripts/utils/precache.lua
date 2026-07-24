--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local particles =
{
    "particles/ping_custom.vpcf",
    "particles/battle_pass/battle_pass_back.vpcf",
    "particles/ability_select/ability_color_white.vpcf",
    "particles/creep_sended/creep_sended.vpcf",
    "particles/rain_fx/econ_rain.vpcf",
    "particles/rain_fx/econ_snow.vpcf",
    "particles/dk_attack.vpcf",
    "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_corrosive.vpcf",
    "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf",
    "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf",
}

local sounds = 
{
    "soundevents/game_sounds.vsndevts",
    "soundevents/game_sounds_dungeon_enemies.vsndevts",
    "soundevents/game_sounds_winter_2018.vsndevts",
    "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts",
    "soundevents/game_sounds_creeps.vsndevts",
    "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts",
    "soundevents/game_sounds_cha_custom.vsndevts",
}

local models =
{
    "models/courier/baby_rosh/babyroshan_ti9.vmdl",
    "models/courier/baby_rosh/babyroshan_crownfall.vmdl",
    "models/courier/baby_rosh/babyroshan.vmdl",
    "models/events/frostivus/penguin/penguin_prime.vmdl",
    "models/props_gameplay/pig_blue.vmdl",
    "models/items/courier/baekho/baekho.vmdl",
    "models/heroes/dragon_knight/dragon_knight_dragon.vmdl",
    "models/development/invisiblebox.vmdl",
    "models/heroes/lich/ice_spire.vmdl",
    "models/heroes/undying/undying_minion.vmdl",
    "models/heroes/undying/undying_minion_torso.vmdl",
    "models/heroes/lanaya/lanaya_trap_crystal_invis.vmdl",
}

local units = {
    "npc_minigames_arena",
    "npc_minigames_mirana",
    "npc_minigames_pudge",
    "cosmetic_pet",
    "arena_vision_revelear",
    "npc_dota_brewmaster_fire_1",
    "npc_dota_brewmaster_earth_1",
    "npc_dota_brewmaster_storm_1",
    "npc_dota_brewmaster_void_1",
    "npc_dota_clinkz_skeleton_archer_custom",
    "npc_dota_invoker_forged_spirit",
    "npc_dota_venomancer_plague_ward_1",
    "npc_dota_beastmaster_boar",
    "npc_dota_lycan_wolf1",
    "npc_dota_unit_undying_zombie",
    "npc_dota_creature_tombstone",
    "npc_dota_creature_tombstone_zombie",
    "npc_dota_creature_tombstone_zombie_torso",
    "npc_dota_broodmother_spiderling",
    "npc_dota_eidolon",
    "npc_dota_furion_treant",
    "npc_dota_furion_treant_large",
    "npc_dota_warlock_golem",
    "npc_dota_visage_familiar1",
    "npc_dota_shadow_shaman_ward_1",
    "npc_dota_wraith_king_skeleton_warrior",
    "npc_dota_item_wraith_pact_totem",
    "npc_dota_lich_ice_spire",
}

_G.PrecachedUnits = {}

function TryPrecacheUnitAsync(sUnitName, callback)
    if sUnitName == nil or callback == nil then return end

    if _G.PrecachedUnits[sUnitName] == nil then
        _G.PrecachedUnits[sUnitName] = false

        PrecacheUnitByNameAsync(sUnitName, function(prec_Id)
            _G.PrecachedUnits[sUnitName] = true

            Rounds:AddSpawnGroupToRound(prec_Id, sUnitName)

            if callback ~= nil then
                callback(prec_Id)
            end
        end)
    else
        if callback ~= nil then
            callback()
        end
    end
end

local function PrecacheEverythingFromTable( context, kvtable)
    for key, value in pairs(kvtable) do
        if type(value) == "table" then
            if not string.find(key, "npc_precache_") then
               PrecacheEverythingFromTable( context, value )
            end
        else
            if string.find(value, "vpcf") then
                PrecacheResource( "particle", value, context)
            end
            if string.find(value, "vmdl") then
                PrecacheResource( "model", value, context)
            end
            if string.find(value, "vsndevts") then            
                PrecacheResource( "soundfile", value, context)
            end
        end
    end
end

function PrecacheEverythingFromKV( context )
    local kv_files = 
    {
        "scripts/npc/npc_abilities_custom.txt",
        "scripts/npc/npc_units_custom.txt",
        "scripts/npc/npc_units.txt",
        "scripts/npc/npc_items_custom.txt",
    }
    for _, kv in pairs(kv_files) do
        local kvs = LoadKeyValues(kv)
        if kvs then
            PrecacheEverythingFromTable( context, kvs)
        end
    end
end

return function(context)
    -- PrecacheEverythingFromKV(context)
    for _, p in pairs(particles) do
        PrecacheResource("particle", p, context)
    end
    for _, p in pairs(sounds) do
        PrecacheResource("soundfile", p, context)
    end
    for _, p in pairs(models) do
        PrecacheResource("model", p, context)
    end
    for _, p in pairs(units) do
        PrecacheUnitByNameSync(p, context)
    end
end
