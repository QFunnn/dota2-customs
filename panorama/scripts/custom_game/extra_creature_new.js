--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const MAIN_PANEL = $.GetContextPanel();
const LocalPID = Players.GetLocalPlayer();
const ExtraCreature = $("#ExtraCreature");
const ExtraCreatureBlock = $("#ExtraCreatureBlock");
const ExtraCreaturePlayerHeroIcon = $("#ExtraCreaturePlayerHeroIcon");
let Scheduler = -1;
function ExtraCreatureAdded(event) {
    var _a;
    const PlayerInfo = Game.GetPlayerInfo(event.caller);
    if (!PlayerInfo || event.option === 1)
        return;
    const isMinimized = event.option === 2;
    ExtraCreatureBlock.SetHasClass("Minimized", isMinimized);
    ExtraCreatureBlock.SetDialogVariable("caller_player_name", PlayerInfo.player_name);
    ExtraCreatureBlock.SetDialogVariable("caller_hero_name", $.Localize(`#${PlayerInfo.player_selected_hero}`));
    ExtraCreatureBlock.SetDialogVariable("creep_name", $.Localize(`#${event.creatureName}`));
    //@ts-ignore
    ExtraCreaturePlayerHeroIcon.heroname = PlayerInfo.player_selected_hero;
    ExtraCreatureBlock.AddClass("fade");
    const creatureName = (_a = EXTRA_CREATURE_FIX_NAME_MAP[event.creatureName]) !== null && _a !== void 0 ? _a : event.creatureName;
    ExtraCreature.SetUnit(creatureName, "", true);
    const soundEventName = EXTRA_CREATURE_SOUND_EVENTS[event.creatureName];
    if (soundEventName != undefined) {
        Game.EmitSound(soundEventName);
    }
    Game.EmitSound("Creep.Sended");
    const particleID = Particles.CreateParticle("particles/custom/creep_sended.vpcf", ParticleAttachment_t.PATTACH_EYES_FOLLOW, 0);
    $.Schedule(0.5, function () {
        Particles.DestroyParticleEffect(particleID, false);
    });
    if (Scheduler != -1) {
        $.CancelScheduled(Scheduler);
        Scheduler = -1;
    }
    Scheduler = $.Schedule(2, function () {
        ExtraCreatureBlock.RemoveClass("fade");
    });
}
GameEvents.Subscribe("ExtraCreatureAddedNew", ExtraCreatureAdded);
const EXTRA_CREATURE_FIX_NAME_MAP = {
    npc_dota_dark_troll_warlord: "npc_dota_neutral_dark_troll_warlord"
};
const EXTRA_CREATURE_SOUND_EVENTS = {
    npc_dota_satyr_trickster: "n_creep_SatyrTrickster.Cast",
    npc_dota_big_thunder_lizard: "n_creep_Thunderlizard_Big.Roar",
    npc_dota_spider_range: "Hero_Viper.Nethertoxin.Cast",
    npc_dota_dark_troll_warlord: "n_creep_TrollWarlord.Ensnare",
    npc_dota_ghost: "n_creep_ghost.Death",
    npc_dota_centaur_khan: "n_creep_Centaur.Stomp",
    npc_dota_prowler_shaman: "n_creep_Spawnlord.Stomp",
    npc_dota_granite_golem: "n_creep_golemRock.Death",
    npc_dota_rock_golem: "n_creep_golemRock.Death",
    npc_dota_gnoll_assassin: "n_creep_gnoll.Death",
    npc_dota_kobold: "n_creep_kobolds.Death",
    npc_dota_timber_spider: "Hero_Shredder.WhirlingDeath.Cast",
    npc_dota_explode_spider: "Hero_Broodmother.SpawnSpiderlings"
};