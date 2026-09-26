--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var ROLL_FAST_TIME = 3.5
var ROLL_SLOW_MIN = 7.5
var ROLL_SLOW_MAX = 9
var ROLL_BRAKE_POWER = 6
var ROLL_LOOP = 20
var ROLL_LOOPS = 1
var ROLL_TICK_INTERVAL = 0.1
var ROLL_EDGE_CHANCE = 0.7
var ROLL_DROP_SLOT = 70

function ChestRollPicks(items)
{
    let picks = []
    for (let i = 0; i <= ROLL_DROP_SLOT + 6; i++)
    {
        picks.push(i < ROLL_LOOP ? items[Math.floor(Math.random() * items.length)] : picks[i - ROLL_LOOP])
    }
    return picks
}

function ChestRollAnimate(roll_panel, drop_pos, card_width, is_cancelled, on_finish)
{
    let roll = Math.random()
    let part = Math.random()
    let shift = part * 0.9
    if (roll < ROLL_EDGE_CHANCE / 2) { shift = part * 0.1 }
    else if (roll < ROLL_EDGE_CHANCE) { shift = 0.82 + part * 0.08 }
    let drop_distance = drop_pos[0] + (drop_pos[1] - drop_pos[0]) * shift
    let slow_time = ROLL_SLOW_MIN + Math.random() * (ROLL_SLOW_MAX - ROLL_SLOW_MIN)
    let loop_width = ROLL_LOOP * card_width
    let distance = drop_distance - ROLL_LOOPS * loop_width
    let speed = distance / (ROLL_FAST_TIME + slow_time / (0.85 * ROLL_BRAKE_POWER + 0.15 * 2))
    let fast_distance = speed * ROLL_FAST_TIME
    let start_time = Date.now()
    let last_card = 0
    let last_tick = 0
    let step = function()
    {
        if (is_cancelled()) { return }
        let time = (Date.now() - start_time) / 1000
        let rest = Math.max(0, 1 - Math.max(0, time - ROLL_FAST_TIME) / slow_time)
        let current = time < ROLL_FAST_TIME ? speed * time : fast_distance + (distance - fast_distance) * (1 - 0.85 * Math.pow(rest, ROLL_BRAKE_POWER) - 0.15 * rest * rest)
        let loops = Math.min(ROLL_LOOPS, Math.max(0, Math.floor((-current / card_width - 5) / ROLL_LOOP)))
        let offset = current + loops * loop_width
        roll_panel.style.transform = "translateX(" + offset.toFixed(1) + "px)"
        let card = Math.floor(-offset / card_width)
        if (card != last_card)
        {
            last_card = card
            if (time - last_tick >= ROLL_TICK_INTERVAL)
            {
                last_tick = time
                Game.EmitSound("random_wheel_lever")
            }
        }
        if (rest <= 0)
        {
            $.Schedule(0.1, on_finish)
            return
        }
        $.Schedule(0, step)
    }
    step()
}