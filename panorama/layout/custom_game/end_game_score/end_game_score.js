--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const EndDuelScore = $("#EndDuelScore")

let DuelPlayers = {}
let Listeners = []

SubscribeAndFireNetTableByKey("globals", `last_duel_players`, function(v){
	DuelPlayers = v

	SetupLastDuelScore()
})

function SetupLastDuelScore() 
{
	EndDuelScore.SetHasClass("Show", Object.keys(DuelPlayers).length > 0)

	for (const ListenerID of Listeners) {
		CustomNetTables.UnsubscribeNetTableListener( ListenerID )
	}
	Listeners = []

	for (const PlayerIndex in DuelPlayers) {
		let PlayerID = DuelPlayers[PlayerIndex]
		let listener = SubscribeAndFireNetTableByKey("players", `player_${PlayerID}_pvp_info`, function(v){
			let p = EndDuelScore.FindChildTraverse(`Player${PlayerIndex}`)
			if(p){
				p.SetDialogVariable("score", v.last_duel_wins)

				let PlayerIcons = p.FindChildrenWithClassTraverse("PlayerIcon")
				if(PlayerIcons && PlayerIcons[0]){
					let HeroName = Players.GetPlayerSelectedHero(PlayerID)
					PlayerIcons[0].style.backgroundImage = 'url( "file://{images}/heroes/icons/' + HeroName + '.png" );'
					PlayerIcons[0].style.backgroundSize = "100%"
				}
			}
		})
		Listeners.push(listener)
	}
}