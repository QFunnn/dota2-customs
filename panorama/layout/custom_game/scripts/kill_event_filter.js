--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var steakSound={
  3:"announcer_killing_spree_announcer_kill_spree_01",
  4:"announcer_killing_spree_announcer_kill_dominate_01",
  5:"announcer_killing_spree_announcer_kill_mega_01",
  6:"announcer_killing_spree_announcer_kill_unstop_01",
  7:"announcer_killing_spree_announcer_kill_wicked_01",
  8:"announcer_killing_spree_announcer_kill_monster_01",
  9:"announcer_killing_spree_announcer_kill_godlike_01",
  10:"announcer_killing_spree_announcer_kill_holy_01"  
}

function DotaKillStreak(keys)
{   
    var streakDelay = 0.1
    if ( Players.GetTeam( Players.GetLocalPlayer())>=6 )  
    {
       	$.Schedule(streakDelay, function(){
        	if (keys.killer_streak>10) {keys.killer_streak=10}
        	Game.EmitSound(steakSound[keys.killer_streak]);
       	});
    }
}

function DotaFirstBlood(keys)
{   
  	if ( Players.GetTeam( Players.GetLocalPlayer())>=6 )  
  	{
    	Game.EmitSound("announcer_killing_spree_announcer_1stblood_01");
  	}
}

(function () {
    GameEvents.Subscribe( "dota_chat_kill_streak", DotaKillStreak );
    GameEvents.Subscribe( "dota_chat_first_blood", DotaFirstBlood );
})();