--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Map == nil then
	Map = class({})
end

function Map:Init()
    print('[Map] Module is active!')

    self.bStarted = true

    self.Roshans = {
        roshan_honey = {
            model = "models/courier/baby_rosh/babyroshan_ti9.vmdl",
            effect = "particles/econ/courier/courier_babyroshan_ti9/courier_babyroshan_ti9_ambient.vpcf"
        },
        roshan_crownfall = {
            model = "models/courier/baby_rosh/babyroshan_crownfall.vmdl",
            effect = ""
        },
        roshan_darkmoon = {
            model = "models/courier/baby_rosh/babyroshan.vmdl",
            effect = "particles/econ/courier/courier_roshan_darkmoon/courier_roshan_darkmoon.vpcf"
        },
        roshan_jade = {
            model = "models/courier/baby_rosh/babyroshan.vmdl",
            effect = "particles/econ/courier/courier_roshan_ti8/courier_roshan_ti8.vpcf"
        }
    }

    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap( Map, 'OnGameRulesStateChange' ), self )

    self.Arenas = {}

    self.ModifiersToCheck = {}
    self.AbilitiesToCheck = {}
end

function Map:AddModifierToChecker(ModifierName, hParent, hCaster, hAbility)
    if not hCaster or not hAbility or not hParent or hCaster:IsNull() or hAbility:IsNull() or hParent:IsNull() then return end

    if self.ModifiersToCheck[hParent:entindex()] == nil then
        self.ModifiersToCheck[hParent:entindex()] = {}
    end

    if self.ModifiersToCheck[hParent:entindex()][ModifierName] == nil then
        self.ModifiersToCheck[hParent:entindex()][ModifierName] = {
            ability = hAbility,
            caster = hCaster
        }
    end
end

function Map:AddAbilityToChecker(hAbility, hParent)
    if not hAbility or not hParent or hAbility:IsNull() or hParent:IsNull() then return end

    if self.AbilitiesToCheck[hParent:entindex()] == nil then
        self.AbilitiesToCheck[hParent:entindex()] = hAbility
    end
end

function Map:RegisterArena(Name, Mins, Maxs, Center, GroundMins, GroundMaxs)
    if self.Arenas[Name] ~= nil then return end

    local CenterPosition = Center

    if type(Center) == "string" then
        local Ent = Entities:FindByName(nil, Center)
        if Ent then
            CenterPosition = Ent:GetAbsOrigin()
        end
    end

    if CenterPosition == nil or type(CenterPosition) == "string" then return end

    local ArenaPositions = {}
    if Name == "MINIGAMES" then
        for i=1, 8 do
            local Ent = Entities:FindByName(nil, "minigames_arena_point_"..i)
            if Ent then
                table.insert(ArenaPositions, Ent:GetAbsOrigin())
            end
        end
    elseif Name == "MASS_ARENA" then
        for i=1, 8 do
            local Ent = Entities:FindByName(nil, "mass_arena_point_"..i)
            if Ent then
                table.insert(ArenaPositions, Ent:GetAbsOrigin())
            end
        end
    end

    self.Arenas[Name] = {
        mins=Mins,
        maxs=Maxs,
        ground_mins=GroundMins,
        ground_maxs=GroundMaxs,
        center = CenterPosition,
        positions = ArenaPositions
    }
end

function Map:FixUnitsPositions()
    local Units = FindUnitsInRadius(
        DOTA_TEAM_GOODGUYS, 
        Vector(0,0,0), 
        nil, 
        99999, 
        DOTA_UNIT_TARGET_TEAM_BOTH, 
        DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
        DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 
        FIND_ANY_ORDER, 
        false
    )

    for _, unit in ipairs(Units) do
        local Team = unit:GetTeamNumber()
        if Team ~= DOTA_TEAM_NEUTRALS and unit:GetUnitName() ~= "npc_dota_hero_target_dummy" then
            local PlayerHero = GetRealUnit(unit)
            if PlayerHero and PlayerHero:IsRealHero() then
                local PlayerInfo = Players:GetPlayer(PlayerHero:GetPlayerID())
                if PlayerInfo then
                    local CurrentArenaName = unit.Arena or PlayerInfo.arena

                    if CurrentArenaName == "MINIGAMES" and PlayerHero ~= unit and string.match(unit:GetUnitName(), "minigames") == nil then
                        CurrentArenaName = "MAIN"
                    end

                    if CurrentArenaName == "MAIN" and unit ~= PlayerHero and unit._main_invulnerabled == nil then
                        unit._main_invulnerabled = true
                        unit:AddNewModifier(PlayerHero, nil, "modifier_summon_invulnerable", {})
                    elseif (CurrentArenaName ~= "MAIN" or unit == PlayerHero) and unit._main_invulnerabled == true then
                        unit._main_invulnerabled = nil
                        unit:RemoveModifierByName("modifier_summon_invulnerable")
                    end
                    
                    local ArenaInfo = self:GetArenaInfo(CurrentArenaName)
                    if ArenaInfo then
                        local Mins = ArenaInfo.mins
                        local Maxs = ArenaInfo.maxs
                        if not unit:HasFlyMovementCapability() and ArenaInfo.ground_mins ~= nil and ArenaInfo.ground_maxs ~= nil then
                            Mins = ArenaInfo.ground_mins
                            Maxs = ArenaInfo.ground_maxs
                        end
                        self:AdjustPosition(unit, Mins, Maxs)
                    end
                end
            end
        else
            local Arena = unit.Arena
            if Arena ~= nil then
                local ArenaInfo = self:GetArenaInfo(Arena)
                if ArenaInfo then
                    local Mins = ArenaInfo.mins
                    local Maxs = ArenaInfo.maxs

                    if not unit:HasFlyMovementCapability() and not IsUnitBerserked(unit) and ArenaInfo.ground_mins ~= nil and ArenaInfo.ground_maxs ~= nil then
                        Mins = ArenaInfo.ground_mins
                        Maxs = ArenaInfo.ground_maxs
                    end

                    self:AdjustPosition(unit, Mins, Maxs)
                end
            end
        end
    end

    for UnitIndex, Modifiers in pairs(self.ModifiersToCheck) do
        local Unit = EntIndexToHScript(UnitIndex)
        if Unit and not Unit:IsNull() then
            for ModifierName, ModifierInfo in pairs(Modifiers) do
                if ModifierInfo.caster and not ModifierInfo.caster:IsNull() then
                    if not Unit:FindModifierByNameAndCaster(ModifierName, ModifierInfo.caster) then
                        if ModifierInfo.ability and not ModifierInfo.ability:IsNull() and ModifierInfo.ability._bCustomDisabled == nil then
                            if ModifierInfo.ability:IsHidden() then
                                ModifierInfo.ability:SetHidden(false)

                                self.ModifiersToCheck[UnitIndex][ModifierName] = nil
                            end
                        else
                            self.ModifiersToCheck[UnitIndex][ModifierName] = nil
                        end
                    end
                else
                    self.ModifiersToCheck[UnitIndex][ModifierName] = nil
                end
            end
        else
            self.ModifiersToCheck[UnitIndex] = nil
        end
    end

    for UnitIndex, hAbility in pairs(self.AbilitiesToCheck) do
        local Unit = EntIndexToHScript(UnitIndex)
        if Unit and not Unit:IsNull() and hAbility and not hAbility:IsNull() and hAbility._bCustomDisabled == nil then
            hAbility:SetHidden(false)
        else
            self.AbilitiesToCheck[UnitIndex] = nil
        end
    end

    return 0.03
end

function Map:AdjustPosition(Unit, Mins, Maxs)
    local UnitPos = Unit:GetAbsOrigin()
    if not IsInCube(UnitPos, Vector(Mins.x, Mins.y, 0), Vector(Maxs.x, Maxs.y, 0)) then
        local NewUnitPos = UnitPos
        if UnitPos.x >= Maxs.x then
            NewUnitPos.x = Maxs.x
        end
        if UnitPos.x <= Mins.x then
            NewUnitPos.x = Mins.x
        end
        if UnitPos.y >= Maxs.y then
            NewUnitPos.y = Maxs.y
        end
        if UnitPos.y <= Mins.y then
            NewUnitPos.y = Mins.y
        end

        NewUnitPos = GetGroundPosition(NewUnitPos, Unit)

        FindClearSpaceForUnit(Unit, NewUnitPos, false)
    end
end

function Map:OnGameRulesStateChange()
    local State = GameRules:State_Get()

    if State == DOTA_GAMERULES_STATE_STRATEGY_TIME then
        self:RegisterArena("MAIN", Vector(-1792, 3008, 0), Vector(1792, 6656), "main_arena_center")
        self:RegisterArena("MINIGAMES", Vector(-6912, 2816, 0), Vector(-2816, 6912), "minigames_arena_center")
        self:RegisterArena("MASS_ARENA", Vector(2560, 2560, 0), Vector(6912, 6912), "mass_arena_center")
        self:RegisterArena("BOSS_ARENA", Vector(-3840, -6912, 0), Vector(3840, -4352), "boss_arena_center")

        self:RegisterArena("UNDERWORLD", Vector(999399, 999399, 0), Vector(999999, 999999), Vector(999699, 999699, 0))
    end

    if State == DOTA_GAMERULES_STATE_PRE_GAME then
        self:LoadPlayersArenaMaps()
        self:CreateBabyRoshans()
        self:CreatePenguins()

        local Aegis = Entities:FindByName(nil, "aegis")
        if Aegis then
            ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/generic_gameplay/dropped_aegis.vpcf", PATTACH_ABSORIGIN_FOLLOW, Aegis))
        end
        local Dragon = Entities:FindByName(nil, "dragon")
        if Dragon then
            ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/world/ancient/radiant_dragon_king_2024/radiant_dragon_king_2024_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, Dragon))
        end
    end
end

function Map:CreatePenguins()
    local Ents = Entities:FindAllByName("penguin_spawn")

    if #Ents > 0 then
        for i = 1, 2 do
            local rIndex = table.random_key(Ents)
            local rEnt = Ents[rIndex]

            local Penguin = CreateUnitByName("npc_penguin_map", rEnt:GetAbsOrigin(), false, nil, nil, DOTA_TEAM_NEUTRALS)

            table.remove(Ents, rIndex)
        end
    end
end

function Map:CreateBabyRoshans()
    for RoshanName, Info in pairs(self.Roshans) do
        local Ent = Entities:FindByName(nil, RoshanName)
        if Ent then
            local EntAngles = Ent:GetAngles()

            local Roshan = CreateUnitByName("npc_baby_roshan_map", Ent:GetAbsOrigin(), false, nil, nil, DOTA_TEAM_NEUTRALS)
            Roshan:AddNewModifier(Roshan, nil, "modifier_roshan_map", {model=Info.model, effect = Info.effect})
            Roshan:SetAngles(EntAngles.x, EntAngles.y, EntAngles.z)
        end
    end
end

function Map:LoadPlayersArenaMaps()
    local AsyncDelay = 0

    for TeamID, TeamInfo in pairs(Players:GetAllTeams()) do
        local MapName = "default"

        if TeamInfo.active and #TeamInfo.players == 1 then
            local PlayerID = TeamInfo.players[1]

            local PlayerServerInfo = Server:GetPlayerInfo(PlayerID)
            if PlayerServerInfo then
                MapName = PlayerServerInfo.map
            end
        end

        local InfoTargetName = TeamInfo.arena
        local InfoTarget = Entities:FindByName(nil, InfoTargetName)
        if InfoTarget then
            InfoTarget:SetContextThink(DoUniqueString("MapSpawn"), function ()
                local Center = InfoTarget:GetAbsOrigin()-Vector(0,0,256)
                if GetMapName() ~= "1x8_test" and GetMapName() ~= "1x8" then
                    MapName = GetMapName() == "1x8_test2" and "default_test" or "default"
                    print(MapName)
                    DOTA_SpawnMapAtPosition("player_arenas/"..MapName, Center, false, nil, function(SpawnGroup)

                        local Maxs = Center + Vector(1064, 1064, 0)
                        local Mins = Center - Vector(1064, 1064, 0)

                        local GroundMaxs = Center + Vector(768, 768, 0)
                        local GroundMins = Center - Vector(768, 768, 0)

                        self:RegisterArena(InfoTargetName, Mins, Maxs, InfoTarget:GetAbsOrigin(), GroundMins, GroundMaxs)

                        Players:OnTeamArenaLoaded(TeamID, SpawnGroup)
                    end, nil)
                else
                    local Maxs = Center + Vector(1064, 1064, 0)
                    local Mins = Center - Vector(1064, 1064, 0)

                    local GroundMaxs = Center + Vector(768, 768, 0)
                    local GroundMins = Center - Vector(768, 768, 0)

                    self:RegisterArena(InfoTargetName, Mins, Maxs, InfoTarget:GetAbsOrigin(), GroundMins, GroundMaxs)

                    Players:OnTeamArenaLoaded(TeamID, nil)
                end
            end, AsyncDelay)

            AsyncDelay = AsyncDelay + 0.25
        end
    end
end

function Map:GetPositionArena(Position)
    if Position == nil then return end

    if Position.GetAbsOrigin then Position = Position:GetAbsOrigin() end

    local Arena = nil

    for ArenaName, ArenaInfo in pairs(self:GetAllArenas()) do
        if IsInCube(Position, Vector(ArenaInfo.mins.x, ArenaInfo.mins.y, 0), Vector(ArenaInfo.maxs.x, ArenaInfo.maxs.y, 0)) then
            Arena = ArenaName
            break
        end
    end

    return Arena
end

function Map:GetAllArenas()
    return self.Arenas
end

function Map:GetArenaInfo(Name)
    return self.Arenas[Name]
end

if not Map.bStarted then Map:Init() end