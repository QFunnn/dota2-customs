--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PlayerID = Players.GetLocalPlayer()

const MAIN_PANEL = $.GetContextPanel()

const BetHistoyMain = $("#BetHistoyMain")
const BetHistoryButton = $("#BetHistoryButton")
const BetHistoryContainer = $("#BetHistoryContainer")

let CourierControlsPanel = FindDotaHudElement("CourierControls")
if(CourierControlsPanel){
	CourierControlsPanel.style.visibility = "collapse"
}
var courierControls = FindDotaHudElement("ShopCourierControls");
if(courierControls.FindChildTraverse("betHistoryButton")){
	courierControls.FindChildTraverse("betHistoryButton").DeleteAsync(0.0)
}
if(courierControls.FindChildTraverse("BetHistoryButton")){
	courierControls.FindChildTraverse("BetHistoryButton").DeleteAsync(0.0)
}
BetHistoryButton.SetParent(courierControls)

BetHistoryContainer.RemoveAndDeleteChildren()

SubscribeAndFirePlayerTableByKey(`player_${PlayerID}`, `bet_history`, function(v){
	if(Count(v) == 0){
		BetHistoryContainer.RemoveAndDeleteChildren()
	}
	let Array = toArray(v)
	if(Array){
		UpdateBets(Array)
	}
})

function UpdateBets(BetsHistory)
{
	BetHistoyMain.SetHasClass("Empty", BetsHistory.length == 0)

	let AllSum = 0
	for (const BetIndex in BetsHistory) {
		let BetInfo = BetsHistory[BetIndex]
		let panel = GetOrCreateBetHistoryRow(BetIndex)

		panel.SetHasClass("Odd", BetIndex%2==1)
		panel.SetHasClass("Even", BetIndex%2!=1)

		panel.SetHasClass("PlusGold", BetInfo.value > 0)
		panel.SetHasClass("MinusGold", BetInfo.value < 0)

		panel.SetDialogVariable("round_num", BetInfo.round)

		let BetText = BetInfo.value > 0 ? `+${BetInfo.value}` : BetInfo.value

		panel.round = BetInfo.round

		AllSum += BetInfo.value

		for(const betIndex in BetInfo.bets){
			let BetPlayerInfo = BetInfo.bets[betIndex]
			if(BetPlayerInfo.TeamID == BetInfo.fTeam || BetPlayerInfo.TeamID == BetInfo.sTeam){
				let Container = BetPlayerInfo.TeamID == BetInfo.fTeam ? panel.FindChildTraverse("FirstTeam") : panel.FindChildTraverse("SecondTeam")

				let PlayerInfo = Game.GetPlayerInfo(BetPlayerInfo.PlayerID)

				let HeroIcon = Container.FindChildTraverse("HeroIcon")
				if(HeroIcon){
					HeroIcon.heroname = PlayerInfo.player_selected_hero
				}

				Container.SetDialogVariable("player_name", PlayerInfo.player_name)
				Container.SetDialogVariable("hero_name", $.Localize(`#${PlayerInfo.player_selected_hero}`))

				Container.SetHasClass("BettedToThis", BetPlayerInfo.TeamID == BetInfo.betted_team)

				if(BetInfo.loser_team == BetPlayerInfo.TeamID && PlayerID == BetPlayerInfo.PlayerID){
					AllSum -= BetInfo.value

					panel.AddClass("IsLocalLose")
				}

				Container.SetHasClass("Winner", BetInfo.winner_team == BetPlayerInfo.TeamID)
			}
		}

		panel.SetDialogVariable("bet_sum", ""+BetText)
	}

	ReorderPanels(BetHistoryContainer, SortFuncValue)

	let AllSumText = AllSum > 0 ? `+${AllSum}` : AllSum
	BetHistoyMain.SetDialogVariable("bets_sum", ""+AllSumText)
	BetHistoryButton.SetDialogVariable("bets_sum", ""+AllSumText)
	BetHistoyMain.SetHasClass("LoseGold", AllSum < 0)
	BetHistoryButton.SetHasClass("LoseGold", AllSum < 0)
}

function ReorderPanels(Container, SortFunc){
    var count = Container.GetChildCount()
	if (count > 0) {
		for (var i = 0; i < count; i++) {
            for (var j = i+1; j < count; j++) {
                let prev = Container.GetChild(i);
                let child = Container.GetChild(j);
                if(child != undefined){
                    SortFunc(Container, prev, child);
                }
            }
        }
	}
}

function SortFuncValue(Container, a, b){
    let aRound = a.round
    let bRound = b.round
    if(bRound > aRound){
        Container.MoveChildBefore(b, a);
    }
}

function ToggleBetHistory()
{
    BetHistoyMain.ToggleClass("Show")
    BetHistoryButton.SetHasClass("Show", BetHistoyMain.BHasClass("Show"))

	if(BetHistoyMain.BHasClass("Show")){
		Game.EmitSound("Shop.PanelUp")
	}else{
		Game.EmitSound("Shop.PanelDown")
	}
}

function GetOrCreateBetHistoryRow(BetNum){
	let f = BetHistoryContainer.FindChildTraverse(`Bet_${BetNum}`)
	if(f){
		return f
	}else{
		let p = $.CreatePanel("Panel", BetHistoryContainer, `Bet_${BetNum}`, {})
		p.BLoadLayoutSnippet("HistoryItem")

		return p
	}
}

GameEvents.Subscribe("AUTO_OPEN_BET_HISTORY", function(){
	if(!BetHistoyMain.BHasClass("Show")){
		BetHistoyMain.AddClass("Show")
		BetHistoryButton.AddClass("Show")
		
		Game.EmitSound("Shop.PanelUp")
	}
})