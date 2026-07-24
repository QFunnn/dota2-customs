--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const ROOT = $.GetContextPanel().GetParent().GetParent().GetParent();
const PROMO_ROOT = ROOT.FindChildTraverse("StrategyFriendsAndFoes");
const PASS_UPSELL = ROOT.FindChildTraverse("BattlePassHeroUpsell");
const PASS_HEADER = PASS_UPSELL.GetChild(0);
const PASS_ICON = PASS_HEADER.GetChild(0);
const INFO_ICON = PASS_HEADER.GetChild(2).GetChild(0);
const HEADER_TITLE = PASS_HEADER.GetChild(1).GetChild(0);
const PASS_MESSAGING = PASS_UPSELL.GetChild(1);

function RemoveStuff() {
	PASS_MESSAGING.RemoveAndDeleteChildren(); //Hide the BattlePass Message Container
}

function ChangeColorsOfStuff() {
	PASS_UPSELL.style.borderTop = "2px solid #4677b7";
	PASS_UPSELL.style.backgroundColor =
		"gradient( linear, 0% 0%, 0% 100%, from( #313b49 ), color-stop( 0.5, #141b21), to( #141b21) )";
	INFO_ICON.style.washColor = "#4677b7";
}

function ChangeHeaderStuff() {
	HEADER_TITLE.text = $.Localize("#patreon_loadout_promo_header");
	PASS_ICON.visible = false;
	INFO_ICON.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowTextTooltip", INFO_ICON, "#patreon_loadout_promo_help");
	});
	INFO_ICON.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("DOTAHideTextTooltip");
	});
}

function CreateSnippetPanel() {
	const context_panel = $.GetContextPanel();
	const body_panel = $.CreatePanel("Panel", context_panel, "");
	PASS_MESSAGING.style.width = "100%";
	PASS_MESSAGING.style.height = "100%";
	PASS_MESSAGING.style.margin = "10px 0px 0px 0px";

	body_panel.BLoadLayoutSnippet("CustomPatreonUpsell");

	const create_content = (tier) => {
		const panel = body_panel.FindChildTraverse(`LinesSub_${tier}`);
		if (!panel || !BOOST_BONUSES[tier]) return;

		Object.entries(BOOST_BONUSES[tier]).forEach(([bonus_name, value]) => {
			const line = $.CreatePanel("Label", panel, `BC_Content_${bonus_name}_${tier}`, {
				class: `Content_${bonus_name}`,
				html: true,
			});
			if (value) line.SetDialogVariableInt("value", value);
			line.text = $.Localize(`#payment_sub_content_line_${bonus_name}`, line);
		});
	};
	create_content(1);
	create_content(2);

	body_panel.SetParent(PASS_MESSAGING);
}
function OpenPatreon() {
	$.DispatchEvent("ExternalBrowserGoToURL", "https://www.patreon.com/dota2unofficial");
}

(function () {
	RemoveStuff();
	ChangeColorsOfStuff();
	ChangeHeaderStuff();
	CreateSnippetPanel();
})();