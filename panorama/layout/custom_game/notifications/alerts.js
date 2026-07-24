--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const ALERT = $("#Alert");

let hide_alert_schedule;
function Alert(key, vars) {
	if (hide_alert_schedule) hide_alert_schedule = $.CancelScheduled(hide_alert_schedule);

	const set_line = (loc_key, type) => {
		const loc_line = $.Localize(loc_key, ALERT);
		const b_has_loc = loc_key != loc_line;
		ALERT.SetHasClass(`BType_${type}`, b_has_loc);
		if (b_has_loc) ALERT.SetDialogVariable(`alert_${type}`, loc_line);
	};
	set_line(`alert_${key}`, "header");
	set_line(`alert_${key}_desc`, "desc");

	ALERT.AddClass("Show");

	if (vars)
		Object.entries(vars).forEach(([k, v]) => {
			ALERT.SetDialogVariable(k, v);
		});

	hide_alert_schedule = $.Schedule(5, () => {
		hide_alert_schedule = undefined;
		ALERT.RemoveClass("Show");
	});
}

(() => {
	const frame = GameEvents.NewProtectedFrame("notifications_alerts");
	frame.SubscribeProtected("alerts:alert", (data) => {
		if (data.message) Alert(data.message, data.vars || {});
	});
	GameUI.OT3_Alert = Alert;
})();