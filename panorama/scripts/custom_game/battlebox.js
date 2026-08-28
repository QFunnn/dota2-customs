--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/* 
	战斗回合开始弹窗
*/
(function () {
	GameEvents.Subscribe("battle_info", OnBattleInfo);
	GameEvents.Subscribe("show_battle_box", OnShowBattleBox);
})();

function OnShowBattleBox(data) {
	if (!CheckClientKey(data.key)) return;
    $('#panel_battle_box_guest').SetHasClass('show',true);
	$('#panel_battle_box_host').SetHasClass('show',true);

	//显示BattleBox
	$.Msg(data);

    var type = data.type;
    if (type == "clound"){
        var host_steam_id = data.host_team_stat.steam_id;
        var guest_steam_id = data.text;
        $.Msg(host_steam_id);
        $.Msg(guest_steam_id);
        
    }

    

	$.Schedule(5,function(){
		$('#panel_battle_box_guest').SetHasClass('show',false);
		$('#panel_battle_box_host').SetHasClass('show',false);
	});
}

function OnBattleInfo(data) {
    if (!CheckClientKey(data.key)) return;
    CURR_HOST_OPPO = null;

    $('#panel_battle_0').visible = false;
    $('#panel_battle_1').visible = false;
    $('#panel_battle_2').visible = false;
    $('#panel_battle_3').visible = false;
    $('#panel_battle_4').visible = false;
    $('#panel_battle_5').visible = false;
    $('#panel_battle_6').visible = false;
    $('#panel_battle_7').visible = false;

    if (data.type == 'prepare') { // 准备中
        BATTLE_STATUS = 0;

        $('#round_battle').text = $.Localize('#' + data.text);
        $('#round_battle').SetPanelEvent(
            "onactivate",
            function () { }
        )
        $('#battle_icon').SetHasClass('invisible', true);
        $('#cloud_icon').SetHasClass('invisible', true);
        $('#creep_icon').SetHasClass('invisible', true);
        $('#round_battle').SetHasClass('invisible', false);
        $('#cloud_name').SetHasClass('invisible', true);
        $('#round_battle').style['color'] = '#fff';
    }
    else if (data.type == 'pve') { // pve
        BATTLE_STATUS = 1;
        $('#round_battle').text = $.Localize('#' + 'pve_' + data.text);
        $('#round_battle').SetPanelEvent(
            "onactivate",
            function () { }
        )
        $('#battle_icon').SetHasClass('invisible', true);
        $('#cloud_icon').SetHasClass('invisible', true);
        $('#creep_icon').SetHasClass('invisible', false);
        $('#round_battle').SetHasClass('invisible', false);
        $('#round_battle').style['color'] = '#fff';
        $('#cloud_name').SetHasClass('invisible', true);

        // OnShowPopupBox({
        //     round: data.round,
        //     type: 'pve',
        //     oppo_name: $.Localize('#' + 'pve_' + data.text),
        //     history_win: data.history_win,
        //     history_lose: data.history_lose,
        //     buffs: data.buffs,
        // });
		OnShowBattleBox(data);
    }
    else if (data.type == 'cloud') {
        // 云对战
        BATTLE_STATUS = 3;
        $('#battle_icon').SetHasClass('invisible', true);
        $('#cloud_icon').SetHasClass('invisible', false);
        $('#creep_icon').SetHasClass('invisible', true);
        $('#round_battle').SetHasClass('invisible', true);
        $('#round_battle').style['color'] = '#fff';
        $('#round_battle').SetPanelEvent(
            "onactivate",
            function () { }
        )
        $('#cloud_name').SetHasClass('invisible', false);
        $('#cloud_name').steamid = data.text;

        // OnShowPopupBox({
        //     round: data.round,
        //     type: 'cloud',
        //     oppo_name: $.Localize('#' + 'cloud_player'),
        //     history_win: data.history_win,
        //     history_lose: data.history_lose,
        //     buffs: data.buffs,
        // });
		OnShowBattleBox(data);

        // 显示客场正在对战谁
        $('#panel_battle_' + Game.GetLocalPlayerID()).visible = true;
        start_battle_animation($('#panel_battle_' + Game.GetLocalPlayerID()));
    }
    else if (data.type == 'pvp') {
        // 普通对战
        BATTLE_STATUS = 2;
        $('#battle_icon').SetHasClass('invisible', false);
        $('#cloud_icon').SetHasClass('invisible', true);
        $('#creep_icon').SetHasClass('invisible', true);
        $('#round_battle').SetHasClass('invisible', false);

        CURR_HOST_OPPO = parseInt(data.host_oppo_id);
        CURR_GUEST_OPPO = parseInt(data.guest_oppo_id);
        // 转为team index
        CURR_HOST_OPPO = GetPlayerIndexByPlayerID(CURR_HOST_OPPO);
        CURR_GUEST_OPPO = GetPlayerIndexByPlayerID(CURR_GUEST_OPPO);

        $('#round_battle').SetPanelEvent(
            "onactivate",
            function () {
                change_camera_2_player_ground(CURR_HOST_OPPO);
            }
        )
        $('#cloud_name').SetHasClass('invisible', true);

        $('#round_battle').text = Players.GetPlayerName(parseInt(data.text));

        // $('#round_battle').style['color'] = TEAM_COLOR[team];

        // 显示客场正在对战谁
        $('#panel_battle_' + CURR_GUEST_OPPO).visible = true;
        start_battle_animation($('#panel_battle_' + CURR_GUEST_OPPO));

        // OnShowPopupBox({
        //     round: data.round,
        //     type: 'pvp',
        //     oppo_name: Players.GetPlayerName(parseInt(data.text)),
        //     history_win: data.history_win,
        //     history_lose: data.history_lose,
        //     buffs: data.buffs,
        //     is_chesses_same_star: data.is_chesses_same_star,
        // });
		OnShowBattleBox(data);
    }
    $('#round_info').text = "ROUND " + data.round;
    ROUND = data.round;
}
// function OnShowPopupBox(keys) {
// 	var round = keys.round;
// 	var oppo_name = keys.oppo_name;
// 	var type = keys.type; // pve/pvp/cloud
// 	var buffs = keys.buffs;
// 	var history_win = keys.history_win || 0;
// 	var history_lose = keys.history_lose || 0;
// 	var is_chesses_same_star = keys.is_chesses_same_star;

// 	// $.Schedule(0.5,function(){
// 	// Game.EmitSound("dac.popup");
// 	// Game.EmitSound("diretide.stinger");
// 	Game.EmitSound("dac.season.battleround");
// 	// });

// 	$('#text_panel_popup_box_inner_line5').text = '';
// 	$('#text_panel_popup_box_inner_line6').text = '';
// 	$('#text_panel_popup_box_inner_line7').text = '';

// 	if (type == 'pve') {

// 		$('#panel_popup_box_player_details_buff').SetHasClass('invisible', true);
// 		if (round > 3) {
// 			if (round == 10 || round == 20 || round == 30 || round == 40 || round == 50) {
// 				$('#text_panel_popup_box_inner_line5').text = $.Localize('#'+'round_relic');
// 				$('#text_panel_popup_box_inner_line6').text = $.Localize('#'+'round_relic_line6') + ' √';
// 				$('#text_panel_popup_box_inner_line7').text = $.Localize('#'+'round_relic_line7') + ' √';
// 				$('#text_panel_popup_box_inner_line6').style['color'] = '#ddd';
// 				$('#text_panel_popup_box_inner_line7').style['color'] = '#ddd';
// 			}
// 			else {
// 				$('#text_panel_popup_box_inner_line5').text = $.Localize('#'+'round_pve');
// 				$('#text_panel_popup_box_inner_line6').text = $.Localize('#'+'round_loot_line6') + ' √';
// 				$('#text_panel_popup_box_inner_line7').text = $.Localize('#'+'round_loot_line7') + ' √';
// 				$('#text_panel_popup_box_inner_line6').style['color'] = '#ddd';
// 				$('#text_panel_popup_box_inner_line7').style['color'] = '#ddd';
// 			}
// 		}
// 		else {
// 			$('#text_panel_popup_box_inner_line5').text = $.Localize('#'+'round_pve');
// 			$('#text_panel_popup_box_inner_line7').text = $.Localize('#'+'round_loot_line7') + ' √';
// 			$('#text_panel_popup_box_inner_line6').text = $.Localize('#'+'round_loot_line6');
// 			$('#text_panel_popup_box_inner_line7').style['color'] = '#ddd';
// 			$('#text_panel_popup_box_inner_line6').style['color'] = '#444';
// 		}
// 	}
// 	if (type == 'cloud') {
// 		$('#text_panel_popup_box_inner_line5').text = $.Localize('#'+'round_cloud');
// 		$('#panel_popup_box_player_details_buff').SetHasClass('invisible', true);
// 		$('#text_panel_popup_box_inner_line6').text = $.Localize('#'+'round_cloud_line6');
// 		$('#text_panel_popup_box_inner_line7').text = $.Localize('#'+'round_cloud_line7');
// 		$('#text_panel_popup_box_inner_line6').style['color'] = '#ddd';
// 		$('#text_panel_popup_box_inner_line7').style['color'] = '#ddd';
// 	}
// 	if (type == 'pvp') {
// 		$('#text_panel_popup_box_inner_line5').text = '';
// 		$('#text_panel_popup_box_inner_line6').text = '';
// 		$('#text_panel_popup_box_inner_line7').text = '';
// 		$('#panel_popup_box_player_details_buff').SetHasClass('invisible', false);
// 	}

// 	// 渲染窗口内容
// 	if (round) {
// 		$('#text_panel_popup_box_inner_line1').text = 'ROUND ' + round;
// 	}
// 	else {
// 		$('#text_panel_popup_box_inner_line1').text = 'UNKNOWN ROUND';
// 	}

// 	if (oppo_name) {
// 		$('#text_panel_popup_box_inner_line2').text = oppo_name;
// 	}
// 	else {
// 		$('#text_panel_popup_box_inner_line2').text = 'UNKNOWN PLAYER';
// 	}

// 	if ((history_win || history_win == 0) && (history_lose || history_lose == 0)) {
// 		if (history_win > history_lose) {
// 			$('#text_panel_popup_box_inner_line4').style['color'] = '#44ff44';
// 		}
// 		if (history_win < history_lose) {
// 			$('#text_panel_popup_box_inner_line4').style['color'] = '#ff4444';
// 		}
// 		if (history_win == history_lose) {
// 			$('#text_panel_popup_box_inner_line4').style['color'] = '#ddd';
// 		}
// 		$('#text_panel_popup_box_inner_line4').text = history_win + '-' + history_lose;
// 	}
// 	else {
// 		$('#text_panel_popup_box_inner_line4').text = '0-0';
// 		$('#text_panel_popup_box_inner_line4').style['color'] = '#ddd';
// 	}

// 	$('#panel_popup_box_player_details_buff').RemoveAndDeleteChildren();
// 	if (buffs) {
// 		// $('#panel_popup_box_player_details_buff').BCreateChildren(GetShowBuffXML(buffs));
// 		CreateChildren($('#panel_popup_box_player_details_buff'), GetShowBuffXML(buffs));
// 	}



// 	$('#panel_popup_box').SetHasClass('invisible', false);
// 	$("#panel_popup_box").style['opacity'] = '1';
// 	$("#panel_popup_box").style['transform'] = 'scale3d( 1, 1, 1);';

// 	//

// 	$.Schedule(7, function () {
// 		Game.EmitSound("ui.profile_close");

// 		$("#panel_popup_box").style['opacity'] = '0.01';
// 		$("#panel_popup_box").style['transform'] = 'scale3d( 2, 2, 2);';
// 		$.Schedule(0.5, function () {
// 			$('#panel_popup_box').SetHasClass('invisible', true);
// 		});
// 	});

// 	close_legendary_box();
// }