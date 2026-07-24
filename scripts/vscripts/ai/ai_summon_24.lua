--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "ai\\ai_summon_24"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["6"] = 5,["9"] = 8,["10"] = 9,["13"] = 10,["14"] = 10,["15"] = 10,["16"] = 13,["17"] = 14,["18"] = 15,["19"] = 16,["20"] = 17,["21"] = 18,["22"] = 18,["23"] = 18,["24"] = 18,["25"] = 22,["26"] = 23,["27"] = 24,["28"] = 24,["29"] = 25,["30"] = 26,["31"] = 27,["32"] = 28,["33"] = 24,["34"] = 29,["35"] = 29,["36"] = 29,["37"] = 24,["38"] = 24,["39"] = 33,["40"] = 34,["41"] = 34,["42"] = 35,["43"] = 36,["44"] = 37,["45"] = 38,["46"] = 34,["47"] = 39,["48"] = 39,["49"] = 39,["50"] = 34,["51"] = 34,["52"] = 44,["53"] = 45,["56"] = 49,["57"] = 49,["59"] = 52,["60"] = 52,["61"] = 52,["62"] = 52,["63"] = 52,["64"] = 52,["65"] = 52,["66"] = 52,["67"] = 52,["68"] = 52,["69"] = 52,["70"] = 64,["71"] = 66,["72"] = 67,["73"] = 67,["74"] = 67,["75"] = 67,["76"] = 67,["77"] = 67,["78"] = 67,["79"] = 67,["80"] = 67,["81"] = 67,["82"] = 67,["85"] = 81,["86"] = 82,["87"] = 83,["88"] = 83,["89"] = 83,["90"] = 83,["91"] = 87,["92"] = 87,["93"] = 87,["94"] = 87,["95"] = 87,["96"] = 92,["97"] = 93,["101"] = 97,["102"] = 10,["103"] = 10,["104"] = 8});
if IsClient() then
    return
end
function Spawn(self, entityKeyValues)
    if IsClient() then
        return
    end
    thisEntity:GameTimer(
        0.1,
        function()
            local hOwner = thisEntity:GetOwner()
            if IsValid(hOwner) then
                local fDistance = (hOwner:GetAbsOrigin() - thisEntity:GetAbsOrigin()):Length2D()
                if fDistance > 1000 then
                    thisEntity:SetForceAttackTarget(nil)
                    ExecuteOrderFromTable({
                        OrderType = DOTA_UNIT_ORDER_STOP,
                        UnitIndex = thisEntity:entindex()
                    })
                    local vStartPos = thisEntity:GetAbsOrigin()
                    local vEndPos = hOwner:GetAbsOrigin() + RandomVector(200)
                    ParticleManager_s2c:ToClient(
                        function()
                            local iParticleID = ParticleManager_s2c:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_CUSTOMORIGIN, thisEntity)
                            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vStartPos)
                            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                            ParticleManager_s2c:StartSoundEventFromPosition("DOTA_Item.BlinkDagger.Activate", vStartPos)
                        end,
                        {
                            pid = Player_EntityToID(_G, thisEntity),
                            weight = 1
                        }
                    )
                    ProjectileManager:ProjectileDodge(thisEntity)
                    ParticleManager_s2c:ToClient(
                        function()
                            local iParticleID = ParticleManager_s2c:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_CUSTOMORIGIN, thisEntity)
                            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vEndPos)
                            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                            ParticleManager_s2c:EmitSoundOn("DOTA_Item.BlinkDagger.NailedIt", thisEntity)
                        end,
                        {
                            pid = Player_EntityToID(_G, thisEntity),
                            weight = 1
                        }
                    )
                    thisEntity:SetAbsOrigin(vEndPos)
                    return 0.1
                end
            end
            if thisEntity:IsAttacking() then
                return 0.1
            end
            local hTarget = FindUnitsInRadius(
                thisEntity:GetTeamNumber(),
                thisEntity:GetAbsOrigin(),
                nil,
                AttributeKind.AtkRange:Get(thisEntity),
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_CLOSEST,
                false
            )[1]
            if not IsValid(hTarget) then
                if IsValid(hOwner) then
                    hTarget = FindUnitsInRadius(
                        thisEntity:GetTeamNumber(),
                        hOwner:GetAbsOrigin(),
                        nil,
                        AttributeKind.AtkRange:Get(hOwner),
                        DOTA_UNIT_TARGET_TEAM_ENEMY,
                        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                        DOTA_UNIT_TARGET_FLAG_NONE,
                        FIND_CLOSEST,
                        false
                    )[1]
                end
            end
            if IsValid(hTarget) then
                if not thisEntity:IsAttacking() then
                    ExecuteOrderFromTable({
                        OrderType = DOTA_UNIT_ORDER_STOP,
                        UnitIndex = thisEntity:entindex()
                    })
                    ExecuteOrderFromTable({
                        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                        UnitIndex = thisEntity:entindex(),
                        TargetIndex = hTarget:entindex()
                    })
                    if thisEntity:GetForceAttackTarget() ~= hTarget then
                        thisEntity:SetForceAttackTarget(hTarget)
                    end
                end
            end
            return 0.1
        end
    )
end