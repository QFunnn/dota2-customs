--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
const TEXT_FIELD = $("#FeedbackText");
const SEND_BUTTON = $("#FeedbackSendButton");
const MAX_SYMBOLS_FIELD = $("#MaxSymbols");
const MAX_SYMBOLS = 500;

const current_text_length = () => {
	return TEXT_FIELD.text.length;
};

function SendFeedback() {
	const text = TEXT_FIELD.text;
	if (!SEND_BUTTON.BHasClass("Cooldown") && text != "") {
		SEND_BUTTON.SetHasClass("Cooldown", true);
		GameEvents.SendToServerEnsured("WebFeedback:send_feedback", {
			text: text,
		});
		TEXT_FIELD.text = "";
		Game.EmitSound("General.ButtonClick");
		CloseFeedback();
	}
}

function UpdateCooldown(data) {
	SEND_BUTTON.SetHasClass("Cooldown", data.cooldown > 0);
}

function FeedbackTooltip() {
	if (SEND_BUTTON.BHasClass("Cooldown")) {
		$.DispatchEvent("DOTAShowTextTooltip", SEND_BUTTON, $.Localize("#feedback_cooldown"));
	} else if (SEND_BUTTON.BHasClass("Blocked")) {
		$.DispatchEvent("DOTAShowTextTooltip", SEND_BUTTON, $.Localize("#feedback_blocked"));
	}
}

function UpdateFeedbackText() {
	SEND_BUTTON.SetHasClass("Blocked", TEXT_FIELD.text == "");
	const max_symbols_reached = current_text_length() > MAX_SYMBOLS;
	if (max_symbols_reached) {
		TEXT_FIELD.text = TEXT_FIELD.text.substring(0, MAX_SYMBOLS);
	}
	MAX_SYMBOLS_FIELD.SetHasClass("max", max_symbols_reached);
	MAX_SYMBOLS_FIELD.SetDialogVariable("current", current_text_length());
}

function CloseFeedback() {
	GameUI.ToggleFeedback();
	$.DispatchEvent("DropInputFocus");
	if (dotaHud.BHasClass("CustomEndGameSimulate")) GameUI.SetEndgameFocus();
}
GameUI.CloseFeedback = () => {
	CONTEXT.RemoveClass("show");
};
GameUI.ToggleFeedback = () => {
	CONTEXT.ToggleClass("show");
	Game.EmitSound("ui_chat_slide_in");
	return CONTEXT.BHasClass("show");
};

(function () {
	MAX_SYMBOLS_FIELD.SetDialogVariable("max", MAX_SYMBOLS);
	MAX_SYMBOLS_FIELD.SetDialogVariable("current", 0);

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());
	frame.SubscribeProtected("WebFeedback:update_cooldown", UpdateCooldown);

	GameEvents.SendToServerEnsured("WebFeedback:get_cooldown", {});
})();