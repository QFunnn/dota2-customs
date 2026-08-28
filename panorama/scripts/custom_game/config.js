--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// 设置面板
GameEvents.Subscribe("show_config", ShowConfig);
GameEvents.Subscribe("update_config", UpdateConfig);

function ShowConfig() {
    $('#panel_config').ToggleClass('show');
}

function CloseConfig() {
    $('#panel_config').SetHasClass('show', false);
}

function UpdateConfig() {
    var setting = CustomNetTables.GetTableValue("setting_table", 'show_settings');
    if (!setting) {
        return;
    }
    var local_id = Game.GetPlayerInfo(Players.GetLocalPlayer()).player_steamid;
    var my_setting = setting[local_id];
    if (my_setting) {
        if (parseInt(my_setting.is_click_select) == 0) {
            $('#toggle_select').SetSelected(false);
            GameEvents.SendCustomGameEventToServer("user_settings_update", {
                "key": "is_click_select",
                "value": 0,
                "hehe": Date.now(),
            });
        }
        else {
            $('#toggle_select').SetSelected(true);
            GameEvents.SendCustomGameEventToServer("user_settings_update", {
                "key": "is_click_select",
                "value": 1,
                "hehe": Date.now(),
            });
        }
        if (parseInt(my_setting.is_auto_combine) == 0) {
            $('#toggle_combine').SetSelected(false);
        }
        else {
            $('#toggle_combine').SetSelected(true);
        }
        // if (parseInt(my_setting.is_fog_show) == 0) {
        //     $('#toggle_fog').SetSelected(false);
        // }
        // else {
        //     $('#toggle_fog').SetSelected(true);
        // }
        if (parseInt(my_setting.is_auto_ai||1) == 0) {
            $('#toggle_auto_ai').SetSelected(false);
        }
        else {
            $('#toggle_auto_ai').SetSelected(true);
            // 显示宠物托管按钮
            if (FindDotaHudElement('petgpt_button')){
                FindDotaHudElement('petgpt_button').visible = true;
            }
        }
    }
}

function ToggleFog() {
    //通知lua设置改变了
    GameEvents.SendCustomGameEventToServer("user_settings_update", {
        "key": "is_fog_show",
        "value": $('#toggle_fog').checked ? 1 : 0,
        "hehe": Date.now(),
    });
}

function ToggleSelect() {
    if (!$('#toggle_select').checked) {
        GameUI.SelectUnit(-1, false);
    }
    //通知lua设置改变了
    GameEvents.SendCustomGameEventToServer("user_settings_update", {
        "key": "is_click_select",
        "value": $('#toggle_select').checked ? 1 : 0,
        "hehe": Date.now(),
    });
}

function ToggleCombine() {
    //通知lua设置改变了
    GameEvents.SendCustomGameEventToServer("user_settings_update", {
        "key": "is_auto_combine",
        "value": $('#toggle_combine').checked ? 1 : 0,
        "hehe": Date.now(),
    });
}

function ToggleAutoAI() {
    //通知lua设置改变了
    GameEvents.SendCustomGameEventToServer("user_settings_update", {
        "key": "is_auto_ai",
        "value": $('#toggle_auto_ai').checked ? 1 : 0,
        "hehe": Date.now(),
    });
}

function OnTP() {
    CloseConfig();
    GameEvents.SendCustomGameEventToServer("courier_tp", {
        "hehe": Date.now(),
    });
}

function OnGGSimida() {
    CloseConfig();
    show_confirm($.Localize('#text_confirm_ggsimida'), function(){
        GGSimida();
    });
}

function GGSimida() {
    close_confirm();
    GameEvents.SendCustomGameEventToServer("gg_simida", {
        "hehe": Date.now(),
        "key": CLIENT_KEY,
    });
}

function OnSuggestLiuju() {
    if (FindDotaHudElement('button_liuju').BHasClass('unavailable') == true){
        return;
    }
    show_confirm($.Localize('#' + 'confirm_suggest_liuju'), function () {
        SuggestLiuju();
    });
}
function SuggestLiuju() {
    close_confirm();
    GameEvents.SendCustomGameEventToServer("suggest_liuju",
    {
        "player_id": Players.GetLocalPlayer(),
        "hehe": Date.now()
    });
}