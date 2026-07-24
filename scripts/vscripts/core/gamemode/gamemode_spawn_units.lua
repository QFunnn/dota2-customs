--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GameMode:SpawnNeutralUnits()
    local snowman = Entities:FindByName(nil, "snowman") ---@type CBaseEntity?
    _G.GoodFrogPos = snowman and snowman:GetAbsOrigin() or Vector(0, 0, 128)

    _G.GoodFrog = CreateUnitByName("npc_dota_frog", GoodFrogPos, true, nil, nil, DOTA_TEAM_NEUTRALS)
    GoodFrog:SetForwardVector(RandomVector(1))

    _G.FountainThinker = CreateModifierThinker(nil, nil, "modifier_fountain_thinker", {}, Vector(0, 0, 128), DOTA_TEAM_NEUTRALS, false)

    if not IsValid(_G.MODIFIER_EVENTS_DUMMY) then
        _G.MODIFIER_EVENTS_DUMMY = CreateModifierThinker(
            nil,
            nil,
            "modifier_events",
            {},
            Vector(0, 0, 0),
            DOTA_TEAM_NOTEAM,
            false
        )
    end

    if not IsValid(_G.ABILITIES_FIX_DUMMY) then
        _G.ABILITIES_FIX_DUMMY = CreateModifierThinker(
            nil,
            nil,
            "modifier_abilities_fix",
            {},
            Vector(0, 0, 0),
            DOTA_TEAM_NOTEAM,
            false
        )
    end 
end