--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


/* 
    嘲讽表情， 覆盖dota2原有的
*/
GameEvents.Subscribe("drodo_emotion", OnShowDrodoEmotion);

var IS_EMOTION_IN_COOLDOWN = false;
function RequestSendEmotion(index) {
    if (IS_EMOTION_IN_COOLDOWN) {
        return;
    }
    GameEvents.SendCustomGameEventToServer("request_show_emotion_bubble", {
        emotion_index: index,
        player_id: Players.GetLocalPlayer(),
    });
    DisableSendEmotion();

    $.Schedule(10, function () {
        EnableSendEmotion();
    });
}
function EnableSendEmotion() {
    FindDotaHudElement('panel_emotion_box').style['brightness'] = '1';
    FindDotaHudElement('panel_emotion_box').style['saturation'] = '1';
    IS_EMOTION_IN_COOLDOWN = false;
}
function DisableSendEmotion() {
    FindDotaHudElement('panel_emotion_box').style['brightness'] = '0.1';
    FindDotaHudElement('panel_emotion_box').style['saturation'] = '0';
    IS_EMOTION_IN_COOLDOWN = true;
}

function OnShowDrodoEmotion(keys) {
    if ((keys.player_from || keys.player_from == 0) && Game.IsPlayerMuted(keys.player_from) == true) {
        return;
    }

    // 右侧UI气泡
    OnShowChatBubblePlayerBoard({
        player_from: keys.player_from,
        player_to: keys.player_to,
        emotion_index: keys.emotion_index,
    })
    // 信使头上气泡
    // DisplayBubble({
    // 	unit: Players.GetPlayerHeroEntityIndex(keys.player_from),
    // 	pic: keys.emotion_index,
    // });
    InitChatBubble(Players.GetPlayerHeroEntityIndex(keys.player_from), keys.emotion_index, null);

    // 客场镜像信使头上气泡
    if (keys.mirror_chesser_entindex) {
        // DisplayBubble({
        //     unit: keys.mirror_chesser_entindex,
        //     pic: keys.emotion_index,
        // });
        InitChatBubble(keys.mirror_chesser_entindex, keys.emotion_index, null);
    }

    // FindDotaHudElement('panel_emotion_box').SetHasClass('Visible', false);
    $('#panel_emotion_box').SetHasClass('invisible', true);
    $('#panel_emotion_box').style['opacity'] = '0';
    $('#panel_emotion_box').style['transform'] = 'scale3d( 0.01, 0.01, 0.01)';
}