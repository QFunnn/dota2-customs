--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


var teamId = $.GetContextPanel().GetAttributeInt( "team_id", -1 );
if ( GameUI.CustomUIConfig().team_colors )
{
    var teamColor = GameUI.CustomUIConfig().team_colors[ teamId ];
    if ( teamColor )
    {
        $("#ShieldColor").style.washColor = teamColor;
    }
}
if ( GameUI.CustomUIConfig().team_icons )
{
    var teamIcon = GameUI.CustomUIConfig().team_icons[ teamId ];
    if ( teamIcon )
    {
        $("#TeamIcon").SetImage( teamIcon );
    }
}