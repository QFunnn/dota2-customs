--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";

    function ShowLicenseConfirmation() {
        $.GetContextPanel().AddClass("visible");
        Game.EmitSound("ui_window_open");
    }

    function HideLicenseConfirmation() {
        $.GetContextPanel().RemoveClass("visible");
        Game.EmitSound("ui_window_close");
        $.GetContextPanel().DeleteAsync(0); // Удаляем панель после закрытия
    }

    // Обработчик кнопки отмены
    function OnCancelLicensePurchase() {
        console.log("License purchase cancelled");
        HideLicenseConfirmation();
        
        // Отправляем событие об отмене покупки
        GameEvents.SendCustomGameEventToServer("booster_license_purchase_cancelled", {});
    }
    
    // Обработчик кнопки подтверждения
    function OnConfirmLicensePurchase() {
        console.log("License purchase confirmed");
        HideLicenseConfirmation();
        
        // Отправляем событие о подтверждении покупки
        GameEvents.SendCustomGameEventToServer("booster_purchase_license", {});
    }

    // Обработчик клика по overlay
    function OnOverlayClick() {
        // Закрываем окно при клике по затемненной области
        HideLicenseConfirmation();
    }

    // Инициализация
    (function() {
        // Привязываем обработчики кнопок
        let cancelButton = $.GetContextPanel().FindChildTraverse("cancel_license_purchase");
        if (cancelButton) {
            cancelButton.SetPanelEvent("onactivate", OnCancelLicensePurchase);
        }

        let confirmButton = $.GetContextPanel().FindChildTraverse("confirm_license_purchase");
        if (confirmButton) {
            confirmButton.SetPanelEvent("onactivate", OnConfirmLicensePurchase);
        }

        // Привязываем обработчик для overlay
        let overlay = $.GetContextPanel().FindChildTraverse("license_confirmation_overlay");
        if (overlay) {
            overlay.SetPanelEvent("onactivate", OnOverlayClick);
        }

        // Показываем окно при инициализации
        ShowLicenseConfirmation();
    })();
})();