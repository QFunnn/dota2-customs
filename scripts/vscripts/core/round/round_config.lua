--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


BASE_PREPARE_TIME = 15
ROUND_LIMIT_TIME = 50
ROUND_BASE_BONUS = 300

COMPENSATION_ROUNDS = {
    [10] = true,
    [20] = true,
    [30] = true,
    [40] = true
}

if IsInToolsMode() then
    BASE_PREPARE_TIME = 15
    ROUND_LIMIT_TIME = 50
    COMPENSATION_ROUNDS = {
        [1] = true,
        [2] = true,
        [3] = true,
        [4] = true
    }
end
