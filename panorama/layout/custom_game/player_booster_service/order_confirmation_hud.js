--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


// Order Confirmation HUD JavaScript
(function() {
    "use strict";
    
    // Основные элементы интерфейса
    let orderConfirmationOverlay = null;
    let closeConfirmationButton = null;
    let rejectOrderButton = null;
    let confirmOrderButton = null;
    let currentOrderData = null;
    
    const DotaHUD = GameUI.CustomUIConfig().DotaHUD;

    DotaHUD.windowControllers["order_confirmation_hud"] = {
        is_open: false,
        open: function(){
            $.GetContextPanel().style.opacity = "1";
            Game.EmitSound("ui_window_open");
        },
        close: function(){
            $.GetContextPanel().style.opacity = "0";
            Game.EmitSound("ui_window_close");
        }
    }
    
    // Инициализация при загрузке
    function Initialize() {
        $.Msg("Order Confirmation HUD Initialize");
        
        // Получаем ссылки на элементы
        orderConfirmationOverlay = $.GetContextPanel().FindChildTraverse("order_confirmation_overlay");
        closeConfirmationButton = $.GetContextPanel().FindChildTraverse("order_confirmation_overlay");
        rejectOrderButton = $.GetContextPanel().FindChildTraverse("reject_order_button");
        confirmOrderButton = $.GetContextPanel().FindChildTraverse("confirm_order_button");
        
        // Добавляем обработчики событий
        if (closeConfirmationButton) {
            closeConfirmationButton.SetPanelEvent("onactivate", HideOrderConfirmation);
        }
        
        if (rejectOrderButton) {
            rejectOrderButton.SetPanelEvent("onactivate", OnRejectOrderClicked);
        }
        
        if (confirmOrderButton) {
            confirmOrderButton.SetPanelEvent("onactivate", OnConfirmOrderClicked);
        }
        
        // Скрываем панель по умолчанию
        if (orderConfirmationOverlay) {
            orderConfirmationOverlay.style.opacity = "0";
            orderConfirmationOverlay.style.visibility = "collapse";
        }
    }
    
    // Показать окно подтверждения заказа
    function ShowOrderConfirmation(orderData) {
        $.Msg("ShowOrderConfirmation called with data:", orderData);
        
        if (!orderConfirmationOverlay) {
            $.Msg("Order confirmation overlay not found");
            return;
        }
        
        // Сохраняем данные заказа (включая secret_key от сервера)
        currentOrderData = orderData;
        
        // Заполняем информацию о бустере
        let avatarImage = orderConfirmationOverlay.FindChildTraverse("confirmation_avatar");
        if (avatarImage && orderData.booster_steam_id) {
            avatarImage.steamid = orderData.booster_steam_id.toString();
        }
        
        let boosterName = orderConfirmationOverlay.FindChildTraverse("confirmation_booster_name");
        if (boosterName && orderData.booster_steam_id) {
            boosterName.steamid = orderData.booster_steam_id.toString();
        }
        
        let boosterStats = orderConfirmationOverlay.FindChildTraverse("confirmation_booster_stats");
        if (boosterStats && orderData.booster_profile) {
            let completedOrders = orderData.booster_profile.completed_orders || 0;
            boosterStats.text = "<font color='#00FF00'>" + completedOrders + " заказов</font> выполнено";
            boosterStats.html = true;
        }
        
        // Заполняем детали заказа
        let difficulty = orderConfirmationOverlay.FindChildTraverse("confirmation_difficulty");
        if (difficulty && orderData.difficulty) {
            difficulty.text = orderData.difficulty.toString();
        }
        
        let price = orderConfirmationOverlay.FindChildTraverse("confirmation_price");
        if (price && orderData.price) {
            price.text = orderData.price.toString();
        }
        
        // Итоговая сумма к доплате (без комиссии, так как она списывается с исполнителя)
        let total = orderConfirmationOverlay.FindChildTraverse("confirmation_total");
        if (total && orderData.price) {
            total.text = orderData.price.toString();
        }
        
        // Показываем окно
        orderConfirmationOverlay.style.opacity = "1";
        orderConfirmationOverlay.style.visibility = "visible";
        Game.EmitSound("ui_window_open");
    }
    
    // Скрыть окно подтверждения заказа
    function HideOrderConfirmation() {
        $.Msg("HideOrderConfirmation called");
        
        if (!orderConfirmationOverlay) {
            return;
        }
        
        // Скрываем окно
        orderConfirmationOverlay.style.opacity = "0";
        orderConfirmationOverlay.style.visibility = "collapse";
        Game.EmitSound("ui_window_close");
        
        // Очищаем данные заказа
        currentOrderData = null;
    }
    
    // Обработчик отклонения заказа
    function OnRejectOrderClicked() {
        $.Msg("OnRejectOrderClicked called");
        
        if (!currentOrderData) {
            $.Msg("No current order data available");
            return;
        }
        
        // Используем ключ, полученный от сервера
        let requestKey = currentOrderData.secret_key;
        
        // Отправляем отклонение заказа на сервер с ключом
        GameEvents.SendCustomGameEventToServer("booster_reject_order", {
            order_id: currentOrderData.order_id,
            booster_player_id: currentOrderData.booster_player_id,
            secret_key: requestKey
        });
        
        // Закрываем окно подтверждения
        HideOrderConfirmation();
        
        // Показываем уведомление об отклонении
        ShowNotification("Заказ отклонен", "error");
    }
    
    // Обработчик подтверждения заказа
    function OnConfirmOrderClicked() {
        $.Msg("OnConfirmOrderClicked called");
        
        if (!currentOrderData) {
            $.Msg("No current order data available");
            return;
        }
        
        // Используем ключ, полученный от сервера
        let requestKey = currentOrderData.secret_key;
        
        // Отправляем подтверждение заказа на сервер с ключом
        GameEvents.SendCustomGameEventToServer("booster_accept_order", {
            order_id: currentOrderData.order_id,
            booster_player_id: currentOrderData.booster_player_id,
            difficulty: currentOrderData.difficulty,
            price: currentOrderData.price,
            secret_key: requestKey
        });
        
        // Скрываем окно подтверждения
        HideOrderConfirmation();
        
        // Показываем уведомление
        ShowNotification("Заказ принят!", "success");
    }
    
    // Показать уведомление
    function ShowNotification(message, type) {
        // Создаем временное уведомление
        let notification = $.CreatePanel("Panel", $.GetContextPanel(), "notification");
        notification.AddClass("notification-" + type);
        
        let label = $.CreatePanel("Label", notification, "notification-text");
        label.text = message;
        
        // Автоматически удаляем через 3 секунды
        $.Schedule(3.0, function() {
            if (notification && notification.IsValid()) {
                notification.DeleteAsync(0);
            }
        });
    }
    
    // Глобальная переменная для хранения данных заказа
    let pendingOrderData = null;
    
    // Функция для установки данных заказа (вызывается извне)
    function SetOrderData(data) {
        $.Msg("SetOrderData called with data:", data);
        pendingOrderData = data;
        
        // Если окно уже открыто, сразу показываем данные
        if (orderConfirmationOverlay && orderConfirmationOverlay.style.visibility === "visible") {
            ShowOrderConfirmation(data);
        }
    }
    
    // Функция для получения данных заказа
    function GetOrderData() {
        return pendingOrderData;
    }
    
    // Обработчик события confirm_booster_order от сервера
    function OnConfirmBoosterOrder(data) {
        $.Msg("OnConfirmBoosterOrder received data:", data);
        
        // Устанавливаем данные заказа
        SetOrderData(data);
        
        // Показываем окно подтверждения
        ShowOrderConfirmation(data);
    }
    
    // Регистрация обработчиков событий
    GameEvents.Subscribe("confirm_booster_order", OnConfirmBoosterOrder);
    
    // Инициализация при загрузке
    Initialize();
    
})();