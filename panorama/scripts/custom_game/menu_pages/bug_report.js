--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


// Get elements
var bugTypeDropdown = $("#BugTypeDropdown");
var descriptionInput = $("#BugDescriptionInput");
var charCounter = $("#CharCounter");
var validationError = $("#ValidationError");
var screenshotCheckbox = $("#ScreenshotCheckbox");
var submitButton = $("#SubmitButton");
var notificationPanel = $("#BugReportNotification");
var notificationTitle = $("#BugReportNotificationTitle");
var notificationMessage = $("#BugReportNotificationMessage");

// Bug types (Other is default)
var bugTypes = [
    { id: "other", text: "#BugReport_Type_Other" },
    { id: "hero", text: "#BugReport_Type_Hero" },
    { id: "ability", text: "#BugReport_Type_Ability" },
    { id: "item", text: "#BugReport_Type_Item" }
];

// Populate dropdown
if (bugTypeDropdown) {
    $.Msg("[BugReport] Populating dropdown with " + bugTypes.length + " types");
    
    // Clear existing options
    bugTypeDropdown.RemoveAllOptions();
    
    for (var i = 0; i < bugTypes.length; i++) {
        var type = bugTypes[i];
        var option = $.CreatePanel("Label", bugTypeDropdown, "option_" + i);
        option.text = $.Localize(type.text);
        option.SetAttributeString("data-type-id", type.id);
        bugTypeDropdown.AddOption(option);
        $.Msg("[BugReport] Added option " + i + ": " + type.id + " = " + $.Localize(type.text));
    }
    bugTypeDropdown.SetSelected(0);
    $.Msg("[BugReport] Dropdown populated, selected: 0");
} else {
    $.Msg("[BugReport] ERROR: bugTypeDropdown is null!");
}

// Минимальная длина описания и кулдаун отправки (сервер проверяет то же самое)
var MIN_DESCRIPTION_LENGTH = 5;
var REPORT_COOLDOWN = 10; // секунд

// Character counter
if (descriptionInput && charCounter) {
    descriptionInput.SetPanelEvent("ontextentrychange", function() {
        var text = descriptionInput.text || "";
        var length = text.length;
        charCounter.text = length + "/500";

        if (length < MIN_DESCRIPTION_LENGTH) {
            charCounter.style.color = "#ff4444";
        } else {
            charCounter.style.color = "#4ade80";
        }
    });
}

// Кулдаун: после отправки кнопка гаснет и показывает обратный отсчёт
var submitLabel = submitButton ? submitButton.GetChild(0) : null;
var submitLabelDefaultText = submitLabel ? submitLabel.text : "";
var cooldownEndTime = 0;

function IsOnCooldown() {
    return Game.Time() < cooldownEndTime;
}

function StartCooldown() {
    cooldownEndTime = Game.Time() + REPORT_COOLDOWN;
    if (submitButton) {
        submitButton.AddClass("OnCooldown");
        submitButton.enabled = false;
    }
    UpdateCooldownVisual();
}

function UpdateCooldownVisual() {
    var remaining = Math.ceil(cooldownEndTime - Game.Time());
    if (remaining > 0) {
        if (submitLabel) {
            submitLabel.text = submitLabelDefaultText + " (" + remaining + ")";
        }
        $.Schedule(0.2, UpdateCooldownVisual);
    } else {
        if (submitLabel) {
            submitLabel.text = submitLabelDefaultText;
        }
        if (submitButton) {
            submitButton.RemoveClass("OnCooldown");
            submitButton.enabled = true;
        }
    }
}

// Submit button
if (submitButton) {
    submitButton.SetPanelEvent("onactivate", function() {
        SubmitBugReport();
    });
}

function SubmitBugReport() {
    var description = descriptionInput ? (descriptionInput.text || "") : "";

    // Get selected type
    var selectedOption = bugTypeDropdown ? bugTypeDropdown.GetSelected() : null;
    var bugType = "other"; // default

    if (selectedOption) {
        var typeId = selectedOption.GetAttributeString("data-type-id", "");
        if (typeId) {
            bugType = typeId;
        } else {
            // Fallback: try to get index from id
            var optionId = selectedOption.id;
            if (optionId && optionId.indexOf("option_") === 0) {
                var index = parseInt(optionId.replace("option_", ""));
                if (!isNaN(index) && index >= 0 && index < bugTypes.length) {
                    bugType = bugTypes[index].id;
                }
            }
        }
    }

    $.Msg("[BugReport] Submit - bugType: " + bugType + ", description length: " + description.length);

    // Validation
    if (IsOnCooldown()) {
        ShowValidationError("#BugReport_Cooldown");
        return;
    }
    if (description.length < MIN_DESCRIPTION_LENGTH) {
        ShowValidationError("#BugReport_TooShort");
        return;
    }

    // Send to server
    GameEvents.SendCustomGameEventToServer("bug_report_submit", {
        PlayerID: Players.GetLocalPlayer(),
        bug_type: bugType,
        description: description
    });

    // Кулдаун стартует сразу; уведомление об успехе придёт от сервера (bug_report_response)
    StartCooldown();

    // Clear form
    if (descriptionInput) {
        descriptionInput.text = "";
        if (charCounter) charCounter.text = "0/500";
    }
    if (bugTypeDropdown) bugTypeDropdown.SetSelected(0);
    if (screenshotCheckbox) screenshotCheckbox.checked = false;
}

function ShowValidationError(message) {
    ShowNotification("#BugReport_Error_Title", message, false);
}

function ShowMessage(message, isSuccess) {
    var title = isSuccess ? "#BugReport_Success_Title" : "#BugReport_Error_Title";
    ShowNotification(title, message, isSuccess);
}

function ShowNotification(title, message, isSuccess) {
    if (notificationPanel && notificationTitle && notificationMessage) {
        notificationTitle.text = $.Localize(title);
        notificationMessage.text = $.Localize(message);
        notificationPanel.AddClass("ShowNotification");
        
        $.Schedule(4, function() {
            CloseBugReportNotification();
        });
    }
}

function CloseBugReportNotification() {
    if (notificationPanel) {
        notificationPanel.RemoveClass("ShowNotification");
    }
}

// Listen for server response
GameEvents.Subscribe("bug_report_response", function(data) {
    if (data.success) {
        ShowMessage("#BugReport_Success", true);
    } else {
        ShowMessage(data.error || "#BugReport_Error", false);
    }
});