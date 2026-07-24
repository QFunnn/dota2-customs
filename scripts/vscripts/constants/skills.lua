--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Список всех возможных навыков героя (которые пассивные)
SKILLS_LIST_TABLE = {
    armor = {
        icon = "chainmail",
        value = 7,
    },
    movespeed = {
        icon = "boots",
        value = 40,
    },
    attackspeed = {
        icon = "gloves",
        value = 40,
    },
    evasion = {
        icon = "talisman_of_evasion",
        value = 7,

        is_percent = true,
    },
    magical_resistance = {
        icon = "cloak",
        value = 5,

        is_percent = true,
        max = 8,
    },
    status_resistance = {
        icon = "titan_sliver",
        value = 3,

        is_percent = true,
        max = 8,
    },
    spell_amplify = {
        icon = "kaya",
        value = 3,

        is_percent = true,
        max = 8,
    },
    attack_range = {
        icon = "dragon_lance",
        value = 40,

        custom_mult = 1, --По ходу игры не увеличивает свои значения (можно выставить любое значение и на него будет умножатся value)
    },
    cast_range = {
        icon = "psychic_headband",
        value = 50,
    },
    damage = {
        icon = "blades_of_attack",
        value = 40,
    },
    health = {
        icon = "vitality_booster",
        value = 500,
    },
    projectile_speed = {
        icon = "witch_blade",
        value = 300,
    },
    manacost_pct = {
        icon = "mysterious_hat",
        value = 10,

        is_percent = true,
    },
    health_regen_pct = {
        icon = "heart",
        value = 0.5,

        is_percent = true,
    },
    mana_regen_pct = {
        icon = "bloodstone",
        value = 0.5,

        is_percent = true,
    },
    universal_evasion = {
        icon = "void_spell",
        value = 5,

        is_percent = true,

        max = 4, --Сколько максимум может быть этих навыков у игрока

        disabled = true, --Убран из предлагаемых при выборе навыков (не оффается игрокам)
    },
    total_block = {
        icon = "craggy_coat",
        value = 5,

        is_percent = true,

        custom_mult = 1, --По ходу игры не увеличивает свои значения (можно выставить любое значение и на него будет умножатся value)

        max = 4, --Сколько максимум может быть этих навыков у игрока
    },
    critical_strike = {
        icon = "lesser_crit",
        value = 10,

        is_percent = true,
    },
    magical_critical_strike = {
        icon = "magilys_custom",
        value = 10,

        is_percent = true,
    },
    all_atributes = {
        icon = "crown",
        value = 10,
    },
    gold_per_minute = {
        icon = "philosophers_stone",
        value = 50, --динамически = max(50, раунд*2) за 1 стак (реальное значение считает GetSkillValue); поле — фолбэк
        max = 8,
    },
    lifesteal = {
        icon = "lifesteal",
        value = 10,

        is_percent = true,
    },
    spell_lifesteal = {
        icon = "voodoo_mask",
        value = 10,

        is_percent = true,
    },
    cast_point = {
        icon = "arcane_blink",
        value = 10,

        is_percent = true,
    },
    debuff_amplify = {
        icon = "timeless_relic",
        value = 3,

        is_percent = true,
        max = 8,
    },
}