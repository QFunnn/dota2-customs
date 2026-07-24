--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Файл типов
RequireFiles({
    "constants/types"
})

-- Включен ли чит мод (если true - значит с читами можно делать что угодно и тд (т.е снимает ограничения))
GAME_CHEAT_MODE_ENABLED = true

-- ═══ ЕДИНЫЙ ВЫКЛЮЧАТЕЛЬ ВСЕХ DEBUG-ПРИНТОВ ═══
-- false (ПРОД): ни один print() мода не пишет в console (перехват в addon_init.lua) —
--   нет console-I/O на игровом сервере.
-- true (ТУЛЗЫ/ЛОКАЛКА): печатает ВСЁ (диагностику и ошибки). Ставь true при отладке.
-- Опция авто-режима: DEBUG_PRINT_STATUS = IsInToolsMode() — тогда прод всегда тихий,
--   а в тулзах включается сам (нельзя случайно залить =true).
DEBUG_PRINT_STATUS = false

-- Точечные throttle-флаги для ОЧЕНЬ шумных подсистем — работают ПОВЕРХ мастера выше
-- (печатают только если DEBUG_PRINT_STATUS=true И сам флаг=true). Нужны, чтобы даже
-- при включённой отладке не топить консоль пер-тик спамом.
ROUND_DEBUG_ENABLED = false      -- [ROUND_DEBUG] AFK/AEGIS/FORCE_KILL (rounds, round_controller)
REFLECTION_DEBUG_ENABLED = false -- [Reflection DEBUG] печатает на КАЖДЫЙ тик каждого зачарованного крипа

-- Включаем все основные файлы
RequireFiles({
    "constants/rounds_list",
    "constants/skills",
    "constants/pvp_sounds",
    "constants/abilities_settings",
    "constants/heroes_settings",
    "constants/modifiers_settings",
    "constants/tier_lists",
    "constants/summons",
    "constants/chat_wheel_items",
    "constants/inventory_items",
    "utils/both_side_utils"
})

-- Всяческие длительности на стадии настроек
SETTINGS_STATE_DURATIONS = {
    START_VOTING = 10, -- Длительность начального голосования на согласие на стадию настроек
    DIFFICULT_VOTING = 10, -- Длительность голосования за категорию настроек (сложность или кастомная)
    CUSTOM_VOTING = 30, -- Длительность выбора кастомных вариантов настроек игры
    CUSTOM_VOTE_RESULTS = 10, --Длительность показа результатов голосования кастомных настроек
}

-- Настройки игры, зависящие от стадии настроек
GAME_SETTINGS = {


    --Стандартные настройки (бывший MEDIUM). Применяются если голосование пропущено ИЛИ игроки проголосовали за "Стандартные".
    DEFAULT = {
        DIFFICULT = 4,
        BANNING_STATE_DURATION = 45,
        PICK_STATE_DURATION = 45,
        PLAYER_INIT_SMOKES = 3,
        PLAYER_INIT_REROLLS = 1,
        SSS_FIRST_ABILITY_COUNT = 1,
        PLAYER_INIT_LIFES = 2,
        CREEP_BONUS_ARMOR_PER_LATE_ROUND = 0.85,
        CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND = 1.25,
        ROUND_WHEN_LOSE_AEGIS = 70,
        ROUND_WHEN_CAN_SUMMON_CREEPS = 40,
        ROUND_WHEN_QUEUE_START = 40,
        FIRST_ABILITY_IS_GENERAL = 0,
        HAS_SKILLS_SELECT = 1,
        MULT_GOLD = 1,
        MULT_EXP = 1,
    },


    EASY = {
        BANNING_STATE_DURATION = 60,
        PICK_STATE_DURATION = 60,
        PLAYER_INIT_SMOKES = 3,
        PLAYER_INIT_REROLLS = 10,
        CREEP_BONUS_ARMOR_PER_LATE_ROUND = 0.7,
        CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND = 1,
    },
    MEDIUM = {
        BANNING_STATE_DURATION = 45,
        PICK_STATE_DURATION = 45,
        PLAYER_INIT_SMOKES = 3,
        PLAYER_INIT_REROLLS = 5,
        CREEP_BONUS_ARMOR_PER_LATE_ROUND = 0.85,
        CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND = 1.25,
    },
    HARD = {
        BANNING_STATE_DURATION = 30,
        PICK_STATE_DURATION = 30,
        PLAYER_INIT_SMOKES = 1,
        PLAYER_INIT_REROLLS = 0,
        CREEP_BONUS_ARMOR_PER_LATE_ROUND = 1,
        CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND = 1.5,
    },
    CUSTOM = {
        PLAYER_INIT_REROLLS = { 0, 1, 3 },
        SSS_FIRST_ABILITY_COUNT = { 0, 1, 2, 3 },
        PLAYER_INIT_LIFES = { 1, 2, 3 },
        CREEP_BONUS_ARMOR_PER_LATE_ROUND = {0.7, 0.85, 1},
        CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND = {1, 1.25, 1.5},
        ROUND_WHEN_LOSE_AEGIS = {65, 70, 75},
        ROUND_WHEN_CAN_SUMMON_CREEPS = {50, 60, 70},
        FIRST_ABILITY_IS_GENERAL = {0, 1},
        HAS_SKILLS_SELECT = {0, 1},
    }
}

--Настройки голосований в игре
VOTES_LIST = {
    --Голосование за режим следующего раунда
    ROUND_MODE = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        options = {
            0, -- Миниигры
            1, -- Масс арена
        }
    },
    --Голосование за мини-игру
    MINIGAME_TYPE = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        options = {
            0, -- Arena Mode
            1, -- Pudge Wars
            2, -- Mirana Wars
        }
    },
    --Голосование за последнюю дуэль
    LAST_DUEL = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = false,
        double_confirm = true,
        options = {
            0, -- No
            1, -- Yes
        }
    },
    --Голосование за стадию настроек
    SETTINGS_STATE = {
        default_option = 0,
        force_default_option = true,
        no_one_voted_random_option = false,
        options = {
            0, -- No
            1, -- Yes
        }
    },
    --Голосование за начальные реролы игрока
    INIT_REROLLS = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].PLAYER_INIT_REROLLS -- Берём значения из таблицы настроек
    },
    --Голосование за начальное кол-во жизней игрока
    INIT_LIFES = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].PLAYER_INIT_LIFES -- Берём значения из таблицы настроек
    },
    --Голосование за кол-во SSS способностей в первом выборе способностей
    SSS_COUNT_FIRST = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].SSS_FIRST_ABILITY_COUNT -- Берём значения из таблицы настроек
    },
    --Голосование за то, общие способности у игроков на 1 выборе или нет
    FIRST_ABILITY_IS_GENERAL = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].FIRST_ABILITY_IS_GENERAL -- Берём значения из таблицы настроек
    },
    --Голосование за то, есть ли в игре выбор пассивных навыков героя
    HAS_SKILLS_SELECT = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].HAS_SKILLS_SELECT -- Берём значения из таблицы настроек
    },
    --Голосование за броню крипов на поздних раундах
    CREEP_BONUS_ARMOR = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].CREEP_BONUS_ARMOR_PER_LATE_ROUND -- Берём значения из таблицы настроек
    },
    --Голосование за магическое сопротивление крипов на поздних раундах
    CREEP_BONUS_MAGIC_RESISTANCE = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].CREEP_BONUS_MAGIC_RESISTANCE_PER_LATE_ROUND -- Берём значения из таблицы настроек
    },
    --Голосование за изначальный раунд снятия аегиса (при 8 игроках)
    ROUND_WHEN_LOSE_AEGIS = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].ROUND_WHEN_LOSE_AEGIS -- Берём значения из таблицы настроек
    },
    --Голосование за раунд с которого можно отправлять крипов
    ROUND_WHEN_CAN_SUMMON_CREEPS = {
        default_option = 0,
        force_default_option = false,
        no_one_voted_random_option = true,
        mini = true,
        options = GAME_SETTINGS["CUSTOM"].ROUND_WHEN_CAN_SUMMON_CREEPS -- Берём значения из таблицы настроек
    },
}

-- Список валидных команд 
TEAM_LIST = {
    DOTA_TEAM_GOODGUYS,
    DOTA_TEAM_BADGUYS,
    DOTA_TEAM_CUSTOM_1,
    DOTA_TEAM_CUSTOM_2,
    DOTA_TEAM_CUSTOM_3,
    DOTA_TEAM_CUSTOM_4,
    DOTA_TEAM_CUSTOM_5,
    DOTA_TEAM_CUSTOM_6,
}

-- Количество игроков в каждой команде
PLAYERS_PER_TEAM = 1

-- Интервал обновления полного лива игрока
PLAYERS_ABANDON_INTERVAL = 1

-- Задержка перед концом игры
GAME_END_DELAY = 5

-- Включить/отключить запись уведомлений. false - отключить
GAME_NOTIFICATIONS_ENABLED = true

-- Включить/отключить летящие уведомления. false - отключить
GAME_BARRAGE_ENABLED = false

-- Включить/отключить таблицу урона. false - отключить
GAME_DAMAGE_TABLE_ENABLED = true

-- Включить/отключить историю ставок. false - отключить
GAME_BETS_HISTORY_ENABLED = true

-- Включить/отключить снижение урона у крипов. false - отключить
GAME_DAMAGE_REDUCTION_ENABLED = false

-- Включить/отключить раунды по парам. false - отключить
GAME_QUEUE_ROUNDS_ENABLED = true

-- Кол-во игроков, после которого крипов можно призывать на любом раунде
PLAYERS_WHEN_CAN_SUMMON_CREEPS = 4

--Настройки аегиса: задержка перед появлением и длительность снижения урона после появления
AEGIS_REINCARNATE_DELAY = 5
AEGIS_REINCARNATE_BUFF_DURATION = 14

--Максимальное кол-во юнитов, которое может заспавнится за 1 тик (1 кадр сервера)
MAX_UNITS_SPAWN_PER_TICK = 3

-- Время подготовки к раундам различного типа
GAME_ROUNDS_PRE_ROUND_PREPARE_DURATION = {
    [ROUND_TYPES.BASIC] = 20, --Подготовка к обычному раунду
    [ROUND_TYPES.BOSS] = 20, --Подготовка к раунду с боссами
    [ROUND_TYPES.VOTING] = 20, --Подготовка к мини-играм или масс-арене
}

-- Всяческие тайминги игры
GAME_ROUNDS_TIMINGS = {
    ROUND_TYPE_SELECTING = 10, --Длительность голосования за тип следующего раунда
    MINIGAMES = 10, --Длительность голосования за мини-игру раунда
    MINIGAMES_DELAY = 5, --Задержка после выбора мини-игры, а-ля подготовка
    MASS_ARENA = 5, --Задержка после появления на арене, а-ля подготовка
}

--Длительность раундов различного типа
GAME_ROUNDS_DURATION = {
    [ROUND_TYPES.BASIC] = 50, --Длительность обычного раунда
    [ROUND_TYPES.BOSS] = 50, --Длительность раунда с боссами
    [ROUND_TYPES.VOTING] = 90,--Длительность мини-игр или масс-арены
}

-- Настройки круга
GAME_ROUNDS_CIRCLE_SETTINGS = {
    MINIGAMES = { -- Настройки круга для мини-игры
        PREPARE_VISUAL = 20, -- Время с начала раунда после которого появится предупреждающий круг
        START = 30, -- Время с начала раунда после которого появится основной круг
        END = 60, -- Время с начала раунда после которого круг станет минимального размера
        MAX_SIZE = 1800, -- Максимальный размер круга
        MIN_SIZE = 500, -- Минимальный размер круга
        INTERVAL = 1, -- Интервал нанесения урона
        DAMAGE = 2, -- Урон за каждый интервал
        MODIFIER = "modifier_minigames_circle_debuff" -- Модификатор если чел вышел за круг
    },
    MASS_ARENA = { -- Настройки круга для масс-арены
        PREPARE_VISUAL = 20, -- Время с начала раунда после которого появится предупреждающий круг
        START = 30, -- Время с начала раунда после которого появится основной круг
        END = 60, -- Время с начала раунда после которого круг станет минимального размера
        MAX_SIZE = 1800, -- Максимальный размер круга
        MIN_SIZE = 700, -- Минимальный размер круга
        INTERVAL = 1, -- Интервал нанесения урона
        DAMAGE = 10,  -- Урон за каждый интервал
        MODIFIER = "modifier_mass_arena_circle_debuff" -- Модификатор если чел вышел за круг
    }
}

-- Раунды, на которых нужно выдавать нейтралки
GIVE_NEUTRALS_ROUNDS = {
    1, 10, 20, 30, 40
}

-- Раунды, на которых нужно выдавать Neutral Book
GIVE_NEUTRAL_BOOK_ROUNDS = {
    70, 80
}

-- Раунды, на которых нужно выдавать SSS Relearn Book
GIVE_SSS_RELEARN_BOOK_ROUNDS = {
    60, 70, 80
}

-- Раунды, на которых нужно выдавать Paragon Book 2
GIVE_PARAGON_BOOK_ROUNDS = {
    70
}

-- Раунды, на которых нужно выдавать выбор способностей
GIVE_ABILITY_SELECTION_ROUNDS = {
    3, 6, 9
}

-- Раунды, на которых нужно выдавать бонусы для отстающих команд.
-- 70-я волна намеренно исключена: к этому моменту матч близок к финалу, и
-- дополнительный буст отстающим перекашивает балансы выхода в дуэль.
GIVE_BONUSES_FOR_LAST_PLACES_ROUNDS = {
    10, 20, 30, 40, 50, 60
}

-- Задержка перед проигрышем игрока на своей арене (условно чтобы он мог успеть кого-то добить дебаффом после окончательной смерти)
GAME_PLAYER_LOSE_DELAY = 3

-- Сколько нейтральных предметов предлагает при крафте
NEUTRALS_ITEMS_PER_TIER_DEFAULT = 5

-- Сколько чар предлагает при крафте
NEUTRALS_ENCHANTMENTS_PER_TIER_DEFAULT = 5

-- Длительность автоматического показа дополнительной информации о раунде 
ROUND_MORE_INFO_NOTIFICATION_DURATION = 10

-- Длительность показа информации о сложном враге в раунде
ROUND_HARD_ENEMY_NOTIFICATION_DURATION = 10

-- Длительность показа информации о потере аегиса в раунде 
ROUND_PVP_AEGIS_LOST_NOTIFICATION_DURATION = 10

-- Длительность оповещения о противнике в дуэли (по центру экрана)
DUEL_NOTIFICATION_DURATION = 7

-- На каком раунде стартует последняя дуэль
LAST_DUEL_STARTING_ROUND_NUM = 200

-- До скольки поражений идёт последняя дуэль
LAST_DUEL_LOSES_TO_LOSE = 3

-- Дополнительное время для подготовки перед первым раундом последней дуэли
LAST_DUEL_PREPARE_DURATION = 120

-- С читами это время меньше
if IsCheatsEnabled() then
    LAST_DUEL_PREPARE_DURATION = 10
end

-- Сколько выдать книг переобучения при начале последней дуэли
LAST_DUEL_RELEARN_BOOKS = 5

-- Сколько выдать золота при начале последней дуэли
LAST_DUEL_GOLD = 15000

-- Максимальное здоровье крипа
MAX_CREEP_HEALTH = 10000000

-- Единая формула масштабирования крипов: стат = базовый * рост^(номер волны)
CREEP_HP_GROWTH_PER_ROUND = 1.14        -- рост HP за волну (+14%)
CREEP_DAMAGE_GROWTH_PER_ROUND = 1.125   -- рост урона за волну (+12.5%)

-- Уменьшение урона за каждый раунд после 50
CREEP_DAMAGE_REDUCTION_PER_LATE_ROUND = 0

-- Скорость атаки за каждый раунд после 50
CREEP_BONUS_ATTACK_SPEED_PER_LATE_ROUND = 3

-- Скорость передвижения за каждый раунд после 50
CREEP_BONUS_MOVE_SPEED_PER_LATE_ROUND = 2

-- Максимальный урон крипа
MAX_CREEP_DAMAGE = 1800000000

--Кол-во банов
PLAYER_INIT_BANS = {
    HEROES = 1,
    ABILITIES = 2,
    RANDOM_HEROES = 2,
    RANDOM_ABILITIES = 3,

    --BATTLE PASS
    BONUS_HEROES = 2,
    BONUS_ABILITIES = 1,
    RANDOM_BONUS_HEROES = 1,
    RANDOM_BONUS_ABILITIES = 1,
}

-- Турнирные оверрайды банов на конкретных игроков по SteamAccountID (32-bit, как
-- возвращает PlayerResource:GetSteamAccountID(PID); это число, а не SteamID64).
--
-- Поведение:
--   - Если SteamAccountID игрока есть в этой таблице, ему ВЫСТАВЛЯЮТСЯ ровно эти числа банов
--     (heroes/abilities/random_heroes/random_abilities), а base PLAYER_INIT_BANS и BP-бонус
--     для него ИГНОРИРУЮТСЯ.
--   - Игроки, которых нет в этой таблице, получают обычный flow (base + BP если есть).
--
-- Где взять SteamAccountID: в URL Steam-профиля https://steamcommunity.com/profiles/<SteamID64>
-- вычесть 76561197960265728 (0x0110000100000000) -- получится SteamAccountID.
-- Либо сайтом https://steamid.io/ -- "steamID3" в формате [U:1:XXXXXXX] -> XXXXXXX и есть нужное число.
--
-- Пример (закомментирован, чтобы не активировался случайно):
-- PLAYER_BANS_OVERRIDES = {
--     [137000001] = { heroes = 3, abilities = 4, random_heroes = 2, random_abilities = 2 },
--     [137000002] = { heroes = 3, abilities = 4, random_heroes = 2, random_abilities = 2 },
-- }
PLAYER_BANS_OVERRIDES = {
    -- На время турнира пропиши SteamAccountID и баны прямо здесь, например:
    -- [44477]     = { heroes = 4, abilities = 4, random_heroes = 4, random_abilities = 4 },
    -- [871812405] = { heroes = 4, abilities = 4, random_heroes = 4, random_abilities = 4 },
}

-- Длительность перезарядки кнопки "Похвалить" у каждого игрока
PLAYER_TIP_COOLDOWN = 5

-- Кол-во пауз изначально у игрока
PLAYER_INIT_PAUSES = 2

-- Максимальное кол-во пауз у игрока одновременно
PLAYER_MAX_PAUSES = 5

-- Кд зачисления зарядов паузы
PLAYERS_PAUSE_CHARGE_COOLDOWN = 30*60 -- 30 минут

-- Зарядов за 1 перезарядку (1 раз в 30 минут)
PLAYERS_PAUSE_CHARGES_PER_COOLDOWN = 1

-- Минимальное время паузы, когда никто кроме владельца не может отжать её
PLAYERS_MIN_PAUSE_DURATION = 30

-- Минимальное время после паузы когда вообще никто не может отжать её (чтобы избежать двойных нажатий в основном (типа нажал и отжал сразу))
PLAYERS_MIN_UNPAUSE_DURATION = 3

-- Задержка перед снятием паузы, можно в это время поставить паузу заного
PLAYERS_MIN_UNPAUSE_DELAY = 3

-- Кол-во выборов абилок изначально у игрока (включая первый SSS выбор)
PLAYER_INIT_SELECTION_ABILITIES_COUNT = 2

--Кол-во перевыборов героев у игрока
PLAYER_INIT_REROLLS = 5

-- Минимальное количество игроков, чтобы игра считалась валидной
SERVER_MIN_PLAYERS_TO_COUNT = 2

-- Сколько будет SSS спеллов в SSS книге переобучения
SSS_RELEARN_BOOK_COUNT = 3

-- Кол-во стаков бафа за победу в мини-играх или масс арене, зависящее от кол-ва игроков
MINIGAMES_WIN_BUFF_STACKS = {
    [8] = {
        [1] = 4,
        [2] = 3,
        [3] = 2,
        [4] = 1,
        [5] = -2,
        [6] = -3,
        [7] = -4,
        [8] = -5,
    },
    [7] = {
        [1] = 3,
        [2] = 2,
        [3] = 1,
        [4] = 0,
        [5] = -2,
        [6] = -3,
        [7] = -4,
    },
    [6] = {
        [1] = 3,
        [2] = 2,
        [3] = 1,
        [4] = -2,
        [5] = -3,
        [6] = -4,
    },
    [5] = {
        [1] = 3,
        [2] = 2,
        [3] = 1,
        [4] = -2,
        [5] = -3,
    },
    [4] = {
        [1] = 3,
        [2] = 2,
        [3] = -2,
        [4] = -3,
    },
    [3] = {
        [1] = 3,
        [2] = 0,
        [3] = -3,
    },
    [2] = {
        [1] = 3,
        [2] = -3,
    },
}

-- Сколько стаков теряет игрок если потерять аегис
MINIGAMES_REDUCE_WIN_BUFF_STACKS_PER_LOSE_AEGIS = 10


-- Если true то отключает интеллект крипов полностью
STOP_ALL_ORDERS = false