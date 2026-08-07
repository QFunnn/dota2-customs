--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


/* 
	聊天框 与 战报显示框， 覆盖dota2原有的
*/

GameEvents.Subscribe("drodo_chat", OnShowDrodoChat);
GameEvents.Subscribe("drodo_combat", OnShowDrodoCombat);
GameEvents.Subscribe("drodo_bubble", OnShowDrodoBubble);


var CHAT_LIST = [];
var COMBAT_LIST = [];
var CHAT_LIMIT = 50;

function OnShowDrodoBubble(keys) {
	var text_ori = keys.text || '';
	var text = '';
	if (text_ori.indexOf('|') >= 0) {
		var text_array = text_ori.split('|');
		for (var i = 0; i < text_array.length; i++) {
			var ttt = text_array[i];
			var tttt = ttt;
			if (ttt){
				if ($.Localize('#'+ttt) != ('#'+ttt)){
					text += $.Localize('#'+ttt);
				}
				else if($.Localize(ttt) != (ttt)){
					text += $.Localize(ttt);
				}
				else{
					text += ttt;
				}
			}
		}
	}
	else {
		text = $.Localize(keys.text);
	}

	// text替换一些占位符
	if (text.indexOf('<player_name>') >= 0) {
		text = text.replace('<player_name>', keys.player_name);
	}
	if (text.indexOf('<chess_name>') >= 0) {
		text = text.replace('<chess_name>', $.Localize(keys.chess_name));
	}
	if (text.indexOf('<emotion_id>') >= 0) {
		text = text.replace('<emotion_id>', 'emotion:' + keys.emotion_index);
	}

	// if (text.indexOf('emotion:') == 0) {
	// 	var emotion_index = parseInt(text.slice(8)) || 0;
	// 	// DisplayBubble({
	// 	// 	unit: keys.unit_index,
	// 	// 	pic: emotion_index,
	// 	// });
	// 	InitChatBubble(keys.unit_index, emotion_index, null);
	// }
	// else {
	// 	// DisplayBubble({
	// 	// 	unit: keys.unit_index,
	// 	// 	text: text,
	// 	// });
	// 	InitChatBubble(keys.unit_index, null, text);
	// }
}

function OnShowDrodoChat(keys) {
	var type = keys.type || 'common';
	var player_id = keys.player_id;
	var text = keys.text || '';
	var win_streak = keys.win_streak || 0;
	var onduty_hero = keys.onduty_hero;
	var time_stamp = keys.time_stamp || 0;
	var chess = keys.chess;
	var ability = keys.ability;
	var chat_str = text;
	var emoji = keys.emoji || 0;

	if ((player_id || player_id == 0) && Game.IsPlayerMuted(player_id) == true) {
		return;
	}

	var text_ori = text || '';
	var text = '';
	if (text_ori.indexOf('|') >= 0) {
		var text_array = text_ori.split('|');
		for (var i = 0; i < text_array.length; i++) {
			var ttt = text_array[i];
			var tttt = ttt;
			if (ttt){
				if ($.Localize('#'+ttt) != ('#'+ttt)){
					text += $.Localize('#'+ttt);
				}
				else if($.Localize(ttt) != (ttt)){
					text += $.Localize(ttt);
				}
				else{
					text += ttt;
				}
			}
		}
	}
	else {
		text = $.Localize(keys.text);
	}

	text = html2Escape(text);

	if (type == 'player_chat') {
		// 玩家聊天消息
		var player_color = GetWSColor(win_streak);
		var player_name = Players.GetPlayerName(player_id);
		if ($.Language() == 'schinese') {
			text = wordFilter(text);
		}
		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;margin-left:55px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + ": '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;' class='' text='" + wordFilter(text) + "'/>";
		chat_str += "</Panel>";

		// DisplayBubble({
		// 	unit: Players.GetPlayerHeroEntityIndex(player_id),
		// 	// pic: keys.emotion_index,
		// 	text: text,
		// });
		// InitChatBubble(Players.GetPlayerHeroEntityIndex(player_id), null, text);
	}
	else if (type == 'player_emotion') {
		// 玩家聊天表情消息
		var player_color = GetWSColor(win_streak);
		var player_name = Players.GetPlayerName(player_id);

		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;overflow:noclip noclip;margin-left:55px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<Image style='width:25px;height:25px;vertical-align:bottom;margin-bottom:10px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;vertical-align:bottom;margin-bottom:10px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + ": '/>";
		// chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;' class='' text='" + wordFilter(text) + "'/>";

		var m_info;
		for (var i in EMOTION_LIST) {
			if (EMOTION_LIST[i].emotion_index == keys.emotion_index) {
				m_info = EMOTION_LIST[i];
			}
		}
		var transform_text = 'scale3d( EMOTIONSIZE, EMOTIONSIZE, EMOTIONSIZE)'.replace(/EMOTIONSIZE/g, m_info.size);
		chat_str += "<Image style='width:150px;height:150px;margin-top:-30px;margin-bottom:-30px;transform:" + transform_text + ";' src='file://{resources}/images/custom_game/chat/" + keys.emotion_index + ".png'/>";
		chat_str += "</Panel>";

		// DisplayBubble({
		// 	unit: Players.GetPlayerHeroEntityIndex(player_id),
		// 	// pic: keys.emotion_index,
		// 	text: text,
		// });
		// InitChatBubble(Players.GetPlayerHeroEntityIndex(player_id), null, text);
	}
	else if (type == 'player_event') {
		// 玩家事件
		var player_color = GetWSColor(win_streak);
		var player_name = Players.GetPlayerName(player_id);
		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;margin-left:55px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+text) + "'/>";
		if (emoji) {
			chat_str += "<DOTAEmoticon emoticonid='" + emoji + "' animating='true' style='width:20px;height:20px;'/>";
		}
		chat_str += "</Panel>";
	}
	else if (type == 'player_courier_event') {
		// 玩家信使事件
		var player_color = GetWSColor(win_streak);
		var player_name = Players.GetPlayerName(player_id);
		var courier_color = COLOR_STR[onduty_hero?onduty_hero.slice(1, 2):1];
		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;margin-left:55px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+text) + ": '/>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + courier_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;' class='' text='" + $.Localize('#'+onduty_hero) + " '/>";
		chat_str += "</Panel>";
	}
	else if (type == 'chess_event') {
		// 棋子事件
		var chess_name = $.Localize('#'+chess);
		var chess_color = LEVEL_2_COLOR[CHESS_2_LEVEL[chess]];
		var chess_hero_name = Chess2HeroName(chess);
		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;margin-left:55px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<DOTAHeroImage id='cursor_hero_icon' style='width:25px;height:25px;' heroname='" + chess_hero_name + "' heroimagestyle='icon' />";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + chess_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;' class='' text='" + chess_name + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+text) + "'/>";
		chat_str += "</Panel>";
	}
	else if (type == 'egg_event') {
		// 蛋
		var player_color = GetWSColor(win_streak);
		var player_name = Players.GetPlayerName(player_id);
		var courier_color = COLOR_STR[onduty_hero?onduty_hero.slice(1, 2):1];
		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;margin-left:55px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + " '/>";
		var ttt = $.Localize('#'+text);
		var chess_name = $.Localize('#'+chess);
		var ccc1 = chess.replace('11','').replace('1','');
		var chess_color = LEVEL_2_COLOR[CHESS_2_LEVEL[ccc1]];
		ttt = ttt.split('<chess>');
		var ttt1 = ttt[0] || '';
		var ttt2 = ttt[1] || '';
		var chess_hero_name = Chess2HeroName(chess);
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + ttt1 + "'/>";
		chat_str += "<DOTAHeroImage id='cursor_hero_icon' style='width:25px;height:25px;' heroname='" + chess_hero_name + "' heroimagestyle='icon' />";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + chess_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;' class='' text='" + chess_name + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + ttt2 + "'/>";

		chat_str += "</Panel>";
	}
	else if (type == 'copy_synergy_event') {
		// 奇观轮
		var player_color = GetWSColor(win_streak);
		var player_name = Players.GetPlayerName(player_id);
		var courier_color = COLOR_STR[onduty_hero?onduty_hero.slice(1, 2):1];
		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;margin-left:55px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + " '/>";
		var ttt = $.Localize('#'+text);
		var chess_name = $.Localize('#'+chess);
		var ccc1 = chess.replace('11','').replace('1','');
		var chess_color = LEVEL_2_COLOR[CHESS_2_LEVEL[ccc1]];
		ttt = ttt.split('<chess>');
		var ttt1 = ttt[0] || '';
		var ttt2 = ttt[1] || '';
		var chess_hero_name = Chess2HeroName(chess);
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + ttt1 + "'/>";
		chat_str += "<DOTAHeroImage id='cursor_hero_icon' style='width:25px;height:25px;' heroname='" + chess_hero_name + "' heroimagestyle='icon' />";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + chess_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;' class='' text='" + chess_name + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + ttt2 + "'/>";
		
		var synergy_color = SYNERGY_2_COLOR['class'];
		if (text=='notice_add_synergy1'){
			synergy_color = SYNERGY_2_COLOR['spec'];
		}
		var synergy_name = $.Localize('#DOTA_Tooltip_ability_'+ability) || '';
		synergy_name = synergy_name.replace('<font color=\"#E7D291\">','').replace('<font color=\"#91C1F7\">','').replace('</font>','');
		chat_str += "<DOTAAbilityImage id='cursor_hero_icon' style='width:25px;height:25px;' abilityname='" + ability + "' heroimagestyle='icon' />";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + synergy_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;' class='' text='" + synergy_name + " '/>";

		chat_str += "</Panel>";
	}
	else if (type == 'double_coin_event') {
		// 双面币
		var player_color = GetWSColor(win_streak);
		var player_name = Players.GetPlayerName(player_id);
		var courier_color = COLOR_STR[onduty_hero?onduty_hero.slice(1, 2):1];
		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;margin-left:55px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + " '/>";
		var ttt = $.Localize('#'+text);
		var ttt1 = ttt.replace('%s1',(keys.number || 0));
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + ttt1 + "'/>";

		chat_str += "</Panel>";
	}
	else if (type == 'common') {
		chat_str = "<Panel id='drodoChat_" + (CHAT_LIST.length + 1) + "' style='flow-children:right;margin-left:85px;margin-top:-2px;padding-top:2px;margin-bottom:2px;'>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + text + "'/>";
		chat_str += "</Panel>";
	}

	if (!keys.is_bubble_only) {
		if (CHAT_LIST.length > CHAT_LIMIT) {
			for (var i = ii; i < CHAT_LIST.length - CHAT_LIMIT; i++) {
				if (CHAT_LIST[i]) {
					CHAT_LIST[i] = null;
				}
			}
		}

		CHAT_LIST.push({
			time_stamp: time_stamp,
			text: chat_str,
		});

		var ii = 0;
		if (CHAT_LIST.length > CHAT_LIMIT) {
			ii = CHAT_LIST.length - CHAT_LIMIT;
		}

		var str = '';
		for (var i = ii; i < CHAT_LIST.length; i++) {
			if (CHAT_LIST[i] && CHAT_LIST[i].text) {
				str += CHAT_LIST[i].text;
			}
		}

		$.Schedule(0.01, function () {
			FindDotaHudElement('ChatLinesPanel').RemoveAndDeleteChildren();
			// FindDotaHudElement('ChatLinesPanel').BCreateChildren(str);
			CreateChildren(FindDotaHudElement('ChatLinesPanel'), str);
			for (var i = ii; i < CHAT_LIST.length; i++) {
				var t = CHAT_LIST[i].time_stamp || 0;
				var expire = (time_stamp - t);
				var delay = 0;
				if (expire > 10) {
					delay = 0;
				}
				else if (delay < 0) {
					delay = 10;
				}
				else {
					delay = 10 - expire;
				}
				SetChatExpired("drodoChat_" + (i + 1), delay);
			}
		});
	}

}

function OnShowDrodoCombat(keys) {
	var type = keys.type || 'common';
	var text = ''+(keys.text||'');
	var time_stamp = keys.time_stamp || 0;
	var chat_str = text;
	text = html2Escape(text);

	if (type == 'common') {
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:20px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Label html='true' style='color:#bbb;text-shadow:1px 1.5px 0px 2 #000000;font-size:16px;line-height:25px;font-family:titleFont;' class='' text='" + text + "'/>";
		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'round_number') {
		var round_text = ($.Localize('#text_top_round')||'ROUND %round%').replace('%round%',text||'?');
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:20px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Label html='true' style='color:#bbb;text-shadow:1px 1.5px 0px 2 #000000;font-size:16px;line-height:25px;' class='' text='" + round_text + "'/>";
		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_pve_win') {
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";
		// chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;margin-left:5px;' class='' text=' "+num1+"'/>";
		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_win.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";

		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+text) + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_pve_draw') {
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";

		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_draw.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";

		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+text) + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_pve_lose') {
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";

		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_lose.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";
		// chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;margin-right:5px;' class='' text='"+num1+" '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+text) + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_cloud_win') {
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";
		// chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;margin-left:5px;' class='' text=' "+num1+"'/>";
		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_win.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";

		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+'cloud_player') + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_cloud_draw') {
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";

		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_draw.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";

		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+'cloud_player') + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_cloud_lose') {
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";
		chat_str += "<Label html='true' style='color:#ff4444;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;margin-right:5px;font-family:titleFont;' class='' text='(-" + num1 + ") '/>";

		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_lose.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";

		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+'cloud_player') + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_pvp_win') {
		// pvp战报
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1?onduty_hero1.slice(1, 2):1];
		var num1 = keys.num1;
		var player_id2 = keys.player_id2;
		var win_streak2 = keys.win_streak2 || 0;
		var onduty_hero2 = keys.onduty_hero2;
		var player_color2 = GetWSColor(win_streak2);
		var player_name2 = textLimitLength(Players.GetPlayerName(player_id2));
		var courier_color2 = COLOR_STR[onduty_hero2.slice(1, 2)];
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";
		// chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;margin-left:5px;' class='' text=' "+num1+"'/>";
		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_win.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";

		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero2 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color2 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name2) + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_pvp_draw') {
		// pvp战报
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		var player_id2 = keys.player_id2;
		var win_streak2 = keys.win_streak2 || 0;
		var onduty_hero2 = keys.onduty_hero2;
		var player_color2 = GetWSColor(win_streak2);
		var player_name2 = textLimitLength(Players.GetPlayerName(player_id2));
		var courier_color2 = COLOR_STR[onduty_hero2.slice(1, 2)];
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";

		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_draw.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";

		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero2 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color2 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name2) + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'battle_pvp_lose') {
		// pvp战报
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1?onduty_hero1.slice(1, 2):1];
		var num1 = keys.num1;
		var player_id2 = keys.player_id2;
		var win_streak2 = keys.win_streak2 || 0;
		var onduty_hero2 = keys.onduty_hero2;
		var player_color2 = GetWSColor(win_streak2);
		var player_name2 = textLimitLength(Players.GetPlayerName(player_id2));
		var courier_color2 = COLOR_STR[onduty_hero2?onduty_hero2.slice(1, 2):1];
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";
		chat_str += "<Label html='true' style='color:#ff4444;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:22px;line-height:25px;margin-right:5px;font-family:titleFont;' class='' text='(-" + num1 + ") '/>";

		chat_str += "<Image style='width:40px;height:40px;' src='file://{images}/custom_game/round_lose.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;' class='' text=' '/>";

		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero2 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color2 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name2) + " '/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'player_dead') {
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		var gold1 = keys.gold1;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+"notice_player_dead_1") + " '/>";
		chat_str += "<Image style='width:35px;height:35px;margin-top:-3px;' src='file://{images}/custom_game/items.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;margin-left:5px;margin-right:10px;font-family:titleFont;' class='' text='" + num1 + "'/>";
		chat_str += "<Image style='width:25px;height:25px;margin-top:3px;' src='file://{images}/custom_game/money.png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;font-family:titleFont;' class='' text='" + gold1 + "'/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'drop_shengjian') {
		var player_id1 = keys.player_id2;
		var win_streak1 = keys.win_streak2 || 0;
		var onduty_hero1 = keys.onduty_hero2;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero1 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color1 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name1) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+"notice_player_got") + " '/>";
		chat_str += "<DOTAItemImage style='width:44px;height:32px;' itemname='item_shengjian'/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'destroy_piece') {
		var player_id = keys.player_id;
		var win_streak = keys.win_streak || 0;
		var onduty_hero = keys.onduty_hero;
		var player_color = GetWSColor(win_streak);
		var player_name = textLimitLength(Players.GetPlayerName(player_id));
		var courier_color = COLOR_STR[onduty_hero.slice(1, 2)];
		var num = keys.num;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+"notice_player_destroy_piece_1") + " '/>";
		chat_str += "<DOTAItemImage style='width:44px;height:32px;' itemname='item_destroy_piece'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+"notice_player_destroy_piece_2") + " '/>";
		chat_str += "<Image style='width:25px;height:25px;margin-top:3px;' src='file://{images}/custom_game/money.png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;font-family:titleFont;' class='' text='" + num + "'/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'item_get_money') {
		var player_id = keys.player_id;
		var win_streak = keys.win_streak || 0;
		var onduty_hero = keys.onduty_hero;
		var item = keys.item;
		var player_color = GetWSColor(win_streak);
		var player_name = textLimitLength(Players.GetPlayerName(player_id));
		var courier_color = COLOR_STR[onduty_hero.slice(1, 2)];
		var num = keys.num;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+"notice_player_item_get_money_1") + " '/>";
		chat_str += "<DOTAItemImage style='width:44px;height:32px;' itemname='" + item + "'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+item) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+"notice_player_item_get_money_2") + " '/>";
		chat_str += "<Image style='width:25px;height:25px;margin-top:3px;' src='file://{images}/custom_game/money.png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;font-family:titleFont;' class='' text='" + num + "'/>";

		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'terminate') {
		var player_id1 = keys.player_id1;
		var win_streak1 = keys.win_streak1 || 0;
		var onduty_hero1 = keys.onduty_hero1;
		var player_color1 = GetWSColor(win_streak1);
		var player_name1 = textLimitLength(Players.GetPlayerName(player_id1));
		var courier_color1 = COLOR_STR[onduty_hero1.slice(1, 2)];
		var num1 = keys.num1;
		var player_id2 = keys.player_id2;
		var win_streak2 = keys.win_streak2 || 0;
		var onduty_hero2 = keys.onduty_hero2;
		var player_color2 = GetWSColor(win_streak2);
		var player_name2 = textLimitLength(Players.GetPlayerName(player_id2));
		var courier_color2 = COLOR_STR[onduty_hero2?onduty_hero2.slice(1, 2):1];
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		// chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/"+onduty_hero1+".png'/>";
		// chat_str += "<Label html='true' style='margin-left:5px;color:"+player_color1+";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='"+player_name1+" '/>";
		// chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='"+$.Localize('#'+"notice_player_terminate_1")+" '/>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero2 + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color2 + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name2) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+"notice_player_terminate_2") + " '/>";
		chat_str += "<Image style='width:25px;height:25px;margin-top:3px;' src='file://{images}/custom_game/money.png'/>";
		chat_str += "<Label html='true' style='color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;margin-left:5px;margin-right:5px;font-family:titleFont;' class='' text='" + num1 + "'/>";


		chat_str += "</DOTACombatEventRow>";
	}
	else if (type == 'reveal_legendary') {
		var player_id = keys.player_id;
		var win_streak = keys.win_streak || 0;
		var onduty_hero = keys.onduty_hero;
		var player_color = GetWSColor(win_streak);
		var player_name = textLimitLength(Players.GetPlayerName(player_id));
		var courier_color = COLOR_STR[onduty_hero.slice(1, 2)];
		var num = keys.num;
		chat_str = "<DOTACombatEventRow id='drodoCombat_" + (COMBAT_LIST.length + 1) + "' class='ToastPanel Collapse' style='flow-children:right-wrap;margin-left:5px;' hittest='false' hittestchildren='false' require-composition-layer='true' always-cache-composition-layer='true'>";
		chat_str += "<Image style='width:25px;height:25px;' src='file://{images}/custom_game/skaters/" + onduty_hero + ".png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:" + player_color + ";text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + html2Escape(player_name) + " '/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:18px;line-height:25px;' class='' text='" + $.Localize('#'+"notice_player_reveal_legendary") + " '/>";
		chat_str += "<Image style='width:25px;height:25px;margin-top:3px;' src='file://{images}/custom_game/money.png'/>";
		chat_str += "<Label html='true' style='margin-left:5px;color:#fff;text-shadow:1px 1.5px 0px 2 #000000;font-weight:bold;font-size:25px;line-height:25px;font-family:titleFont;' class='' text='" + num + "'/>";

		chat_str += "</DOTACombatEventRow>";
		Game.EmitSound("dac.reveal_legendary");
	}

	if (COMBAT_LIST.length > CHAT_LIMIT) {
		for (var i = ii; i < COMBAT_LIST.length - CHAT_LIMIT; i++) {
			if (COMBAT_LIST[i]) {
				COMBAT_LIST[i] = null;
			}
		}
	}

	COMBAT_LIST.push({
		time_stamp: time_stamp,
		text: chat_str,
	});

	var ii = 0;
	if (COMBAT_LIST.length > CHAT_LIMIT) {
		ii = COMBAT_LIST.length - CHAT_LIMIT;
	}

	var str = '';
	for (var i = ii; i < COMBAT_LIST.length; i++) {
		if (COMBAT_LIST[i] && COMBAT_LIST[i].text) {
			str += COMBAT_LIST[i].text;
		}
	}

	FindDotaHudElement('ToastManager').RemoveAndDeleteChildren();
	// FindDotaHudElement('ToastManager').BCreateChildren(str);
	CreateChildren(FindDotaHudElement('ToastManager'), str);

	for (var i = ii; i < COMBAT_LIST.length; i++) {
		var t = COMBAT_LIST[i].time_stamp || 0;
		var expire = (time_stamp - t);
		var delay = 0;
		if (expire > 10) {
			delay = 0;
		}
		else if (delay < 0) {
			delay = 10;
		}
		else {
			delay = 10 - expire;
		}
		SetCombatExpired("drodoCombat_" + (i + 1), delay);
	}
	AutoSetCombatPanelHeight();
}

function SetChatExpired(id, delay) {
	$.Schedule(delay, function () {
		if (!FindDotaHudElement(id)) {
			return;
		}
		FindDotaHudElement(id).SetHasClass('ChatLine', true);
		FindDotaHudElement(id).SetHasClass('Expired', true);
	});
}
function SetCombatExpired(id, delay) {
	if (delay > 0) {
		if (!FindDotaHudElement(id)) {
			return;
		}
		FindDotaHudElement(id).SetHasClass('ToastPanel', false);
		FindDotaHudElement(id).SetHasClass('Collapse', false);
	}
	$.Schedule(delay, function () {
		if (!FindDotaHudElement(id)) {
			return;
		}
		FindDotaHudElement(id).SetHasClass('ToastPanel', true);
		FindDotaHudElement(id).SetHasClass('Collapse', true);
	});
}

function textLimitLength(text, len) {
	if (!len) len = 12;
	return text.length > len ? text.substr(0, len) : text;
}