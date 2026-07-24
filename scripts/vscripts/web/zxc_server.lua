--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require('web/zxc_server_settings')

if Server == nil then
	Server = class({})
end

function Server:Init()
    print('[Server] Module is active!')

    self.bStarted = true

    self.Players = {}

    self.RatingSeasonsInfo = {}
    self.RatingTops = {}

    self.LastRoundBeforeDuel = 0

    CustomGameEventManager:RegisterListener("PlayerSettings", function(source, event) self:OnPlayerChangeSettings(event) end)

    CustomGameEventManager:RegisterListener("custom_keybind_changed",function(source, event) self:OnPlayerChangeKeyBind(event) end)
    CustomGameEventManager:RegisterListener("custom_keybind_quickcast_changed",function(source, event) self:OnPlayerChangeKeyBindQuickcast(event) end)

    CustomGameEventManager:RegisterListener("server_update_notification_filter_settings",function(source, event) self:OnPlayerChangeNotificationFilter(event) end)

    CustomGameEventManager:RegisterListener("server_get_rating_season_info",function(source, event) self:OnPlayerWantGetRatingSeasonInfo(event) end)

    CustomGameEventManager:RegisterListener("server_on_player_use_promocode",function(source, event) self:OnPlayerAttemptUsePromocode(event) end)

    CustomGameEventManager:RegisterListener("server_on_player_add_to_favorite_ban",function(source, event) self:OnPlayerAddFavoriteBan(event) end)

    CustomGameEventManager:RegisterListener("server_buy_item",function(source, event) self:OnPlayerWantBuyItem(event) end)

    CustomGameEventManager:RegisterListener("server_wear_item",function(source, event) self:OnPlayerWantWearItem(event) end)

    CustomGameEventManager:RegisterListener("BattlePassBuy",function(source, event) self:BattlePassBuy(event) end)

    CustomGameEventManager:RegisterListener("bug_report_submit",function(source, event) self:OnBugReportSubmit(event) end)

    CustomGameEventManager:RegisterListener("player_report_submit",function(source, event) self:OnPlayerReportSubmit(event) end)
    CustomGameEventManager:RegisterListener("player_report_open",function(source, event) self:OnPlayerReportOpen(event) end)

    CustomGameEventManager:RegisterListener("mute_prefs_changed",function(source, event) self:OnPlayerChangeMutePrefs(event) end)
    CustomGameEventManager:RegisterListener("mute_prefs_all_changed",function(source, event) self:OnPlayerChangeMutePrefsAll(event) end)
end

function Server:RegisterPlayer(PlayerID)
    if self.Players[PlayerID] == nil then
        local SteamID = PlayerResource:GetSteamAccountID(PlayerID)

        self.Players[PlayerID] = {
            steamid = SteamID,
            profile = {
                rating = 0,
                rating_number_in_top = 0,
                coins = 0,
                max_coins_daily = 0,
                game_time = 0,
                total_games = 0,
                season_games = 0,
                battle_pass = {
                    status = false,
                    end_date = "",
                    end_days = 0,
                },
            },
            server_connected = false,
            end_data = {},

            favorite_ban_heroes = {},
            favorite_ban_abilities = {},

            -- [MF-18] Мут-префы: ключ — steamid32 ЦЕЛИ (строкой), значение {text, sounds, other}.
            -- Ключуем по SteamID, а не по PlayerID: слот между играми у игрока разный.
            mute_prefs = {},

            player_die_round = nil,
            current_ban_heroes = {},
            current_ban_abilities = {},
            map = "default",

            current_position = Vector(0,0,0),

            player_owned_items = {},
            player_items_slots = {},

            settings = {
                settings_right_select = 0,
                settings_effect_select = 1,
                settings_width_select = 0,
                keybinds = {},
                quickcasts = {},
                settings_hints_enabled = 0,
                settings_barrage_opacity = 100,
                settings_penguin_sound = 1,
                settings_notifications = 1,

                settings_notifications_filters = {},

                duel_notification_duration = DUEL_NOTIFICATION_DURATION,
                camera_distance = 1134,

                minimized_extra_creatures = 0,
                autoclose_duel_info = 0,
                autoopen_bet_history = 0,

                -- [NP-23] Доп. настройки (дефолт 0). Креп-уведомление переиспользует
                -- существующий minimized_extra_creatures, расширенный до 0=большое/1=маленькое/2=выкл.
                hide_aegis_notification = 0,        -- не показывать хинт о потере аегиса
                watch_duel_after_round = 0,         -- камера на арену дуэли после дефа крипов

                -- Подсветка способностей (см. ability_colors.js → HIGHLIGHT_DEFAULTS).
                -- Все цвета — строки "#RRGGBB", все флаги — 0/1.
                highlight_master_enabled = 1,
                highlight_sss_enabled = 1,
                highlight_modified_enabled = 1,
                highlight_use_categories = 0,
                color_default_sss = "#ff8c42",
                color_modified = "#ffffff",
                color_forms = "#ff8c42",
                color_splashes = "#ff8c42",
                color_op = "#ff8c42",
                color_bkb = "#ff8c42",
                color_bashes = "#ff8c42",
                color_percent = "#ff8c42",
                color_saves = "#ff8c42",
                color_useful = "#ff8c42",
            },
        }

        PlayerTables:SetTableValue('player_'..PlayerID, "setting_data", self.Players[PlayerID].settings)

        if IsInToolsMode() then
            self.Players[PlayerID].profile.coins = 9999
            self.Players[PlayerID].server_connected = true

            local all_items = {}
            for item_name, _ in pairs(ITEMS_LIST) do
                table.insert(all_items, {item_name = item_name})
            end
            for item_name, _ in pairs(CHAT_WHEEL_LIST) do
                table.insert(all_items, {item_name = item_name})
            end
            self.Players[PlayerID].player_owned_items = all_items
        end

        self:UpdatePlayerNetTable(PlayerID)

        print('[Server] Trying to get profile of '..PlayerID..' PlayerID and '..SteamID..' SteamID')

        SendRequest(SERVER_URL.."get_player_profile", {SteamID=SteamID}, function(ResultData)
            self:CreatePlayerProfile(ResultData, PlayerID, SteamID)
        end, true)
    end
end

function Server:CreatePlayerProfile(data, PlayerID, SteamID)
    print('[Server] Succefully created profile of '..PlayerID..' PlayerID and '..SteamID..' SteamID')

    self.Players[PlayerID].profile = data.profile
    self.Players[PlayerID].favorite_ban_heroes = data.bans_info and (data.bans_info.heroes or {})
    self.Players[PlayerID].favorite_ban_abilities = data.bans_info and (data.bans_info.abilities or {})
    self.Players[PlayerID].player_owned_items = data.player_owned_items or {}
    self.Players[PlayerID].player_items_slots = data.slots or {}

    -- [MF-18] Мут-префы из БД (JSON-колонка mute_prefs). Ключ — steamid32 цели.
    self.Players[PlayerID].mute_prefs = self:NormalizeMutePrefs(data.mute_prefs)

    self.Players[PlayerID].server_connected = true

    if data.settings then
        local settings_table = 
        {
            settings_right_select = data.settings.ability_right or 0,
            settings_effect_select = data.settings.ability_glow or 1,
            settings_width_select = data.settings.ability_small or 0,
            keybinds = data.settings.keybinds or {},
            quickcasts = data.settings.quickcasts or {},
            settings_hints_enabled = data.settings.hints or 0,
            settings_barrage_opacity = data.settings.barrage_opacity or 100,
            settings_penguin_sound = data.settings.penguin_sound or 1,
            settings_notifications = data.settings.notifications or 1,

            settings_notifications_filters = data.settings.notification_filters or {},

            duel_notification_duration = data.settings.duel_notification_duration or DUEL_NOTIFICATION_DURATION,
            camera_distance = data.settings.camera_distance or 1134,

            minimized_extra_creatures = data.settings.minimized_extra_creatures or 0,
            autoclose_duel_info = data.settings.autoclose_duel_info or 0,
            autoopen_bet_history = data.settings.autoopen_bet_history or 0,

            -- [NP-23] Доп. настройки (дефолт 0):
            hide_aegis_notification = data.settings.hide_aegis_notification or 0,
            watch_duel_after_round = data.settings.watch_duel_after_round or 0,

            -- Подсветка — если игрок ничего не настраивал, ставим дефолты.
            highlight_master_enabled = data.settings.highlight_master_enabled or 1,
            highlight_sss_enabled = data.settings.highlight_sss_enabled or 1,
            highlight_modified_enabled = data.settings.highlight_modified_enabled or 1,
            highlight_use_categories = data.settings.highlight_use_categories or 0,
            color_default_sss = data.settings.color_default_sss or "#ff8c42",
            color_modified = data.settings.color_modified or "#ffffff",
            color_forms = data.settings.color_forms or "#ff8c42",
            color_splashes = data.settings.color_splashes or "#ff8c42",
            color_op = data.settings.color_op or "#ff8c42",
            color_bkb = data.settings.color_bkb or "#ff8c42",
            color_bashes = data.settings.color_bashes or "#ff8c42",
            color_percent = data.settings.color_percent or "#ff8c42",
            color_saves = data.settings.color_saves or "#ff8c42",
            color_useful = data.settings.color_useful or "#ff8c42",
        }

        self.Players[PlayerID].settings = settings_table
    end

    self:UpdatePlayerNetTable(PlayerID)

    PlayerTables:SetTableValue('player_'..PlayerID, "setting_data", self.Players[PlayerID].settings)

    -- [CREEP-SETTING DEBUG] временный лог: что пришло от api (+тип) и что реально опубликовано в setting_data.
    -- from_api=nil -> api в рантайме не отдал настройку; from_api=1, stored=1 -> грузится, баг в применении.
    local _dbgApi = data.settings and data.settings.minimized_extra_creatures
    local _dbgStored = self.Players[PlayerID].settings and self.Players[PlayerID].settings.minimized_extra_creatures
    print(string.format("[CREEP-SETTING] PID=%s from_api=%s (%s) stored=%s",
        tostring(PlayerID), tostring(_dbgApi), type(_dbgApi), tostring(_dbgStored)))

    Players:OnPlayerProfileLoaded(PlayerID, self.Players[PlayerID])

    -- [MF-18] Публикуем ВСЕМ: у этого игрока появились свои префы, а для уже загруженных
    -- игроков он сам стал резолвимой целью (его steamid32 мог быть у них в мутах).
    self:PublishMutePrefsForAll()

    if data.chat_wheel ~= nil then
        ChatWheel:LoadPlayer(PlayerID, data.chat_wheel)
    end
end

-- === [MF-18] Персист мут-префов (этап 2) ===
-- Хранение — JSON-колонка player.mute_prefs, ключ steamid32 ЦЕЛИ (стабилен между играми).
-- Клиенту префы отдаём УЖЕ отрезолвленными в PlayerID текущей игры: резолв steamid32 -> слот
-- знает только сервер (в панораме player_steamid — 64-битная строка, точного перевода в
-- account_id на клиенте нет). Публикуем в приватную player-table, поэтому реконнект
-- восстанавливает префы сам: значение живёт на сервере, панорама переподпишется.

-- Приводим к {[steamid32-строка] = {text=0|1, sounds=0|1, other=0|1}}. Записи со всеми
-- нулями отбрасываем (размут = удаление ключа) — иначе словарь растёт бесконечно.
function Server:NormalizeMutePrefs(raw)
    local result = {}
    if type(raw) ~= "table" then return result end

    for key, value in pairs(raw) do
        local steamid = tonumber(key)
        if steamid ~= nil and steamid > 0 and type(value) == "table" then
            local text   = (tonumber(value.text)   or 0) ~= 0 and 1 or 0
            local sounds = (tonumber(value.sounds) or 0) ~= 0 and 1 or 0
            local other  = (tonumber(value.other)  or 0) ~= 0 and 1 or 0

            if text ~= 0 or sounds ~= 0 or other ~= 0 then
                result[tostring(math.floor(steamid))] = {text = text, sounds = sounds, other = other}
            end
        end
    end

    return result
end

-- Резолв steamid32 -> PlayerID текущей игры. Игроки, которых нет в этой игре, остаются
-- в памяти/БД нетронутыми (просто не попадают в публикацию).
function Server:PublishMutePrefs(PlayerID)
    if not self.Players[PlayerID] then return end

    local prefs = self.Players[PlayerID].mute_prefs or {}
    local resolved = {}

    for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if i ~= PlayerID and PlayerResource:IsValidPlayerID(i) then
            local target_steamid = PlayerResource:GetSteamAccountID(i)
            if target_steamid ~= nil and target_steamid > 0 then
                local entry = prefs[tostring(target_steamid)]
                if entry ~= nil then
                    resolved[tostring(i)] = {text = entry.text, sounds = entry.sounds, other = entry.other}
                end
            end
        end
    end

    PlayerTables:SetTableValue('player_'..PlayerID, "mute_prefs", resolved)
end

function Server:PublishMutePrefsForAll()
    for PlayerID, _ in pairs(self.Players) do
        self:PublishMutePrefs(PlayerID)
    end
end

-- Клиент прислал изменение по ОДНОЙ цели (клик в панели игрока / таблице счёта).
-- Словарь целиком храним на сервере и целиком же шлём в БД — клиент не является
-- источником правды по чужим записям (он знает только игроков текущей игры).
function Server:OnPlayerChangeMutePrefs(event)
    local PlayerID = event.PlayerID
    if PlayerID == nil or not self.Players[PlayerID] then return end

    local TargetPlayerID = event.target_player_id
    if TargetPlayerID == nil or not PlayerResource:IsValidPlayerID(TargetPlayerID) then return end
    if TargetPlayerID == PlayerID then return end

    local target_steamid = PlayerResource:GetSteamAccountID(TargetPlayerID)
    if target_steamid == nil or target_steamid <= 0 then return end

    local text   = (tonumber(event.text)   or 0) ~= 0 and 1 or 0
    local sounds = (tonumber(event.sounds) or 0) ~= 0 and 1 or 0
    local other  = (tonumber(event.other)  or 0) ~= 0 and 1 or 0

    local prefs = self.Players[PlayerID].mute_prefs or {}
    local key = tostring(target_steamid)

    if text == 0 and sounds == 0 and other == 0 then
        prefs[key] = nil
    else
        -- Кап на размер словаря (защита от бесконечного роста JSON). Обновление
        -- существующей записи проходит всегда, ограничиваем только новые ключи.
        if prefs[key] == nil and self:CountMutePrefs(prefs) >= MUTE_PREFS_MAX_ENTRIES then
            return
        end
        prefs[key] = {text = text, sounds = sounds, other = other}
    end

    self.Players[PlayerID].mute_prefs = prefs

    self:PublishMutePrefs(PlayerID)

    SendRequest(SERVER_URL.."on_mute_prefs_changed", {
        SteamID = self.Players[PlayerID].steamid,
        mute_prefs = prefs,
    }, nil, true)
end

-- «Мут всех» из таблицы счёта: применяем ко всем игрокам игры за один заход, чтобы
-- не гнать 24 отдельных запроса в БД.
function Server:OnPlayerChangeMutePrefsAll(event)
    local PlayerID = event.PlayerID
    if PlayerID == nil or not self.Players[PlayerID] then return end

    local value = (tonumber(event.value) or 0) ~= 0 and 1 or 0

    local prefs = self.Players[PlayerID].mute_prefs or {}

    for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if i ~= PlayerID and PlayerResource:IsValidPlayerID(i) then
            local target_steamid = PlayerResource:GetSteamAccountID(i)
            if target_steamid ~= nil and target_steamid > 0 then
                local key = tostring(target_steamid)
                if value == 0 then
                    prefs[key] = nil
                elseif prefs[key] ~= nil or self:CountMutePrefs(prefs) < MUTE_PREFS_MAX_ENTRIES then
                    prefs[key] = {text = 1, sounds = 1, other = 1}
                end
            end
        end
    end

    self.Players[PlayerID].mute_prefs = prefs

    self:PublishMutePrefs(PlayerID)

    SendRequest(SERVER_URL.."on_mute_prefs_changed", {
        SteamID = self.Players[PlayerID].steamid,
        mute_prefs = prefs,
    }, nil, true)
end

function Server:CountMutePrefs(prefs)
    local count = 0
    for _, _ in pairs(prefs) do count = count + 1 end
    return count
end

function Server:CreatePlayerData(PlayerID, Place)
    if not self.Players[PlayerID] then return end
    if Place == 0 then return end

    if not Rounds:IsLastDuelActive() then
        HeroBuilder:UpdateSmokeCount(PlayerID)
        HeroBuilder:UpdateLoserCurseCount(PlayerID)
    end

    local PlayerBuilderInfo = HeroBuilder:GetPlayerInfo(PlayerID)
    local PlayerMainInfo = Players:GetPlayer(PlayerID)
    if PlayerBuilderInfo == nil or PlayerMainInfo == nil then return end

    local Hero = PlayerBuilderInfo.selected_hero_ent
    if Hero == nil then return end

    -- Гарантируем, что зафиксирована волна, на которой умер игрок
    if not self.Players[PlayerID].player_die_round or self.Players[PlayerID].player_die_round == 0 then
        self.Players[PlayerID].player_die_round = Rounds:GetCurrentRound()
    end

    local LastWave = self.Players[PlayerID].player_die_round or 0

    local LastDuelWinner = false
    local LastDuelActivated = false
    local LastDuelWins = 0
    local LastDuelLoses = 0

    -- ВАЖНО: рейтинг/монеты тут считаем ВСЕГДА реальными. CreatePlayerData вызывается в момент
    -- ВЫЛЕТА игрока (players.lua), поэтому гейт «<20 волн» по текущему раунду = по ЛИЧНОЙ волне
    -- вылета — это была дыра: вышедший до 20-й волны не получал минус рейтинг, хотя матч доживал
    -- до 20+. Решение «засчитывать матч» — по ИТОГОВОЙ длине, применяется в конце игры (см. on_game_end).
    local PlayerPreRating = self:CalculatePreRatingByGame(PlayerID, Place)

    if Rounds:IsLastDuelActive() then
        LastWave = self.LastRoundBeforeDuel

        local PlayerInfo = Players:GetPlayer(PlayerID)
        if PlayerInfo ~= nil then
            LastDuelActivated = true
            LastDuelWins = PlayerInfo.last_duel_wins
            LastDuelLoses = PlayerInfo.last_duel_loses
            if PlayerInfo.last_duel_wins >= 3 then
                LastDuelWinner = true
            end
        end
    else
        PlayerPreRating = self:AbsRating(PlayerPreRating, Place)
        CustomNetTables:SetTableValue('mmr_player', tostring(PlayerID), {original_rating = self.Players[PlayerID].profile.rating, new_rating = self.Players[PlayerID].profile.rating+PlayerPreRating})
    end

    self.Players[PlayerID].end_data = {
        SteamID = self.Players[PlayerID].steamid,

        player_data = {
            rating_change = PlayerPreRating,
            coins_change = self:CalculateCoinsByGame(PlayerID, Place),
            game_time = GameRules:GetDOTATime(false, false),
            heroname = PlayerBuilderInfo.selected_hero,
            level = PlayerResource:GetLevel(PlayerID) or 0,
            kills = PlayerMainInfo.pvp_wins,
            kills_creeps = PlayerResource:GetLastHits(PlayerID) or 0,
            deaths = PlayerMainInfo.pvp_loses,
            gold = Players:GetPlayerNetworth(PlayerID) or 0,
            bet_gold = self:GetPlayerBetsGold(PlayerID),
            place = Place,
            has_scepter = Hero:HasScepter(),
            has_shard = Hero:HasModifier("modifier_item_aghanims_shard"),
            leaved = Players:PlayerStateIs(PlayerID, PLAYER_STATE.ABANDONED),
            facet = Hero:GetHeroFacetID(),
            last_wave = LastWave,
            books = PlayerBuilderInfo.books,
            abilities = PlayerBuilderInfo.abilities_list,
            abilities_new = PlayerBuilderInfo.abilities_list_server,
            skills = PlayerBuilderInfo.skills_list,        -- [навыки] словарь skill_name -> count, для записи в БД/показа на сайте
            items = self:GetAllPlayerItemsByCategories(Hero),
            last_duel_activated = LastDuelActivated,
            last_duel_winner = LastDuelWinner,
            last_duel_wins = LastDuelWins,
            last_duel_loses = LastDuelLoses,
            lifes = PlayerBuilderInfo.lifes_count_server,
            loser_curse = PlayerBuilderInfo.loser_curse_count,
            smokes = PlayerBuilderInfo.smoke_count,

            banned_heroes = Bans:GetPlayerHeroBans(PlayerID),
            banned_abilities = Bans:GetPlayerAbilityBans(PlayerID),
            pages = PlayerBuilderInfo.pages,
            reroll_times = PlayerBuilderInfo.reroll_times,

            attribute_book_str = PlayerBuilderInfo.attribute_book_str,
            attribute_book_agi = PlayerBuilderInfo.attribute_book_agi,
            attribute_book_int = PlayerBuilderInfo.attribute_book_int,

            extra_creeps = PlayerBuilderInfo.extra_creeps,
        }
    }

    PlayerTables:SetTableValue("globals", "player_"..PlayerID.."_end_data", self.Players[PlayerID].end_data)
end

function Server:GetAllPlayerItemsByCategories(Hero)
    local ItemsBase = {
        inventory = {},
        backpack = {},
        neutral = {},
        eated = {},
    }
    if not Hero then
        return ItemsBase
    end

    local ItemsSlots = {
        inventory = {
            DOTA_ITEM_SLOT_1,
            DOTA_ITEM_SLOT_2,
            DOTA_ITEM_SLOT_3,
            DOTA_ITEM_SLOT_4,
            DOTA_ITEM_SLOT_5,
            DOTA_ITEM_SLOT_6,
        },
        backpack = {
            DOTA_ITEM_SLOT_7,
            DOTA_ITEM_SLOT_8,
            DOTA_ITEM_SLOT_9,
        },
        neutral = {
            DOTA_ITEM_NEUTRAL_ACTIVE_SLOT,
            DOTA_ITEM_NEUTRAL_PASSIVE_SLOT,
        }
    }
    
    for k, v in pairs(ItemsSlots) do
        for _, SlotID in ipairs(v) do
            local Item = Hero:GetItemInSlot(SlotID)
            if Item then
                table.insert(ItemsBase[k], Item:GetName())
            end
        end
    end

    local Buffs = {
        "modifier_item_essence_of_speed",
        "modifier_item_gem_shard",
        "modifier_item_gem_shard_2",
        "modifier_item_moon_shard_buff_custom",
        "modifier_item_dark_moon_shard"
    }

    for _, ModifName in ipairs(Buffs) do
        if Hero:HasModifier(ModifName) then
            table.insert(ItemsBase["eated"], ModifName)
        end
    end

    return ItemsBase
end

function Server:GetPlayerBetsGold(PlayerID)
    local PlayerInfo = Players:GetPlayer(PlayerID)

    if PlayerInfo == nil then return 0 end

    local GoldFromBets = 0

    for _, Bet in pairs(PlayerInfo.bet_history) do
        if Bet.winner_team == Bet.betted_team then
            GoldFromBets = GoldFromBets + Bet.value
        end
    end

    return GoldFromBets
end

function Server:SendDataToServer(TeamID, bWin)
    if TeamID == nil then return end
    if Players:GetTeam(TeamID) == nil then return end

    if not SERVER_ENABLE_WITH_CHEATS then
        if IsInToolsMode() or GameRules:IsCheatMode() then 
            return 
        end
    end

    -- Новый фильтр: не отправлять игры, если игроков меньше, чем требуется
    if self:GetPlayersCount() < SERVER_MIN_PLAYERS_TO_COUNT then
        return
    end

    if SERVER_CHECK_CONDITIONS then
        if self:GetPlayersCount() <= SERVER_CONDITIONS_TO_COUNT_GAME.PLAYERS then return end

        local GameMinutes = (GameRules:GetDOTATime(false, false) / 60)
        if GameMinutes < SERVER_CONDITIONS_TO_COUNT_GAME.MINUTES then return end
    end

    local MatchID = tostring(GameRules:Script_GetMatchID())
    local RatingSeasonInfo = self.RatingSeasonsInfo
    local RatingSeasonID = 0
    if RatingSeasonInfo and RatingSeasonInfo.CurrentSeason and RatingSeasonInfo.CurrentSeason.id ~= nil then
        RatingSeasonID = RatingSeasonInfo.CurrentSeason.id
    end
    local WinnerSteamID = -1
    local fTeamPlayerID = Players:GetTeamPlayerByNum(TeamID, 1)
    if fTeamPlayerID ~= nil and bWin then
        WinnerSteamID = PlayerResource:GetSteamAccountID(fTeamPlayerID)
    end

    local LastWave = Rounds:GetCurrentRound()
    local LastDuelWins = 0
    local LastDuelLoses = 0

    if Rounds:IsLastDuelActive() then
        LastWave = self.LastRoundBeforeDuel

        if fTeamPlayerID ~= nil then
            local PlayerDuelInfo = Players:GetPlayer(fTeamPlayerID)
            if PlayerDuelInfo ~= nil then
                LastDuelWins = PlayerDuelInfo.last_duel_wins
                LastDuelLoses = PlayerDuelInfo.last_duel_loses
            end
        end
    end

    local CurrentSettings = {}
    for SETTING_NAME, SETTING_VALUE in pairs(GAME_SETTINGS.DEFAULT) do
        if SETTING_NAME ~= "DIFFICULT" then
            table.insert(CurrentSettings, {name = SETTING_NAME, value = GetGameSetting(SETTING_NAME)})
        end
    end

    local Data = {
        Main = {
            match_id = MatchID,
            season_id = RatingSeasonID,
            winner_steamid = WinnerSteamID,
            last_duel_activated = Rounds:IsLastDuelActive() == true,
            last_duel_wins = LastDuelWins,
            last_duel_loses = LastDuelLoses,
            last_wave = LastWave,
            duration = GameRules:GetDOTATime(false, false),
            abilities_bans = Bans:GetAllBannedAbilities(),
            heroes_bans = Bans:GetAllBannedHeroes(),
            rounds_seed = tostring(Rounds:GetRandomSeed()),
            game_settings = CurrentSettings,
            duel_log = Rounds.DuelLog or {}     -- [дуэлянты] все дуэли за игру (round/a/b/winner)
        },
        Players = {},
    }

    -- [<20] Матч короче 20 волн НЕ засчитывается. Решает ИТОГОВАЯ длина матча (LastWave =
    -- матчевая волна завершения), а НЕ личный забег игрока. Зануляем награды ВСЕМ для экрана
    -- конца игры (на сервер всё равно не шлём — гейт ниже). Так вышедший рано НЕ убегает от
    -- минуса рейтинга в матче, дожившем до 20+ (рейтинг считается реальным в CreatePlayerData).
    local bMatchCounts = LastWave >= 20

    -- [пиковый ливер] Игрок, который подключился (значит зарегистрирован в self.Players на
    -- OnPlayerConnected), но вышел ДО получения героя (на пиках) — CreatePlayerData для него
    -- вылетал на Hero==nil, поэтому end_data оставался {} и его не было НИ в матче, НИ в рейтинге.
    -- Достраиваем ему минимальный end_data: последнее место + обычный минус рейтинга за него
    -- (без спец-штрафа). Места доигравших (1..N) при этом не сдвигаются — GetAllActiveTeams уже
    -- исключил удалённые команды ливеров, так что «последнее» место как раз свободно.
    local FinisherCount = 0
    for _, PlayerInfo in pairs(self.Players) do
        if PlayerInfo.end_data.SteamID ~= nil then
            FinisherCount = FinisherCount + 1
        end
    end

    local LeaverIndex = 0
    for PID, PlayerInfo in pairs(self.Players) do
        -- пустой end_data + реальный SteamID (бот отсеивается: у него есть герой -> end_data не пустой)
        if PlayerInfo.end_data.SteamID == nil and PlayerInfo.steamid and PlayerInfo.steamid ~= 0 then
            LeaverIndex = LeaverIndex + 1
            local Place = FinisherCount + LeaverIndex

            -- Тот же путь расчёта, что у всех: pre-rating за место -> AbsRating (кап MAX_LOSS[Place]).
            -- WaveBonus=0 (player_die_round=0/nil -> волн < порога), т.е. чистый минус за место.
            local LeaverRating = self:AbsRating(self:CalculatePreRatingByGame(PID, Place), Place)

            CustomNetTables:SetTableValue('mmr_player', tostring(PID),
                { original_rating = PlayerInfo.profile.rating, new_rating = PlayerInfo.profile.rating + LeaverRating })

            -- Полная структура player_data с нулевыми дефолтами — mysql2 на сервере падает на
            -- undefined bind-параметрах, поэтому ВСЕ поля обязаны иметь конкретное значение.
            PlayerInfo.end_data = {
                SteamID = PlayerInfo.steamid,

                player_data = {
                    rating_change = LeaverRating,
                    coins_change = 0,
                    game_time = GameRules:GetDOTATime(false, false),
                    heroname = "",
                    level = 0,
                    kills = 0,
                    kills_creeps = 0,
                    deaths = 0,
                    gold = 0,
                    bet_gold = 0,
                    place = Place,
                    has_scepter = false,
                    has_shard = false,
                    leaved = 1,
                    facet = 0,
                    last_wave = 0,
                    books = 0,
                    abilities = {},
                    abilities_new = {},
                    skills = {},
                    items = self:GetAllPlayerItemsByCategories(nil),
                    last_duel_activated = false,
                    last_duel_winner = false,
                    last_duel_wins = 0,
                    last_duel_loses = 0,
                    lifes = 0,
                    loser_curse = 0,
                    smokes = 0,
                    banned_heroes = {},
                    banned_abilities = {},
                    pages = 0,
                    reroll_times = 0,
                    attribute_book_str = 0,
                    attribute_book_agi = 0,
                    attribute_book_int = 0,
                    extra_creeps = {},
                }
            }

            PlayerTables:SetTableValue("globals", "player_"..PID.."_end_data", PlayerInfo.end_data)
        end
    end

    for PID, PlayerInfo in pairs(self.Players) do
        if PlayerInfo.end_data.SteamID ~= nil then
            if not bMatchCounts then
                if PlayerInfo.end_data.player_data then
                    PlayerInfo.end_data.player_data.rating_change = 0
                    PlayerInfo.end_data.player_data.coins_change = 0
                end
                PlayerTables:SetTableValue("globals", "player_"..PID.."_end_data", PlayerInfo.end_data)
                CustomNetTables:SetTableValue('mmr_player', tostring(PID),
                    { original_rating = PlayerInfo.profile.rating, new_rating = PlayerInfo.profile.rating })
            elseif PlayerInfo.end_data.player_data
               and PlayerInfo.end_data.player_data.rating_change ~= nil
               and Rounds:IsLastDuelActive()
               and PlayerInfo.end_data.player_data.place <= 2 then
                PlayerInfo.end_data.player_data.rating_change = self:AbsRating(
                    self:CalculateRatingByGame(PID, PlayerInfo.end_data.player_data.rating_change, PlayerInfo.end_data.player_data.place),
                    PlayerInfo.end_data.player_data.place
                )

                CustomNetTables:SetTableValue(
                    'mmr_player',
                    tostring(PID),
                    { original_rating = PlayerInfo.profile.rating, new_rating = PlayerInfo.profile.rating + PlayerInfo.end_data.player_data.rating_change }
                )
            end
            table.insert(Data.Players, PlayerInfo.end_data)
        end
    end

    -- Матчи, закончившиеся РАНЬШЕ 20-го раунда, не отправляем на сервер (не идут в статистику).
    -- LastWave = раунд завершения (GetCurrentRound / LastRoundBeforeDuel). Сервер дублирует этот
    -- гейт в on_game_end на случай форжа.
    if LastWave < 20 then
        return
    end

    SendRequest(SERVER_URL.."on_game_end", Data, nil, true)
end

function Server:GetRatingTop(SeasonID, bSendToPanorama)
    if self.RatingTops[SeasonID] == nil then
        SendRequest(SERVER_URL.."get_rating_top", {SeasonID = SeasonID}, function (Res)
            self.RatingTops[SeasonID] = Res

            if bSendToPanorama then
                CustomGameEventManager:Send_ServerToAllClients("server_send_rating_season_info", {season = SeasonID, top = Res})
            end
        end, true)
    elseif bSendToPanorama then
        CustomGameEventManager:Send_ServerToAllClients("server_send_rating_season_info", {season = SeasonID, top = self.RatingTops[SeasonID]})
    end
end

function Server:GetRatingSeasons()
    SendRequest(SERVER_URL.."get_rating_seasons", {}, function (Res)
        self.RatingSeasonsInfo = Res
        CustomNetTables:SetTableValue("globals", "rating_seasons", Res)

        if Res.CurrentSeason and Res.CurrentSeason.id ~= nil and Res.CurrentSeason.id ~= 0 then
            self:GetRatingTop(Res.CurrentSeason.id, false)
        end
    end, true)
end

function Server:GetCurrentSeasonRatingTop()
    local CurrentSeasonInfo = self.RatingSeasonsInfo.CurrentSeason

    if CurrentSeasonInfo and CurrentSeasonInfo.id ~= nil and CurrentSeasonInfo.id ~= 0 then
        return self.RatingTops[CurrentSeasonInfo.id]
    end

    return nil
end

function Server:UpdatePlayersPopularBans()
    local Players = {}

    for PID, PlayerInfo in pairs(self.Players) do
        table.insert(Players, {
            steamid = PlayerInfo.steamid,
            heroes = PlayerInfo.current_ban_heroes,
            abilities = PlayerInfo.current_ban_abilities,

            favorite_ban_heroes = PlayerInfo.favorite_ban_heroes,
            favorite_ban_abilities = PlayerInfo.favorite_ban_abilities,
        })
    end

    SendRequest(SERVER_URL.."update_popular_bans", {Players = Players}, nil, true)
end

function Server:OnAttemptRerollHeroes(PlayerID, Price)
    if not self.Players[PlayerID] then return end

    self.Players[PlayerID].profile.coins = self.Players[PlayerID].profile.coins - Price

    self:UpdatePlayerNetTable(PlayerID)

    local Data = {
        SteamID = self.Players[PlayerID].steamid,
        price = Price
    }

    SendRequest(SERVER_URL.."on_reroll", Data, function (Res)
        self.Players[PlayerID].profile.coins = Res.coins

        self:UpdatePlayerNetTable(PlayerID)
    end, true)
end

function Server:OnSettingsChanged(PlayerID)
    if not self.Players[PlayerID] then return end

    -- CustomNetTables:SetTableValue("player_info", "setting_data_"..tostring(PlayerID), self.Players[PlayerID].settings)
    PlayerTables:SetTableValue('player_'..PlayerID, "setting_data", self.Players[PlayerID].settings)

    local Data = table.shallowcopy(self.Players[PlayerID].settings)
    Data.SteamID = self.Players[PlayerID].steamid

    SendRequest(SERVER_URL.."on_settings_changed", Data, nil, true)
end

function Server:OnPlayerWantBuyItem(event)
    local PlayerID = event.PlayerID
    local ItemName = event.name

    local ItemInfo = ITEMS_LIST[ItemName] or CHAT_WHEEL_LIST[ItemName]
    if ItemInfo == nil or ItemInfo.buyable == false or self:PlayerHasItem(PlayerID, ItemName) then return end

    local Player = PlayerResource:GetPlayer(PlayerID)

    if Player then
        CustomGameEventManager:Send_ServerToPlayer(Player, "menu_loading", {})
    end

    if not self.Players[PlayerID] or self.Players[PlayerID].server_connected == false then 
        if Player then
            CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#bp_error_server_disconnect", class = "Error", type=1})
        end
        return 
    end

    local Price = ItemInfo.cost
    if Price == nil then
        Price = 0
    end

    if self.Players[PlayerID].profile.coins >= Price then

        self.Players[PlayerID].profile.coins = self.Players[PlayerID].profile.coins - Price

        self:UpdatePlayerNetTable(PlayerID)

        local Data = {
            SteamID = self.Players[PlayerID].steamid,
            item = ItemName,
            price = Price
        }
    
        SendRequest(SERVER_URL.."on_buy_item", Data, function (Res)
            self.Players[PlayerID].profile.coins = Res.coins
            self.Players[PlayerID].player_owned_items = Res.items

            self:UpdatePlayerNetTable(PlayerID)

            if Player then
                CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#bp_accept", class = "Success", type=2, duration=1})
            end
        end, true)
    else
        if Player then
            CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#bp_error_no_arena_coin", class = "Error", type=1})
        end
    end
end

function Server:OnPlayerWantWearItem(event)
    local PlayerID = event.PlayerID
    local ItemName = event.name

    local ItemInfo = ITEMS_LIST[ItemName]
    if ItemInfo == nil or not self:PlayerHasItem(PlayerID, ItemName) then return end

    local SlotName = Server:GetItemSlotName(ItemName)

    if SlotName ~= "NONE" and self.Players[PlayerID] and self.Players[PlayerID].player_items_slots then
        local Name = ItemName
        if self.Players[PlayerID].player_items_slots[SlotName] == ItemName then
            self.Players[PlayerID].player_items_slots[SlotName] = ""
            Name = ""
        else
            self.Players[PlayerID].player_items_slots[SlotName] = ItemName
        end

        self:UpdatePlayerNetTable(PlayerID)

        self:UpdatePlayerCosmetics(PlayerID, SlotName, ItemName)

        CustomGameEventManager:Send_ServerToAllClients("PLAYER_INVENTORY_ITEM_WEAR_UPDATE", {PlayerID = PlayerID, SlotName=SlotName})

        local Data = {
            SteamID = self.Players[PlayerID].steamid,
            slot = SlotName,
            item = Name,
        }

        SendRequest(SERVER_URL.."on_wear_item", Data, nil, true)
    end
end

function Server:GetItemSlotName(ItemName)
    if ITEMS_LIST[ItemName] and ITEMS_LIST[ItemName].slot_name then
        return ITEMS_LIST[ItemName].slot_name
    end

    return "NONE"
end

function Server:GetPlayerSlotItemInfo(PlayerID, SlotName)
    if self.Players[PlayerID] and self.Players[PlayerID].player_items_slots then
        local ItemName = self.Players[PlayerID].player_items_slots[SlotName]
        if ItemName and ItemName ~= "" and ITEMS_LIST[ItemName] and self:PlayerHasItem(PlayerID, ItemName) then
            return ITEMS_LIST[ItemName]
        end
    end

    return nil
end

function Server:UpdatePlayerCosmetics(PlayerID, SlotName, ItemName)
    local Player = Players:GetPlayer(PlayerID)
    if not Player then return end

    local Owner = Player.hero
    local Units = {Player.hero, Player.secondary_unit}
    local ItemSlotType = self:GetItemSlotType(ItemName)

    local TypesToUpdate = {
        ITEMS_TYPES.PET,
        ITEMS_TYPES.FX_HERO,
        ITEMS_TYPES.WEATHER,
        ITEMS_TYPES.FX_ATTACK
    }

    for _, Unit in ipairs(Units) do
        if Owner and not Owner:IsNull() and Unit and not Unit:IsNull() and table.contains(TypesToUpdate, ItemSlotType) then
            Unit:AddNewModifier(Owner, nil, "modifier_player_cosmetics", {})
        end
    end
end

function Server:GetItemSlotType(ItemName)
    if ITEMS_LIST[ItemName] and ITEMS_LIST[ItemName].slot_type then
        return ITEMS_LIST[ItemName].slot_type
    end

    return "NONE"
end

function Server:OnPlayerAttemptUsePromocode(event)
    local PlayerID = event.PlayerID
    local Code = event.code

    local Player = PlayerResource:GetPlayer(PlayerID)

    if not self.Players[PlayerID] or self.Players[PlayerID].server_connected == false then 
        if Player then
            CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#bp_error_server_disconnect", class = "Error", type=1})
        end
        return 
    end

    local Data = {
        SteamID = self.Players[PlayerID].steamid,
        code = Code,
    }

    SendRequest(SERVER_URL.."on_use_promocode", Data, function (Res)
        if Res.status == 1 then
            self.Players[PlayerID].profile.coins = Res.new_coins

            self:UpdatePlayerNetTable(PlayerID)

            if Player then
                CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#bp_accept", class = "Success", type=2, duration=1})
            end
        else
            CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#promocode_error", class = "Error", type=1})
        end
    end, true)
end

function Server:OnPlayerAddFavoriteBan(event)
    local BanType = event.BanType
    local PlayerID = event.PlayerID
    local BanItem = event.BanItem

    if not self.Players[PlayerID] then return end

    local BanCategory = BanType == "HERO" and "favorite_ban_heroes" or "favorite_ban_abilities"

    if self.Players[PlayerID][BanCategory] == nil then return end

    if table.contains(self.Players[PlayerID][BanCategory], BanItem) then
        table.remove_item(self.Players[PlayerID][BanCategory], BanItem)
    else
        if #self.Players[PlayerID][BanCategory] >= 10 then
            SendErrorToPlayer(PlayerID, "#dota_hud_error_message")
        else
            table.insert(self.Players[PlayerID][BanCategory], BanItem)
        end
    end

    self:UpdatePlayerNetTable(PlayerID)
end

function Server:BattlePassBuy(event)
    local PlayerID = event.PlayerID
    local duration_type = event.duration_type

    self:OnAttemptBuyBattlePass(PlayerID, store_system.BattlePassDuration[duration_type], store_system.BattlePassPrice[duration_type])
end

function Server:OnAttemptBuyBattlePass(PlayerID, TimeInDays, Price)
    local Player = PlayerResource:GetPlayer(PlayerID)

    if Player then
        CustomGameEventManager:Send_ServerToPlayer(Player, "menu_loading", {})
    end

    if not self.Players[PlayerID] or self.Players[PlayerID].server_connected == false then 
        if Player then
            CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#bp_error_server_disconnect", class = "Error", type=1})
        end
        return 
    end

    if self.Players[PlayerID].profile.coins >= Price then

        self.Players[PlayerID].profile.coins = self.Players[PlayerID].profile.coins - Price

        self:UpdatePlayerNetTable(PlayerID)

        local Data = {
            SteamID = self.Players[PlayerID].steamid,
            time = TimeInDays,
            price = Price
        }
    
        SendRequest(SERVER_URL.."on_buy_battle_pass", Data, function (Res)
            self.Players[PlayerID].profile.coins = Res.coins
            self.Players[PlayerID].profile.battle_pass = Res.battle_pass

            self:UpdatePlayerNetTable(PlayerID)

            if Player then
                CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#bp_accept", class = "Success", type=2, duration=1})
            end
        end, true)
    else
        if Player then
            CustomGameEventManager:Send_ServerToPlayer(Player, "menu_special_notification", {text = "#bp_error_no_arena_coin", class = "Error", type=1})
        end
    end
end

function Server:OnPlayerChangeSettings(event)
    if event.PlayerID == nil then return end
    if not self.Players[event.PlayerID] then return end

    local settings = self.Players[event.PlayerID].settings
    if settings then
        if event.effect_ability_selection ~= nil then
            settings.settings_effect_select = event.effect_ability_selection
        end
        if event.right_ability_selection ~= nil then
            settings.settings_right_select = event.right_ability_selection
        end
        if event.width_ability_selection ~= nil then
            settings.settings_width_select = event.width_ability_selection
        end
        if event.settings_hints_enabled ~= nil then
            settings.settings_hints_enabled = event.settings_hints_enabled
        end
        if event.settings_barrage_opacity ~= nil then
            settings.settings_barrage_opacity = event.settings_barrage_opacity
        end
        if event.settings_penguin_sound ~= nil then
            settings.settings_penguin_sound = event.settings_penguin_sound
        end
        if event.settings_notifications ~= nil then
            settings.settings_notifications = event.settings_notifications
        end
        if event.duel_notification_duration ~= nil then
            settings.duel_notification_duration = event.duel_notification_duration
        end
        if event.camera_distance ~= nil then
            settings.camera_distance = event.camera_distance
        end
        if event.minimized_extra_creatures ~= nil then
            settings.minimized_extra_creatures = event.minimized_extra_creatures
        end
        if event.autoclose_duel_info ~= nil then
            settings.autoclose_duel_info = event.autoclose_duel_info
        end
        if event.autoopen_bet_history ~= nil then
            settings.autoopen_bet_history = event.autoopen_bet_history
        end

        -- [NP-23] Доп. настройки.
        local np23_fields = {
            "hide_aegis_notification",
            "watch_duel_after_round",
        }
        for _, f in ipairs(np23_fields) do
            if event[f] ~= nil then settings[f] = event[f] end
        end

        -- Подсветка: тогглы (числа 0/1) + 10 цветов (строки "#RRGGBB").
        local highlight_fields = {
            "highlight_master_enabled", "highlight_sss_enabled",
            "highlight_modified_enabled", "highlight_use_categories",
            "color_default_sss", "color_modified",
            "color_forms", "color_splashes", "color_op", "color_bkb",
            "color_bashes", "color_percent", "color_saves", "color_useful",
        }
        for _, f in ipairs(highlight_fields) do
            if event[f] ~= nil then settings[f] = event[f] end
        end

        self:OnSettingsChanged(event.PlayerID)
    end
end

function Server:GetPlayerSettingValue(PlayerID, SettingName)
    if not self.Players[PlayerID] or not self.Players[PlayerID].settings then return 0 end

    return self.Players[PlayerID].settings[SettingName] or 0
end

function Server:OnPlayerChangeKeyBind(event)
    if event == nil then return end
    local slot = event.bind_num
    local key = event.key
    local PlayerID = event.PlayerID
    local PlayerInfo = Server:GetPlayerInfo(PlayerID)
    local SlotString = tostring(slot)
    if PlayerInfo and SlotString ~= nil then
        PlayerInfo.settings.keybinds[SlotString] = key

        self:OnSettingsChanged(PlayerID)
    end
end

function Server:OnPlayerChangeKeyBindQuickcast(event)
    local slot = event.bind_num
    local enabled = event.enabled
    local PlayerID = event.PlayerID
    local PlayerInfo = Server:GetPlayerInfo(PlayerID)

    if PlayerInfo then
        PlayerInfo.settings.quickcasts[slot] = enabled

        self:OnSettingsChanged(PlayerID)
    end
end

function Server:OnPlayerChangeNotificationFilter(event)
    local FilterType = event.filter_type
    local FilterEnabled = event.enabled
    local PlayerID = event.PlayerID
    local PlayerInfo = Server:GetPlayerInfo(PlayerID)

    if PlayerInfo then
        PlayerInfo.settings.settings_notifications_filters[FilterType] = FilterEnabled

        self:OnSettingsChanged(PlayerID)
    end
end

function Server:RecordChatWheelChanges(PlayerID, LineID, ItemName)
    local Data = {
        SteamID = PlayerResource:GetSteamAccountID(PlayerID),
        LineID = LineID,
        ItemName = ItemName
    }

    SendRequest(SERVER_URL.."chat_wheel_changed", Data, nil, true)
end

function Server:OnPlayerWantGetRatingSeasonInfo(event)
    local SeasonID = event.season

    if SeasonID ~= 0 or SeasonID ~= -1 then
        self:GetRatingTop(SeasonID, true)
    end
end

function Server:CalculateCoinsByGame(PlayerID, Place)
    if not self.Players[PlayerID] then
        CustomNetTables:SetTableValue('coins_table', tostring(PlayerID), {coins_bonus = 0})
        return 0
    end
    
    local CoinsByGame = SERVER_COINS_BY_PLACE[Place] or 0

    if CoinsByGame >= self.Players[PlayerID].profile.max_coins_daily then
        CoinsByGame = self.Players[PlayerID].profile.max_coins_daily
    end

    CustomNetTables:SetTableValue('coins_table', tostring(PlayerID), {coins_bonus = CoinsByGame})

    return CoinsByGame
end

function Server:CalculatePreRatingByGame(PlayerID, Place)
    if not self.Players[PlayerID] then return 0 end

    if not SERVER_RATING_ENABLE_WITH_CHEATS then
        if IsInToolsMode() or GameRules:IsCheatMode() then 
            return 0
        end
    end

    local bIsFullGame = self:GetPlayersCount() == 8

    -- Базовые переменные рейтинга
    local CurrentRating = self.Players[PlayerID].profile.rating
    local BaseChange = SERVER_RATING_SETTINGS.BASE_CHANGE[Place] or 0
    -- Передаём Place, чтобы GetWavesRatingBonus для финалистов (1-2 место в LastDuel)
    -- мог использовать LastRoundBeforeDuel, а не player_die_round=200+ (см. fix
    -- ниже в GetWavesRatingBonus -- без него финалистам всегда начислялся
    -- максимальный WaveBonus=20 из-за прыжка self.CurrentRound на 200 при
    -- активации финальной дуэли в Rounds:PrepareRound(LAST_DUEL_STARTING_ROUND_NUM)).
    local WaveBonus = self:GetWavesRatingBonus(PlayerID, Place)
    local AverageRating = 0
    local StrengthRatio = 1

    for _, PlayerInfo in pairs(self.Players) do
        AverageRating = AverageRating + (PlayerInfo.profile.rating)
    end
    local PlayersCount = math.max(self:GetPlayersCount(), 1)
    AverageRating = AverageRating / PlayersCount

    if CurrentRating > 0 and AverageRating > 0 then
        StrengthRatio = CurrentRating / AverageRating
    end

    local RatingModifier = StrengthRatio
    if BaseChange > 0 then
        RatingModifier = 1 / StrengthRatio
    end
    RatingModifier = math.pow(RatingModifier, SERVER_RATING_SETTINGS.STR_RATIO_POWER or 1)

    local PreBonus = WaveBonus
    if bIsFullGame then
        PreBonus = (BaseChange * RatingModifier * SERVER_RATING_SETTINGS.K_FACTOR) + WaveBonus
    end

    return PreBonus
end

function Server:CalculateRatingByGame(PlayerID, Rating, Place)
    if not self.Players[PlayerID] then return Rating end

    local bIsFullGame = self:GetPlayersCount() == 8

    if bIsFullGame then
        -- Бонус/штраф последней дуэли: каждый финалист получает изменение от своего
        -- собственного pre-rating'а, а не от рейтинга соперника. Это убирает кейс,
        -- когда 1-е место получало огромный бонус из-за раздутого pre-rating'а
        -- слабого 2-го (через 1/StrengthRatio в RatingModifier).
        local DuelDelta = math.abs(Rating) * (SERVER_RATING_SETTINGS.DUEL_PCT / 100)

        if Place == 1 then
            Rating = Rating + DuelDelta
        elseif Place == 2 then
            Rating = Rating - DuelDelta
        end
    end

    return Rating
end

function Server:AbsRating(Rating, Place)
    local bIsNegative = Rating < 0
    local Floored = math.floor(math.abs(Rating) + 0.5)
    local CapTable = bIsNegative and SERVER_RATING_SETTINGS.MAX_LOSS or SERVER_RATING_SETTINGS.MAX_GAIN
    local Cap = math.abs(CapTable[Place] or 0)
    if Floored > Cap then
        Floored = Cap
    end

    if bIsNegative then
        Floored = Floored * -1
    end

    return Floored
end

function Server:GetWavesRatingBonus(PlayerID, Place)
    if not self.Players[PlayerID] then return 0 end

    -- Для финалистов (1-2 место в активной LastDuel) используем LastRoundBeforeDuel,
    -- а не player_die_round. Иначе они ВСЕГДА получают max WaveBonus=20 -- потому что
    -- активация LastDuel вызывает Rounds:PrepareRound(LAST_DUEL_STARTING_ROUND_NUM=200),
    -- self.CurrentRound прыгает на 200, и MakeTeamLose/MakeTeamWin фиксируют
    -- player_die_round=200, что >> 120 (максимальный чекпойнт). В итоге Place=1/2
    -- получали +20 «за дожитие» независимо от того, на какой волне реально стартовала дуэль.
    -- LastRoundBeforeDuel = RoundNum - 1 устанавливается в Rounds:RoundLastDuelVoting
    -- при активации дуэли -- это реальная последняя волна ДО прыжка.
    local Waves
    if Place and Place <= 2 and Rounds and Rounds.IsLastDuelActive and Rounds:IsLastDuelActive() then
        Waves = self.LastRoundBeforeDuel or 0
    else
        Waves = self.Players[PlayerID].player_die_round or 0
    end

    local checkpoints = {
        {70, 1},
        {105, 10},
        {120, 20}
    }

    if Waves < checkpoints[1][1] then return 0 end

    -- Находим интервал
    local prev = checkpoints[1]
    local nextp = checkpoints[#checkpoints]
    for i = 2, #checkpoints do
        if Waves <= checkpoints[i][1] then
            nextp = checkpoints[i]
            break
        end
        prev = checkpoints[i]
    end

    -- Экспоненциальная интерполяция
    local interval = nextp[1] - prev[1]
    local value = prev[2]
    if interval > 0 then
        local t = (Waves - prev[1]) / interval
        value = prev[2] * math.pow(nextp[2] / prev[2], t)
    end

    return math.floor(value + 0.5) -- округляем
end

function Server:UpdatePlayerNetTable(PlayerID)
    if not self.Players[PlayerID] then return end
    
    local t = table.shallowcopy(self.Players[PlayerID])
    t.settings = nil
    CustomNetTables:SetTableValue("players_server_info", "player_"..PlayerID, t)
end

function Server:GetPlayerInfo(PlayerID)
    return self.Players[PlayerID]
end

function Server:GetAllConnectedPlayers()
    local Players = {}
    for PID, PlayerInfo in pairs(self.Players) do
        if PlayerResource:GetConnectionState(PID) == DOTA_CONNECTION_STATE_CONNECTED then
            Players[PID] = PlayerInfo
        end
    end

    return Players
end

function Server:GetUnbannedPlayerFavoriteBans(PlayerID, Type)
    if not self.Players[PlayerID] then return {} end

    local Table = {}

    if Type == "HEROES" then
        Table = self.Players[PlayerID].favorite_ban_heroes
    else
        Table = self.Players[PlayerID].favorite_ban_abilities
    end

    local Result = {}

    for _, Item in ipairs(Table) do
        if Type == "HEROES" and not KeyValues:IsBannedHero(Item) then
            table.insert(Result, Item)
        elseif Type == "ABILITIES" and not KeyValues:IsBannedAbility(Item) then
            table.insert(Result, Item)
        end
    end

    return Result
end

function Server:PlayerHasItem(PlayerID, ItemName)
    if not self.Players[PlayerID] then return false end

    for _, ItemInfo in ipairs(self.Players[PlayerID].player_owned_items) do
        if ItemInfo.item_name == ItemName then
            return true
        end
    end

    return false
end

function Server:GetAllPlayers()
    return self.Players
end

function Server:GetPlayersCount()
    return table.count(self.Players)
end

function Server:GetPlayerRating(PlayerID)
    if not self.Players[PlayerID] or not self.Players[PlayerID].profile then return 3000 end

    return self.Players[PlayerID].profile.rating
end

function Server:SetPlayerValue(PlayerID, ValueName, Value)
    if not self.Players[PlayerID] then return end

    self.Players[PlayerID][ValueName] = Value
end

function Server:IsPlayerBattlePassSubscribed(PlayerID)
    if not self.Players[PlayerID] then return false end

    if self.Players[PlayerID].profile.battle_pass ~= nil and self.Players[PlayerID].profile.battle_pass.status == true then
        return true
    end

    return false
end

function Server:IsPlayerPenguinSoundEnabled(PlayerID)
    if self.Players[PlayerID] == nil then return true end

    if self.Players[PlayerID].settings == nil then return true end

    return self.Players[PlayerID].settings.settings_penguin_sound == 1
end

function Server:IsPlayerNotificationsEnabled(PlayerID)
    if self.Players[PlayerID] == nil then return true end

    if self.Players[PlayerID].settings == nil then return true end

    return self.Players[PlayerID].settings.settings_notifications == 1
end

function Server:IsPlayerAutoOpenBetHistoryEnabled(PlayerID)
    -- По умолчанию авто-открытие истории ставок ОТКЛЮЧЕНО.
    -- Включается через настройку в меню (CheckAutoopenBetHistory).
    if self.Players[PlayerID] == nil then return false end

    if self.Players[PlayerID].settings == nil then return false end

    return self.Players[PlayerID].settings.autoopen_bet_history == 1
end

function Server:IsPlayerConnectedToServer(PlayerID)
    if self.Players[PlayerID] == nil then return false end

    return self.Players[PlayerID].server_connected
end

function Server:OnBugReportSubmit(event)
    -- Получаем PlayerID из источника события
    local PlayerID = event.PlayerID
    if PlayerID == nil then
        print("[BugReport] ERROR: PlayerID is nil!")
        return
    end

    local bugType = event.bug_type or "other"
    local description = event.description or ""

    -- Кулдаун: не чаще 1 репорта в BUG_REPORT_COOLDOWN секунд с игрока (серверная защита, UI дублирует)
    self.LastBugReportTime = self.LastBugReportTime or {}
    local now = GameRules:GetGameTime()
    local last = self.LastBugReportTime[PlayerID]
    if last ~= nil and (now - last) < (BUG_REPORT_COOLDOWN or 10) then
        print("[BugReport] Cooldown active for PlayerID=" .. tostring(PlayerID))
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PlayerID), "bug_report_response", {
            success = false,
            error = "#BugReport_Cooldown"
        })
        return
    end

    -- Минимальная длина описания (серверная проверка, UI дублирует)
    if string.len(description) < (BUG_REPORT_MIN_LENGTH or 5) then
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PlayerID), "bug_report_response", {
            success = false,
            error = "#BugReport_TooShort"
        })
        return
    end

    self.LastBugReportTime[PlayerID] = now

    print("[BugReport] SERVER RECEIVED: PlayerID=" .. tostring(PlayerID) .. ", Type=" .. bugType .. ", Desc length=" .. string.len(description))

    -- Получаем информацию об игроке
    local steamID = PlayerResource:GetSteamAccountID(PlayerID)
    local playerName = "Player " .. tostring(PlayerID)
    
    -- Пробуем получить имя разными способами
    -- 1. Из PlayerResource
    local prName = PlayerResource:GetPlayerName(PlayerID)
    if prName ~= nil and prName ~= "" then
        playerName = prName
    else
        -- 2. Из Player entity
        local player = PlayerResource:GetPlayer(PlayerID)
        if player then
            local pName = player:GetName()
            if pName and pName ~= "" then
                playerName = pName
            end
        end
        
        -- 3. Из Server.Players если есть
        if (playerName == "Player " .. tostring(PlayerID)) and self.Players[PlayerID] then
            if self.Players[PlayerID].nickname and self.Players[PlayerID].nickname ~= 0 then
                playerName = tostring(self.Players[PlayerID].nickname)
            end
        end
    end
    
    -- Получаем информацию о текущем раунде
    local currentRound = 0
    if Rounds ~= nil then
        currentRound = Rounds:GetCurrentRound()
    end

    -- Получаем информацию о герое
    local hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    local heroName = "Unknown"
    local heroLevel = 0
    local abilities = {}
    local items = {}
    
    if hero then
        heroName = hero:GetUnitName()
        heroLevel = hero:GetLevel()
        
        -- Собираем способности (все, даже не прокачанные)
        for i = 0, hero:GetAbilityCount() - 1 do
            local ability = hero:GetAbilityByIndex(i)
            if ability and not ability:IsHidden() then
                local abilityName = ability:GetAbilityName()
                local abilityLevel = ability:GetLevel()
                if type(abilityName) == "string" and type(abilityLevel) == "number" then
                    table.insert(abilities, abilityName .. " (" .. abilityLevel .. ")")
                end
            end
        end
        
        -- Собираем предметы
        for i = 0, 8 do
            local item = hero:GetItemInSlot(i)
            if item then
                local itemName = item:GetAbilityName()
                if type(itemName) == "string" then
                    table.insert(items, itemName)
                end
            end
        end
    end
    
    -- Получаем время игры
    local gameTime = GameRules:GetGameTime()
    local minutes = math.floor(gameTime / 60)
    local seconds = math.floor(gameTime % 60)
    local gameTimeStr = string.format("%d:%02d", minutes, seconds)

    print("[BugReport] Player " .. playerName .. " (SteamID: " .. steamID .. ") submitted bug report:")
    print("[BugReport] Type: " .. bugType)
    print("[BugReport] Description: " .. description)
    print("[BugReport] Hero: " .. heroName .. " (Lvl " .. heroLevel .. ")")
    print("[BugReport] Abilities count: " .. #abilities)
    print("[BugReport] Items count: " .. #items)
    print("[BugReport] Game time: " .. gameTimeStr)

    -- Отправляем в Discord
    self:SendBugReportToDiscord(playerName, steamID, bugType, description, currentRound, heroName, heroLevel, abilities, items, gameTimeStr)

    -- Отправляем подтверждение клиенту
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PlayerID), "bug_report_response", {
        success = true
    })
end

function Server:SendBugReportToDiscord(playerName, steamID, bugType, description, round, heroName, heroLevel, abilities, items, gameTime)
    print("[BugReport] SendBugReportToDiscord called!")
    print("[BugReport] Webhook URL: " .. tostring(DISCORD_BUG_REPORT_WEBHOOK))
    
    if DISCORD_BUG_REPORT_WEBHOOK == nil or DISCORD_BUG_REPORT_WEBHOOK == "" or DISCORD_BUG_REPORT_WEBHOOK == "YOUR_DISCORD_WEBHOOK_URL_HERE" then
        print("[BugReport] Discord webhook not configured!")
        return
    end
    
    print("[BugReport] Preparing Discord message...")

    -- Переводим тип бага на русский
    local bugTypeRu = {
        ["other"] = "Другое",
        ["hero"] = "Герой",
        ["ability"] = "Способность",
        ["item"] = "Предмет"
    }
    local bugTypeText = bugTypeRu[bugType] or bugType
    
    -- Форматируем имя героя (убираем npc_dota_hero_)
    local heroDisplayName = heroName:gsub("npc_dota_hero_", "")
    heroDisplayName = heroDisplayName:sub(1,1):upper() .. heroDisplayName:sub(2)
    
    -- Форматируем способности
    local abilitiesStr = "Нет"
    if #abilities > 0 then
        abilitiesStr = table.concat(abilities, ", ")
    end
    
    -- Форматируем предметы
    local itemsStr = "Нет"
    if #items > 0 then
        -- Убираем item_ префикс для читаемости
        local itemsFormatted = {}
        for _, item in ipairs(items) do
            if type(item) == "string" then
                local formattedItem = item:gsub("item_", "")
                table.insert(itemsFormatted, formattedItem)
            end
        end
        if #itemsFormatted > 0 then
            itemsStr = table.concat(itemsFormatted, ", ")
        end
    end

    -- Формируем embed для Discord
    local embedColor = {
        ["other"] = 9807270,      -- Серый
        ["hero"] = 15158332,      -- Красный
        ["ability"] = 3447003,    -- Синий
        ["item"] = 15105570       -- Оранжевый
    }
    
    -- Компактная информация о герое, раунде и времени в одну строку
    local gameInfoStr = "**🦸 Герой:** " .. heroDisplayName .. " (Lvl " .. heroLevel .. ") | **🔢 Раунд:** " .. tostring(round) .. " | **⏱️ Время:** " .. gameTime

    local discordData = {
        embeds = {
            {
                color = embedColor[bugType] or 9807270,
                fields = {
                    {
                        name = "👤 Отправил:",
                        value = playerName .. " (" .. steamID .. ")",
                        inline = false
                    },
                    {
                        name = "🏷️ Тип",
                        value = bugTypeText,
                        inline = false
                    },
                    {
                        name = "📝 Описание",
                        value = description,
                        inline = false
                    },
                    {
                        name = "ℹ️ Информация об игре",
                        value = gameInfoStr,
                        inline = false
                    },
                    {
                        name = "⚡ Способности",
                        value = abilitiesStr,
                        inline = false
                    },
                    {
                        name = "🎒 Предметы",
                        value = itemsStr,
                        inline = false
                    }
                }
            }
        }
    }

    -- Отправляем запрос в Discord
    print("[BugReport] Encoding JSON data...")
    local encodedData = json.encode(discordData)
    print("[BugReport] JSON encoded successfully. Length: " .. string.len(encodedData))
    
    print("[BugReport] Creating HTTP request...")
    local request = CreateHTTPRequestScriptVM('POST', DISCORD_BUG_REPORT_WEBHOOK)
    request:SetHTTPRequestHeaderValue("Content-Type", "application/json")
    request:SetHTTPRequestRawPostBody("application/json", encodedData)
    
    print("[BugReport] Sending request to Discord...")
    request:Send(function(result)
        print("[BugReport] Response received! Status code: " .. tostring(result.StatusCode))
        if result.StatusCode == 204 or result.StatusCode == 200 then
            print("[BugReport] Successfully sent to Discord!")
        else
            print("[BugReport] Failed to send to Discord. Status code: " .. tostring(result.StatusCode))
            if result.Body then
                print("[BugReport] Response body: " .. tostring(result.Body))
            end
        end
    end)
end

--------------------------------------------------------------------------------
-- РЕПОРТ НА ИГРОКА (жалоба) → Discord. По образцу багрепорта (OnBugReportSubmit).
--------------------------------------------------------------------------------

-- Достаёт читаемое имя игрока по PlayerID из нескольких источников (как в багрепорте).
function Server:ResolvePlayerName(PlayerID)
    local name = PlayerResource:GetPlayerName(PlayerID)
    if name ~= nil and name ~= "" then return name end
    local player = PlayerResource:GetPlayer(PlayerID)
    if player then
        local pName = player:GetName()
        if pName and pName ~= "" then return pName end
    end
    if self.Players[PlayerID] and self.Players[PlayerID].nickname and self.Players[PlayerID].nickname ~= 0 then
        return tostring(self.Players[PlayerID].nickname)
    end
    return "Player " .. tostring(PlayerID)
end

-- Открыть форму репорта у отправителя (кросс-панель: строка таблицы → сервер →
-- обратно этому же игроку). PlayerID берём из движка (event.PlayerID), цель — из
-- клиентских данных, валидируем.
function Server:OnPlayerReportOpen(event)
    local PlayerID = event.PlayerID
    print("[PlayerReport] OnPlayerReportOpen: pid="..tostring(PlayerID).." target="..tostring(event.target_player_id))
    if PlayerID == nil then return end

    local TargetPlayerID = tonumber(event.target_player_id)
    if TargetPlayerID == nil or not PlayerResource:IsValidPlayerID(TargetPlayerID)
       or TargetPlayerID == PlayerID or PlayerResource:GetTeam(TargetPlayerID) == 1 then
        print("[PlayerReport] OnPlayerReportOpen REJECT: target="..tostring(TargetPlayerID)
            .." valid="..tostring(TargetPlayerID ~= nil and PlayerResource:IsValidPlayerID(TargetPlayerID))
            .." team="..tostring(TargetPlayerID ~= nil and PlayerResource:GetTeam(TargetPlayerID)))
        return
    end

    print("[PlayerReport] OnPlayerReportOpen: sending show_player_report to pid="..tostring(PlayerID))
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PlayerID), "show_player_report", {
        target_player_id = TargetPlayerID
    })
end

function Server:OnPlayerReportSubmit(event)
    local PlayerID = event.PlayerID
    if PlayerID == nil then return end

    local TargetPlayerID = tonumber(event.target_player_id)
    local reason = event.reason or "other"
    local description = event.description or ""

    local function reject(errKey)
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PlayerID), "player_report_response", {
            success = false, error = errKey
        })
    end

    -- Цель должна быть валидным игроком и не самим собой.
    if TargetPlayerID == nil or not PlayerResource:IsValidPlayerID(TargetPlayerID)
       or TargetPlayerID == PlayerID or PlayerResource:GetTeam(TargetPlayerID) == 1 then
        reject("#PlayerReport_InvalidTarget")
        return
    end

    -- Причина обязана быть из допустимого списка (игрок должен корректно указать).
    if PLAYER_REPORT_REASONS[reason] == nil then
        reject("#PlayerReport_InvalidReason")
        return
    end

    -- Кулдаун: общий на отправителя (не на конкретную цель).
    self.LastPlayerReportTime = self.LastPlayerReportTime or {}
    local now = GameRules:GetGameTime()
    local last = self.LastPlayerReportTime[PlayerID]
    if last ~= nil and (now - last) < (PLAYER_REPORT_COOLDOWN or 10) then
        reject("#PlayerReport_Cooldown")
        return
    end

    -- Минимальная длина описания.
    if string.len(description) < (PLAYER_REPORT_MIN_LENGTH or 5) then
        reject("#PlayerReport_TooShort")
        return
    end

    self.LastPlayerReportTime[PlayerID] = now

    local reporterName = self:ResolvePlayerName(PlayerID)
    local reporterSteam = PlayerResource:GetSteamAccountID(PlayerID)
    local targetName = self:ResolvePlayerName(TargetPlayerID)
    local targetSteam = PlayerResource:GetSteamAccountID(TargetPlayerID)

    -- Герой цели (для контекста в Discord).
    local targetHeroName = "Unknown"
    local targetHero = PlayerResource:GetSelectedHeroEntity(TargetPlayerID)
    if targetHero then targetHeroName = targetHero:GetUnitName() end

    local currentRound = 0
    if Rounds ~= nil then currentRound = Rounds:GetCurrentRound() end

    local gameTime = GameRules:GetGameTime()
    local gameTimeStr = string.format("%d:%02d", math.floor(gameTime / 60), math.floor(gameTime % 60))

    self:SendPlayerReportToDiscord(reporterName, reporterSteam, targetName, targetSteam, reason, description, targetHeroName, currentRound, gameTimeStr)

    -- Копия репорта в БД (чтобы не терялись, помимо Discord). Эндпоинт on_player_report.
    SendRequest(SERVER_URL.."on_player_report", {
        SteamID = reporterSteam,
        target_steamid = targetSteam,
        reason = reason,
        description = description,
        hero = targetHeroName,
        round = currentRound,
        game_time = gameTimeStr,
    }, nil, true)

    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(PlayerID), "player_report_response", { success = true })
end

function Server:SendPlayerReportToDiscord(reporterName, reporterSteam, targetName, targetSteam, reason, description, targetHeroName, round, gameTime)
    if DISCORD_PLAYER_REPORT_WEBHOOK == nil or DISCORD_PLAYER_REPORT_WEBHOOK == ""
       or DISCORD_PLAYER_REPORT_WEBHOOK == "YOUR_DISCORD_WEBHOOK_URL_HERE" then
        print("[PlayerReport] Discord webhook not configured!")
        return
    end

    local reasonText = (PLAYER_REPORT_REASONS and PLAYER_REPORT_REASONS[reason]) or reason

    local heroDisplayName = targetHeroName:gsub("npc_dota_hero_", "")
    heroDisplayName = heroDisplayName:sub(1,1):upper() .. heroDisplayName:sub(2)

    local discordData = {
        embeds = {
            {
                title = "🚨 Жалоба на игрока",
                color = 15158332, -- красный
                fields = {
                    { name = "🎯 На кого", value = targetName .. " (" .. tostring(targetSteam) .. ")", inline = false },
                    { name = "🏷️ Причина", value = reasonText, inline = false },
                    { name = "📝 Комментарий", value = description, inline = false },
                    { name = "👤 Отправил", value = reporterName .. " (" .. tostring(reporterSteam) .. ")", inline = false },
                    { name = "ℹ️ Игра", value = "**🦸 Герой цели:** " .. heroDisplayName .. " | **🔢 Раунд:** " .. tostring(round) .. " | **⏱️ Время:** " .. gameTime, inline = false },
                }
            }
        }
    }

    local encodedData = json.encode(discordData)
    local request = CreateHTTPRequestScriptVM('POST', DISCORD_PLAYER_REPORT_WEBHOOK)
    request:SetHTTPRequestHeaderValue("Content-Type", "application/json")
    request:SetHTTPRequestRawPostBody("application/json", encodedData)
    request:Send(function(result)
        if result.StatusCode == 204 or result.StatusCode == 200 then
            print("[PlayerReport] Successfully sent to Discord!")
        else
            print("[PlayerReport] Failed to send to Discord. Status code: " .. tostring(result.StatusCode))
        end
    end)
end

if not Server.bStarted then Server:Init() end