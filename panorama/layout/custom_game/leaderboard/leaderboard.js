--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var InitLeaderboard = false;
var cooldown_panel = false
var current_sub_tab = "";
var TOP_RATING_LIST = {}
var OpenedHeroSoloPanel = null

function ToggleLeaderboard() 
{
    if (!InitLeaderboard)
    {
        InitRatingTable()
        GetLocalRating()
        GetPlayersData()
        GetPlayersDataPve()
        FirstOpen()
        InitLeaderboard = true
    }
    $("#LeaderboardWindow").SetHasClass("setvisible", !$("#LeaderboardWindow").BHasClass("setvisible"))
}

function FirstOpen()
{
    $("#PanelButPVE").SetHasClass("ButtonRatActive", false)
    $("#PanelButPVP").SetHasClass("ButtonRatActive", false)
    $("#PvpInfo").style.visibility = "collapse"
    $("#PveInfo").style.visibility = "collapse"
    if (Game.GetMapInfo().map_display_name == "arena")
    {
        $("#PanelButPVE").SetHasClass("ButtonRatActive", true)
        $("#PveInfo").style.visibility = "visible"
    }
    else
    {
        $("#PanelButPVP").SetHasClass("ButtonRatActive", true)
        $("#PvpInfo").style.visibility = "visible"
    }
}
 
function GetLocalRating()
{
    var localplayer_data = Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer()));
    if (!localplayer_data)
    {
        $.Schedule(1, GetLocalRating)
        return;
    } 
    $("#LocalRating").text = String(localplayer_data.rating)
    $("#LocalRatingPve").text = String(localplayer_data.pve_rating)
}


function InitRatingTable()
{
    GameEvents.SendCustomGameEventToServer_custom( "donate_shop_get_top_rating", {} );
}

GameEvents.Subscribe_custom( 'donate_shop_set_top_rating', donate_shop_set_top_rating );
function donate_shop_set_top_rating(data)
{
    TOP_RATING_LIST = data
}

function GetPlayersData()
{
    var top_rating = TOP_RATING_LIST["top_rating"]
    if (!top_rating)
    {
        $.Schedule(1, GetPlayersData)
        return;
    }
    for (let i in top_rating)
    {
        let player_data = top_rating[i]
        if (player_data)
        {
            CreatePlayer(player_data.steamid, player_data.rating, $("#PlayersTable"), i, false, player_data)  
        }
    }
}

function GetPlayersDataPve()
{
    var top_rating = TOP_RATING_LIST["top_rating_pve"]
    if (!top_rating || top_rating == null || Object.keys(top_rating).length <= 0)
    {
        $.Schedule(1, GetPlayersDataPve)
        return;
    }
    for (let i = 1; i <= 200; i++)
    { 
        let data_1 = top_rating["1"][i]
        let data_2 = top_rating["2"][i]
        let data_3 = top_rating["3"][i]
        if (data_1)
        {
            //CreatePlayer(data_1.p1, data_1.wave_count, $("#PlayersTablePVE1"), i, true, data_1)
        }
        if (data_2)
        {
            CreatePlayers(data_2.p1, data_2.p2, data_2.p3, data_2.p4, data_2.wave_count, $("#PlayersTablePVE2"), i, true, data_2)
        }
        if (data_3)
        {
            CreatePlayers(data_3.p1, data_3.p2, data_3.p3, data_3.p4, data_3.wave_count, $("#PlayersTablePVE3"), i, true, data_3)
        }
    }
    InitTopHeroesPve(top_rating)
}

function CreatePlayer(steam_id, rating, panel, number, pve, full_data) 
{
    var Line = $.CreatePanel("Panel", panel, "");
    Line.AddClass("LinePlayer");

    var RankPanel = $.CreatePanel("Panel", Line, "");
    RankPanel.AddClass("RankPanel");

    var RankImage = $.CreatePanel("Panel", RankPanel, "");
    RankImage.AddClass("RankImage");

    let index = number >= 1 && number <= 10 ? 1 : number <= 50 ? 2 : number <= 100 ? 3 : null;
    if (index) 
    {
        RankImage.style.backgroundImage = `url("file://{images}/custom_game/leaderboard/rating${index}.png")`;
        RankImage.style.backgroundSize = "100%" 
    }
    else 
    {
        RankImage.style.opacity = 1;
    }

    var Rank_number = $.CreatePanel("Label", RankImage, "");
    Rank_number.AddClass("Rank_number");
    Rank_number.text = number

    var AvatarNicknamePanel = $.CreatePanel("Panel", Line, "");
    AvatarNicknamePanel.AddClass("AvatarNicknamePanel");

    $.CreatePanel("DOTAAvatarImage", AvatarNicknamePanel, "AvatarLeaderboard", { style: "width:32px;height:32px;vertical-align:center;", accountid: steam_id });

    if (pve && full_data.hero_1)
    {
        let hero_icon = $.CreatePanel("Panel", AvatarNicknamePanel, "");
        hero_icon.AddClass("hero_icon");
        hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + full_data.hero_1 + '.png" );'
        hero_icon.style.backgroundSize = "100%"
    }

    $.CreatePanel("DOTAUserName", AvatarNicknamePanel, "NickNameLeaderboard", { style: "vertical-align:center;margin-left:10px;height: 20px;", accountid: steam_id });

    var Rating = $.CreatePanel("Label", Line, "");
    Rating.AddClass("RatingLabel");
    Rating.text = String(rating)

    if (pve)
    {
        Rating.style.color = "orange";
    } 
    
    let rewards_list = $.CreatePanel("Panel", Line, "");
    rewards_list.AddClass("rewards_list");

    let rewardData = 
    {
        1: { amount: "10000", hasEffect: true },
        2: { amount: "8000", hasEffect: true },
        3: { amount: "6000", hasEffect: true },
        range4_10: { amount: "3000", hasEffect: true },
        range11_50: { amount: "2000", hasEffect: false },
        range51_100: { amount: "1000", hasEffect: false }
    };

    if (pve)
    {
        rewardData = 
        {
            1: { amount: "2500", hasEffect: false },
            2: { amount: "2000", hasEffect: false },
            3: { amount: "1500", hasEffect: false },
            range4_10: { amount: "750", hasEffect: false },
            range11_50: { amount: "500", hasEffect: false },
            range51_100: { amount: "250", hasEffect: false }
        };
    }

    // Выбираем нужные данные награды
    let currentReward;
    if (number >= 51 && number <= 100) {
        currentReward = rewardData.range51_100;
    } else if (number >= 11 && number <= 50) {
        currentReward = rewardData.range11_50;
    } else if (number >= 4 && number <= 10) {
        currentReward = rewardData.range4_10;
    } else if (number == 3) {
        currentReward = rewardData[3];
    } else if (number == 2) {
        currentReward = rewardData[2];
    } else if (number == 1) {
        currentReward = rewardData[1];
    }

    if (currentReward)
    {
        if (currentReward.hasEffect && !pve) 
        {
            let effect_icon = $.CreatePanel("Panel", rewards_list, "");
            effect_icon.AddClass("effect_icon");
            SetIconInfo(effect_icon, "emblem_140", "emblem_140_open")
            effect_icon.style.backgroundImage = 'url( "file://{images}/custom_game/shop/emblem_140.png" )';
            effect_icon.style.backgroundSize = "100%"
            GameUI.CustomUIConfig().OpenCheckoutItemPreview(effect_icon, [1084, null, null, "emblem_140", "emblem_140", null], true)
        }

        let money_reward = $.CreatePanel("Panel", rewards_list, "");
        money_reward.AddClass("money_reward");

        SetTextInfo(money_reward, "coin_reward_information_leaderboard")

        let coin_icon = $.CreatePanel("Panel", money_reward, "");
        coin_icon.AddClass("coin_icon");

        let coin_number = $.CreatePanel("Label", money_reward, "");
        coin_number.AddClass("coin_number");
        coin_number.text = currentReward.amount;
    }
}

function CreatePlayers(id1, id2, id3, id4, rating, panel, number, pve, full_data) 
{
    var Line = $.CreatePanel("Panel", panel, "");
    Line.AddClass("LinePlayer");

    var RankPanel = $.CreatePanel("Panel", Line, "");
    RankPanel.AddClass("RankPanel");

    var RankImage = $.CreatePanel("Panel", RankPanel, "");
    RankImage.AddClass("RankImage");

    let index = number >= 1 && number <= 10 ? 1 : number <= 50 ? 2 : number <= 100 ? 3 : null;
    if (index) 
    {
        RankImage.style.backgroundImage = `url("file://{images}/custom_game/leaderboard/rating${index}.png")`;
        RankImage.style.backgroundSize = "100%" 
    }
    else 
    {
        RankImage.style.opacity = 1;
    }

    var Rank_number = $.CreatePanel("Label", RankImage, "");
    Rank_number.AddClass("Rank_number");
    Rank_number.text = number

    var AvatarNicknamePanel = $.CreatePanel("Panel", Line, "");
    AvatarNicknamePanel.AddClass("AvatarNicknamePanel");

    if (Number(id1) != 0)
    {
        $.CreatePanel("DOTAAvatarImage", AvatarNicknamePanel, "AvatarLeaderboard", { style: "width:32px;height:32px;vertical-align:center;", accountid: id1 });
        if (pve && full_data.hero_1)
        {
            let hero_icon = $.CreatePanel("Panel", AvatarNicknamePanel, "");
            hero_icon.AddClass("hero_icon");
            hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + full_data.hero_1 + '.png" );'
            hero_icon.style.backgroundSize = "100%"
        }
    }
    if (Number(id2) != 0)
    {
        $.CreatePanel("DOTAAvatarImage", AvatarNicknamePanel, "AvatarLeaderboard", { style: "width:32px;height:32px;vertical-align:center;margin-left:10px;", accountid: id2 });
        if (pve && full_data.hero_2)
        {
            let hero_icon = $.CreatePanel("Panel", AvatarNicknamePanel, "");
            hero_icon.AddClass("hero_icon");
            hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + full_data.hero_2 + '.png" );'
            hero_icon.style.backgroundSize = "100%"
        }
    }
    if (Number(id3) != 0)
    {
        $.CreatePanel("DOTAAvatarImage", AvatarNicknamePanel, "AvatarLeaderboard", { style: "width:32px;height:32px;vertical-align:center;margin-left:10px;", accountid: id3 });  
        if (pve && full_data.hero_3)
        {
            let hero_icon = $.CreatePanel("Panel", AvatarNicknamePanel, "");
            hero_icon.AddClass("hero_icon");
            hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + full_data.hero_3 + '.png" );'
            hero_icon.style.backgroundSize = "100%"
        }
    }
    if (Number(id4) != 0)
    {
       $.CreatePanel("DOTAAvatarImage", AvatarNicknamePanel, "AvatarLeaderboard", { style: "width:32px;height:32px;vertical-align:center;margin-left:10px;", accountid: id4 }); 
       if (pve && full_data.hero_4)
        {
            let hero_icon = $.CreatePanel("Panel", AvatarNicknamePanel, "");
            hero_icon.AddClass("hero_icon");
            hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + full_data.hero_4 + '.png" );'
            hero_icon.style.backgroundSize = "100%"
        }
    }

    var Rating = $.CreatePanel("Label", Line, "");
    Rating.AddClass("RatingLabel");
    Rating.text = String(rating)

    if (pve)
    {
        Rating.style.color = "orange";
    }

    let rewards_list = $.CreatePanel("Panel", Line, "");
    rewards_list.AddClass("rewards_list");
    
    let rewardData = {

        //  1: { amount: "2500", hasEffect: true },
        //  2: { amount: "2000", hasEffect: true },
        //  3: { amount: "1500", hasEffect: true },
        //  range4_10: { amount: "750", hasEffect: true },
        //  range11_50: { amount: "500", hasEffect: false },
        //  range51_100: { amount: "250", hasEffect: false }

        1: { amount: "5000", hasEffect: true },
        2: { amount: "4000", hasEffect: true },
        3: { amount: "3000", hasEffect: true },
        range4_10: { amount: "1500", hasEffect: true },
        range11_50: { amount: "1000", hasEffect: false },
        range51_100: { amount: "500", hasEffect: false }
    };

    // Выбираем нужные данные награды
    let currentReward;
    if (number >= 51 && number <= 100) {
        currentReward = rewardData.range51_100;
    } else if (number >= 11 && number <= 50) {
        currentReward = rewardData.range11_50;
    } else if (number >= 4 && number <= 10) {
        currentReward = rewardData.range4_10;
    } else if (number == 3) {
        currentReward = rewardData[3];
    } else if (number == 2) {
        currentReward = rewardData[2];
    } else if (number == 1) {
        currentReward = rewardData[1];
    }

    if (currentReward)
    {
        if (currentReward.hasEffect) 
        {
            let effect_icon = $.CreatePanel("Panel", rewards_list, "");
            effect_icon.AddClass("effect_icon");
            effect_icon.style.backgroundImage = 'url( "file://{images}/custom_game/shop/emblem_130.png" )';
            effect_icon.style.backgroundSize = "100%"
            SetIconInfo(effect_icon, "emblem_130", "emblem_130_open")
            GameUI.CustomUIConfig().OpenCheckoutItemPreview(effect_icon, [1074, null, null, "emblem_130", "emblem_130", null], true)
        }

        let money_reward = $.CreatePanel("Panel", rewards_list, "");
        money_reward.AddClass("money_reward");

        SetTextInfo(money_reward, "coin_reward_information_leaderboard")

        let coin_icon = $.CreatePanel("Panel", money_reward, "");
        coin_icon.AddClass("coin_icon");

        let coin_number = $.CreatePanel("Label", money_reward, "");
        coin_number.AddClass("coin_number");
        coin_number.text = currentReward.amount;
    }
}

function ChangeRanKingPanel(mode)
{
    $("#PanelButPVE").SetHasClass("ButtonRatActive", false)
    $("#PanelButPVP").SetHasClass("ButtonRatActive", false)
    $("#PvpInfo").style.visibility = "collapse"
    $("#PveInfo").style.visibility = "collapse"
    if (mode == "pvp")
    {
        $("#PanelButPVP").SetHasClass("ButtonRatActive", true)
        $("#PvpInfo").style.visibility = "visible"
    }
    if (mode == "pve")
    {
        $("#PanelButPVE").SetHasClass("ButtonRatActive", true)
        $("#PveInfo").style.visibility = "visible"
    }
}

function ChangeRankingPve(mode)
{
    $("#PanelButPVE_1").SetHasClass("ButtonRatActive", false)
    $("#PanelButPVE_2").SetHasClass("ButtonRatActive", false)
    $("#PanelButPVE_3").SetHasClass("ButtonRatActive", false)
    $("#PanelButPVE_4").SetHasClass("ButtonRatActive", false)
    $("#PlayersTablePVE1").visible = false
    $("#PlayersTablePVE2").visible = false
    $("#PlayersTablePVE3").visible = false
    $("#PlayersTablePVE4").visible = false
    $("#PanelButPVE_"+mode).SetHasClass("ButtonRatActive", true)
    $("#PlayersTablePVE"+mode).visible = true
}

function SetTextInfo(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, $.Localize("#" + text)); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function SetIconInfo(panel, text, image)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTitleImageTextTooltip', panel, $.Localize("#" + text), "file://{images}/custom_game/shop/" + image + ".png", $.Localize("#" + text + "_description")) });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTitleImageTextTooltip', panel);
    });       
}

function InitTopHeroesPve(data)
{
    for (let i in data["hero"])
    {
        let hero_data = data["hero"][i]
        CreateHeroPanel(Number(i), hero_data.hero, hero_data.wave_count, hero_data.player_id, hero_data.players || []);
    }
}

function CreateHeroPanel(number, hero_name, record, player_id, players)
{
    var HeroBlock = $.CreatePanel("Panel", $("#PlayersTablePVE4"), "");
    HeroBlock.AddClass("HeroSoloBlock");

    var Line = $.CreatePanel("Panel", HeroBlock, "");
    Line.AddClass("LinePlayer");
    Line.AddClass("HeroSoloLine");
    Line.SetPanelEvent('onactivate', function() { ToggleHeroSoloPlayers(HeroBlock, players, hero_name); });

    var RankPanel = $.CreatePanel("Panel", Line, "");
    RankPanel.AddClass("RankPanel");

    var RankImage = $.CreatePanel("Panel", RankPanel, "");
    RankImage.AddClass("RankImage");

    let index = number >= 1 && number <= 10 ? 1 : number <= 50 ? 2 : number <= 100 ? 3 : null;
    if (index) 
    { 
        RankImage.style.backgroundImage = `url("file://{images}/custom_game/leaderboard/rating${index}.png")`;
        RankImage.style.backgroundSize = "100%" 
    }
    else 
    {
        RankImage.style.opacity = 1;
    }

    var Rank_number = $.CreatePanel("Label", RankImage, "");
    Rank_number.AddClass("Rank_number");
    Rank_number.text = number

    var AvatarNicknamePanel = $.CreatePanel("Panel", Line, "");
    AvatarNicknamePanel.AddClass("AvatarNicknamePanel");
    $.CreatePanel("DOTAAvatarImage", AvatarNicknamePanel, "AvatarLeaderboard", { style: "width:32px;height:32px;vertical-align:center;", accountid: player_id });

    let hero_icon = $.CreatePanel("Panel", AvatarNicknamePanel, "");
    hero_icon.AddClass("hero_icon");
    hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + hero_name + '.png" );'
    hero_icon.style.backgroundSize = "100%"

    $.CreatePanel("DOTAUserName", AvatarNicknamePanel, "NickNameLeaderboard", { style: "vertical-align:center;margin-left:10px;height: 20px;", accountid: player_id });

    var Rating = $.CreatePanel("Label", Line, "");
    Rating.AddClass("RatingLabel");
    Rating.text = String(record)
    Rating.style.color = "orange";

    let rewards_list = $.CreatePanel("Panel", Line, "");
    rewards_list.AddClass("rewards_list");

    let rewardData = 
    {
        // 1: { amount: "500", hasEffect: true },
        // 2: { amount: "500", hasEffect: true },
        // 3: { amount: "500", hasEffect: true },
        // range4_10: { amount: "500", hasEffect: true },
        // range11_50: { amount: "500", hasEffect: true },
        // range51_100: { amount: "500", hasEffect: true }

        1: { amount: "2500", hasEffect: true },
        2: { amount: "2500", hasEffect: true },
        3: { amount: "2500", hasEffect: true },
        range4_10: { amount: "2500", hasEffect: true },
        range11_50: { amount: "2500", hasEffect: true },
        range51_100: { amount: "2500", hasEffect: true }
    };

    // Выбираем нужные данные награды
    let currentReward;
    if (number >= 51 && number <= 100) {
        currentReward = rewardData.range51_100;
    } else if (number >= 11 && number <= 50) {
        currentReward = rewardData.range11_50;
    } else if (number >= 4 && number <= 10) {
        currentReward = rewardData.range4_10;
    } else if (number == 3) {
        currentReward = rewardData[3];
    } else if (number == 2) {
        currentReward = rewardData[2];
    } else if (number == 1) {
        currentReward = rewardData[1];
    }

    if (currentReward)
    {
        if (currentReward.hasEffect) 
        {
            let effect_icon = $.CreatePanel("Panel", rewards_list, "");
            effect_icon.AddClass("effect_icon");
            effect_icon.style.backgroundImage = 'url( "file://{images}/custom_game/shop/emblem_131.png" )';
            effect_icon.style.backgroundSize = "100%"
            SetIconInfo(effect_icon, "emblem_131", "emblem_131_open")
            GameUI.CustomUIConfig().OpenCheckoutItemPreview(effect_icon, [1075, null, null, "emblem_131", "emblem_131", null], true)
        }

        let money_reward = $.CreatePanel("Panel", rewards_list, "");
        money_reward.AddClass("money_reward");

        SetTextInfo(money_reward, "coin_reward_information_leaderboard")

        let coin_icon = $.CreatePanel("Panel", money_reward, "");
        coin_icon.AddClass("coin_icon");

        let coin_number = $.CreatePanel("Label", money_reward, "");
        coin_number.AddClass("coin_number");
        coin_number.text = currentReward.amount;
    }
}
function ToggleHeroSoloPlayers(hero_block, players, hero_name)
{
    let players_panel = hero_block.hero_players_panel;
    if (!players_panel)
    {
        players_panel = $.CreatePanel("Panel", hero_block, "");
        players_panel.AddClass("HeroSoloPlayers");
        players_panel.visible = false;
        hero_block.hero_players_panel = players_panel;
        CreateHeroSoloPlayers(players, players_panel, hero_name);
    }

    let should_open = !players_panel.visible;
    if (OpenedHeroSoloPanel && OpenedHeroSoloPanel != players_panel)
    {
        OpenedHeroSoloPanel.visible = false;
        OpenedHeroSoloPanel.GetParent().SetHasClass("HeroSoloOpen", false);
    }

    players_panel.visible = should_open;
    hero_block.SetHasClass("HeroSoloOpen", should_open);
    OpenedHeroSoloPanel = should_open ? players_panel : null;
}

function CreateHeroSoloPlayers(players, panel, hero_name)
{
    if (!players)
    {
        return;
    }

    let players_list = [];
    for (let key in players)
    {
        if (players[key])
        {
            players_list.push(players[key]);
        }
    }

    players_list.sort(function(a, b) {
        return Number(b.wave_count || 0) - Number(a.wave_count || 0);
    });

    for (let i = 1; i < players_list.length && i < 10; i++)
    {
        let player_data = players_list[i];
        CreateHeroSoloPlayer(i + 1, player_data.player_id, player_data.wave_count, panel, hero_name);
    }
}

function CreateHeroSoloPlayer(number, steam_id, record, panel, hero_name)
{
    var Line = $.CreatePanel("Panel", panel, "");
    Line.AddClass("LinePlayer");
    Line.AddClass("HeroSoloPlayerLine");

    var RankPanel = $.CreatePanel("Panel", Line, "");
    RankPanel.AddClass("RankPanel");

    var RankImage = $.CreatePanel("Panel", RankPanel, "");
    RankImage.AddClass("RankImage");
    RankImage.style.opacity = 1;

    var Rank_number = $.CreatePanel("Label", RankImage, "");
    Rank_number.AddClass("Rank_number");
    Rank_number.text = number;

    var AvatarNicknamePanel = $.CreatePanel("Panel", Line, "");
    AvatarNicknamePanel.AddClass("AvatarNicknamePanel");
    $.CreatePanel("DOTAAvatarImage", AvatarNicknamePanel, "AvatarLeaderboard", { style: "width:32px;height:32px;vertical-align:center;", accountid: steam_id });
    let hero_icon = $.CreatePanel("Panel", AvatarNicknamePanel, "");
    hero_icon.AddClass("hero_icon");
    hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + hero_name + '.png" );'
    hero_icon.style.backgroundSize = "100%"
    $.CreatePanel("DOTAUserName", AvatarNicknamePanel, "NickNameLeaderboard", { style: "vertical-align:center;margin-left:10px;height: 20px;", accountid: steam_id });

    var Rating = $.CreatePanel("Label", Line, "");
    Rating.AddClass("RatingLabel");
    Rating.text = String(record);
    Rating.style.color = "orange";

    let rewards_list = $.CreatePanel("Panel", Line, "");
    rewards_list.AddClass("rewards_list");
}

// tp_effect_5
// tp_effect_6