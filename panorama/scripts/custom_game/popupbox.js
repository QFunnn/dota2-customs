--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


/* 
	战斗回合开始弹窗（准备弃用了）
*/
GameEvents.Subscribe("battle_info", OnBattleInfo);
GameEvents.Subscribe("show_popup_box", OnShowPopupBox);
GameEvents.Subscribe("show_popup_box_update_buff", OnPopupBoxUpdateBuff);

function OnPopupBoxUpdateBuff(keys) {

	$('#panel_popup_box_player_details_buff').RemoveAndDeleteChildren();
	// if (buffs) {
	// 	// $('#panel_popup_box_player_details_buff').BCreateChildren(GetShowBuffXML(buffs));
	// 	CreateChildren($('#panel_popup_box_player_details_buff'), GetShowBuffXML(buffs));
	// }
	InitBattleBubble({

	});
	// if (keys.synergy){
	// 	var panel_popup_box_player_details_buff_inner = $.CreatePanel('Panel', $('#panel_popup_box_player_details_buff'), "panel_popup_box_player_details_buff_inner", {
	// 	});
		
	// 	var synergy = keys.synergy.split(',');

	// 	// 去重
	// 	var synergy2 = [];
	// 	for (var l = 0; l < synergy.length; l++) {
	// 		var s = synergy[l];

	// 		var dump = false;
	// 		for (var ll = 0; ll < synergy.length; ll++){
	// 			var ss = synergy[ll];
	// 			if (s+'1' == ss || s+'11' == ss){
	// 				dump = true;
	// 			}
	// 		}

	// 		if (!dump){
	// 			// 是一个最高羁绊
	// 			var buff_name = '';
	// 			var buff_count = 0;
	// 			if (s.indexOf('11') > -1) {
	// 				buff_name = s.substr(0, s.length - 2);
	// 				buff_index = 2;
	// 			}
	// 			else if (s.indexOf('1') > -1) {
	// 				buff_name = s.substr(0, s.length - 1);
	// 				buff_index = 1;
	// 			}
	// 			else {
	// 				buff_name = s;
	// 				buff_index = 0;
	// 			}

	// 			if (BUFF_LIST_1[buff_name]) {
	// 				buff_count = BUFF_LIST_1[buff_name][buff_index] || 0;
	// 			}
	// 			if (BUFF_LIST_2[buff_name]) {
	// 				buff_count = BUFF_LIST_2[buff_name][buff_index] || 0;
	// 			}
	// 			synergy2.push({
	// 				buff_name: buff_name,
	// 				buff_count: buff_count,
	// 			});
	// 		}
	// 	}

	// 	synergy2.sort(function(a,b){
	// 		return (b.buff_count*10000+BUFF_PRIORITY[b.buff_name]) - (a.buff_count*10000+BUFF_PRIORITY[a.buff_name]);
	// 	});

	// 	var first_buff_name;
	// 	for (var l = 0; l < synergy2.length; l++) {
	// 		var s = synergy2[l];
	// 		var buff_name = s.buff_name;
	// 		var buff_count = s.buff_count||0;

	// 		if (!first_buff_name){
	// 			first_buff_name = buff_name;
	// 		}

	// 		var block4_container_buff = $.CreatePanel('Panel', panel_popup_box_player_details_buff_inner, "", {
	// 			style: 'width:45px;height:55px;flow-children:down;margin-top:0px;',
	// 		});
	// 		$.CreatePanel('DOTAAbilityImage', block4_container_buff, "", {
	// 			abilityname: buff_name,
	// 			style: 'width:40px;height:40px;',
	// 			onmouseover: 'DOTAShowAbilityTooltip(\'' + buff_name + '\')',
	// 			onmouseout: 'DOTAHideAbilityTooltip()',
	// 		});
	// 		$.CreatePanel('Label', block4_container_buff, "", {
	// 			text: '(' + buff_count + ')',
	// 			style: 'font-size:20px;margin-top:-7px;color:#ddd;horizontal-align:center;',
	// 		});
	// 	}

	// 	if (synergy2.length > 0){
	// 		Game.EmitSound("Item.LotusOrb.Destroy");
			
	// 	}

	// 	if ($('#panel_popup_box_player_avatar_container') && $('#panel_popup_box').style['background-img-opacity'] == 0.005){
	// 		$('#panel_popup_box_player_avatar_container').SetHasClass('invisible',false);
	// 		$('#panel_popup_box_player_avatar_container').RemoveAndDeleteChildren();
	// 		$('#panel_popup_box').style['background-img-opacity'] = '0.0';
	// 		// $.CreatePanel('DOTAAvatarImage', $('#panel_popup_box_player_avatar_container'), "", {
	// 		// 	steamid: guest_steam_id,
	// 		// 	style: 'width:350px;height:350px;',
	// 		// 	onactivate: '',
	// 		// 	onmouseover: '',
	// 		// });
	// 		// $.CreatePanel('DOTAHeroMovie', $('#panel_popup_box_player_avatar_container'), "", {
	// 		// 	heroname: 'npc_dota_hero_tusk',
	// 		// 	style: 'width:350px;height:450px;',
	// 		// });
	// 		$.CreatePanel('DOTAAbilityImage', $('#panel_popup_box_player_avatar_container'), "", {
	// 			abilityname: first_buff_name,
	// 			style: 'width:350px;height:350px;',
	// 			onmouseover: '',
	// 			onmouseout: '',
	// 		});
	// 	}
	// 	else{
	// 		$('#panel_popup_box_player_avatar_container').SetHasClass('invisible',true);
	// 	}
	
	// }
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

        OnShowPopupBox({
            round: data.round,
            type: 'pve',
            oppo_name: $.Localize('#' + 'pve_' + data.text),
            history_win: data.history_win,
            history_lose: data.history_lose,
        });
    }
    else if (data.type == 'cloud') {
        // 云对战
        BATTLE_STATUS = 3;
        $('#battle_icon').SetHasClass('invisible', true);
        $('#cloud_icon').SetHasClass('invisible', false);
        $('#creep_icon').SetHasClass('invisible', true);
        $('#round_battle').SetHasClass('invisible', false);
        $('#round_battle').style['color'] = '#fff';
        $('#round_battle').SetPanelEvent(
            "onactivate",
            function () { }
        )
        $('#cloud_name').SetHasClass('invisible', false);
        $('#cloud_name').steamid = data.text;
		$('#round_battle').text = $.Localize('#' + 'cloud_player');

        OnShowPopupBox({
            round: data.round,
            type: 'cloud',
            oppo_name: '',
            history_win: data.history_win,
            history_lose: data.history_lose,
			guest_steam_id: data.guest_steam_id,
        });

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
		
        OnShowPopupBox({
            round: data.round,
            type: 'pvp',
            oppo_name: Players.GetPlayerName(parseInt(data.text)),
            history_win: data.history_win,
            history_lose: data.history_lose,
            is_chesses_same_star: data.is_chesses_same_star,
			guest_steam_id: data.guest_steam_id,
        });
    }
    $('#round_info').text = ($.Localize('#text_top_round')||'ROUND %round%').replace('%round%',data.round||'?');
    ROUND = data.round;
}

function OnShowPopupBox(keys) {
	Game.EmitSound("dac.season.battleround"); 
	return;
	var round = keys.round;
	var oppo_name = keys.oppo_name;
	var type = keys.type; // pve/pvp/cloud
	var buffs = keys.buffs;
	var history_win = keys.history_win || 0;
	var history_lose = keys.history_lose || 0;
	var is_chesses_same_star = keys.is_chesses_same_star;
	var guest_steam_id = keys.guest_steam_id;
	//<DOTAHeroMovie id="movie_legendary_box_2" heroname=""/>

	// $.Schedule(0.5,function(){
	// Game.EmitSound("dac.popup");
	// Game.EmitSound("diretide.stinger");
	
	// Game.EmitSound("valve_dota_001.music.battle_01_end");
	// });

	$('#text_panel_popup_box_inner_line5').text = '';
	$('#text_panel_popup_box_inner_line6').text = '';
	$('#text_panel_popup_box_inner_line7').text = '';

	if (type == 'pve') {

		// $('#panel_popup_box_player_details_buff').SetHasClass('invisible', true);
		// if (round > 3) {
		// 	if (round == 10 || round == 20 || round == 30 || round == 40 || round == 50) {
		// 		$('#text_panel_popup_box_inner_line5').text = $.Localize('#'+'round_relic');
		// 		$('#text_panel_popup_box_inner_line6').text = $.Localize('#'+'round_relic_line6') + ' √';
		// 		$('#text_panel_popup_box_inner_line7').text = $.Localize('#'+'round_relic_line7') + ' √';
		// 		$('#text_panel_popup_box_inner_line6').style['color'] = '#ddd';
		// 		$('#text_panel_popup_box_inner_line7').style['color'] = '#ddd';
		// 	}
		// 	else {
		// 		$('#text_panel_popup_box_inner_line5').text = $.Localize('#'+'round_pve');
		// 		$('#text_panel_popup_box_inner_line6').text = $.Localize('#'+'round_loot_line6') + ' √';
		// 		$('#text_panel_popup_box_inner_line7').text = $.Localize('#'+'round_loot_line7') + ' √';
		// 		$('#text_panel_popup_box_inner_line6').style['color'] = '#ddd';
		// 		$('#text_panel_popup_box_inner_line7').style['color'] = '#ddd';
		// 	}
		// }
		// else {
		// 	$('#text_panel_popup_box_inner_line5').text = $.Localize('#'+'round_pve');
		// 	$('#text_panel_popup_box_inner_line7').text = $.Localize('#'+'round_loot_line7') + ' √';
		// 	$('#text_panel_popup_box_inner_line6').text = $.Localize('#'+'round_loot_line6');
		// 	$('#text_panel_popup_box_inner_line7').style['color'] = '#ddd';
		// 	$('#text_panel_popup_box_inner_line6').style['color'] = '#444';
		// }
		// : 
		// background-img-opacity: 0.01;
		$('#panel_popup_box').style['background-image'] = 'url("file://{images}/custom_game/pve_logo/'+round+'.png");';
		$('#panel_popup_box').style['background-img-opacity'] = '0.15';
		$('#panel_popup_box').style['background-position'] = 'center 35%';
	}
	else{
		$('#panel_popup_box').style['background-image'] = 'url("s2r://panorama/images/dpc/aegis_icon_flat_large_psd.vtex");';
		$('#panel_popup_box').style['background-img-opacity'] = '0.005';
		$('#panel_popup_box').style['background-position'] = '0% 0%';
	}

	$('#panel_popup_box_player_avatar_container').SetHasClass('invisible',true);
	// if (type == 'cloud') {
	// 	// $('#text_panel_popup_box_inner_line5').text = $.Localize('#'+'round_cloud');
	// 	// // $('#panel_popup_box_player_details_buff').SetHasClass('invisible', true);
	// 	// $('#text_panel_popup_box_inner_line6').text = $.Localize('#'+'round_cloud_line6');
	// 	// $('#text_panel_popup_box_inner_line7').text = $.Localize('#'+'round_cloud_line7');
	// 	// $('#text_panel_popup_box_inner_line6').style['color'] = '#ddd';
	// 	// $('#text_panel_popup_box_inner_line7').style['color'] = '#ddd';
	// }
	// if (type == 'pvp') {
	// 	$('#text_panel_popup_box_inner_line5').text = '';
	// 	$('#text_panel_popup_box_inner_line6').text = '';
	// 	$('#text_panel_popup_box_inner_line7').text = '';
	// }

	$('#panel_popup_box_player_details_buff').SetHasClass('invisible', false);

	// 渲染窗口内容
	$('#text_panel_popup_box_inner_line1').text = ($.Localize('#text_top_round')||'ROUND %round%').replace('%round%',round||'?');

	if (oppo_name) {
		$('#text_panel_popup_box_inner_line2').text = oppo_name;
	}
	else {
		$('#text_panel_popup_box_inner_line2').text = '';
	}

	if ((history_win || history_win == 0) && (history_lose || history_lose == 0)) {
		if (history_win > history_lose) {
			$('#text_panel_popup_box_inner_line4').style['color'] = '#44ff44';
		}
		if (history_win < history_lose) {
			$('#text_panel_popup_box_inner_line4').style['color'] = '#ff4444';
		}
		if (history_win == history_lose) {
			$('#text_panel_popup_box_inner_line4').style['color'] = '#ddd';
		}
		$('#text_panel_popup_box_inner_line4').text = history_win + '-' + history_lose;
	}
	else {
		$('#text_panel_popup_box_inner_line4').text = '0-0';
		$('#text_panel_popup_box_inner_line4').style['color'] = '#ddd';
	}

	$('#panel_popup_box_player_details_buff').RemoveAndDeleteChildren();
	// if (buffs) {
	// 	// $('#panel_popup_box_player_details_buff').BCreateChildren(GetShowBuffXML(buffs));
	// 	CreateChildren($('#panel_popup_box_player_details_buff'), GetShowBuffXML(buffs));
	// }
	// if (keys.host_synergy){
	// 	var panel_popup_box_player_details_buff_inner = $.CreatePanel('Panel', $('#panel_popup_box_player_details_buff'), "panel_popup_box_player_details_buff_inner", {
	// 	});
		
	// 	var synergy = keys.host_synergy.split(',');
	// 	for (var l = 0; l < synergy.length; l++) {
	// 		var s = synergy[l];
	// 		var buff_name = '';
	// 		var buff_count = 0;
	// 		if (s.indexOf('11') > -1) {
	// 			buff_name = s.substr(0, s.length - 2);
	// 			buff_index = 2;
	// 		}
	// 		else if (s.indexOf('1') > -1) {
	// 			buff_name = s.substr(0, s.length - 1);
	// 			buff_index = 1;
	// 		}
	// 		else {
	// 			buff_name = s;
	// 			buff_index = 0;
	// 		}

	// 		if (BUFF_LIST_1[buff_name]) {
	// 			buff_count = BUFF_LIST_1[buff_name][buff_index] || 0;
	// 		}
	// 		if (BUFF_LIST_2[buff_name]) {
	// 			buff_count = BUFF_LIST_2[buff_name][buff_index] || 0;
	// 		}

	// 		var block4_container_buff = $.CreatePanel('Panel', panel_popup_box_player_details_buff_inner, "", {
	// 			style: 'width:35px;height:42px;flow-children:down;margin-top:0px;',
	// 		});
	// 		$.CreatePanel('DOTAAbilityImage', block4_container_buff, "", {
	// 			abilityname: buff_name,
	// 			style: 'width:30px;height:30px;',
	// 			onmouseover: 'DOTAShowAbilityTooltip(\'' + buff_name + '\')',
	// 			onmouseout: 'DOTAHideAbilityTooltip()',
	// 		});
	// 		$.CreatePanel('Label', block4_container_buff, "", {
	// 			text: '(' + buff_count + ')',
	// 			style: 'font-size:18px;margin-top:-7px;color:#ddd;horizontal-align:center;',
	// 		});
	// 	}
	// }

	$('#panel_popup_box').SetHasClass('invisible', false);
	$("#panel_popup_box").style['opacity'] = '1';
	$("#panel_popup_box").style['position'] = '0px 0px 0px';

	//

	$.Schedule(10, function () {
		Game.EmitSound("ui.profile_close");

		$("#panel_popup_box").style['opacity'] = '0.01';
		$("#panel_popup_box").style['position'] = '-500px 0px 0px';
		$.Schedule(0.5, function () {
			$('#panel_popup_box').SetHasClass('invisible', true);
		});
	});

	close_legendary_box();
	// HideBatEffect();
}

function HideBatEffect() {
	if ($('#panel_diretide_bat')){
		$('#panel_diretide_bat').style['opacity'] = '0';
	}
}