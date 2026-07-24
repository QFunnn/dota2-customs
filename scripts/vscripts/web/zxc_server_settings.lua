--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


SERVER_CONDITIONS_TO_COUNT_GAME = {
    PLAYERS = 5,
    MINUTES = 25
}

SERVER_CHECK_CONDITIONS = false

SERVER_MAX_COINS_DAILY = 50

SERVER_REROLL_PRICE = 20

SERVER_REROLL_PRICE_LOCKED_HERO = 50

-- Дополнительные платные перевыборы, доступные сверх бесплатных PLAYER_INIT_REROLLS
PLAYER_EXTRA_PAID_REROLLS = 5

SERVER_COINS_BY_PLACE = {
    [1] = 10,
    [2] = 7,
    [3] = 5,
    [4] = 4,
    [5] = 3,
    [6] = 2,
    [7] = 1,
    [8] = 1,
}

SERVER_RATING_SETTINGS = {
    K_FACTOR = 1,
    -- DUEL_PCT теперь применяется к СОБСТВЕННОМУ pre-rating'у каждого финалиста:
    -- 1-е место получает +DUEL_PCT% от своего pre-rating'а, 2-е теряет столько же
    -- от своего. Раньше было 10% от pre-rating'а 2-го места и переносилось 1-му --
    -- это давало несоразмерный бонус 1-му если у 2-го рейтинг был сильно ниже среднего.
    DUEL_PCT = 5,
    STR_RATIO_POWER = 1.25,
    -- BASE_CHANGE NEW3 (12.05.2026): сужает разброс между местами, плюс
    -- немного увеличивает дефляцию (Σ = -30 вместо -25), чтобы система меньше
    -- инфлировала на длинных матчах. Размах +1..-8 сократился со 170 до 125
    -- пунктов базы (фактически 50..-48 по итоговой Δ в средне-длинном матче).
    -- Старая раскладка: 80/60/30/15/-20/-35/-65/-90 (Σ=-25).
    BASE_CHANGE = {
        [1] = 55,
        [2] = 40,
        [3] = 25,
        [4] = 10,
        [5] = -10,
        [6] = -30,
        [7] = -50,
        [8] = -70,
    },
    MAX_GAIN = {
        [1] = 125,
        [2] = 125,
        [3] = 125,
        [4] = 125,
        [5] = 125,
        [6] = 125,
        [7] = 125,
        [8] = 125,
    },
    MAX_LOSS = {
        [1] = 150,
        [2] = 150,
        [3] = 150,
        [4] = 150,
        [5] = 150,
        [6] = 150,
        [7] = 150,
        [8] = 150,
    }
}

-- Discord Webhook URL для отправки багрепортов и репортов на игроков.
-- СЕКРЕТЫ вынесены из исходников: реальные значения лежат в gitignore-файле
-- web/zxc_server_secrets.lua (ZXC_SECRETS.DISCORD_BUG_REPORT_WEBHOOK /
-- ZXC_SECRETS.DISCORD_PLAYER_REPORT_WEBHOOK).
-- pcall, чтобы отсутствие файла на машине без секретов не валило загрузку.
pcall(require, 'web/zxc_server_secrets')
DISCORD_BUG_REPORT_WEBHOOK = (ZXC_SECRETS and ZXC_SECRETS.DISCORD_BUG_REPORT_WEBHOOK) or ""
DISCORD_PLAYER_REPORT_WEBHOOK = (ZXC_SECRETS and ZXC_SECRETS.DISCORD_PLAYER_REPORT_WEBHOOK) or ""

-- Кулдаун отправки багрепорта одним игроком, сек
BUG_REPORT_COOLDOWN = 10
-- Минимальная длина описания багрепорта, символов
BUG_REPORT_MIN_LENGTH = 5

-- Репорт на игрока (жалоба → Discord). Кулдаун общий на отправителя (не на цель).
PLAYER_REPORT_COOLDOWN = 30
-- Минимальная длина описания причины репорта, символов
PLAYER_REPORT_MIN_LENGTH = 5
-- Допустимые причины репорта (id → русский текст для Discord). Клиент шлёт id;
-- неизвестный id → отклоняем (игрок обязан выбрать корректную причину).
PLAYER_REPORT_REASONS = {
    ["ruiner"]  = "Слив игры / руинер",
    ["toxic"]   = "Токсичность / оскорбления",
    ["cheat"]   = "Читы / эксплойты",
    ["afk"]     = "АФК / бросил игру",
    ["other"]   = "Другое",
}

-- [MF-18] Максимум записей в mute_prefs игрока (одна запись ~40 символов JSON).
-- Кап держит колонку в разумном размере; такой же лимит валидирует api.js.
MUTE_PREFS_MAX_ENTRIES = 200