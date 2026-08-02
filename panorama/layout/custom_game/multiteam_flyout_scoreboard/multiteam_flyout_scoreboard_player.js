--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function ToggleMute()
{
    var playerId = $.GetContextPanel().GetAttributeInt( "player_id", -1 );
    if ( playerId !== -1 )
    {
        var newIsMuted = !Game.IsPlayerMuted( playerId );
        Game.SetPlayerMuted( playerId, newIsMuted );
        Game.SetPlayerMutedVoice( playerId, newIsMuted );
        Game.SetPlayerMutedText( playerId, newIsMuted );
        $.GetContextPanel().SetHasClass( "player_muted", newIsMuted );
    }
}
(function()
{
    var playerId = $.GetContextPanel().GetAttributeInt( "player_id", -1 );
    $.GetContextPanel().SetHasClass( "player_muted", Game.IsPlayerMuted( playerId ) );
})();