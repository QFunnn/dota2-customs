--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function SendErrorToPlayer(PID, errorText, errorSound)
    if errorSound == nil then
        errorSound = "UUI_SOUNDS.NoGold"
    end
    local player = PlayerResource:GetPlayer(PID)
    if player then
        CustomGameEventManager:Send_ServerToPlayer(player, "SEND_ERROR_TO_PLAYER", {errorText=errorText, errorSound=errorSound})
    end
end

function PlayerSelectUnit(PlayerID, Entity, bReplace)
    if PlayerID == nil or Entity == nil or Entity:IsNull() then return end

    local Player = PlayerResource:GetPlayer(PlayerID)
    if Player then
        CustomGameEventManager:Send_ServerToPlayer(Player, "select_unit_custom", {entity=Entity:entindex(), replace=bReplace})
    end
end

function GetRealUnit(Attacker)
    if Attacker == nil then
        return Attacker
    end
    if Attacker.GetAssignedHero ~= nil then
        return Attacker:GetAssignedHero()
    end
    if not Attacker:IsRealHero() and not Attacker:IsIllusion() then
        local owner = Attacker:GetOwner()
        if owner ~= nil and owner.GetAssignedHero ~= nil then
            return owner:GetAssignedHero()
        end
        if owner ~= nil and owner:IsBaseNPC() then
            return owner
        end
    end
    if Attacker:IsRealHero() and not Attacker:IsIllusion() then
        if Attacker:IsClone() then
            local CloneSource = Attacker:GetCloneSource()
            if CloneSource then
                return CloneSource
            end
        end
        if Attacker:GetClassname() == "npc_dota_lone_druid_bear" then
            local playerID = Attacker:GetPlayerOwnerID()
            local player = PlayerResource:GetPlayer(playerID)
            if player ~= nil then
                return player:GetAssignedHero()
            end
        end
    end
    if Attacker:IsHero() and (Attacker:IsIllusion() or Attacker:IsStrongIllusion() or Attacker:IsTempestDouble()) then
        local playerID = Attacker:GetPlayerID()
        local player = PlayerResource:GetPlayer(playerID)
        if player ~= nil then
            return player:GetAssignedHero()
        end
    end
    return Attacker
end

function IsRealHero(Unit)
    if not Unit or Unit:IsNull() then return false end

    if not Unit:IsRealHero() or Unit:IsIllusion() or Unit:IsStrongIllusion() or Unit:IsTempestDouble() or Unit:IsClone() or Unit:GetClassname() == "npc_dota_lone_druid_bear" then return false end

    return true
end

function CalculateDistance(ent1, ent2)
    local pos1 = ent1
    local pos2 = ent2
    if ent1.GetAbsOrigin then pos1 = ent1:GetAbsOrigin() end
    if ent2.GetAbsOrigin then pos2 = ent2:GetAbsOrigin() end
    local distance = (pos1 - pos2):Length2D()
    return distance
end

function CalculateDirection(ent1, ent2)
    local pos1 = ent1
    local pos2 = ent2
    if ent1.GetAbsOrigin then pos1 = ent1:GetAbsOrigin() end
    if ent2.GetAbsOrigin then pos2 = ent2:GetAbsOrigin() end
    local direction = (pos1 - pos2):Normalized()
    return direction
end

function IsInCube(vPos, vMins, vMaxs)
    return (vPos.x > vMins.x and vPos.x < vMaxs.x and vPos.y < vMaxs.y and vPos.y > vMins.y)
end

function math.round(x)
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

function table.random(t)
    local key_table = {}
    for k in pairs(t) do
        table.insert(key_table, k)
    end

    local rnd = key_table[RandomInt(1, #key_table)]

    return t[rnd]
end

function table.random_key(t)
    local key_table = {}
    for k in pairs(t) do
        table.insert(key_table, k)
    end

    local rnd = key_table[RandomInt(1, #key_table)]

    return rnd
end

function string.split(str, sep)
    local result = {}
    for part in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(result, part)
    end
    return result
end

function IsModifierChangesAttackCap(ModifierName)
    if MODIFIERS_SETTINGS[ModifierName] == nil then return false end

    return MODIFIERS_SETTINGS[ModifierName].bChangeAttack == true
end

function CDOTA_Buff:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end

function IsSolo()
    return GetMapName() == "1x7_map"
end

function ArrayRemove(t, fnKeep)
    local j, n = 1, #t
    for i=1,n do
        if (fnKeep(t, i, j)) then
            if (i ~= j) then
                t[j] = t[i]
                t[i] = nil
            end
            j = j + 1
        else
            t[i] = nil
        end
    end
    return t
end

function IsUnitBerserked(hUnit)
    if not hUnit or hUnit:IsNull() or not hUnit:IsAlive() then return false end

    local modif = hUnit:FindModifierByName("modifier_creep_controll")
    return (modif and modif:IsBerserked())
end

function IsLocalServer()
    return not IsDedicatedServer()
end

-- Защитная обёртка над UnloadSpawnGroupByHandle.
-- Гарантирует что один и тот же id не выгружается повторно (источник
-- спама "CL: AsyncUnloadSpawnGroup -- no such spawn group" на клиентах
-- и зрителях) и что мы никогда не трогаем активную spawn group карты.
_G.UnloadedSpawnGroups = _G.UnloadedSpawnGroups or {}

function SafeUnloadSpawnGroup(handle)
    if handle == nil or handle == 0 then return false end
    if _G.UnloadedSpawnGroups[handle] then return false end

    local activeHandle = nil
    if GetActiveSpawnGroupHandle ~= nil then
        local ok, h = pcall(GetActiveSpawnGroupHandle)
        if ok then activeHandle = h end
    end
    if activeHandle ~= nil and handle == activeHandle then
        return false
    end

    _G.UnloadedSpawnGroups[handle] = true
    UnloadSpawnGroupByHandle(handle)
    return true
end

function ResetSpawnGroupTracking()
    _G.UnloadedSpawnGroups = {}
end

function RemoveAbilitySpawnGroupIfNoUsed(hAbility)
    if IsClient() then
        print("PREPARING TO DELETE ABILITY SPAWN GROUP")
    end
    if not hAbility or hAbility:IsNull() then return end

    local AbilityHeroName = KeyValues:GetHeroNameByAbilityName(hAbility:GetAbilityName())
    local hCaster = hAbility:GetCaster()
    if AbilityHeroName == nil or hCaster == nil or hCaster:IsNull() then return end

    local SpawnGroupID = HeroBuilder:GetSpawnGroup(AbilityHeroName)
    if SpawnGroupID == nil then return end

    local allPlayers = Players:GetAllActivePlayers(true)

    local delete = true
    for _, PlayerID in ipairs(allPlayers) do
        local BuilderInfo = HeroBuilder:GetPlayerInfo(PlayerID)
        if BuilderInfo then
            local Hero = BuilderInfo.selected_hero_ent
            if Hero:GetUnitName() == AbilityHeroName then
                delete = false
                break
            end

            for _, AbilityName in ipairs(BuilderInfo.abilities_list) do
                local AHeroName = KeyValues:GetHeroNameByAbilityName(AbilityName)
                if AHeroName and AHeroName == AbilityHeroName and hAbility ~= Hero:FindAbilityByName(AbilityName) then
                    delete = false
                    break
                end
            end
        end
    end

    if delete then
        HeroBuilder:UnPrecacheHero(AbilityHeroName)
        SafeUnloadSpawnGroup(SpawnGroupID)
        if Rounds and Rounds.RemoveSpawnGroupFromRound then
            Rounds:RemoveSpawnGroupFromRound(SpawnGroupID)
        end
    end
end

function FindUnitsInCone(teamNumber, vDirection, vPosition, startRadius, endRadius, flLength, hCacheUnit, targetTeam, targetUnit, targetFlags, findOrder, bCache)
	local vDirectionCone = Vector( vDirection.y, -vDirection.x, 0.0 )
	local enemies = FindUnitsInRadius(teamNumber, vPosition, hCacheUnit, endRadius + flLength, targetTeam, targetUnit, targetFlags, findOrder, bCache )
	ArrayRemove(enemies, function(t, i, j)
		local enemy = t[i]
		local vToPotentialTarget = enemy:GetOrigin() - vPosition
		local flSideAmount = math.abs( vToPotentialTarget.x * vDirectionCone.x + vToPotentialTarget.y * vDirectionCone.y + vToPotentialTarget.z * vDirectionCone.z )
		local enemy_distance_from_caster = ( vToPotentialTarget.x * vDirection.x + vToPotentialTarget.y * vDirection.y + vToPotentialTarget.z * vDirection.z )

		-- Author of this "increase over distance": Fudge, pretty proud of this :D

		-- Calculate how much the width of the check can be higher than the starting point
		local max_increased_radius_from_distance = endRadius - startRadius

		-- Calculate how close the enemy is to the caster, in comparison to the total distance
		local pct_distance = enemy_distance_from_caster / flLength

		-- Calculate how much the width should be higher due to the distance of the enemy to the caster.
		local radius_increase_from_distance = max_increased_radius_from_distance * pct_distance

		if ( flSideAmount < startRadius + radius_increase_from_distance ) and ( enemy_distance_from_caster > 0.0 ) and ( enemy_distance_from_caster < flLength ) then
			return true
		else
			return false
		end
	end)
	return enemies
end













function PrintTable(t, indent, done)
    --print ( string.format ('PrintTable type %s', type(keys)) )
    if type(t) ~= "table" then return end

    done = done or {}
    done[t] = true
    indent = indent or 0

    local l = {}
    for k, v in pairs(t) do
        table.insert(l, k)
    end

    table.sort(l)
    for k, v in ipairs(l) do
        -- Ignore FDesc
        if v ~= 'FDesc' then
            local value = t[v]

            if type(value) == "table" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..":")
                PrintTable (value, indent + 2, done)
            elseif type(value) == "userdata" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
            else
                if t.FDesc and t.FDesc[v] then
                    print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
                else
                    print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                end
            end
        end
    end
end


function PrintTableToString(t, indent, done)
    --print ( string.format ('PrintTable type %s', type(keys)) )

    local result = ""

    if type(t) ~= "table" then return end

    done = done or {}
    done[t] = true
    indent = indent or 0

    local l = {}
    for k, v in pairs(t) do
        table.insert(l, k)
    end

    table.sort(l)
    for k, v in ipairs(l) do
        -- Ignore FDesc
        if v ~= 'FDesc' then
            local value = t[v]

            if type(value) == "table" and not done[value] then
                done [value] = true
                result=result..string.rep ("\t", indent)..tostring(v)..":"
                result=result..PrintTableToString (value, indent + 2, done).."\n"
            elseif type(value) == "userdata" and not done[value] then
                done [value] = true
                result=result..string.rep ("\t", indent)..tostring(v)..": "..tostring(value)
                result=result..PrintTableToString ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done).."\n"
            else
                if t.FDesc and t.FDesc[v] then
                    result=result..string.rep ("\t", indent)..tostring(t.FDesc[v]).."\n"
                else
                    result=result..string.rep ("\t", indent)..tostring(v)..": "..tostring(value).."\n"
                end
            end
        end
    end
    return result
end

function string.trim(s)
    return s:match "^%s*(.-)%s*$"
end

function ContainsValue(sum,nValue)
    if type(sum) == "userdata" then
        sum = tonumber(tostring(sum))
    end

    if bit:_and(sum,nValue)==nValue then
        return true
    else
        return false
    end
end

function GetAllItemsInInventoryAndBackpack(Unit)
    if not Unit or Unit:IsNull() then
        return {}
    end

    local Items = {}

    local Check = {
        DOTA_ITEM_SLOT_1,
        DOTA_ITEM_SLOT_2,
        DOTA_ITEM_SLOT_3,
        DOTA_ITEM_SLOT_4,
        DOTA_ITEM_SLOT_5,
        DOTA_ITEM_SLOT_6,
        DOTA_ITEM_SLOT_7,
        DOTA_ITEM_SLOT_8,
        DOTA_ITEM_SLOT_9,
    }

    for _, SLOT in ipairs(Check) do
        local Item = Unit:GetItemInSlot(SLOT)
        if Item then
            table.insert(Items, Item)
        end
    end

    return Items
end

function extractDigits(num, maxDigits)
    maxDigits = maxDigits or 2  -- по умолчанию 2 цифры
    
    local digits = {}
    local temp = num
    
    for i = maxDigits, 1, -1 do
        local divisor = 10^(i-1)
        local digit = math.floor(temp / divisor)
        table.insert(digits, digit)
        temp = temp % divisor
    end
    
    return digits
end