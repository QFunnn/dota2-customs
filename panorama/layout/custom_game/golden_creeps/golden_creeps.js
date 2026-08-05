--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


$("#menu_golden_spawn").visible = false

function part_1_btn() {
    isopen = false
    GameEvents.SendCustomGameEventToServer("golden_spawn", { type: "GoldenMiner1" });
    Game.EmitSound("ui_select_arrow")
}

function part_2_btn() {
    GameEvents.SendCustomGameEventToServer("golden_spawn", { type: "GoldenQueen1" });
    Game.EmitSound("ui_select_arrow")
}

function part_3_btn() {
    GameEvents.SendCustomGameEventToServer("golden_spawn", { type: "GoldenWyvern1" });
    Game.EmitSound("ui_select_arrow")
}

function part_4_btn() {
    GameEvents.SendCustomGameEventToServer("golden_spawn", { type: "GoldenSea1" });
    Game.EmitSound("ui_select_arrow")
}

function part_5_btn() {
    GameEvents.SendCustomGameEventToServer("golden_spawn", { type: "GoldenDragon1" });
    Game.EmitSound("ui_select_arrow")
}

function part_6_btn() {
    GameEvents.SendCustomGameEventToServer("golden_spawn", { type: "GoldenForest1" });
    Game.EmitSound("ui_select_arrow")
}

function spawn_golden_event(t) {
    $("#menu_golden_spawn").visible = true
}

function spawned(t) {
    if (t.successfully > 0) {
        $("#menu_golden_spawn").visible = false
    }
}

function part_7_btn() {
    $("#menu_golden_spawn").visible = false
    Game.EmitSound("ui_select_arrow")
}

GameEvents.Subscribe("spawn_golden_event", spawn_golden_event);
GameEvents.Subscribe("spawned", spawned);