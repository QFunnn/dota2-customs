--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var favourites = new Array();
var nowrings = 9;
var selected_sound_current = undefined;
var nowselect = 0;
var current_button

var rings = new Array(
    new Array(//0 start
        new Array("","","","","","","",""),
        new Array(true,true,true,true,true,true,true,true),
    ),
);

function StartWheel() {
    selected_sound_current = undefined;
    $("#Wheel").visible = true;
    $("#Bubble").visible = true;
    $("#PhrasesContainer").visible = true;
    $("#PhrasesContainer").RemoveAndDeleteChildren();

    for ( var i = 0; i < 9; i++ )
    {
        $.CreatePanel(`Button`, $("#PhrasesContainer"), `Phrase${i}`, {
            class: `MyPhrases`,
            onmouseover: `OnMouseOver(${i})`,
            onmouseout: `OnMouseOut(${i})`,
        });
        $("#Phrase"+i).BLoadLayoutSnippet("Phrase");
        //$("#Phrase"+i).GetChild(0).GetChild(0).visible = rings[0][1][i];

        let sounds_table = CustomNetTables.GetTableValue("custom_sounds", "sounds")
        let name = ""
        let level = 1
        if (sounds_table)
        {
            if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))])
            {
                if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1])
                {
                    if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][2])
                    {
                        name = String(sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][2])
                        level = String(sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][1])
                    }
                }
            }
        }

        var player_data_local = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());
            var hero_name = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ));
        if (player_data_local)
        {
            if (player_data_local["heroes_data"])
            {
                if (player_data_local["heroes_data"][Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))])
                {
                   if ((player_data_local.subscribed == 0) || (Number(player_data_local["heroes_data"][Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))]["tier"]) < Number(level))
                     || (player_data_local.heroes_data[hero_name] && player_data_local.heroes_data[hero_name].has_level == 0))
                    {
                        $("#Phrase"+i).style.brightness = 0.2
                    }
                }
            }
        }

        $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(0).text = $.Localize('#'+name);
        $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + (level) + '_png.vtex")'
        $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundSize = "100%"
    }
}

function StopWheel() {
    $("#Wheel").visible = false;
    $("#Bubble").visible = false;
    $("#PhrasesContainer").visible = false;

    let sounds_table = CustomNetTables.GetTableValue("custom_sounds", "sounds")
    if (sounds_table)
    {
        if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))])
        {
            if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][selected_sound_current+1])
            {
                if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][selected_sound_current+1][2])
                {
                    GameEvents.SendCustomGameEventToServer_custom("SelectHeroVO", {num: String(sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][selected_sound_current+1][2]), name : String(sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][selected_sound_current+1][2])});
                }
            }
        }
    }

    if (nowselect != 0)
    {
        $("#PhrasesContainer").RemoveAndDeleteChildren();
        for ( var i = 0; i < 9; i++ )
        {
            $.CreatePanel(`Button`, $("#PhrasesContainer"), `Phrase${i}`, {
                class: `MyPhrases`,
                onmouseover: `OnMouseOver(${i})`,
                onmouseout: `OnMouseOut(${i})`,
            });
            $("#Phrase"+i).BLoadLayoutSnippet("Phrase");
            $("#Phrase"+i).GetChild(0).GetChild(0).visible = rings[0][1][i];

            let sounds_table = CustomNetTables.GetTableValue("custom_sounds", "sounds")
            let name = ""
            let level = 1
            if (sounds_table)
            {
                if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))])
                {
                    if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1])
                    {
                        if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][2])
                        {
                            name = String(sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][2])
                            level = String(sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][1])
                        }
                    }
                }
            }

            var player_data_local = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());
            var hero_name = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ));
            if (player_data_local)
            {
                if (player_data_local["heroes_data"])
                {
                    if (player_data_local["heroes_data"][Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))])
                    {
                        if ((player_data_local.subscribed == 0) ||(Number(player_data_local["heroes_data"][Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))]["tier"]) < Number(level))
                            || (player_data_local.heroes_data[hero_name] && player_data_local.heroes_data[hero_name].has_level == 0))
                        {
                            $("#Phrase"+i).style.brightness = 0.2
                        }
                    }
                }
            }

            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(0).text = $.Localize('#'+name);
            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + (level) + '_png.vtex")'
            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundSize = "100%"
        }
    }
    selected_sound_current = undefined;
}

function OnMouseOver(num) {
    selected_sound_current = num;
    $( "#WheelPointer" ).RemoveClass( "Hidden" );
    $( "#Arrow" ).RemoveClass( "Hidden" );
    for ( var i = 0; i < 9; i++ )
    {
        if ($("#Wheel").BHasClass("ForWheel"+i))
            $( "#Wheel" ).RemoveClass( "ForWheel"+i );
    }
    $( "#Wheel" ).AddClass( "ForWheel"+num );
}

function OnMouseOut(num) {
    selected_sound_current = undefined;
    $( "#WheelPointer" ).AddClass( "Hidden" );
    $( "#Arrow" ).AddClass( "Hidden" );
}

(function() {
	GameUI.CustomUIConfig().chatWheelLoaded = true;

    for ( var i = 0; i < 9; i++ )
    {
        $.CreatePanel(`Button`, $("#PhrasesContainer"), `Phrase${i}`, {
            class: `MyPhrases`,
            onmouseover: `OnMouseOver(${i})`,
            onmouseout: `OnMouseOut(${i})`,
        });
        $("#Phrase"+i).BLoadLayoutSnippet("Phrase");
        //$("#Phrase"+i).GetChild(0).GetChild(0).visible = rings[0][1][i];

        let sounds_table = CustomNetTables.GetTableValue("custom_sounds", "sounds")
        let name = ""
        let level = 1
        if (sounds_table)
        {
            if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))])
            {
                if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1])
                {
                    if (sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][2])
                    {
                        name = String(sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][2])
                        level = String(sounds_table[Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))][i+1][1])
                    }
                }
            }
        }

        var player_data_local = CustomNetTables.GetTableValue("sub_data", Players.GetLocalPlayer());
        if (player_data_local)
        {
            if (player_data_local["heroes_data"])
            {
                if (player_data_local["heroes_data"][Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))])
                {
                    if (Number(player_data_local["heroes_data"][Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ))]["tier"]) < Number(level))
                    {
                        $("#Phrase"+i).style.brightness = 0.2
                    }
                }
            }
        }

        $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(0).text = $.Localize('#'+name);
        $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + (level) + '_png.vtex")'
        $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundSize = "100%"
    }

    const name_bind = "WheelHeroButton" + Math.floor(Math.random() * 99999999);
    Game.AddCommand("+" + name_bind, StartWheel, "", 0);
    Game.AddCommand("-" + name_bind, StopWheel, "", 0);
    Game.CreateCustomKeyBind(GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_CHAT_WHEEL), '+' + name_bind);


    current_button = GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_CHAT_WHEEL)
    SetBindInterval()


    $("#Wheel").visible = false;
    $("#Bubble").visible = false;
    $("#PhrasesContainer").visible = false;
})();

GameEvents.Subscribe_custom( 'chat_dota_sound', ChatSound );


var team_color =
{
    2 : [101, 183, 235],
    3 : [254, 138, 24],
    6 : [125, 232, 144],
    7 : [227, 61, 227],
    8 : [255, 158, 158],
    9 : [222, 209, 35],
}


function ChatSound( data )
{
    let dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
    let Hudchat = dotaHud.FindChildTraverse("HudChat")
    let LinesPanel = $("#PhraseChatContainer2")
    let is_duo_game = false
    if (true)
    {
        is_duo_game = true
    }   
    if (is_duo_game)
    {
        LinesPanel = Hudchat.FindChildTraverse("ChatLinesPanel")
    }
    let hero_icon = "file://{images}/heroes/" + Game.GetHeroImage(data.player_id, data.hero_name) + ".png"
    let player_name = Players.GetPlayerName( data.player_id )
    let sound_name = $.Localize(data.sound_name)
    let color = "white;"
    let hero_tier =  "s2r://panorama/images/hero_badges/hero_badge_rank_" + data.tier + "_tiny_png.vtex"
    let phase_tier = data.phase_tier
    let phrase_color = "white;"
    if (Game.IsPlayerMuted( data.player_id ) || Game.IsPlayerMutedVoice( data.player_id ) || Game.IsPlayerMutedText( data.player_id )) 
    {
        return
    }
    let playerInfo = Game.GetPlayerInfo( data.player_id );
    if ( playerInfo )
    {
        var table_color = team_color[ playerInfo.player_team_id ] 
        if (table_color)
        {
            color = "rgb(" + table_color[0] + "," + table_color[1] + "," + table_color[2] + ")"
        }
    }

    Game.EmitSound(data.sound_name_global)

    let player_color_style = "font-size:18px;font-weight:bold;text-shadow: 1px 1.5px 0px 2 black;color:" + color + ";"
    let dot_color = "font-size:18px;font-weight:bold;text-shadow: 1px 1.5px 0px 2 black;color:white;"

    if (phase_tier == 0)
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #c0501a ), to( #f49327 ) );"
    } 
    else if (phase_tier == 1) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #b4e1f0 ), to( #85b6c7 ) );"
    } 
    else if (phase_tier == 2) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #c0911d ), to( #e8c216 ) );"
    } 
    else if (phase_tier == 3) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #6a98ed ), to( #32cdcf ) );"
    } 
    else if (phase_tier == 4) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #da250f ), to( #e0b816 ) );"
    } 
    else if (phase_tier == 5) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #cc743e ), to( #fee1ae ) );"
    }

    let phase_label_color_style = "font-size:18px;margin-left:5px;font-weight:bold;text-shadow: 1px 1.5px 0px 2 black;color:" + phrase_color
    let style_original = "margin-left:37px;flow-children: right;width:100%;vertical-align:bottom;transition-property: opacity;transition-duration: 0.1s;padding-top: 2px;"
    if (is_duo_game)
    {
        style_original = "margin-left:5px;flow-children: right;width:100%;vertical-align:bottom;transition-property: opacity;transition-duration: 0.1s;padding-top: 2px;"
    }

    let ChatPanelSound = $.CreatePanel("Panel", LinesPanel, "", { style: style_original });
    //let HeroTier = $.CreatePanel("Image", ChatPanelSound, "", { src:`${hero_tier}`, style:"width:32px;height:32px;margin-right:0px;margin-top:-5px;margin-bottom:-5px;" }); 
    let HeroIcon = $.CreatePanel("Image", ChatPanelSound, "", { src:`${hero_icon}`, style:"width:40px;height:23px;margin-right:12px;border:1px solid black;" }); 
    let LabelPlayer = $.CreatePanel("Label", ChatPanelSound, "", { text:`${player_name}`, style:`${player_color_style}` });
    let dots = $.CreatePanel("Label", ChatPanelSound, "", { text:":", style:`${dot_color}` });
    let SoundIcon = $.CreatePanel("Image", ChatPanelSound, "", { class:"ChatWheelIcon", style:"width:20px;height:20px;", src:"file://{images}/hud/reborn/icon_scoreboard_mute_sound.psd" }); 
    let LabelSound = $.CreatePanel("Label", ChatPanelSound, "", { text:`${sound_name}`, style:`${phase_label_color_style}`});

    if (is_duo_game)
    {
        $.Schedule( 7, function()
        {
            ChatPanelSound.AddClass("ChatLine")
            ChatPanelSound.AddClass("Expired")
        })
    }
    else
    {
        $.Schedule( 7, function()
        {
            if (ChatPanelSound) 
            {
                ChatPanelSound.style.opacity = "0";  
            }
        })
        ChatPanelSound.DeleteAsync(8)
    }
} 

$.RegisterForUnhandledEvent("StyleClassesChanged", ClearChatBadgesEvent );

function ClearChatBadgesEvent(panel)
{
	if (panel == null) { return }
    if (panel.paneltype != "Label") { return }
	if (panel.BHasClass("ChatLine"))
    {
        let HeroBadges = panel.FindChildrenWithClassTraverse( "HeroBadge" )
        for (let badge of HeroBadges)
        {
            badge.visible = false
        }
    }
}

function GetGameKeybind(command) {
    return Game.GetKeybindForCommand(command);
}

function SetBindInterval()
{
    if (GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_CHAT_WHEEL) != current_button)
    {
        const name_bind = "WheelHeroButton" + Math.floor(Math.random() * 99999999);
        Game.AddCommand("+" + name_bind, StartWheel, "", 0);
        Game.AddCommand("-" + name_bind, StopWheel, "", 0);
        Game.CreateCustomKeyBind(GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_CHAT_WHEEL), '+' + name_bind);
        current_button = GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_CHAT_WHEEL)
    }
    $.Schedule( 1, SetBindInterval );
}