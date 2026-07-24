--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function Spawn()
    if not IsServer() then
        return
    end

    if thisEntity == nil then
        return
    end

    if thisEntity:GetTeam() ~= DOTA_TEAM_NEUTRALS then
        return
    end

    thisEntity:SetContextThink("GreevilGoldenThink", GreevilGoldenThink, 0.1)
end

function GreevilGoldenThink()
    local hUnit = thisEntity


    if IsValid(hUnit) and hUnit:IsAlive() then
        if hUnit.RoomCenter == nil then
            if hUnit.nSpawnerTeamNumber ~= nil and type(hUnit.nSpawnerTeamNumber) == "number" then
                local vRoomCenter = Util:GetRoomCenter("center_" .. hUnit.nSpawnerTeamNumber)
                if vRoomCenter ~= nil then
                    hUnit.RoomCenter = vRoomCenter
                end
            end
            return 0.5
        else
            local vPos = hUnit.RoomCenter + RandomVector(500)
            ExecuteOrderFromTable({
                UnitIndex = hUnit:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                -- TargetIndex = EntityIndex,
                -- AbilityIndex = EntityIndex,
                Position = vPos,
                Queue = false,
            })
            return 3
        end
    else
        return nil
    end
end