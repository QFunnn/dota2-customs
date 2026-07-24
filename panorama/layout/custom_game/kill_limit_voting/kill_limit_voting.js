--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
const specific_kill_limit_by_map = {
	ot3_necropolis_ffa: 1,
};
let is_increased_kl = false;

function IncreaseKillLimit() {
	if (!CONTEXT.BHasClass("Show") || is_increased_kl) return;

	is_increased_kl = true;
	GameEvents.SendToServerEnsured("kl_voting:vote_additional_goal", {});
	HideKillLimitVoting();
}

function IncreaseKillLimitByToken() {
	if (!CONTEXT.BHasClass("BGGTokensOwned") || !CONTEXT.BHasClass("Show") || is_increased_kl) return;

	is_increased_kl = true;
	GameUI.Inventory.ConsumeItem("bp_gg_token", 1);
	HideKillLimitVoting();
}

function HideKillLimitVoting() {
	CONTEXT.SetHasClass("Show", false);
}

function ShowKillLimitVoting() {
	CONTEXT.SetHasClass("Show", true);
}

const TOKENS_INC_KL_BY_MPA = {
	ot3_necropolis_ffa: 10,
	ot3_gardens_duo: 10,
	ot3_jungle_quintet: 15,
	ot3_desert_octet: 20,
};

(() => {
	HideKillLimitVoting();
	if (IsSpectating()) return;

	if (Game.GetMapInfo().map_display_name === "ot3_demo") return;

	CONTEXT.SetDialogVariableInt("kill_limit_inc", specific_kill_limit_by_map[MAP_NAME] || 2);
	CONTEXT.SetDialogVariableInt("kill_limit_inc_token", TOKENS_INC_KL_BY_MPA[MAP_NAME] || 10);

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());
	frame.SubscribeProtected("kl_voting:show", ShowKillLimitVoting);

	GameEvents.SendToServerEnsured("kl_voting:get_state", {});

	GameUI.Inventory.RegisterForInventoryChanges(() => {
		const tokens_count = GameUI.Inventory.GetItemCount("bp_gg_token");
		const b_has_tokens = tokens_count > 0;
		CONTEXT.SetHasClass("BGGTokensOwned", b_has_tokens);

		if (b_has_tokens) CONTEXT.SetDialogVariable("gg_token_count", GameUI.Inventory.GetItemCount("bp_gg_token"));
	});
})();