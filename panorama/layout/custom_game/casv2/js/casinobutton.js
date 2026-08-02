--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


// Функция для открытия/закрытия окна казино (доступна глобально)
function openCasinoButton() {
    const DotaHUD = GameUI.CustomUIConfig().DotaHUD;
    if (!DotaHUD) return;

    if (DotaHUD.IsWindowOpen("casv2")) {
        DotaHUD.WindowClose("casv2");
    } else {
        DotaHUD.WindowOpen("casv2");
    }
}

// Функция для создания кнопки в топ-баре (доступна глобально)
function createCasinoTopBarButton() {
    function FindDotaHudElement(panel) {
        return $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse(panel);
    }

    // Проверяем, не создана ли уже кнопка
    var existingButton = FindDotaHudElement("CasinoTopBarButton");
    if (existingButton) {
        return; // Кнопка уже существует
    }

    // Пытаемся найти контейнер для кнопок (BarOverItems или аналогичный)
    var buttonContainer = FindDotaHudElement("BarOverItems");
    if (!buttonContainer) {
        // Если BarOverItems не найден, пытаемся найти другие возможные контейнеры
        var hudRoot = $.GetContextPanel().GetParent().GetParent().GetParent();
        buttonContainer = hudRoot.FindChildTraverse("topbar");
        if (!buttonContainer) {
            $.Msg("[CasinoButton] Could not find button container");
            return;
        }
    }

    // Создаем кнопку
    var casinoButton = $.CreatePanel("Button", buttonContainer, "CasinoTopBarButton");
    if (casinoButton) {
        casinoButton.SetPanelEvent("onactivate", openCasinoButton);
        casinoButton.AddClass("CasinoTopBarButton");
        $.Msg("[CasinoButton] Casino top bar button created");
    }
}

// windowController для casv2 теперь настраивается в casv2.js