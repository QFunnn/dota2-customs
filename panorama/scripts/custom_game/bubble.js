--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


// 自定义对话气泡
let chatBubbleTable = {};
const CHAT_BUBBLE_REFRESH_INVERTAL = 0.01;

(function () {
	GameEvents.Subscribe("chat_bubble", (keys) => {
		InitChatBubble(keys.unit_index, keys.pic, keys.text);
	});
})();

function InitChatBubble(unit_index, pic, text) {
	if (chatBubbleTable[unit_index] && chatBubbleTable[unit_index].panel){
		// 重复创建，需要销毁之前的panel
		chatBubbleTable[unit_index].panel.RemoveAndDeleteChildren();
	}

	var bubbleInfo = {
		unit: unit_index,
		pic: pic,
		text: text,
	};
	chatBubbleTable[unit_index] = bubbleInfo;

	var panel = bubbleInfo['panel'];
	panel = $.CreatePanel('Panel', $.GetContextPanel(), "");
	panel.BLoadLayoutSnippet('bubble');

	if (pic){
		// 图片气泡
		var pic_panel = panel.FindChild('Text').FindChild('Pic');
		panel.FindChild('Text').text = '';
		panel.FindChild('Text').style['padding'] = '0px';
		if (pic_panel) {
			pic_panel.visible = true;

			var m_info;
			for (var i in EMOTION_LIST) {
				if (EMOTION_LIST[i].emotion_index == pic) {
					m_info = EMOTION_LIST[i];
				}
			}
			pic_panel.SetImage('file://{resources}/images/custom_game/chat/' + pic + '.png');
			pic_panel.style['transform'] = 'scale3d( EMOTIONSIZE, EMOTIONSIZE, EMOTIONSIZE)'.replace(/EMOTIONSIZE/g, m_info.size);
			pic_panel.style['vertical-align'] = 'center';
		}
	}
	else{
		// 文字气泡
		panel.FindChild('Text').text = text;
		panel.FindChild('Text').style['padding'] = '15px';
		var font_size = 25;
		var tanhao_count = (text.split('!').length - 1) + (text.split('！').length - 1);
		if (tanhao_count >= 3) {
			tanhao_count = 3;
		}
		font_size += tanhao_count * 5;
		panel.FindChild('Text').style['font-size'] = font_size + 'px';
		panel.FindChild('Text').style['line-height'] = font_size + 'px';
		panel.FindChild('Text').FindChild('Pic').visible = false;
	}

	bubbleInfo['panel'] = panel;

	ShowChatBubble(unit_index);

	$.Schedule(CHAT_BUBBLE_REFRESH_INVERTAL, () => {
		RefreshChatBubble(unit_index);
	});
}

function ShowChatBubble(unit_index) {
	var bubbleInfo = chatBubbleTable[unit_index];
	if (!bubbleInfo) {
		return;
	}
	var panel = bubbleInfo.panel;
	if (!panel) {
		return;
	}
	panel.visible = true;
	panel.SetHasClass('show',true);
	$.Schedule(5,()=>{
		panel.SetHasClass('show',false);
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
		panel.visible = true;
	}

	// 继续刷新
	$.Schedule(HP_BAR_REFRESH_INVERTAL, () => {
		RefreshChatBubble(unit_index);
	});
}