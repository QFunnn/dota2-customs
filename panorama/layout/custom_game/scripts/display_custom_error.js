--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function DisplayCustomError(event) {
	if (event.enable == 0) return;

	$.Msg("Custom message");
	JSON.print(event);

	GameEvents.SendEventClientSide("dota_hud_error_message", {
		splitscreenplayer: 0,
		reason: 80,
		message: event.message,
	});
}

function DisplayCustomErrorWithValue(event) {
	let base_message = $.Localize(event.message);
	Object.entries(event.values).forEach(([key, value]) => {
		base_message = base_message.replace(`##${key}##`, $.Localize(value));
	});
	GameEvents.SendEventClientSide("dota_hud_error_message", {
		splitscreenplayer: 0,
		reason: 80,
		message: base_message,
	});
}

(() => {
	const frame = GameEvents.NewProtectedFrame("display_custom_error");

	frame.SubscribeProtected("display_custom_error", DisplayCustomError);
	frame.SubscribeProtected("display_custom_error_with_value", DisplayCustomErrorWithValue);

	frame.SubscribeProtected("server_print", (event) => $.Msg(`=> ${event.message}`));
})();