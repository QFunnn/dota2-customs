--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const TEXT_LABEL = $("#Custom_HudText");
const TEXT_CONTAINER = $("#Custom_HudMessageContainer");

function CreateCustomMessage(data) {
	CloseMessage();
	TEXT_CONTAINER.SetHasClass("Show", true);
	TEXT_CONTAINER.SetHasClass("Init", true);
	if (data.message) TEXT_LABEL.text = $.Localize(data.message);
}
function CloseMessage() {
	TEXT_CONTAINER.SetHasClass("Show", false);
	TEXT_CONTAINER.SetHasClass("Init", false);
}
(function () {
	CloseMessage();
	GameEvents.SubscribeProtected("custom_hud_message:send", CreateCustomMessage);
})();