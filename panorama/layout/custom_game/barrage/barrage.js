--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


linesUsing = []

//发射弹幕
function FireBullet(keys) {

    //遍历轨道 
    var lineNumber
    for (var i = 0; i < linesUsing.length; i++) {
        if (linesUsing[i] == false) {
            lineNumber = i;
            break;
        }
    }

    if (lineNumber != undefined) {
        var panel = $.CreatePanel("Panel", $("#BarrgeMainPanel"), "BulletPanel_" + lineNumber);

        if (keys.type == "round_finish") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("FinishRound");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");

            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + " "
            panel.FindChildTraverse("GoldValue").text = keys.gold_value
        }
        if (keys.type == "player_say") {
            if (Game.IsPlayerMuted(keys.playerId)) {
                return;
            }
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("PlayerSay");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + ": "
            panel.FindChildTraverse("Content").text = keys.content
        }
        if (keys.type == "minigames_finish") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("MinigamesTeamFinish");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name

            let FinishText = $.Localize("#MINIGAMES_TEAM_END_LOSE")
            if(keys.finish_type == 2){
                FinishText = $.Localize("#MINIGAMES_TEAM_END_LOSER")
            }else if(keys.finish_type == 3){
                FinishText = $.Localize("#MINIGAMES_TEAM_END_WINNER")
            }

            panel.FindChildTraverse("Content").text = FinishText
        }

        if (keys.type == "bet_summary") {
            var teamName = Game.GetTeamDetails(keys.teamId).team_name;
            teamName = $.Localize(teamName);
            panel.BLoadLayoutSnippet("BetSummary");
            panel.FindChildTraverse("GoldValue").text = keys.gold_value
            panel.FindChildTraverse("TeamName").text = " " + teamName + " "
            if (GameUI.CustomUIConfig().team_colors) {
                var teamColor = GameUI.CustomUIConfig().team_colors[keys.teamId];
                if (teamColor) {
                    panel.FindChildTraverse("ShieldColor").style.washColor = teamColor;
                }
            }
            if (GameUI.CustomUIConfig().team_icons) {
                var teamIcon = GameUI.CustomUIConfig().team_icons[keys.teamId];
                if (teamIcon) {
                    panel.FindChildTraverse("TeamIcon").SetImage(teamIcon);
                }
            }
        }

        if (keys.type == "bet_summary_solo") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("BetSummarySolo");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId)
            panel.FindChildTraverse("GoldValue").text = keys.gold_value
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = " " + playerInfo.player_name
        }

        if (keys.type == "bet_win") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("BetWin");
            panel.FindChildTraverse("GoldValue").text = keys.gold_value
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name;
        }
        if (keys.type == "pvp_win") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("PvpWin");
            panel.FindChildTraverse("GoldValue").text = keys.gold_value;
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name;
        }
        if (keys.type == "bet_jackpot") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("BetJackpot");
            panel.FindChildTraverse("GoldValue").text = keys.gold_value;
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name;
        }
        if (keys.type == "team_lose") {
            var teamPlayers = Game.GetPlayerIDsOnTeam(keys.nTeamNumber);
            var teamName = Game.GetTeamDetails(keys.nTeamNumber).team_name;
            teamName = $.Localize(teamName);
            panel.BLoadLayoutSnippet("TeamLose");

            var playerNames = " | "

            for (var playerId of teamPlayers) {
                var playerInfo = Game.GetPlayerInfo(playerId);
                playerNames = playerNames + playerInfo.player_name + "  "
            }
            playerNames = playerNames;

            if (GameUI.CustomUIConfig().team_colors) {
                var teamColor = GameUI.CustomUIConfig().team_colors[keys.nTeamNumber];
                if (teamColor) {
                    panel.FindChildTraverse("ShieldColor").style.washColor = teamColor;
                }
            }
            if (GameUI.CustomUIConfig().team_icons) {
                var teamIcon = GameUI.CustomUIConfig().team_icons[keys.nTeamNumber];
                if (teamIcon) {
                    panel.FindChildTraverse("TeamIcon").SetImage(teamIcon);
                }
            }
            panel.FindChildTraverse("TeamName").text = teamName;
            panel.FindChildTraverse("PlayerName").text = playerNames;

        }
        if (keys.type == "chat_wheel") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("PlayerSay");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + ": "
            panel.FindChildTraverse("Content").text = $.Localize("#chat_wheel_full_" + keys.itemName)
        }

        if (keys.type == "pvp_lose_aegis") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("PlayerSay");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + " "
            panel.FindChildTraverse("Content").text = $.Localize("#lose_aegis")
        }
        if (keys.type == "pvp_stack_curse") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("PlayerSay");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + " "
            panel.FindChildTraverse("Content").text = $.Localize("#stack_curse")
        }
        if (keys.type == "compensate_relearn_book") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("CompensateRelearnBook");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + " "
            panel.FindChildTraverse("RoundNumber").text = keys.round_number + ""
            if (keys.book_type == 1) {
                panel.FindChildTraverse("Content").text = $.Localize("#compensate_torn_book")
            }
            if (keys.book_type == 2) {
                panel.FindChildTraverse("Content").text = $.Localize("#compensate_relearn_book")
            }
            if (keys.book_type == 3) {
                panel.FindChildTraverse("Content").text = $.Localize("#compensate_relearn_and_torn_book")
            }
        }

        if (keys.type == "add_extra_creature") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("PlayerSay");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + " "
            panel.FindChildTraverse("Content").text = $.Localize("#release") + $.Localize("#" + keys.creatureName)
            panel.FindChildTraverse("Content").style.color = "red"
            panel.FindChildTraverse("Content").style.fontWeight = "bold"
        }

        if (keys.playerId != undefined) 
        {
            panel.AddClass("Default")
        } else {
            panel.AddClass("Default")
        }

        if (keys.type == "report_actor") 
        {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("PlayerSay");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name;
            panel.FindChildTraverse("Content").text = $.Localize("#marked_as_actor")
        }

        if (keys.type == "bot_take_over") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("PlayerSay");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name;
            panel.FindChildTraverse("Content").text = $.Localize("#bot_take_over")
        }

        if (keys.type == "settle_pumpkin_king") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("SettlePumpkinKing");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + " "
            panel.FindChildTraverse("DamageValue").text = (keys.damage / 1000).toFixed(1)
            panel.FindChildTraverse("GoldValue").text = keys.gold_value
        }

        if (keys.type == "donate_smile") {
            var playerInfo = Game.GetPlayerInfo(keys.playerId);
            panel.BLoadLayoutSnippet("DonateSmile");
            var heroName = Players.GetPlayerSelectedHero(keys.playerId);
            panel.FindChildTraverse("HeroIcon").SetImage("file://{images}/heroes/icons/" + heroName + ".png");
            panel.FindChildTraverse("PlayerName").text = playerInfo.player_name + " "
            panel.FindChildTraverse("smile_icon").style.backgroundImage = 'url("file://{images}/custom_game/donate/smiles/' + keys.smile_icon + '.png")';
            panel.FindChildTraverse("smile_icon").style.backgroundSize = "100%"
        }

        if (typeof keys.playerId !== 'undefined') {
            var player_info = Game.GetPlayerInfo(keys.playerId);

            var player_information_battlepass = CustomNetTables.GetTableValue("players_server_info", `player_${keys.playerId}`);
            if (player_information_battlepass) {
                if (panel.FindChildTraverse("PlayerName")) {
                    if (player_information_battlepass.nickname == 1) {
                        if (GameUI.CustomUIConfig().team_colors) {
                            var teamColor = GameUI.CustomUIConfig().team_colors[playerInfo.player_team_id];
                            if (teamColor) {
                                panel.FindChildTraverse("PlayerName").style.color = teamColor
                            }
                        }
                    } else if (player_information_battlepass.nickname == 2) {
                        panel.FindChildTraverse("PlayerName").SetHasClass("rainbow_nickname", true)
                        panel.FindChildTraverse("PlayerName").style.color = "gradient( linear, 100% 0%, 0% 0%, from( rgb(0, 183, 255)), color-stop( 0.5, rgb(0, 255, 85)), to( rgb(255, 196, 0)))"
                    } else if (player_information_battlepass.nickname == 3) {
                        panel.FindChildTraverse("PlayerName").SetHasClass("rainbow_nickname_animate", true)
                    }
                }
            }
        }



        var offset = lineNumber * 80
        linesUsing[lineNumber] = true
        panel.style.marginTop = offset + "px";

        //释放轨道
        $.Schedule(10, function() {
            linesUsing[lineNumber] = false
        });
        //清空面板
        $.Schedule(16.5, function() {
            panel.DeleteAsync(0)
        });
    }
}

(function() {
    for (var i = 0; i <= 9; i++) {
        linesUsing.push(false)
    }
    GameEvents.Subscribe("FireBullet", FireBullet);
})();

GameUI.CustomUIConfig().HeroFindCreeps = function HeroFindCreeps(player_id) 
{
    $("#CreepInformation").RemoveAndDeleteChildren()
    let find_table = CustomNetTables.GetTableValue("creep_launch", String(player_id))
    if (find_table)
    {
        for (var i = 0; i < Object.keys(find_table).length; i++) 
        {
            let CreepNameMain = $.CreatePanel("Panel", $("#CreepInformation"), "");
            CreepNameMain.AddClass("CreepNameMain");

            let CreepNameMainBorder = $.CreatePanel("Panel", CreepNameMain, "");
            CreepNameMainBorder.AddClass("CreepNameMainBorder");

            let CreepNameMainImage = $.CreatePanel("DOTAItemImage", CreepNameMainBorder, "");
            CreepNameMainImage.AddClass("CreepNameMainImage");

            let creep_name = Object.keys(find_table)[i]
            if (creep_name == "item_extra_creature_ogreseal_big")
            {
                creep_name = "item_extra_creature_ogreseal"
            }
            if (creep_name == "item_extra_creature_siltbreaker_red")
            {
                creep_name = "item_extra_creature_siltbreaker"
            }
            CreepNameMainImage.itemname = creep_name

            let CreepNameMainCount = $.CreatePanel("Label", CreepNameMain, "");
            CreepNameMainCount.AddClass("CreepNameMainCount");
            CreepNameMainCount.text = find_table[Object.keys(find_table)[i]]
        }
    }
    $("#CreepInformation").style.opacity = "1"
}

GameUI.CustomUIConfig().HeroFindCreepsClose = function HeroFindCreeps() 
{
    $("#CreepInformation").style.opacity = "0"
}

function UpdateShop()
{
    let shop_panel_main = FindDotaHudElement("GridMainShopContents")
    if (shop_panel_main)
    {
        let Grids = shop_panel_main.FindChildrenWithClassTraverse("ShopItemsCategory")
        if(Grids){
            for (const GridPanel of Grids) {
                GridPanel.style.paddingBottom = "35px"
            }
        }
    }
}

UpdateShop()