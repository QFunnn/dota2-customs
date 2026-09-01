--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// 自定义对话气泡

let chatBubbleTable = {};
const CHAT_BUBBLE_REFRESH_INVERTAL = 0.01;
var IS_CHAT_BUBBLE_SHOWING = [0, 0, 0, 0, 0, 0, 0, 0];

GameEvents.Subscribe("chat_bubble", (keys) => {
	InitChatBubble(keys.unit_index, keys.pic, keys.text, keys.duration);
});
GameEvents.Subscribe("battle_bubble", (keys) => {
	InitBattleBubble(keys);
});
GameEvents.Subscribe("chat_bubble_player_board", OnShowChatBubblePlayerBoard);


function InitBattleBubble(keys) {
	const unit_index = keys.unit_index;

	if (chatBubbleTable[unit_index] && chatBubbleTable[unit_index].panel) {
		// 重复创建，需要销毁之前的panel
		chatBubbleTable[unit_index].panel.RemoveAndDeleteChildren();
	}

	if (keys.type == 'host' && keys.name == ''){
		keys.name = '测试玩家';
	}
	if (keys.type == 'pve'){
		keys.name = $.Localize('#'+keys.name);
	}

	var bubbleInfo = {
		unit_index: unit_index,
		duration: keys.duration,
		type: keys.type,
		name: keys.name,
		win_streak: keys.win_streak,
		steam_id: keys.steam_id,
		synergy: keys.synergy,
		pic: keys.pic,
	};
	chatBubbleTable[unit_index] = bubbleInfo;

	var panel = $.CreatePanel('Panel', $.GetContextPanel(), "");
	panel.BLoadLayoutSnippet('bubble');
	var container = panel.FindChild('bubble_container');

	// TODO: 对战气泡
	// $.Msg(bubbleInfo);
	// if (bubbleInfo.type){
	// 	$.CreatePanel('Label', container, '', {
	// 		style: 'horizontal-align: left;vertical-align: top;font-size:18px;color:#888;',
	// 		text: $.Localize('#chatbubble_type_'+bubbleInfo.type),
	// 	});
	// }
	if (bubbleInfo.name){
		var ws_color = GetWSColor(bubbleInfo.win_streak);
		$.CreatePanel('Label', container, '', {
			style: 'horizontal-align: left;vertical-align: top;font-size:26px;color:'+ws_color+';',
			text: bubbleInfo.name,
		});
	}
	if (bubbleInfo.steam_id){
		$.CreatePanel('DOTAUserName', container, '', {
			steamid: bubbleInfo.steam_id,
		});
	}
	if (bubbleInfo.pic){
		var image_container = $.CreatePanel('Panel', container, 'image_container', {
			style: 'background-image:url("'+bubbleInfo.pic+'");',
		});
	}
	if (bubbleInfo.synergy){
		var synergy = bubbleInfo.synergy.split(',');

		// 去重
		var synergy2 = [];
		for (var l = 0; l < synergy.length; l++) {
			var s = synergy[l];

			var dump = false;
			for (var ll = 0; ll < synergy.length; ll++){
				var ss = synergy[ll];
				if (s+'1' == ss || s+'11' == ss){
					dump = true;
				}
			}

			if (!dump){
				// 是一个最高羁绊
				var buff_name = '';
				var buff_count = 0;
				if (s.indexOf('11') > -1) {
					buff_name = s.substr(0, s.length - 2);
					buff_index = 2;
				}
				else if (s.indexOf('1') > -1) {
					buff_name = s.substr(0, s.length - 1);
					buff_index = 1;
				}
				else {
					buff_name = s;
					buff_index = 0;
				}

				if (BUFF_LIST_1[buff_name]) {
					buff_count = BUFF_LIST_1[buff_name][buff_index] || 0;
				}
				if (BUFF_LIST_2[buff_name]) {
					buff_count = BUFF_LIST_2[buff_name][buff_index] || 0;
				}
				synergy2.push({
					buff_name: buff_name,
					buff_count: buff_count,
				});
			}
		}

		synergy2.sort(function(a,b){
			return (b.buff_count*10000+BUFF_PRIORITY[b.buff_name]) - (a.buff_count*10000+BUFF_PRIORITY[a.buff_name]);
		});

		var synergy_container = $.CreatePanel('Panel', container, "", {
            style: 'vertical-align:center;horizontal-align:left;flow-children:right-wrap;margin-top:5px;',
        });

		for (var l = 0; l < synergy2.length; l++) {
			var s = synergy2[l];
			var buff_name = s.buff_name;
			var buff_count = s.buff_count;

			var block4_container_buff = $.CreatePanel('Panel', synergy_container, "", {
				style: 'width:35px;height:48px;flow-children:down;margin-top:0px;',
			});
			$.CreatePanel('DOTAAbilityImage', block4_container_buff, "", {
				abilityname: buff_name,
				style: 'width:30px;height:30px;',
				onmouseover: 'DOTAShowAbilityTooltip(\'' + buff_name + '\')',
				onmouseout: 'DOTAHideAbilityTooltip()',
			});
			$.CreatePanel('Label', block4_container_buff, "", {
				text: '(' + buff_count + ')',
				style: 'font-size:18px;margin-top:0px;color:#ddd;horizontal-align:center;',
			});
		}
	}

	// if (pic) {
	// 	// 图片气泡
	// 	var pic_panel = panel.FindChild('Text').FindChild('Pic');
	// 	panel.FindChild('Text').text = '';
	// 	panel.FindChild('Text').style['padding'] = '0px';
	// 	if (pic_panel) {
	// 		pic_panel.visible = true;

	// 		var m_info;
	// 		for (var i in EMOTION_LIST) {
	// 			if (EMOTION_LIST[i].emotion_index == pic) {
	// 				m_info = EMOTION_LIST[i];
	// 			}
	// 		}
	// 		pic_panel.SetImage('file://{resources}/images/custom_game/chat/' + pic + '.png');
	// 		pic_panel.style['transform'] = 'scale3d( EMOTIONSIZE, EMOTIONSIZE, EMOTIONSIZE)'.replace(/EMOTIONSIZE/g, m_info.size);
	// 		pic_panel.style['vertical-align'] = 'center';
	// 		panel.style['height'] = '120px';
	// 		panel.style['margin-top'] = '-30px';
	// 	}
	// }
	// else {
	// 	// 文字气泡
	// 	panel.FindChild('Text').text = text;
	// 	panel.FindChild('Text').style['padding'] = '15px';
	// 	var font_size = 25;
	// 	var tanhao_count = (text.split('!').length - 1) + (text.split('！').length - 1);
	// 	if (tanhao_count >= 3) {
	// 		tanhao_count = 3;
	// 	}
	// 	font_size += tanhao_count * 5;
	// 	panel.FindChild('Text').style['font-size'] = font_size + 'px';
	// 	panel.FindChild('Text').style['line-height'] = font_size + 'px';
	// 	panel.FindChild('Text').FindChild('Pic').visible = false;
	// }

	bubbleInfo['panel'] = panel;

	ShowChatBubble(unit_index, keys.duration);

	$.Schedule(CHAT_BUBBLE_REFRESH_INVERTAL, () => {
		RefreshChatBubble(unit_index);
	});
}

function InitChatBubble(unit_index, pic, text, duration) {
	if (chatBubbleTable[unit_index] && chatBubbleTable[unit_index].panel) {
		// 重复创建，需要销毁之前的panel
		chatBubbleTable[unit_index].panel.RemoveAndDeleteChildren();
	}

	var bubbleInfo = {
		unit: unit_index,
		pic: pic,
		text: text,
		duration: duration,
	};
	chatBubbleTable[unit_index] = bubbleInfo;

	// var panel = bubbleInfo['panel'];
	// panel = $.CreatePanel('Panel', $.GetContextPanel(), "");
	// panel.BLoadLayoutSnippet('bubble');

	// // TODO: 对战气泡
	// if (pic) {
	// 	// 图片气泡
	// 	var pic_panel = panel.FindChild('Text').FindChild('Pic');
	// 	panel.FindChild('Text').text = '';
	// 	panel.FindChild('Text').style['padding'] = '0px';
	// 	if (pic_panel) {
	// 		pic_panel.visible = true;

	// 		var m_info;
	// 		for (var i in EMOTION_LIST) {
	// 			if (EMOTION_LIST[i].emotion_index == pic) {
	// 				m_info = EMOTION_LIST[i];
	// 			}
	// 		}
	// 		pic_panel.SetImage('file://{resources}/images/custom_game/chat/' + pic + '.png');
	// 		pic_panel.style['transform'] = 'scale3d( EMOTIONSIZE, EMOTIONSIZE, EMOTIONSIZE)'.replace(/EMOTIONSIZE/g, m_info.size);
	// 		pic_panel.style['vertical-align'] = 'center';
	// 		panel.style['height'] = '120px';
	// 		panel.style['margin-top'] = '-30px';
	// 	}
	// }
	// else {
	// 	// 文字气泡
	// 	panel.FindChild('Text').text = text;
	// 	panel.FindChild('Text').style['padding'] = '15px';
	// 	var font_size = 25;
	// 	var tanhao_count = (text.split('!').length - 1) + (text.split('！').length - 1);
	// 	if (tanhao_count >= 3) {
	// 		tanhao_count = 3;
	// 	}
	// 	font_size += tanhao_count * 5;
	// 	panel.FindChild('Text').style['font-size'] = font_size + 'px';
	// 	panel.FindChild('Text').style['line-height'] = font_size + 'px';
	// 	panel.FindChild('Text').FindChild('Pic').visible = false;
	// }

	// bubbleInfo['panel'] = panel;

	ShowChatBubble(unit_index, duration);

	$.Schedule(CHAT_BUBBLE_REFRESH_INVERTAL, () => {
		RefreshChatBubble(unit_index);
	});
}

function ShowChatBubble(unit_index, duration) {
	var bubbleInfo = chatBubbleTable[unit_index];
	if (!bubbleInfo) {
		return;
	}
	var panel = bubbleInfo.panel;
	if (!panel) {
		return;
	}
	panel.visible = true;
	panel.SetHasClass('show', true);
	$.Schedule(duration || 5, () => {
		panel.SetHasClass('show', false);
		HideChatBubble(unit_index);
	});
}
function HideChatBubble(unit_index) {
	var bubbleInfo = chatBubbleTable[unit_index];
	if (!bubbleInfo) {
		return;
	}
	var panel = bubbleInfo.panel;
	if (!panel) {
		return;
	}
	panel.visible = false;
}

function RefreshChatBubble(unit_index) {
	if (!unit_index) {
		HideChatBubble(unit_index);
		return;
	}
	if (!Entities.IsAlive(unit_index)) {
		// 已阵亡
		HideChatBubble(unit_index);
		return;
	}

	var origin = Entities.GetAbsOrigin(unit_index);
	if (!origin) {
		HideChatBubble(unit_index);
		return;
	}
	var bubbleInfo = chatBubbleTable[unit_index];
	if (!bubbleInfo || !bubbleInfo.panel) {
		HideChatBubble(unit_index);
		return;
	}

	// 计算panel位置
	var pos = [Game.WorldToScreenX(origin[0], origin[1], origin[2]), Game.WorldToScreenY(origin[0], origin[1], origin[2])];

	var w = Game.GetScreenWidth();
	var h = Game.GetScreenHeight();
	var panel = bubbleInfo.panel;

	if (pos[0] > w || pos[0] < 0 || pos[1] > h || pos[1] < 0)
		panel.visible = false;
	else {
		panel.visible = true;
		var maxwidth = (w / h) * 1080;
		var midwidth = maxwidth / 2;
		var newX = ((pos[0] / w) * maxwidth) - panel.actuallayoutwidth / 3;
		var newY = ((pos[1] / h) * 1080) - 120 - panel.actuallayoutheight / 3;

		if (newX > midwidth) {
			newX += ((newX - midwidth) / midwidth) * 125;
		}
		else {
			newX -= ((midwidth - newX) / midwidth) * 125;
		}

		if (newY > 540) {
			newY -= ((540 - newY) / 540) * 50;
		}
		else {
			newY += ((newY - 540) / 540) * 50;
		}

		var newPos = newX + "px " + newY + "px 0px";
		panel.style["position"] = newPos;
	}

	// 继续刷新
	$.Schedule(CHAT_BUBBLE_REFRESH_INVERTAL, () => {
		RefreshChatBubble(unit_index);
	});
}

function OnShowChatBubblePlayerBoard(keys) {
	var player_from = keys.player_from;
	var player_to = keys.player_to;

	player_from = Players.GetTeam(player_from) - 6;
	player_to = Players.GetTeam(player_to) - 6;
	// if (!CheckClientKey(keys.key)) return;

	if (IS_CHAT_BUBBLE_SHOWING[player_from]) {
		$.Schedule(0.1, function () {
			OnShowChatBubblePlayerBoard(keys);
		});
	}
	else {
		// $('#panel_chat_bubble_'+player_from).SetHasClass('invisible',false);
		$('#panel_chat_bubble_' + player_from).style['position'] = '0px 0px 0px';
		$('#panel_chat_bubble_' + player_from).style['transform'] = 'scale3d( 1,1,1)';
		$('#panel_chat_bubble_arrow_' + player_from).style['transform'] = 'scale3d( 1,1,1)';
		var text = keys.text;
		if (keys.chess) {
			text = $.Localize('#'+('DOTA_Tooltip_ability_transfer_chess')) + ':\n' + $.Localize('#'+(keys.chess));
		}
		IS_CHAT_BUBBLE_SHOWING[player_from] = 1;

		if (player_from && Game.IsPlayerMuted(player_from) == true) {
			return;
		}

		if (!keys.emotion_index) {
			// 发文字
			$('#text_chat_bubble_' + player_from).text = text;
			$('#title_chat_bubble_' + player_from).text = '';
			$('#img_chat_bubble_' + player_from).SetHasClass('invisible', true);
			// Game.EmitSound("ui.courier_in_use");
			$('#panel_chat_bubble_' + player_from).style['height'] = '100px';

			var font_size = 25;
			var tanhao_count = (text.split('!').length - 1) + (text.split('！').length - 1);
			if (tanhao_count >= 3) {
				tanhao_count = 3;
			}
			font_size += tanhao_count * 5;
			$('#text_chat_bubble_' + player_from).style['font-size'] = font_size + 'px';
			$('#text_chat_bubble_' + player_from).style['line-height'] = font_size + 'px';
		}
		else {
			// 发表情
			var m_info;
			for (var i in EMOTION_LIST) {
				if (EMOTION_LIST[i].emotion_index == keys.emotion_index) {
					m_info = EMOTION_LIST[i];
				}
			}
			$('#text_chat_bubble_' + player_from).text = '';
			$('#title_chat_bubble_' + player_from).text = '';
			$('#img_chat_bubble_' + player_from).SetHasClass('invisible', false);
			$('#img_chat_bubble_' + player_from).SetImage('file://{resources}/images/custom_game/chat/' + keys.emotion_index + '.png');
			$('#img_chat_bubble_' + player_from).style['transform'] = 'scale3d( EMOTIONSIZE, EMOTIONSIZE, EMOTIONSIZE)'.replace(/EMOTIONSIZE/g, m_info.size);
			Game.EmitSound("dac.emotion." + keys.emotion_index);
			$('#panel_chat_bubble_' + player_from).style['height'] = '100px';
		}

		$.Schedule(5, function () {
			IS_CHAT_BUBBLE_SHOWING[player_from] = 0;
			// $('#text_chat_bubble_'+player_from).text = '';
			$('#text_chat_bubble_' + player_from).style['font-size'] = '22px';
			// $('#panel_chat_bubble_'+player_from).SetHasClass('invisible',true);
			$('#panel_chat_bubble_' + player_from).style['position'] = '100px 0px 0px';
			$('#panel_chat_bubble_' + player_from).style['transform'] = 'scale3d( 0.001,0.001,0.001)';
			$('#panel_chat_bubble_arrow_' + player_from).style['transform'] = 'scale3d( 0.001,0.001,0.001)';
		});
	}
}