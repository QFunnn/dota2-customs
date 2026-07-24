--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var favourites = new Array();
var nowrings = 8;
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

    for ( var i = 0; i < 8; i++ )
    {
        $.CreatePanel(`Button`, $("#PhrasesContainer"), `Phrase${i}`, {
            class: `MyPhrases`,
            onmouseover: `OnMouseOver(${i})`,
            onmouseout: `OnMouseOut(${i})`,
        });
        $("#Phrase"+i).BLoadLayoutSnippet("Phrase");
        $("#Phrase"+i).GetChild(0).GetChild(0).visible = rings[0][1][i];

        let name = ""
        var player_table = CustomNetTables.GetTableValue("players_chat_wheel", String(Players.GetLocalPlayer()))
        var player_table_sub = CustomNetTables.GetTableValue("sub_data", String(Players.GetLocalPlayer()))
        let sounds_table = CustomNetTables.GetTableValue("custom_sounds", "sounds")
        let item_id = 0

        if (player_table)
        {
            if (sounds_table["general_ru"])
            {
                for (var sound = 1; sound <= Object.keys(sounds_table["general_ru"]).length; sound++)
                {
                    if (String(sounds_table["general_ru"][sound][1]) == String(player_table[i+1]) )
                    {
                        name = name = $.Localize("#" + String(sounds_table["general_ru"][sound][2]))
                        item_id = sounds_table["general_ru"][sound][1]
                    }
                }
            }
            if (sounds_table["general_eng"])
            {
                for (var sound = 1; sound <= Object.keys(sounds_table["general_eng"]).length; sound++)
                {
                    if (String(sounds_table["general_eng"][sound][1]) == String(player_table[i+1]) )
                    {
                        name = name = $.Localize("#" + String(sounds_table["general_eng"][sound][2]))
                        item_id = sounds_table["general_eng"][sound][1]
                    }
                }
            }
            if (sounds_table["general_other"])
            {
                for (var sound = 1; sound <= Object.keys(sounds_table["general_other"]).length; sound++)
                {
                    if (String(sounds_table["general_other"][sound][1]) == String(player_table[i+1]) )
                    {
                        name = name = $.Localize("#" + String(sounds_table["general_other"][sound][2]))
                        item_id = sounds_table["general_other"][sound][1]
                    }
                }
            }
        }

        if (!HasItemInventory(item_id))
        {
            $("#Phrase"+i).style.brightness = 0.2
        }

        $("#Phrase"+i).GetChild(0).GetChild(0).text = name;
    }
}

function HasItemInventory(item_id)
{
    let player_table = CustomNetTables.GetTableValue("sub_data", String(Players.GetLocalPlayer()))
    if (player_table && player_table.items_ids)
    {
        for (var d = 1; d <= Object.keys(player_table.items_ids).length; d++) 
        {
            if (player_table.items_ids[d])
            {
                if (String(player_table.items_ids[d]) == String(item_id))
                {
                    return true
                }
            }
        }
    }
    return false
}

function StopWheel() {
    $("#Wheel").visible = false;
    $("#Bubble").visible = false;
    $("#PhrasesContainer").visible = false;

    var player_table_chat_wheel = CustomNetTables.GetTableValue("players_chat_wheel", String(Players.GetLocalPlayer()))
    if (player_table_chat_wheel)
    {
        if (player_table_chat_wheel)
        {
            GameEvents.SendCustomGameEventToServer_custom("SelectVO", {num: Number(player_table_chat_wheel[selected_sound_current+1])});
        }
    }
    selected_sound_current = undefined;
}

function OnMouseOver(num) {
    selected_sound_current = num;
    $( "#WheelPointer" ).RemoveClass( "Hidden" );
    $( "#Arrow" ).RemoveClass( "Hidden" );
    for ( var i = 0; i < 8; i++ )
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
    const name_bind = "DefaultWheelButton" + Math.floor(Math.random() * 99999999);
    Game.AddCommand("+" + name_bind, StartWheel, "", 0);
    Game.AddCommand("-" + name_bind, StopWheel, "", 0);
    Game.CreateCustomKeyBind(GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL), '+' + name_bind);


    current_button = GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL)
    SetBindInterval()


    $("#Wheel").visible = false;
    $("#Bubble").visible = false;
    $("#PhrasesContainer").visible = false;
})();

function GetGameKeybind(command) {
    return Game.GetKeybindForCommand(command);
}




function SetBindInterval()
{
    if (GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL) != current_button)
    {
        const name_bind = "DefaultWheelButton" + Math.floor(Math.random() * 99999999);
        Game.AddCommand("+" + name_bind, StartWheel, "", 0);
        Game.AddCommand("-" + name_bind, StopWheel, "", 0);
        Game.CreateCustomKeyBind(GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL), '+' + name_bind);
        current_button = GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL)
    }
    $.Schedule( 1, SetBindInterval );
}