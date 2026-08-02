--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
}
function OpenTopBanner(name) {
	HUD.CONTEXT.RemoveClass(`BClose_${name}`);
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
function OpenMail() {
	GameUI.ToggleMailPanel();
	CloseMailBanner();
}
GameUI.OpenTopBanner = OpenTopBanner;
GameUI.CloseTopBanner = CloseTopBanner;

(() => {
	// HUD.CONTEXT.RemoveClass("BClose_ChatWheelNewPromo");
	CloseTopBanner("NewMail");
	HideDefaultButtons();
})();