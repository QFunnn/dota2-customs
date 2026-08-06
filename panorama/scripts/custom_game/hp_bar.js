--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


// 自定义血条
let hpBarTable = {};
const HP_BAR_REFRESH_INVERTAL = 0.01;
const HP_SPLITTER_SIZE = 500;


// 初始化HUD
$.GetContextPanel().RemoveAndDeleteChildren();

// 从nettable显示当前血条
UpdateHPBar();

function UpdateHPBar() {
	var hp_bar_nettable = CustomNetTables.GetTableValue("hp_bar_table", 'hp_bar');
	for (var index in hp_bar_nettable) {
		if (!hpBarTable[index] && Entities.IsAlive(parseInt(index))) {
			InitHpBar(hp_bar_nettable[index].unit_index);
		}
	}

	$.Schedule(1, () => {
		UpdateHPBar();
	});
}

function ShowHpBar(unit_index) {
	var barInfo = hpBarTable[unit_index];
	if (!barInfo) {
		return;
	}
	var panel = barInfo.panel;
	if (!panel) {
		return;
	}
	panel.visible = true;
}
function HideHpBar(unit_index) {
	var barInfo = hpBarTable[unit_index];
	if (!barInfo) {
		return;
	}
	var panel = barInfo.panel;
	if (!panel) {
		return;
	}
	panel.visible = false;
}

function GetBarInfo(unit_index, barInfo) {
	if (!barInfo) {
		barInfo = {};
	}
	// 基本信息
	barInfo['unit'] = unit_index;
	barInfo['player_id'] = Entities.GetPlayerOwnerID(unit_index);
	barInfo['team_id'] = Entities.GetTeamNumber(unit_index);

	if (Entities.IsHero(unit_index)) {
		// 英雄（信使）
		barInfo['is_hero'] = true;
		barInfo['hp_bar_width'] = 140;
		barInfo['hp_bar_height'] = 14;
		barInfo['mp_bar_height'] = 7;
		if (Entities.GetTeamNumber(unit_index) == Players.GetTeam(Players.GetLocalPlayer())) {
			// 友方信使
			barInfo['hp_color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #79f27988 ), color-stop( 0.85, #79f279dd), to( #79f279ff ) )';
			barInfo['container_border'] = '1px solid #979897ff';
		}
		else {
			// 敌方信使
			barInfo['hp_color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #2da02788 ), color-stop( 0.85, #2da027dd), to( #2da027ff ) )';
			// barInfo['container_border'] = '1px solid #01010188';
			barInfo['container_border'] = '1px solid #979897ff';
		}
		barInfo['size'] = 0.8;

		var data = CustomNetTables.GetTableValue("player_id_table", 'courier_' + barInfo['player_id']);
		if (data && data.courier) {
			barInfo['courier_id'] = data.courier.split('_')[0];
		}
		if (data && (data.win_streak || data.win_streak == 0)) {
			barInfo['win_streak'] = data.win_streak || 0;
		}

		barInfo['player_name'] = html2Escape(Players.GetPlayerName(barInfo['player_id']));
	}
	else {
		// 棋子
		barInfo['is_hero'] = false;
		barInfo['hp_bar_width'] = 120;
		barInfo['hp_bar_height'] = 11;
		barInfo['mp_bar_height'] = 5;
		if (Entities.GetTeamNumber(unit_index) != 4) {
			// 主场棋子
			barInfo['hp_color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #47944788 ), color-stop( 0.85, #479447dd), to( #479447ff ) )';
			barInfo['container_border'] = '1px solid #979897ff';
		}
		else {
			// 客场棋子
			barInfo['hp_color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #7c000088 ), color-stop( 0.85, #8c0000dd), to( #8c0000ff ) )';
			barInfo['container_border'] = '1px solid #010101ff';
		}
		barInfo['size'] = 0.7;
		barInfo['transition-duration'] = 0.2;
	}

	barInfo['y_delta'] = 0;
	var hpbar_offset = Entities.GetHealthBarOffset(unit_index);
	if (hpbar_offset) {
		barInfo['y_delta'] = hpbar_offset + (barInfo['win_streak'] || 0) * 5;
	}

	// 生命值和法力值
	barInfo['hp_per_curr'] = Entities.GetHealthPercent(unit_index);
	barInfo['max_mp'] = Entities.GetMaxMana(unit_index);
	barInfo['max_hp'] = Entities.GetMaxHealth(unit_index);
	if (Entities.GetMaxMana(unit_index) > 0) {
		// 有蓝条
		barInfo['mp_per_curr'] = Entities.GetMana(unit_index) / Entities.GetMaxMana(unit_index) * 100;
		// barInfo['mp_color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #4f78fa88 ), color-stop( 0.85, #4f78fadd), to( #4f78faff ) )';
		barInfo['mp_color'] = 'gradient(linear, 0% 0%, 100% 0%, from( #4d47a088), color-stop(0.85, #4d47a0dd), to( #4d47a0ff))';
		// if (barInfo['mp_per_curr'] >= 100) {
		// 	barInfo['mp_color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #4f78fa88 ), color-stop( 0.85, #4f78fadd), to( #4f78faff ) )';
		// }
	}
	else {
		// 无蓝条
		// barInfo['hp_bar_height'] = barInfo['hp_bar_height'] + (barInfo['mp_bar_height'] / 2);
	}

	for (var i = 0; i < Entities.GetNumBuffs(unit_index); i++) {
		var buff_name = Buffs.GetName(unit_index, i);
		if (buff_name == 'modifier_kill' || buff_name == 'modifier_illusion') {
			barInfo['kill_remaining_time'] = Buffs.GetRemainingTime(unit_index, i);
			barInfo['kill_total_time'] = Buffs.GetRemainingTime(unit_index, i) + Buffs.GetElapsedTime(unit_index, i);
			barInfo['size'] = 0.6;
		}
	}

	if (Entities.GetUnitName(unit_index) == 'pve_black_dragon') {
		barInfo['size'] = 1;
		barInfo['hp_bar_width'] = 250;
		barInfo['hp_bar_height'] = 14;
		barInfo['boss_logo'] = 'file://{resources}/images/custom_game/pve_logo/35.png';
	}
	if (Entities.GetUnitName(unit_index) == 'pve_nian') {
		barInfo['size'] = 1;
		barInfo['hp_bar_width'] = 300;
		barInfo['hp_bar_height'] = 14;
		barInfo['boss_logo'] = 'file://{resources}/images/custom_game/pve_logo/45.png';
	}
	if (Entities.GetUnitName(unit_index) == 'pve_roshan') {
		barInfo['size'] = 1;
		barInfo['hp_bar_width'] = 300;
		barInfo['hp_bar_height'] = 14;
		barInfo['boss_logo'] = 'file://{resources}/images/custom_game/pve_logo/50.png';
	}
	if (Entities.GetUnitName(unit_index) == 'pve_leishou_a') {
		barInfo['size'] = 0.9;
		barInfo['hp_bar_width'] = 150;
		barInfo['hp_bar_height'] = 11;
	}
	if (Entities.GetUnitName(unit_index) == 'pve_vulture_a') {
		barInfo['size'] = 0.9;
		barInfo['hp_bar_width'] = 150;
		barInfo['hp_bar_height'] = 11;
	}
	if (Entities.GetUnitName(unit_index) == 'pve_vulture_b') {
		barInfo['size'] = 0.9;
		barInfo['hp_bar_width'] = 150;
		barInfo['hp_bar_height'] = 11;
	}
	if (Entities.GetUnitName(unit_index) == 'pve_troll_dark_b') {
		barInfo['size'] = 0.9;
		barInfo['hp_bar_width'] = 150;
		barInfo['hp_bar_height'] = 11;
	}
	if (Entities.GetUnitName(unit_index) == 'pve_troll_dark_c') {
		barInfo['size'] = 0.9;
		barInfo['hp_bar_width'] = 150;
		barInfo['hp_bar_height'] = 11;
	}
	if (Entities.GetUnitName(unit_index) == 'pve_bear_a') {
		barInfo['size'] = 0.9;
		barInfo['hp_bar_width'] = 120;
		barInfo['hp_bar_height'] = 11;
	}
	if (Entities.GetUnitName(unit_index) == 'pve_bear_b') {
		barInfo['size'] = 0.9;
		barInfo['hp_bar_width'] = 120;
		barInfo['hp_bar_height'] = 11;
	}
	if (Entities.GetUnitName(unit_index) == 'pve_wolf_big') {
		barInfo['size'] = 0.9;
		barInfo['hp_bar_width'] = 120;
		barInfo['hp_bar_height'] = 11;
	}

	return barInfo;
}
function InitHpBar(unit_index) {
	if (hpBarTable[unit_index] && hpBarTable[unit_index].panel) {
		// 重复创建，需要销毁之前的panel
		hpBarTable[unit_index].panel.RemoveAndDeleteChildren();
	}

	var barInfo = GetBarInfo(unit_index);

	hpBarTable[unit_index] = barInfo;

	// 画出这个bar
	var panel = barInfo['panel'];
	panel = $.CreatePanel('Panel', $.GetContextPanel(), "");
	panel.BLoadLayoutSnippet('hp_bar');

	if (barInfo['is_hero']) {
		panel.style['z-index'] = 100;
	}
	else {
		panel.style['z-index'] = 10;
	}

	if (barInfo.courier_id) {
		panel.FindChild('img_hp_bar_courier').visible = false;
		// panel.FindChild('img_hp_bar_courier').visible = true;
		// panel.FindChild('img_hp_bar_courier').SetImage("file://{resources}/images/custom_game/skaters/" + barInfo.courier_id + ".png");
	}
	else {
		panel.FindChild('img_hp_bar_courier').visible = false;
	}

	if (barInfo.boss_logo) {
		panel.FindChild('img_hp_bar_boss_logo').visible = true;
		panel.FindChild('img_hp_bar_boss_logo').SetImage(barInfo.boss_logo);
	}
	else {
		panel.FindChild('img_hp_bar_boss_logo').visible = false;
	}

	if (barInfo.player_name) {
		panel.FindChild('hp_bar_courier_name').text = barInfo.player_name;
	}
	else {
		panel.FindChild('hp_bar_courier_name').visible = false;
	}

	// panel.FindChild('hp_bar_courier_name').text = "ss.waiting";
	panel.FindChild('hp_bar_courier_name').style['color'] = GetWSColor(barInfo.win_streak || 0);

	// if (barInfo.is_hero) {
	// 	panel.FindChild('hp_bar_courier_hp_container').style['margin-left'] = '50px';
	// }

	if (barInfo['hp_bar_width']) {
		// panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr').style['width'] = barInfo['hp_bar_width'] + 'px';
		// panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['width'] = barInfo['hp_bar_width'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_bg0').style['width'] = barInfo['hp_bar_width'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_bg').style['width'] = barInfo['hp_bar_width'] + 'px';
		// panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').style['width'] = barInfo['hp_bar_width'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_bg').style['width'] = barInfo['hp_bar_width'] + 'px';
	}

	if (barInfo['hp_bar_height']) {
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr').style['height'] = barInfo['hp_bar_height'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['height'] = barInfo['hp_bar_height'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_bg0').style['height'] = barInfo['hp_bar_height'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_bg').style['height'] = barInfo['hp_bar_height'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').style['margin-top'] = barInfo['hp_bar_height'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_bg').style['margin-top'] = barInfo['hp_bar_height'] + 'px';
	}
	if (barInfo['mp_bar_height']) {
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').style['height'] = barInfo['mp_bar_height'] + 'px';
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_bg').style['height'] = barInfo['mp_bar_height'] + 'px';
	}

	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['transition-delay'] = '0s';
	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['transition-duration'] = '0s';
	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr').style['width'] = (barInfo.hp_per_curr / 100.0 * (barInfo['hp_bar_width'] || 120)) + "px";
	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_bg0').style['width'] = (barInfo.hp_per_curr / 100.0 * (barInfo['hp_bar_width'] || 120)) + "px";
	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['width'] = (barInfo.hp_per_curr / 100.0 * (barInfo['hp_bar_width'] || 120)) + "px";
	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['transition-delay'] = (barInfo['transition-duration'] || 0.5) + 's';
	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['transition-duration'] = (barInfo['transition-duration'] || 0.5) + 's';

	if (barInfo['hp_color']) {
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr').style['background-color'] = barInfo['hp_color'];
	}
	if (barInfo['mp_color']) {
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').style['background-color'] = barInfo['mp_color'];
	}

	if (barInfo['container_border']) {
		panel.FindChild('hp_bar_courier_hp_container').style['border'] = barInfo['container_border'];
	}

	if (barInfo['max_mp'] <= 0) {
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').visible = false;
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_bg').style['height'] = barInfo['mp_bar_height'] / 2 + 'px';
	}
	else {
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').style['width'] = (barInfo.mp_per_curr / 100.0 * (barInfo['hp_bar_width'] || 120)) + "px";
	}

	// 画竖线
	var hp_curr_panel = panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr');
	hp_curr_panel.RemoveAndDeleteChildren();
	if (barInfo.max_hp && barInfo.max_hp > 100) {
		var splitter_size = barInfo['hp_bar_width'] * HP_SPLITTER_SIZE / barInfo.max_hp;
		for (var i = splitter_size; i < barInfo['hp_bar_width']; i += splitter_size) {
			// 在i处画一条竖线

			$.CreatePanel('Panel', hp_curr_panel, 'shuxian' + Math.random() * 1000, {
				style: 'width:1px;height:100%;border-right:2px solid #00000088;margin-left:' + i + 'px;',
			});
		}
	}
	// $.CreatePanel('Panel', hp_curr_panel, 'yinying', {
	// 	style: 'width:100%;height:50%;vertical-align:bottom;background-color:#00000033;',
	// });

	barInfo['panel'] = panel;

	ShowHpBar(unit_index);

	// $.Msg('+血条：' + unit_index + '/' + Entities.GetUnitName(unit_index) + '/' + (barInfo.player_name || ''));

	$.Schedule(HP_BAR_REFRESH_INVERTAL, () => {
		RefreshHpBar(unit_index);
	});
	$.Schedule(1, () => {
		RefreshHpBarFull(unit_index);
	});
}

function RefreshHpBar(unit_index) {
	if (!unit_index) {
		// $.Msg('!unit_index');
		HideHpBar(unit_index);
		return;
	}
	var origin = Entities.GetAbsOrigin(unit_index);
	if (!origin) {
		HideHpBar(unit_index);
	}

	var barInfo = hpBarTable[unit_index];

	if (!barInfo || !barInfo.panel) {
		// $.Msg('!barInfo || !barInfo.panel');
		HideHpBar(unit_index);
		return;
	}
	if (!Entities.IsAlive(unit_index) || Entities.GetHealth(unit_index) <= 0) {
		// 死了，不显示血条
		var panel = barInfo.panel;
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr').style['width'] = "0px";
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_bg0').style['width'] = "0px";
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['width'] = "0px";
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').style['width'] = "0px";

		panel.FindChild('hp_bar_remaining_time').visible = false;
		panel.FindChild('hp_bar_remaining_time_bg').visible = false;

		if (barInfo['is_hero'] == false) {
			hide_delay = 0.1;
		}
		else {
			hide_delay = 1;
		}
		panel.FindChild('hp_bar_courier_hp_container').style['transition-property'] = 'opacity,transform';
		panel.FindChild('hp_bar_courier_hp_container').style['transition-delay'] = hide_delay / 2 + 's';
		panel.FindChild('hp_bar_courier_hp_container').style['transition-duration'] = hide_delay / 2 + 's';
		panel.FindChild('hp_bar_courier_hp_container').style['opacity'] = '0';
		// panel.FindChild('hp_bar_courier_hp_container').style['transform'] = 'scale3d( 3, 3, 3)';

		var hide_delay = 1;

		// $.Msg('死亡，销毁血条：' + unit_index + '/' + Entities.GetUnitName(unit_index));

		$.Schedule(hide_delay, () => {
			panel.DeleteAsync(1);
			delete hpBarTable[unit_index];
			// HideHpBar(unit_index);
		});
		return;
	}
	// barInfo = GetBarInfo(unit_index, barInfo);
	// 更新一些变量
	// 生命值和法力值
	barInfo['hp_per_curr'] = Entities.GetHealthPercent(unit_index);
	barInfo['max_mp'] = Entities.GetMaxMana(unit_index);
	if (Entities.GetMaxMana(unit_index) > 0) {
		// 有蓝条
		barInfo['mp_per_curr'] = Entities.GetMana(unit_index) / Entities.GetMaxMana(unit_index) * 100;
		barInfo['mp_color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #4d47a088 ), color-stop( 0.85, #4d47a0dd), to( #4d47a0ff ) )';
		// if (barInfo['mp_per_curr'] >= 100) {
		// 	barInfo['mp_color'] = 'gradient( linear, 0% 0%, 100% 0%, from( #4f78fa88 ), color-stop( 0.85, #4f78fadd), to( #4f78faff ) )';
		// }
	}
	else {
		// 无蓝条
		// barInfo['hp_bar_height'] = barInfo['hp_bar_height'] + (barInfo['mp_bar_height'] / 2);
	}

	for (var i = 0; i < Entities.GetNumBuffs(unit_index); i++) {
		var buff_name = Buffs.GetName(unit_index, i);
		if (buff_name == 'modifier_kill' || buff_name == 'modifier_illusion') {
			barInfo['kill_remaining_time'] = Buffs.GetRemainingTime(unit_index, i);
			barInfo['kill_total_time'] = Buffs.GetRemainingTime(unit_index, i) + Buffs.GetElapsedTime(unit_index, i);
			// barInfo['size'] = 0.6;
		}
	}

	var size = 1;

	// 计算panel位置
	var pos = [Game.WorldToScreenX(origin[0], origin[1], origin[2]), Game.WorldToScreenY(origin[0], origin[1], origin[2])];

	var w = Game.GetScreenWidth();
	var h = Game.GetScreenHeight();
	var panel = barInfo.panel;

	if (pos[0] > w || pos[0] < 0 || pos[1] > h || pos[1] < 0) {
		panel.visible = false;
	}
	else {
		panel.visible = true;
		var maxwidth = (w / h) * 1080;
		var midwidth = maxwidth / 2;
		var maxheight = 1080;//1920 * h / w;
		var midheight = maxheight / 2;

		var newX = ((pos[0] / w) * maxwidth);
		var newY = ((pos[1] / h) * maxheight);

		if (newX > midwidth) {
			newX += ((newX - midwidth) / midwidth) * 125;
		}
		else {
			newX -= ((midwidth - newX) / midwidth) * 125;
		}

		// if (newY > midheight) {
		// 	newY -= ((midheight - newY) / midheight) * 20;
		// }
		// else {
		// 	newY += ((newY - midheight) / midheight) * 20;
		// }

		newX -= (panel.actuallayoutwidth / w * maxwidth) / 2;
		newY -= (panel.actuallayoutheight / midheight * maxheight) / 2;

		size = size * (barInfo['size'] || 1);
		newY -= barInfo.y_delta / 2 * size;

		// 近大远小
		// var far_near_size = ((newY - midheight) / 100.0 * 10) / 100 + 1.2;
		// size = size * (far_near_size || 1);
		size = size * 1.3;

		var newPos = newX + "px " + newY + "px 0px";
		panel.style["position"] = newPos;
		panel.style["transform"] = 'scale3d(' + size + ',' + size + ',' + size + ')';
		if (HIDE_ALL_HP_BARS) {
			panel.visible = false;
		}
		else {
			panel.visible = true;
		}

	}

	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr').style['width'] = (barInfo.hp_per_curr / 100.0 * (barInfo['hp_bar_width'] || 120)) + "px";
	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_bg0').style['width'] = (barInfo.hp_per_curr / 100.0 * (barInfo['hp_bar_width'] || 120)) + "px";
	panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').style['width'] = (barInfo.hp_per_curr / 100.0 * (barInfo['hp_bar_width'] || 120)) + "px";
	if (barInfo['max_mp'] <= 0) {
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').visible = false;
		// panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_bg').style['width'] = '20px';
		// panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_bg').style['horizontal-align'] = 'right';
	}
	else {
		panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').style['width'] = (barInfo.mp_per_curr / 100.0 * (barInfo['hp_bar_width'] || 120)) + "px";
		if (barInfo['mp_color']) {
			panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_mp_curr').style['background-color'] = barInfo['mp_color'];
		}
	}

	if (barInfo['kill_remaining_time'] && barInfo['kill_total_time']) {
		var deg = 1.0 * barInfo['kill_remaining_time'] / barInfo['kill_total_time'] * 360;
		panel.FindChild('hp_bar_remaining_time').visible = true;
		panel.FindChild('hp_bar_remaining_time').style['background-color'] = barInfo['hp_color'];
		panel.FindChild('hp_bar_remaining_time_bg').visible = true;
		panel.FindChild('hp_bar_remaining_time').style['clip'] = 'radial( 50.0% 50.0%, 0.0deg, ' + deg + 'deg)';
	}
	else {
		panel.FindChild('hp_bar_remaining_time').visible = false;
		panel.FindChild('hp_bar_remaining_time_bg').visible = false;
	}

	// if (panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr').actuallayoutwidth != panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_last').actuallayoutwidth){
	// 	panel.SetHasClass('big',true);
	// }
	// else{
	// 	panel.SetHasClass('big',false);
	// }

	// $.Msg(Players.GetPerspectivePlayerId());
	// if (Players.IsLocalPlayerInPerspectiveCamera()){
	// 	panel.visible = false;
	// }
	// else{
	// 	panel.visible = true;
	// }

	// 隐身
	if (panel.visible == true && Entities.GetAbilityByName( unit_index,'invisible_to_enemy') >= 0){
		panel.visible = false;
	}
	if (panel.visible == true && GameUI.GetCameraYaw() != 0){
		panel.visible = false;
	}
	


	// 继续刷新
	$.Schedule(HP_BAR_REFRESH_INVERTAL, () => {
		RefreshHpBar(unit_index);
	});
}

function RefreshHpBarFull(unit_index) {
	var barInfo = hpBarTable[unit_index];

	if (!barInfo || !barInfo.panel) {
		HideHpBar(unit_index);
		return;
	}
	var panel = barInfo.panel;

	// 刷新所有信息
	barInfo = GetBarInfo(unit_index, barInfo);

	if (barInfo.courier_id) {
		panel.FindChild('img_hp_bar_courier').visible = false;
		//panel.FindChild('img_hp_bar_courier').visible = true;
		//panel.FindChild('img_hp_bar_courier').SetImage("file://{resources}/images/custom_game/skaters/" + barInfo.courier_id + ".png");
	}
	else {
		panel.FindChild('img_hp_bar_courier').visible = false;
	}

	if (barInfo.boss_logo) {
		panel.FindChild('img_hp_bar_boss_logo').visible = true;
		panel.FindChild('img_hp_bar_boss_logo').SetImage(barInfo.boss_logo);
	}
	else {
		panel.FindChild('img_hp_bar_boss_logo').visible = false;
	}

	if (barInfo.player_name) {
		panel.FindChild('hp_bar_courier_name').text = barInfo.player_name;
	}
	else {
		panel.FindChild('hp_bar_courier_name').visible = false;
	}

	// panel.FindChild('hp_bar_courier_name').text = "妈妈说名字太长躲在树林里会被敌人发现！！";
	if (barInfo.win_streak) {
		panel.FindChild('hp_bar_courier_name').style['color'] = GetWSColor(barInfo.win_streak || 0);
	}
	else {
		panel.FindChild('hp_bar_courier_name').style['color'] = GetWSColor(0);
	}


	// 画竖线
	var hp_curr_panel = panel.FindChild('hp_bar_courier_hp_container').FindChild('hp_bar_courier_hp_curr');
	hp_curr_panel.RemoveAndDeleteChildren();
	if (barInfo.max_hp && barInfo.max_hp > 100) {
		var splitter_size = barInfo['hp_bar_width'] * HP_SPLITTER_SIZE / barInfo.max_hp;
		for (var i = splitter_size; i < barInfo['hp_bar_width']; i += splitter_size) {
			// 在i处画一条竖线

			$.CreatePanel('Panel', hp_curr_panel, 'shuxian' + Math.random() * 1000, {
				style: 'width:1px;height:100%;border-right:2px solid #00000088;margin-left:' + i + 'px;',
			});
		}
	}
	// $.CreatePanel('Panel', hp_curr_panel, 'yinying', {
	// 	style: 'width:100%;height:40%;vertical-align:bottom;margin-bottom:0px;background-color:#00000025;',
	// });

	// 继续刷新
	$.Schedule(1, () => {
		RefreshHpBarFull(unit_index);
	});
}

var HIDE_ALL_HP_BARS = false;
// FindDotaHudElement('HeroViewButton').SetPanelEvent("onfocus",
// 	function(){
// 		$.Msg('onfocus');
// 		HIDE_ALL_HP_BARS = true;
// 	}
// );
// FindDotaHudElement('HeroViewButton').SetPanelEvent("onblur",
// 	function(){
// 		$.Msg('onblur');
// 		HIDE_ALL_HP_BARS = false;
// 	}
// );
// FindDotaHudElement('HeroViewButton').SetPanelEvent("oncancel",
// 	function(){
// 		$.Msg('oncancel');
// 		HIDE_ALL_HP_BARS = false;
// 	}
// );