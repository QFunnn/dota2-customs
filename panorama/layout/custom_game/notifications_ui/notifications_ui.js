--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	NOTIFICATIONS_TOP: $("#Norifications_TOP"),
};

function WeakTeamNotification(data) {
	const panel = $.CreatePanel("Panel", HUD.NOTIFICATIONS_TOP, "");
	panel.BLoadLayoutSnippet("WeakTeamBonus");

	panel.SetDialogVariable("mmr_diff", Math.abs(data.mmrDiff));
	panel.SetDialogVariable("exp_pct", Math.rd(data.xp_multiplier, 1));
	panel.SetDialogVariable("gold_pct", Math.rd(data.gold_multiplier * 100 - 100, 2));

	panel.SetHasClass("show", true);

	panel.FindChildTraverse("WeakClose").SetPanelEvent("onactivate", () => {
		panel.SetHasClass("show", false);
	});
}
(() => {
	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);
	frame.SubscribeProtected("WeakTeamNotification", WeakTeamNotification);
})();