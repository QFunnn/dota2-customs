--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	LINES: $("#CTM_Lines"),
};

function HideDefaultButtons() {
	const menu = FindDotaHudElement("MenuButtons");
	for (const b of menu.Children()) b.visible = false;
}
function CloseTopBanner(name) {
	HUD.CONTEXT.AddClass(`BClose_${name}`);

	if (name == "NewMail") dotaHud.SetHasClass("BHasCustomNewMails", false);
}
function OpenTopBanner(name) {
	HUD.CONTEXT.RemoveClass(`BClose_${name}`);

	if (name == "NewMail") dotaHud.SetHasClass("BHasCustomNewMails", true);
}
function CloseChatWheelBanner() {
	CloseTopBanner("ChatWheelNewPromo");
}
function OpenChatWheelTab() {
	GameUI.Collection.OpenSpecificTab("chat_wheel");
	CloseChatWheelBanner();
}

function CloseMailBanner() {
	CloseTopBanner("NewMail");
}
GameUI.OpenTopBanner = OpenTopBanner;
GameUI.CloseTopBanner = CloseTopBanner;

(() => {
	CloseTopBanner("NewMail");
	HideDefaultButtons();
})();