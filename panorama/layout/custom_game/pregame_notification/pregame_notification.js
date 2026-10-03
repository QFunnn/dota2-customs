--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
};

function CloseDediLocalLobby() {
	HUD.CONTEXT.RemoveClass("BLocalLobbyDediInformation");
}
(() => {
	if (B_LOCAL_LOBBY && Game.GameStateIsBefore(DOTA_GameState.DOTA_GAMERULES_STATE_GAME_IN_PROGRESS))
		HUD.CONTEXT.AddClass("BLocalLobbyDediInformation");
})();