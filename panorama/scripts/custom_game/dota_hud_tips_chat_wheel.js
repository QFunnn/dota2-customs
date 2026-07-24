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

        var player_table_sub = CustomNetTables.GetTableValue("sub_data", String(Players.GetLocalPlayer()))
        let item_id = 0

        if (player_table_sub && player_table_sub.player_tips)
        {
            player_table_sub.player_tips[0] = 0
            item_id = Number(player_table_sub.player_tips[i])

            if (player_table_sub.selected_tip == i)
            {
                $("#Phrase"+i).GetChild(0).AddClass("Phrase_chosen")
            }else 
            {
                $("#Phrase"+i).GetChild(0).RemoveClass("Phrase_chosen")
            }
        }


        let icon = GetIcon(item_id)

        $("#Phrase"+i).GetChild(0).GetChild(0).style.backgroundImage = 'url("' + icon + '")';
	    $("#Phrase"+i).GetChild(0).GetChild(0).style.backgroundSize = "100%"

        if (item_id == 0 && i != 0)
        {
            $("#Phrase"+i).GetChild(0).GetChild(0).visible = false
        }
    }
}

function GetIcon(item_id)
{
    let tips_info_table = CustomNetTables.GetTableValue("shop_items", "tips")
	for (var d = 1; d <= Object.keys(tips_info_table).length; d++) 
    {
        if (tips_info_table[d])
        {
            if (String(tips_info_table[d][2]) == String(item_id))
            {
                return tips_info_table[d][5]
            }
        }
    }
    return ""
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


    if (selected_sound_current !== undefined)
    {
        Game.EmitSound("UI.Click")
        GameEvents.SendCustomGameEventToServer_custom("select_current_tip", {tip_id: selected_sound_current});
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

var current_button

(function() {
	GameUI.CustomUIConfig().chatWheelLoaded = true;
    const name_bind = "TipsWheelButton" + Math.floor(Math.random() * 99999999);
    Game.AddCommand("+" + name_bind, StartWheel, "", 0);
    Game.AddCommand("-" + name_bind, StopWheel, "", 0);
    Game.CreateCustomKeyBind(GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL2), '+' + name_bind);
    current_button = GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL2)
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
    if (GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL2) != current_button)
    {
        const name_bind = "TipsWheelButton" + Math.floor(Math.random() * 99999999);
        Game.AddCommand("+" + name_bind, StartWheel, "", 0);
        Game.AddCommand("-" + name_bind, StopWheel, "", 0);
        Game.CreateCustomKeyBind(GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL2), '+' + name_bind);
        current_button = GetGameKeybind(DOTAKeybindCommand_t.DOTA_KEYBIND_CHAT_WHEEL2)
    }
    $.Schedule( 1, SetBindInterval );
}