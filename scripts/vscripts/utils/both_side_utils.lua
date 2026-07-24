--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GetSkillValue(Name)
    local SkillInfo = SKILLS_LIST_TABLE[Name]

    --Если этого навыка нет в игре возвращаем 0
    if SkillInfo == nil then return 0 end

    --Берем текущий раунд
    local CurrentRound = 0
    local Table = CustomNetTables:GetTableValue("round_info", "round_number")
    if Table then
        CurrentRound = Table.round
    end

    --Золото/мин зависит от текущего раунда: clamp(раунд*1.5, 50, 150) за 1 стак навыка.
    --Кап 150 достигается на 100-й волне (100*1.5=150), дальше не растёт.
    if Name == "gold_per_minute" then
        return math.max(50, math.min(150, CurrentRound * 1.5))
    end

    local PctMult = 1
    local BaseMult = 1

    -- --Если текущий раунд больше или равен 20 - увеличиваем мультипликатор
    -- if CurrentRound >= 20 then
    --     BaseMult = 2
    -- end

    -- --Если текущий раунд больше или равен 50 - увеличиваем мультипликатор
    -- if CurrentRound >= 50 then
    --     BaseMult = 3
    --     PctMult = 2
    -- end

    --Если навык имеет свой собственный мультипликатор - применяем именно его
    if SkillInfo.custom_mult ~= nil then
        BaseMult = SkillInfo.custom_mult
        PctMult = SkillInfo.custom_mult
    end
    
    if SkillInfo.is_percent == true then
        return SkillInfo.value * PctMult
    else
        return SkillInfo.value * BaseMult
    end
end

function GetPlayerSkillValue(Hero, Name)
    --Если герой не подходит возвращаем 0
    if Hero == nil or not Hero:IsRealHero() then return 0 end

    local PlayerID = Hero:GetPlayerOwnerID()

    --Если ид игрока не подходит возвращаем 0
    if PlayerID == nil or PlayerID == -1 then return 0 end

    local PlayerInfo = HeroBuilder:GetPlayerInfo(PlayerID)

    --Если игрок не записан в билдере возвращаем 0
    if PlayerInfo == nil then return 0 end

    local SkillsList = PlayerInfo.skills_list

    --Если у игрока нет этого навыка возвращаем 0
    if SkillsList[Name] == nil then return 0 end

    local Value = GetSkillValue(Name)

    return Value * SkillsList[Name]
end

function IsCheatsEnabled()
    if not GAME_CHEAT_MODE_ENABLED then return false end
    return (IsInToolsMode() or (GameRules and GameRules:IsCheatMode()))
end

function GetAbilitySetting(AbilityName, Setting)
    if ABILITIES_SETTINGS[AbilityName] == nil then return false end

    return ABILITIES_SETTINGS[AbilityName][Setting] == true
end

function GetModifierSetting(ModifierName, Setting)
    if MODIFIERS_SETTINGS[ModifierName] == nil then return false end

    return MODIFIERS_SETTINGS[ModifierName][Setting] == true
end

function GetGameSetting(SettingName)
    local Difficult = GAME_SETTINGS["DEFAULT"]["DIFFICULT"]

    if Difficult == 1 then
        local DifficultSetting = GAME_SETTINGS["EASY"][SettingName]
        if DifficultSetting == nil then
            DifficultSetting = GAME_SETTINGS["DEFAULT"][SettingName]
        end
        return (DifficultSetting or 0)
    elseif Difficult == 2 then
        local DifficultSetting = GAME_SETTINGS["MEDIUM"][SettingName]
        if DifficultSetting == nil then
            DifficultSetting = GAME_SETTINGS["DEFAULT"][SettingName]
        end
        return (DifficultSetting or 0)
    elseif Difficult == 3 then
        local DifficultSetting = GAME_SETTINGS["HARD"][SettingName]
        if DifficultSetting == nil then
            DifficultSetting = GAME_SETTINGS["DEFAULT"][SettingName]
        end
        return (DifficultSetting or 0)
    elseif Difficult == 4 then
        return (GAME_SETTINGS["DEFAULT"][SettingName] or 0)
    end

    return 0
end

-- if IsServer() then
--     vanillaGetAbsOrigin = vanillaGetAbsOrigin or CBaseEntity.GetAbsOrigin

--     function CBaseEntity:GetAbsOrigin()
--         local info = debug.getinfo(2, "Sl") -- уровень 2 = кто вызвал
--         print("Вызвано из файла:", info.short_src, "строка:", info.currentline)
--         return vanillaGetAbsOrigin(self)
--     end
-- end

-- if IsClient() then
--     vanillaGetAbsOrigin = vanillaGetAbsOrigin or C_BaseEntity.GetAbsOrigin

--     function C_BaseEntity:GetAbsOrigin()
--         local info = debug.getinfo(2, "Sl") -- уровень 2 = кто вызвал
--         print("Вызвано из файла:", info.short_src, "строка:", info.currentline)
--         return vanillaGetAbsOrigin(self)
--     end
-- end