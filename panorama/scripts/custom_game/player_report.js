--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// Форма репорта на игрока. ВСТРОЕНА в панель zxc_notifications (общий глобальный
// scope) — вся логика в IIFE. Наружу — только ClosePlayerReport / PlayerReportNoop
// (их зовёт XML onactivate). Причина — НАТИВНЫЙ <DropDown> (как ExtraCreatureNotifDropdown
// в настройках): сам оверлеит и не двигает поля; ширину меню подгоняем в CSS.
// Открытие формы — серверное "show_player_report" {target_player_id}. Отправка —
// "player_report_submit".
var ClosePlayerReport; // XML onactivate — закрыть форму
var PlayerReportNoop;  // XML onactivate окна — перехват клика (клик по окну не закрывает форму)
(function () {
	var MIN_COMMENT_LENGTH = 5;
	var REPORT_COOLDOWN = 30; // сек — совпадает с сервером

	// Первый пункт — плейсхолдер с пустым id (игрок обязан выбрать реальную причину).
	var REASONS = [
		{ id: "",       text: "#PlayerReport_ReasonPlaceholder" },
		{ id: "ruiner", text: "#PlayerReport_Reason_Ruiner" },
		{ id: "toxic",  text: "#PlayerReport_Reason_Toxic" },
		{ id: "cheat",  text: "#PlayerReport_Reason_Cheat" },
		{ id: "afk",    text: "#PlayerReport_Reason_Afk" },
		{ id: "other",  text: "#PlayerReport_Reason_Other" },
	];

	var root = $("#PlayerReportRoot");
	var dropdown = $("#PlayerReportReasonDropdown");
	var descInput = $("#PlayerReportDescInput");
	var charCounter = $("#PlayerReportCharCounter");
	var errorLabel = $("#PlayerReportError");
	var submitBtn = $("#PlayerReportSubmit");
	var targetNameLabel = $("#PlayerReportTargetName");
	var toast = $("#PlayerReportToast");
	var toastText = $("#PlayerReportToastText");

	var currentTargetId = -1;
	var cooldownEndTime = 0;

	function buildDropdown() {
		if (!dropdown) return;
		dropdown.RemoveAllOptions();
		for (var i = 0; i < REASONS.length; i++) {
			var o = $.CreatePanel("Label", dropdown, "prreason_" + i);
			o.text = $.Localize(REASONS[i].text);
			o.SetAttributeString("data-reason-id", REASONS[i].id);
			o.AddClass("PlayerReportReasonOption");
			if (i === 0) o.AddClass("PlayerReportPlaceholderOpt"); // плейсхолдер — скрыт в самом списке
			dropdown.AddOption(o);
		}
		dropdown.SetSelected("prreason_0"); // плейсхолдер
	}

	function getSelectedReason() {
		if (!dropdown) return "";
		var sel = dropdown.GetSelected();
		return sel ? sel.GetAttributeString("data-reason-id", "") : "";
	}

	function resetDropdown() {
		if (dropdown) { try { dropdown.SetSelected("prreason_0"); } catch (e) {} }
	}

	function openReport(targetPlayerId) {
		currentTargetId = targetPlayerId;
		resetDropdown();
		if (descInput) descInput.text = "";
		updateCharCounter();
		hideError();

		var name = "";
		try { name = Players.GetPlayerName(targetPlayerId) || ""; } catch (e) { name = ""; }
		if (targetNameLabel) targetNameLabel.text = name;

		syncSubmitButton();
		if (root) root.AddClass("PlayerReportVisible");
	}

	function closeReport() {
		if (root) root.RemoveClass("PlayerReportVisible");
	}

	function updateCharCounter() {
		var len = descInput ? (descInput.text || "").length : 0;
		if (charCounter) {
			charCounter.text = len + "/300";
			charCounter.style.color = len < MIN_COMMENT_LENGTH ? "#ff4444" : "#4ade80";
		}
	}

	function showError(token) {
		if (errorLabel) { errorLabel.text = $.Localize(token); errorLabel.AddClass("Show"); }
	}
	function hideError() {
		if (errorLabel) errorLabel.RemoveClass("Show");
	}

	function isOnCooldown() { return Game.Time() < cooldownEndTime; }
	function startCooldown() {
		cooldownEndTime = Game.Time() + REPORT_COOLDOWN;
		syncSubmitButton();
	}
	function syncSubmitButton() {
		if (!submitBtn) return;
		var remaining = Math.ceil(cooldownEndTime - Game.Time());
		var lbl = submitBtn.GetChild(0);
		if (remaining > 0) {
			submitBtn.AddClass("OnCooldown");
			submitBtn.enabled = false;
			if (lbl) lbl.text = $.Localize("#PlayerReport_Submit") + " (" + remaining + ")";
			$.Schedule(0.2, syncSubmitButton);
		} else {
			submitBtn.RemoveClass("OnCooldown");
			submitBtn.enabled = true;
			if (lbl) lbl.text = $.Localize("#PlayerReport_Submit");
		}
	}

	function submitReport() {
		if (isOnCooldown()) return; // кнопка не кликабельна во время кулдауна

		if (currentTargetId < 0) { showError("#PlayerReport_InvalidTarget"); return; }
		var reason = getSelectedReason();
		if (!reason) { showError("#PlayerReport_NoReason"); return; }
		var desc = descInput ? (descInput.text || "") : "";
		if (desc.length < MIN_COMMENT_LENGTH) { showError("#PlayerReport_TooShort"); return; }

		GameEvents.SendCustomGameEventToServer("player_report_submit", {
			PlayerID: Players.GetLocalPlayer(),
			target_player_id: currentTargetId,
			reason: reason,
			description: desc,
		});

		// Форму НЕ закрываем — виден кулдаун. Чистим поля, запускаем отсчёт.
		if (descInput) descInput.text = "";
		resetDropdown();
		updateCharCounter();
		hideError();
		startCooldown();
	}

	function showToast(token, isSuccess) {
		if (!toast || !toastText) return;
		toastText.text = $.Localize(token);
		toast.RemoveClass("Error");
		toast.RemoveClass("Success");
		toast.AddClass(isSuccess ? "Success" : "Error");
		toast.AddClass("Show");
		$.Schedule(3.5, function () { toast.RemoveClass("Show"); });
	}

	// ---- Экспорт для XML ----
	ClosePlayerReport = closeReport;
	PlayerReportNoop = function () {};

	// ---- Init ----
	GameEvents.Subscribe("show_player_report", function (data) {
		if (data && data.target_player_id !== undefined) {
			openReport(data.target_player_id);
		}
	});
	GameEvents.Subscribe("player_report_response", function (data) {
		if (data && data.success) {
			showToast("#PlayerReport_Sent", true);
		} else {
			showToast((data && data.error) || "#PlayerReport_Error", false);
		}
	});

	buildDropdown();

	if (descInput) {
		descInput.SetPanelEvent("ontextentrychange", function () { updateCharCounter(); hideError(); });
	}
	if (submitBtn) {
		submitBtn.SetPanelEvent("onactivate", function () { submitReport(); });
	}
})();