--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function RegisterContextMenuStyleChanged() {
	const context_menu_manager = FindDotaHudElement("ContextMenuManager");
	if (!context_menu_manager) return void $.Schedule(0, RegisterContextMenuStyleChanged);

	const swap_loc_tokens = [$.Localize("#DOTA_UserMenu_Swap"), $.Localize("#DOTA_HUD_Scoreboard_SwapHero")];

	const check_scoreboard_context_style = () => {
		const scoreboard_context_menu = context_menu_manager.FindChildTraverse("ScoreboardMuteContextMenu");
		if (!scoreboard_context_menu) return void $.Schedule(0, check_scoreboard_context_style);

		const buttons = scoreboard_context_menu.FindChildTraverse("MenuOptionsPanel");
		if (!buttons || !buttons.IsValid()) return;

		for (const button of buttons.Children()) {
			const text = button.GetChild(0)?.text;
			if (!text) continue;

			if (swap_loc_tokens.includes(text)) button.visible = false;
		}
	};

	$.RegisterEventHandler("PanelStyleChanged", context_menu_manager, check_scoreboard_context_style);
}

(() => {
	RegisterContextMenuStyleChanged();
})();