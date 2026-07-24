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

var LEVELS_INFO =
{
    BronzeTier : 0,
    SilverTier : 1,
    GoldTier : 2,
    PlatinumTier : 3,
    MasterTier : 4,
    GrandmasterTier : 5,
}

var OTHER_PLAYER_DATA = {}
var PLAYER_DATA = Game.GetCustomTable("woda_player_data", String(Players.GetLocalPlayer()));

function GetHeroInformationOther(hero, player_id) {
    // Проверяем и загружаем данные игрока, если их нет в кэше
    if (!OTHER_PLAYER_DATA[player_id]) {
        OTHER_PLAYER_DATA[player_id] = Game.GetCustomTable("woda_player_data", String(player_id));
    }
    const playerData = OTHER_PLAYER_DATA[player_id];
    if (!playerData?.heroes_level) return null;
    // Используем Object.values для более чистого кода и find для поиска
    return Object.values(playerData.heroes_level).find(
        heroData => heroData.hero === hero
    ) || null;
}

function GetLevelByCoins(coins)
{
    let full_sum = 0
    let level_end = 30
    for (var cc = 0; cc <= Object.keys(levels).length; cc++) 
    {
        full_sum = full_sum + levels[cc]
        if (coins < full_sum)
        {
            level_end = cc - 1
            break
        }
    } 
    return level_end
}

function GetHeroInformation(hero) 
{
    let woda_player_data = PLAYER_DATA
    if (woda_player_data) 
    {
        for (var i = 1; i <= Object.keys(woda_player_data.heroes_level).length; i++) 
        {
            if (woda_player_data.heroes_level[i]["hero"] == hero) 
            {
                return woda_player_data.heroes_level[i]
            }
        }
    }
    return null
}

function GetPlayerRank(level) 
{
    if (level >= 30) 
    {
        return 6
    } else if (level >= 25) 
    {
        return 5
    } else if (level >= 18) 
    {
        return 4
    } else if (level >= 12) 
    {
        return 3
    } else if (level >= 6) 
    {
        return 2
    } else if (level >= 1) 
    {
        return 1
    } else 
    {
        return 0
    }
}

function StartWheel() 
{
    selected_sound_current = undefined;
    $("#Wheel").visible = true;
    $("#Bubble").visible = true;
    $("#PhrasesContainer").visible = true;
    $("#PhrasesContainer").RemoveAndDeleteChildren();
    let hero_id = String(Players.GetSelectedHeroID( Players.GetLocalPlayer() ))
    let player_info = Game.GetPlayerInfo(Players.GetLocalPlayer())
    let hero_name = player_info.player_selected_hero 
    let sounds_table = Game.GetCustomTable("hero_sounds", hero_id)
    if (!sounds_table) { return }
    let sounds_js = []
    for (let id in sounds_table)
    {
        let data = sounds_table[id]
        let name = data["label"]
        let level = LEVELS_INFO[data["unlock_hero_badge_tier"]]
        let message = data["message"]
        let sound = data["sound"]
        let message_id = data["message_id"]
        sounds_js.push([message_id, name, level, message, sound])
    }
    sounds_js.sort((a, b) => a[0] - b[0]);

    let player_rank = 0
    if (GetHeroInformationOther(hero_name, Players.GetLocalPlayer()) != null) 
    {
        let info = GetHeroInformation(hero_name)
        let hero_lvl = GetLevelByCoins(info.coins)
        player_rank = GetPlayerRank(hero_lvl)
    }

    for ( var i = 0; i < 9; i++ )
    {
        if (sounds_js[i])
        {
            let Phrase = $.CreatePanel(`Button`, $("#PhrasesContainer"), `Phrase${i}`, {
                class: `Phrase`,
                onmouseover: `OnMouseOver(${i})`,
                onmouseout: `OnMouseOut(${i})`,
            });
            $("#Phrase"+i).BLoadLayoutSnippet("Phrase");
            let name = ""
            let level = 0
            if (sounds_table)
            {
                name = sounds_js[i][1]
                level = sounds_js[i][2]
            }
            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(0).text = $.Localize(name);
            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + (level) + '_png.vtex")'
            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundSize = "100%"
            if (player_rank <= level)
            {
                Phrase.AddClass("LowLevelPlayer")
                let ChatWheelRequiredTierLockIconShadow = $.CreatePanel("Panel", $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1), "ChatWheelRequiredTierLockIconShadow");
                ChatWheelRequiredTierLockIconShadow.AddClass("ChatWheelRequiredTierLockIconShadow")
                let ChatWheelRequiredTierLockIcon = $.CreatePanel("Panel", $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1), "ChatWheelRequiredTierLockIcon");
                ChatWheelRequiredTierLockIcon.AddClass("ChatWheelRequiredTierLockIcon")
            }
            $("#HeroImage").heroname = hero_name
        }
    }
}

function StopWheel() {
    $("#Wheel").visible = false;
    $("#Bubble").visible = false;
    $("#PhrasesContainer").visible = false;

    let hero_id = String(Players.GetSelectedHeroID( Players.GetLocalPlayer() ))
    let sounds_table = Game.GetCustomTable("hero_sounds", hero_id)
    let sounds_js = []
    for (let id in sounds_table)
    {
        let data = sounds_table[id]
        let name = data["label"]
        let level = LEVELS_INFO[data["unlock_hero_badge_tier"]]
        let message = data["message"]
        let sound = data["sound"]
        let message_id = data["message_id"]
        sounds_js.push([message_id, name, level, message, sound])
    }
    sounds_js.sort((a, b) => a[0] - b[0]);
    
    if (selected_sound_current != undefined && sounds_js[selected_sound_current])
    {
        GameEvents.SendCustomGameEventToServer_custom("SelectHeroVO", {sound : sounds_js[selected_sound_current][4], name : sounds_js[selected_sound_current][1], message : sounds_js[selected_sound_current][3], sound_id : selected_sound_current, level : sounds_js[selected_sound_current][2]});
    }
    
    if (nowselect != 0)
    {
        $("#PhrasesContainer").RemoveAndDeleteChildren();
        for ( var i = 0; i < 9; i++ )
        {
            if (sounds_js[i])
            {
                $.CreatePanel(`Button`, $("#PhrasesContainer"), `Phrase${i}`, {
                    class: `MyPhrases`,
                    onmouseover: `OnMouseOver(${i})`,
                    onmouseout: `OnMouseOut(${i})`,
                });
                $("#Phrase"+i).BLoadLayoutSnippet("Phrase");
                let name = ""
                let level = 0
                if (sounds_table)
                {
                    name = sounds_js[i][1]
                    level = sounds_js[i][2]
                }
                $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(0).text = $.Localize(name);
                $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + (level) + '_png.vtex")'
                $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundSize = "100%"
            }
        }
    }
    selected_sound_current = undefined;
}

function OnMouseOver(num) {
    for ( var i = 0; i < 9; i++ )
    {
        if ($("#Wheel").BHasClass("ForWheel"+i))
            $( "#Wheel" ).RemoveClass( "ForWheel"+i );
    }
    if ($("#Phrase"+num).BHasClass("LowLevelPlayer")) { return }
    selected_sound_current = num;
    $( "#WheelPointer" ).RemoveClass( "Hidden" );
    $( "#Arrow" ).RemoveClass( "Hidden" );
    $( "#Wheel" ).AddClass( "ForWheel"+num );
}

function OnMouseOut(num) {
    selected_sound_current = undefined;
    $( "#WheelPointer" ).AddClass( "Hidden" );
    $( "#Arrow" ).AddClass( "Hidden" );
}

(function() {
	GameUI.CustomUIConfig().chatWheelLoaded = true;
    let hero_id = String(Players.GetSelectedHeroID( Players.GetLocalPlayer() ))
    let sounds_table = Game.GetCustomTable("hero_sounds", hero_id)
    let sounds_js = []
    for (let id in sounds_table)
    {
        let data = sounds_table[id]
        let name = data["label"]
        let level = LEVELS_INFO[data["unlock_hero_badge_tier"]]
        let message = data["message"]
        let sound = data["sound"]
        let message_id = data["message_id"]
        sounds_js.push([message_id, name, level, message, sound])
    }
    sounds_js.sort((a, b) => a[0] - b[0]);
    for ( var i = 0; i < 9; i++ )
    {
        if (sounds_js[i])
        {
            $.CreatePanel(`Button`, $("#PhrasesContainer"), `Phrase${i}`, {
                class: `MyPhrases`,
                onmouseover: `OnMouseOver(${i})`,
                onmouseout: `OnMouseOut(${i})`,
            });
            $("#Phrase"+i).BLoadLayoutSnippet("Phrase");
            let name = ""
            let level = 0
            if (sounds_table)
            {
                name = sounds_js[i][1]
                level = sounds_js[i][2]
            }
            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(0).text = $.Localize(name);
            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundImage = 'url("s2r://panorama/images/hero_badges/hero_badge_rank_' + (level) + '_png.vtex")'
            $("#Phrase"+i).GetChild(0).GetChild(0).GetChild(1).style.backgroundSize = "100%"
        }
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

function ChatSound( data )
{
    let dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()
	let Hudchat = dotaHud.FindChildTraverse("HudChat")
	let LinesPanel = Hudchat.FindChildTraverse("ChatLinesPanel")
    let hero_icon = "file://{images}/heroes/" + data.hero_name + ".png"
    let player_name = Players.GetPlayerName( data.player_id )
    let sound_name = $.Localize(data.sound_name_global)
    let color = "white;"
    let hero_tier =  "s2r://panorama/images/hero_badges/hero_badge_rank_" + data.level + "_tiny_png.vtex"
    let phase_tier = data.level
    let phrase_color = "white;"

    if (Game.IsPlayerMuted( data.player_id ) || Game.IsPlayerMutedVoice( data.player_id ) || Game.IsPlayerMutedText( data.player_id )) 
    {
        return
    }

    var colorInt = Players.GetPlayerColor( data.player_id );
    var colorString = "#" + intToARGB( colorInt );
    color = colorString + ";"

    Game.EmitSound(data.sound_name)

    let player_color_style = "font-size:18px;font-weight:bold;text-shadow: 1px 1.5px 0px 2 black;color:" + color

    if (phase_tier == 0)
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #c0501a ), to( #f49327 ) );"
    } else if (phase_tier == 1) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #b4e1f0 ), to( #85b6c7 ) );"
    } else if (phase_tier == 2) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #c0911d ), to( #e8c216 ) );"
    } else if (phase_tier == 3) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #6a98ed ), to( #32cdcf ) );"
    } else if (phase_tier == 4) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #da250f ), to( #e0b816 ) );"
    } else if (phase_tier == 5) 
    {
        phrase_color = "gradient( linear, 0% 0%, 100% 0%, from( #cc743e ), to( #fee1ae ) );"
    }

    let phase_label_color_style = "font-size:18px;margin-left:5px;font-weight:bold;text-shadow: 1px 1.5px 0px 2 black;color:" + phrase_color
    let ChatPanelSound = $.CreatePanel("Panel", LinesPanel, "", { style:"margin-left:37px;flow-children: right;width:100%;vertical-align:bottom;transition-property: opacity;transition-duration: 0.1s;" });
    let HeroIcon = $.CreatePanel("Image", ChatPanelSound, "", { src:`${hero_icon}`, style:"width:40px;height:23px;margin-right:4px;border:1px solid black;" }); 
    let LabelPlayer = $.CreatePanel("Label", ChatPanelSound, "", { text:`${player_name}` + ":", style:`${player_color_style}` });
    let SoundIcon = $.CreatePanel("Image", ChatPanelSound, "", { class:"ChatWheelIcon", style:"margin-left:4px;width:20px;height:20px;", src:"file://{images}/hud/reborn/icon_scoreboard_mute_sound.psd" }); 
    let LabelSound = $.CreatePanel("Label", ChatPanelSound, "", { text:`${sound_name}`, style:`${phase_label_color_style}`});

    $.Schedule( 7, function()
    {
        if (ChatPanelSound) 
        {
            ChatPanelSound.AddClass("ChatLine"); 
            ChatPanelSound.AddClass("Expired");  
        }
    })
} 
function GetGameKeybind(command) {
    return Game.GetKeybindForCommand(command);
}

GameEvents.Subscribe_custom("panorama_cooldown_error", function(data) 
{
    GameEvents.SendEventClientSide("dota_hud_error_message", 
    {
        "splitscreenplayer": 0,
        "reason": data.reason || 80,
        "message": $.Localize(data.message) + " " + data.time
    })
})

function intToARGB(i) 
{ 
            return ('00' + ( i & 0xFF).toString( 16 ) ).substr( -2 ) +
                                           ('00' + ( ( i >> 8 ) & 0xFF ).toString( 16 ) ).substr( -2 ) +
                                           ('00' + ( ( i >> 16 ) & 0xFF ).toString( 16 ) ).substr( -2 ) + 
                                            ('00' + ( ( i >> 24 ) & 0xFF ).toString( 16 ) ).substr( -2 );
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
    $.Schedule( 0.2, SetBindInterval );
}