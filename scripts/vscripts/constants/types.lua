--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Стейты игроков, для отслеживания в течении игры
PLAYER_STATE = {
    UNKNOWN = 0, -- Обычно не используется, на всякий случай есть
    IN_GAME = 1, -- Обычное состояние игрока
    LEAVED = 2, -- Игрок покинул игру, но не до конца
    ABANDONED = 3, -- Игрок полностью покинул игру
    LOSER = 4, -- Игрок проиграл
    WINNER = 5, -- Игрок победил
}

-- Стеты команд, для отслеживания в течении игры
TEAM_STATE = {
    UNKNOWN = 0, -- Изначально у всех команд
    IN_GAME = 1, -- Обычное состояние команды
    LOSE = 2, -- Команда проиграла
    WIN = 3, -- Команда победила
}

-- Стейты раундов
GAME_STATES = {
    NONE = 1, -- Изначальное состояние
    PREPARING = 2, -- Стадия подготовки
    IN_ACTION = 3, -- Активная часть
    ENDED = 4, -- Раунд закончен, обычно мгновенно переходит на PREPARING
    SPECTATE = 5 -- Игрок проиграл, продолжает наблюдать за игрой
}

-- Типы раундов
ROUND_TYPES = {
    BASIC = 1, -- Обычная волна
    VOTING = 2, -- Выбор режима и игра в него
    BOSS = 3, -- Босс
}

-- Типы уведомлений
NOTIFICATION_TYPE = {
    DUEL_KILL = "DUEL_KILL", -- Убийство на дуэли
    DUEL_KILL_SELF = "DUEL_KILL_SELF", -- Добил себя
    CREEP_KILL = "CREEP_KILL", -- Игрок умер от крипа
    KILL = "KILL", -- Игрок умер от героя, но не на дуэли
    AEGIS_GET = "AEGIS_GET", -- Игрок получил аегис
    AEGIS_LOST = "AEGIS_LOST", -- Игрок потерял аегис
    CREEP_SENDED = "CREEP_SENDED", -- Игрок отправил дополнительного крипа
    MINIGAMES_LOSE = "MINIGAMES_LOSE", -- Игрок проиграл в мини-игре
    MINIGAMES_WIN = "MINIGAMES_WIN", -- Игрок победил в мини-игре
    MASS_ARENA_LOSE = "MASS_ARENA_LOSE", -- Игрок проиграл в масс-арене
    MASS_ARENA_WIN = "MASS_ARENA_WIN", -- Игрок победил в масс-арене
    LAST_PLACE_BONUS = "LAST_PLACE_BONUS", -- Игрок получил компенсацию за последние места в игре
    LAST_PLACE_BONUS_WITH_SMOKE = "LAST_PLACE_BONUS_WITH_SMOKE", -- Игрок получил компенсацию за последние места в игре + смок
    BET_WIN = "BET_WIN", -- Игрок победил в ставке
    BET_WIN_SELF = "BET_WIN_SELF", -- Игрок победил в дуэли и получил золото
    USED_BOOK = "USED_BOOK", -- Игрок использовал уникальную книгу
    ROUND_ENDED = "ROUND_ENDED", -- Игрок закончил раунд
}

-- Типы объектов в чате
CHAT_WHEEL_TYPES = {
    TEXT = 1, --Текстовые
    SOUND = 2 --Звуковые
}

-- Категории в чате
CHAT_WHEEL_CATEGORY = {
    ALL = 0, -- Общие, не имеющие категорию
    RUSSIAN = 1, -- Русские фразы
    ENGLISH = 2, -- Английские фразы
}

-- Типы превью для предметов
ITEMS_PREVIEW_TYPES = {
    IMAGE = 1, -- Картинка
    FX = 2, -- Партикл
    SCENE = 3, -- Сцена (в том числе юниты)
    VIDEO = 4, -- Видео
    CHAT_WHEEL = 5, -- Фраза
}

-- Дефолтные слоты для предметов некоторых типов
ITEMS_DEFAULT_SLOTS = {
    PET = "pet", -- Фразы
    FX_HERO = "fx_hero", -- Партиклы героев
    FX_ATTACK = "fx_attack", -- Партиклы атак
    WEATHER = "weather",  -- Погода
    ICONS = "icons",  -- Иконки героя в топбаре
}

-- Типы предметов
ITEMS_TYPES = {
    CHAT_WHEEL = 1, -- Фразы
    PET = 2, -- Питомцы
    FX_HERO = 3, -- Партиклы героев
    FX_ATTACK = 4, -- Партиклы атак
    WEATHER = 5, -- Погода
    ICONS = 6, -- Иконки героя в топбаре
}

-- Типы выбора способностей
ABILITY_SELECTION_TYPE = {
    NONE = 0, -- Ничего
    BASIC = 1, -- Базовый выбор
    BASIC_SSS = 2, -- Базовый выбор c SSS скиллами
    FAST_RELEARN = 3, -- Замена способности на новую без выбора что заменить
    RELEARN = 4, -- Замена способности на новую
    RELEARN_RETURN = 5, -- Замена способности на новую в списке будет заменённая
    RELEARN_SSS = 6, -- Замена способности на новую в списке будет 2 SSS качества
    DEV = 7, -- Админская панель выбора
}