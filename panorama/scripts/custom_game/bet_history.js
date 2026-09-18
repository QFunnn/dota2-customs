--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


var sum = 0

function BetInfoChanged()
{
    var playerId = Game.GetLocalPlayerInfo().player_id;
    var betHistory = CustomNetTables.GetTableValue("pvp_record", "bet_history_"+playerId);
    var length = 0
    if (betHistory!=undefined)
    {
       $("#BetHistoyEmptyTitle").AddClass("Collapse")
       for (var index in betHistory) {
          length = length +1;
       	  var itemName = "bet_history_" + index;
       	  if ($("#BetHistoyContainer").FindChildTraverse(itemName))
          {
             continue;          
          }
          var betHistoryItem = $.CreatePanel("Panel", $("#BetHistoyContainer"), itemName);
          betHistoryItem.BLoadLayoutSnippet("HistoryItem");
          if (index%2==1)
          {
            betHistoryItem.AddClass("Odd")
          }
          else
          {
             betHistoryItem.AddClass("Even")
          }
          if (betHistory[index].value>0)
          {
            betHistoryItem.FindChildTraverse("Value").text = "+" + betHistory[index].value
            betHistoryItem.FindChildTraverse("Value").AddClass("Red")
          }
          if (betHistory[index].value<0)
          {
            betHistoryItem.FindChildTraverse("Value").text = "" + betHistory[index].value
            betHistoryItem.FindChildTraverse("Value").AddClass("Green")
          }

          $("#BetHistoyMain").sum = $("#BetHistoyMain").sum+betHistory[index].value;

          for (var winnerIndex in betHistory[index].winners) {
          	 var heroName = Players.GetPlayerSelectedHero(betHistory[index].winners[winnerIndex])
          	 betHistoryItem.FindChildTraverse("HeroIconWinner_"+winnerIndex).SetImage( "file://{images}/heroes/icons/" + heroName + ".png" );
             if (betHistory[index].winners[winnerIndex]==playerId)
             {
                 betHistoryItem.FindChildTraverse("YouWinner").RemoveClass("Hidden")
             }
          }
          for (var loserIndex in betHistory[index].losers) {
          	 var heroName = Players.GetPlayerSelectedHero(betHistory[index].losers[loserIndex])
          	 betHistoryItem.FindChildTraverse("HeroIconLoser_"+loserIndex).SetImage( "file://{images}/heroes/icons/" + heroName + ".png" );
             betHistoryItem.FindChildTraverse("HeroIconLoser_"+loserIndex).AddClass("Defeated")
             if (betHistory[index].losers[loserIndex]==playerId)
             {
                 betHistoryItem.FindChildTraverse("YouLoser").RemoveClass("Hidden")
                 betHistoryItem.FindChildTraverse("Value").text = $.Localize("#defeat")
                 //击败的不算
                 $("#BetHistoyMain").sum = $("#BetHistoyMain").sum + (-1* betHistory[index].value);
             }
          }
       } 

       var courierControls = FindDotaHudElement("CourierControls");
       if ($("#BetHistoyMain").sum>0)
       {
           courierControls.FindChildTraverse("betHistoryButtonLabel_2").text = "+"+$("#BetHistoyMain").sum;
           courierControls.FindChildTraverse("betHistoryButtonLabel_2").style.color="#EA7070";
       }
       if ($("#BetHistoyMain").sum<0)
       {
           courierControls.FindChildTraverse("betHistoryButtonLabel_2").text = $("#BetHistoyMain").sum;
           courierControls.FindChildTraverse("betHistoryButtonLabel_2").style.color="#70EA72";
       }
    
      //如果本地玩家是PASS用户
      var pass_info = CustomNetTables.GetTableValue("player_info", "pass_data_"+playerId);
      if (pass_info && pass_info.player_steam_id)
      {

      }
      else
      {
        for (var index in betHistory) {
          if (length>3 && index<=length-3)
          {
              var itemName = "bet_history_" + index;
              $("#BetHistoyContainer").FindChildTraverse(itemName).AddClass("Collapse");
          }
        }
      }
    }
}



function ToggleBetHistory()
{
    $("#BetHistoyMain").ToggleClass("Hidden")

}


(function()
{
    // switch (Game.GetMapInfo().map_display_name) {
    //   case "1x8":
    //     $("#BetHistoyMain").style.width="350px";
    //     break;
    //   case "random_1x8":
    //     $("#BetHistoyMain").style.width="350px";
    //     break;
    //   case "2x6":
    //     $("#BetHistoyMain").style.width="400px";
    //     break;
    // }
    // CustomNetTables.SubscribeNetTableListener("pvp_record", BetInfoChanged);
    // var courierControls = FindDotaHudElement("CourierControls");
    // courierControls.FindChildTraverse("DeliverItemsButton").visible = false;
    
    // var betHistoryButton = $.CreatePanel("Button", courierControls, "betHistoryButton");
    // betHistoryButton.AddClass("ButtonBevel")
    // betHistoryButton.style.flowChildren="down";
    // betHistoryButton.style.width="350px";
    // betHistoryButton.style.paddingTop="0px";
    // betHistoryButton.style.paddingBottom="0px";
    // betHistoryButton.style.paddingLeft="5px";
    // betHistoryButton.style.paddingRight="5px";
    // betHistoryButton.style.marginTop="9px";
    
    // var betHistoryButtonLabel_1 = $.CreatePanel("Label", betHistoryButton, "betHistoryButtonLabel_1");
    // betHistoryButtonLabel_1.text=$.Localize("#bet_summarize");
    // betHistoryButtonLabel_1.style.fontSize="10px";
    // betHistoryButtonLabel_1.style.height="10px";
    // betHistoryButtonLabel_1.style.textOverflow="shrink";

    // var betHistoryButtonLabel_2 = $.CreatePanel("Label", betHistoryButton, "betHistoryButtonLabel_2");
    // betHistoryButtonLabel_2.text="0";
    // betHistoryButtonLabel_2.style.fontSize="15px";

    // $("#BetHistoyMain").sum =0; 

    // betHistoryButton.SetPanelEvent("onactivate", ToggleBetHistory);
    // betHistoryButton.SetPanelEvent("onmouseover", function () {
    //   $.DispatchEvent("DOTAShowTextTooltip", betHistoryButton, $.Localize("#bet_history_hint"));
    // });
    // betHistoryButton.SetPanelEvent("onmouseout", function () {
    //   $.DispatchEvent("DOTAHideTextTooltip");
    // });

    // BetInfoChanged()

})();