--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// /* 
// 	ti12竞猜
// */

function ShowEventti12(){
	ShowExclusionWindow('panel_event_ti12');
}

function OnMouseOverEventti12(t,pos){
	$.DispatchEvent("DOTAShowTitleTextTooltip", $("#" + pos), $.Localize('#'+t + '_title'), $.Localize('#'+t));
	// $('#icon_event_ti12_fire').style.opacity = '1';
}
function OnMouseOutEventti12(){
	$.DispatchEvent("DOTAHideTitleTextTooltip");
	// $('#icon_event_ti12_fire').style.opacity = '0';
}

function ShowBetInfo(info){
	var is_bet_expired = false;
	var panel = FindDotaHudElement('panel_event_ti12_container');
	if (!panel || !info){
		return;
	}
	panel.RemoveAndDeleteChildren();
	if (Date.now() / 1000 >= info.end_time) {
		is_bet_expired = true;
	}

	// 按赔率排序
	var team_arr = [];
	for (var i in info.teams){
		info.teams[i]['team_id'] = i;
		team_arr.push(info.teams[i]);
	}
	team_arr.sort(function(a,b){
		var br_a = 0;
		var br_b = 0;
		if (a.name == 'TBD1'){
			br_a = 9998;
		}
		else if (a.name == 'TBD2'){
			br_a = 9999;
		}
		else{
			br_a = parseFloat(a.bet_rate||0);
		}
		if (b.name == 'TBD1'){
			br_b = 9998;
		}
		else if (b.name == 'TBD2'){
			br_b = 9999;
		}
		else{
			br_b = parseFloat(b.bet_rate||0);
		}
		return br_a - br_b;
	});
	for (var i =0;i<team_arr.length;i++){
		var t = team_arr[i];

		var outer_class = 'bet_one_outer';
		if (t.mychoice){
			outer_class = 'bet_one_outer my_choice';
		}
		var bet_one = $.CreatePanel('Panel', panel, '', {
			class: outer_class,
		});
		var bet_one_image_container = $.CreatePanel('Panel', bet_one, '', {
			class: 'bet_one_image_container',
		});

		// if (t.pic == "file://{images}/custom_game/event/ti15/team/16.png"){
		// 	t.pic = "file://{images}/custom_game/event/ti15/team/15.png";
		// }
		var bet_one_image = $.CreatePanel('Image', bet_one_image_container, '', {
			class: 'bet_one_image',
			style: 'z-index:50;',
			src: t.pic,
		});

		InitTeamHover(bet_one_image,t);

		if (t.mychoice){
			// 显示我的预测
			$.CreatePanel('Label', bet_one_image_container, '', {
				class : 'my_prediction',
				text: $.Localize('#text_ti12_my_team'),
			});
			$.CreatePanel('Panel', bet_one_image_container, '', {
				class: 'my_prediction_bg',
			});
		}

		var team_name = $.CreatePanel('Label', bet_one, '', {
			style: 'horizontal-align:center; color:#fae5d3; font-size:22px;height:25px;',
			text: t.name,
		});

		if (!t.active){
			// 已淘汰
			$.CreatePanel('Label', bet_one, '', {
				style: 'horizontal-align:center; color:#666; font-size:18px; border: 2px solid #444;border-radius:0px;height:25px;',
				text: $.Localize('#text_ti12_dead_team'),
			});
			bet_one_image.SetHasClass('unavailable',true);
			team_name.SetHasClass('unavailable',true);
		}
		else{
			if (!t.prize){
				// 显示赔率
				$.CreatePanel('Label', bet_one, '', {
					style: 'horizontal-align:center; color:#fae5d3; font-size:22px;height:25px;',
					text: '@ '+t.bet_rate,
				});
			}
			else{
				// 显示 冠亚季军
				if (t.prize == 1){
					$.CreatePanel('Label', bet_one, '', {
						style: 'horizontal-align:center; color:#ffff00; font-size:22px;height:25px;',
						text: $.Localize('#text_ti12_1st'),
					});
				}
				if (t.prize == 2){
					$.CreatePanel('Label', bet_one, '', {
						style: 'horizontal-align:center; color:#bbbbdd; font-size:22px;height:25px;',
						text: $.Localize('#text_ti12_2nd'),
					});
				}
				if (t.prize == 3){
					$.CreatePanel('Label', bet_one, '', {
						style: 'horizontal-align:center; color:#dd8888; font-size:22px;height:25px;',
						text: $.Localize('#text_ti12_3rd'),
					});
				}
				
			}
			
		}
		
		var button = $.CreatePanel('Panel', bet_one, '', {
			class: 'dota_button',
			style: 'width:100%;height:40px;margin-top:5px;flow-children:right;',
		});
		var button_inner = $.CreatePanel('Panel', button, '', {
			style: 'vertical-align:center;horizontal-align:center;flow-children:right;',
		});

		$.CreatePanel('Image', button_inner, '', {
			style: 'width:30px;height:30px;vertical-align:center;',
			src: 'file://{images}/custom_game/candy.png',
		});
		$.CreatePanel('Label', button_inner, '', {
			style: 'font-size:24px;color:#fff;text-shadow:2px 2px 2px #330000;font-family:titleFont;margin-left:5px;vertical-align:center;',
			text: '× '+t.bet_candy,
		});

		if (!info.is_bet_available || is_bet_expired || info.my_bet || MY_CANDY < 40){
			button.SetHasClass('unavailable',true);
		}
		else{
			InitButtonBuyBet(button,t.team_id,t);
		}
	}

	

	// 竞猜剩余时间
	if (info.is_bet_available && info.end_time){
		$.Schedule(1, function () {
			ti12_COUNTDOWN_VER++;
			show_ti12_countdown(info.end_time || 1756915200, ti12_COUNTDOWN_VER);
		});
	}
	else{
		FindDotaHudElement('text_ti12_countdown').text = $.Localize('#'+'ti12_countdown_expired');
	}

	// 领奖按钮
	var award_button = FindDotaHudElement('panel_event_ti12_get_award');
	if (info.is_award_available && award_button){
		award_button.SetHasClass('invisible',false);

		if (info.my_bet && info.teams[info.my_bet].prize){	
			award_button.SetPanelEvent(
				"onactivate",
				function () {
					RequestBetAward();
				}
			);
		}
		else{
			award_button.SetHasClass('unavailable',true);
		}
	}
}

function RequestBetAward(){
	var award_button = FindDotaHudElement('panel_event_ti12_get_award');
	if (award_button.BHasClass('unavailable')){
		return;
	}
	if (award_button){
		award_button.SetHasClass('unavailable',true);
	}
	GameEvents.SendCustomGameEventToServer("catch_crab", {
        event: 'get_bet_award',
        cb: 'get_bet_award_cb',
        params: { },
        user_specific: 1,
    });
}

var ti12_COUNTDOWN_VER = 0;
function show_ti12_countdown(refresh_time, ver) {
	if (ver != ti12_COUNTDOWN_VER) {
		return;
	}
	
	if (Date.now() / 1000 >= refresh_time) {
		FindDotaHudElement('text_ti12_countdown').text = $.Localize('#'+'ti12_countdown_expired');
		return;
	}
	var text = time2showtime_day(refresh_time - Math.floor(Date.now() / 1000));
	FindDotaHudElement('text_ti12_countdown').text = $.Localize('#text_ti12_countdown') + ' '+ text;
	$.Schedule(1, function () {
		show_ti12_countdown(refresh_time, ver);
	});
}
function time2showtime_day(t) {
    var h = 0, m = 0, s = 0;
    if (!t) return "00:00:00";

    t = parseInt(t);
	d = Math.floor(t / 86400);
    h = Math.floor((t-d*86400) / 3600);
    m = Math.floor(((t-d*86400) - h * 3600) / 60);
    s = (t-d*86400) - h * 3600 - m * 60;

    h = h < 10 ? '0' + h : h;
    m = m < 10 ? '0' + m : m;
    s = s < 10 ? '0' + s : s;
    return d + $.Localize("#day") +' '+ h + ':' + m + ':' + s;
}
function InitButtonBuyBet(button,team_id,t){
	button.SetPanelEvent(
		"onactivate",
		function () {
			ConfirmBuyBet(team_id, t);
		}
	);
}
function InitTeamHover(panel,t){
	var title = t.name;
	var text = '';
	if (title == 'TBD1'){
		title = $.Localize('#text_ti12_bet_tbd1');
		text += $.Localize('#text_ti12_bet_tbd_desc')+'<br>';
	}
	if (title == 'TBD2'){
		title = $.Localize('#text_ti12_bet_tbd2');
		text += $.Localize('#text_ti12_bet_tbd_desc')+'<br>';
	}

	text += $.Localize('#text_ti12_bet_rate')+': '+(t.bet_rate||0);
	text += '<br>'+$.Localize('#text_ti12_bet_candy')+': '+(t.bet_candy||0);
	if (t.bet_rate == '?'){
		text += '<br>'+$.Localize('#text_ti12_bet_candy_win')+': ?';
	}
	else{
		text += '<br>'+$.Localize('#text_ti12_bet_candy_win')+': '+(Math.floor(t.bet_candy*t.bet_rate)||0);
	}
	

	panel.SetPanelEvent("onmouseover",
        function () {
            $.DispatchEvent("DOTAShowTitleTextTooltip", panel, title, text);
        }
    );
    panel.SetPanelEvent("onmouseout",
        function () {
            $.DispatchEvent("DOTAHideTextTooltip");
            $.DispatchEvent("DOTAHideTitleTextTooltip");
        }
    );
}

var BET_TEAM_INDEX = 0;
function ConfirmBuyBet(index, team_info){
	var team_name = team_info.name;
	var price = team_info.bet_candy;
	var win_candy = Math.floor(price*team_info.bet_rate);
	if (isNaN(win_candy)){
		win_candy = '?';
	}
	var text = $.Localize('#text_ti12_bet_confirm').replace('<candy>',price).replace('<team>',' '+team_name+' ').replace('<candy2>',win_candy);
	show_confirm(text, function(){
		RequestBuyBet();
	});
	BET_TEAM_INDEX = index;
}

function RequestBuyBet(){
    FindDotaHudElement('confirm_box').SetHasClass('invisible', true);
	GameEvents.SendCustomGameEventToServer("catch_crab", {
        event: 'buy_bet',
        cb: 'buy_bet_cb',
        params: { team: BET_TEAM_INDEX },
        user_specific: 1,
    });
}