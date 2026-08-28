--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// Booster Order Confirmation HUD JavaScript
(function() {
    "use strict";
    
    // Хранилище активных заказов
    let activeOrders = new Map();
    let ordersContainer = null;
    let orderTemplate = null;
    
    const DotaHUD = GameUI.CustomUIConfig().DotaHUD;

    DotaHUD.windowControllers["booster_order_confirmation"] = {
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
        
        // Получаем ссылки на элементы
        ordersContainer = $.GetContextPanel().FindChildTraverse("orders_container");
        orderTemplate = $.GetContextPanel().FindChildTraverse("order_template");
        
        // Скрываем панель по умолчанию
        let overlay = $.GetContextPanel().FindChildTraverse("booster_confirmation_overlay");
        if (overlay) {
            overlay.style.opacity = "0";
            overlay.style.visibility = "collapse";
        }
    }
    
    // Создать элемент заказа на основе шаблона
    function CreateOrderElement(orderData) {
        
        // Проверяем, что данные валидны
        if (!orderData || typeof orderData !== 'object') {
            return;
        }
        
        let orderId = orderData.customer_player_id + "_" + Date.now();
        
        // Создаем новую панель заказа
        let orderPanel = $.CreatePanel("Panel", ordersContainer, orderId);
        orderPanel.AddClass("booster-order-modal");
        orderPanel.SetAttributeString("order_id", orderId);
        orderPanel.style.visibility = "visible";
        
        // Создаем структуру заказа напрямую
        CreateOrderStructure(orderPanel, orderId);
        
        // Заполняем данные
        let heroAvatar = orderPanel.FindChildTraverse("hero_avatar");
        if (heroAvatar) {
            heroAvatar.heroname = orderData.customer_hero_name;
        }
        
        let heroName = orderPanel.FindChildTraverse("hero_name");
        if (heroName) {
            heroName.text = GetHeroDisplayName(orderData.customer_hero_name);
        }
        
        let difficultyValue = orderPanel.FindChildTraverse("difficulty_value");
        if (difficultyValue) {
            difficultyValue.text = orderData.game_difficulty ? orderData.game_difficulty.toString() : "N/A";
        }
        
        let customerPriceValue = orderPanel.FindChildTraverse("customer_price_value");
        if (customerPriceValue) {
            customerPriceValue.text = orderData.customer_price ? orderData.customer_price.toString() : "N/A";
        }
        
        let commissionValue = orderPanel.FindChildTraverse("commission_value");
        if (commissionValue) {
            commissionValue.text = orderData.commission_amount ? "-" + orderData.commission_amount.toString() : "N/A";
        }
        
        let boosterPayoutValue = orderPanel.FindChildTraverse("booster_payout_value");
        if (boosterPayoutValue) {
            boosterPayoutValue.text = orderData.booster_payout ? orderData.booster_payout.toString() : "N/A";
        }
        
        // Настраиваем обработчики событий
        let closeButton = orderPanel.FindChildTraverse("close_button");
        if (closeButton) {
            closeButton.SetPanelEvent("onactivate", function() {
                RemoveOrder(orderId);
            });
        }
        
        let rejectButton = orderPanel.FindChildTraverse("reject_button");
        if (rejectButton) {
            rejectButton.SetPanelEvent("onactivate", function() {
                OnRejectOrder(orderId, orderData);
            });
        }
        
        let acceptButton = orderPanel.FindChildTraverse("accept_button");
        if (acceptButton) {
            acceptButton.SetPanelEvent("onactivate", function() {
                OnAcceptOrder(orderId, orderData);
            });
        }
        
        return orderPanel;
    }
    
    // Создать структуру заказа напрямую
    function CreateOrderStructure(orderPanel, orderId) {
        $.Msg("CreateOrderStructure");
        
        // Создаем структуру как в XML
        orderPanel.AddClass("unified-modal-medium");
        orderPanel.style.align = "center center";
        
        // Заголовок
        let header = $.CreatePanel("Panel", orderPanel, "header");
        header.AddClass("unified-modal-header");
        
        let title = $.CreatePanel("Label", header, "title");
        title.AddClass("unified-modal-title");
        title.text = $.Localize("#ui_booster_new_order_title");
        
        let closeButton = $.CreatePanel("Button", header, "close_button");
        closeButton.AddClass("unified-close-button");
        
        let closeText = $.CreatePanel("Label", closeButton, "close_text");
        closeText.AddClass("unified-close-text");
        closeText.text = "×";
        
        // Контент
        let content = $.CreatePanel("Panel", orderPanel, "content");
        content.AddClass("unified-modal-content");
        
        // Информация о заказчике
        let customerSection = $.CreatePanel("Panel", content, "customer_section");
        customerSection.AddClass("unified-info-section");
        
        let heroAvatar = $.CreatePanel("DOTAHeroImage", customerSection, "hero_avatar");
        heroAvatar.AddClass("unified-hero-avatar");
        heroAvatar.heroname = "npc_dota_hero_abyssal_underlord";
        
        let customerInfo = $.CreatePanel("Panel", customerSection, "customer_info");
        customerInfo.AddClass("unified-info-text");
        
        let customerName = $.CreatePanel("Label", customerInfo, "customer_name");
        customerName.AddClass("unified-name");
        customerName.text = $.Localize("#ui_booster_customer_label");
        
        let heroName = $.CreatePanel("Label", customerInfo, "hero_name");
        heroName.AddClass("unified-stats");
        heroName.text = "ABYSSAL UNDERLORD";
        
        // Детали заказа
        let detailsSection = $.CreatePanel("Panel", content, "details_section");
        detailsSection.AddClass("unified-details-section");
        
        // Сложность
        let difficultyRow = $.CreatePanel("Panel", detailsSection, "difficulty_row");
        difficultyRow.AddClass("unified-detail-row");
        
        let difficultyLabel = $.CreatePanel("Label", difficultyRow, "difficulty_label");
        difficultyLabel.AddClass("unified-detail-label");
        difficultyLabel.text = $.Localize("#ui_booster_difficulty_label");
        
        let difficultyValue = $.CreatePanel("Label", difficultyRow, "difficulty_value");
        difficultyValue.AddClass("unified-detail-value");
        difficultyValue.text = "5";
        
        // Цена заказчика
        let customerPriceRow = $.CreatePanel("Panel", detailsSection, "customer_price_row");
        customerPriceRow.AddClass("unified-detail-row");
        
        let customerPriceLabel = $.CreatePanel("Label", customerPriceRow, "customer_price_label");
        customerPriceLabel.AddClass("unified-detail-label");
        customerPriceLabel.text = $.Localize("#ui_booster_customer_price_label");
        
        let customerPriceValue = $.CreatePanel("Label", customerPriceRow, "customer_price_value");
        customerPriceValue.AddClass("unified-detail-value");
        customerPriceValue.text = "10";
        
        // Комиссия
        let commissionRow = $.CreatePanel("Panel", detailsSection, "commission_row");
        commissionRow.AddClass("unified-detail-row");
        
        let commissionLabel = $.CreatePanel("Label", commissionRow, "commission_label");
        commissionLabel.AddClass("unified-detail-label");
        commissionLabel.text = $.Localize("#ui_booster_commission_label");
        
        let commissionValue = $.CreatePanel("Label", commissionRow, "commission_value");
        commissionValue.AddClass("unified-detail-value");
        commissionValue.text = "-1";
        
        // Итого для бустера
        let totalRow = $.CreatePanel("Panel", detailsSection, "total_row");
        totalRow.AddClass("unified-detail-row");
        totalRow.AddClass("total-row");
        
        let totalLabel = $.CreatePanel("Label", totalRow, "total_label");
        totalLabel.AddClass("unified-detail-label");
        totalLabel.text = $.Localize("#ui_booster_you_will_get_label");
        
        let boosterPayoutValue = $.CreatePanel("Label", totalRow, "booster_payout_value");
        boosterPayoutValue.AddClass("unified-detail-value");
        boosterPayoutValue.AddClass("unified-total-amount");
        boosterPayoutValue.text = "9";
        
        // Кнопки действий
        let actionsSection = $.CreatePanel("Panel", content, "actions_section");
        actionsSection.AddClass("unified-actions-section");
        
        let rejectButton = $.CreatePanel("Button", actionsSection, "reject_button");
        rejectButton.AddClass("unified-button");
        rejectButton.AddClass("unified-button-danger");
        
        let rejectButtonText = $.CreatePanel("Label", rejectButton, "reject_button_text");
        rejectButtonText.AddClass("button-text");
        rejectButtonText.text = $.Localize("#ui_booster_reject_button");
        
        let acceptButton = $.CreatePanel("Button", actionsSection, "accept_button");
        acceptButton.AddClass("unified-button");
        acceptButton.AddClass("unified-button-primary");
        
        let acceptButtonText = $.CreatePanel("Label", acceptButton, "accept_button_text");
        acceptButtonText.AddClass("button-text");
        acceptButtonText.text = $.Localize("#ui_booster_accept_button");
    }
    
    // Получить отображаемое имя героя
    function GetHeroDisplayName(heroName) {
        // Проверяем, что heroName не undefined и не null
        if (!heroName || typeof heroName !== 'string') {
            return "Unknown Hero";
        }
        
        // Убираем префикс npc_dota_hero_
        if (heroName.startsWith("npc_dota_hero_")) {
            return heroName.replace("npc_dota_hero_", "").replace(/_/g, " ").toUpperCase();
        }
        return heroName;
    }
    
    // Показать заказ
    function ShowOrder(orderData) {
        
        // Проверяем, что данные валидны
        if (!orderData || typeof orderData !== 'object') {
            return;
        }
        
        if (!ordersContainer) {
            return;
        }
        
        let orderId = orderData.customer_player_id + "_" + Date.now();
        
        // Сохраняем данные заказа
        activeOrders.set(orderId, orderData);
        
        // Создаем элемент заказа
        let orderElement = CreateOrderElement(orderData);
        
        // Показываем оверлей если он скрыт
        let overlay = $.GetContextPanel().FindChildTraverse("booster_confirmation_overlay");
        if (overlay) {
            overlay.style.opacity = "1";
            overlay.style.visibility = "visible";
        }
        
        Game.EmitSound("ui_window_open");
    }
    
    // Удалить заказ
    function RemoveOrder(orderId) {
        
        let orderElement = ordersContainer.FindChildTraverse(orderId);
        if (orderElement) {
            orderElement.DeleteAsync(0);
        }
        
        activeOrders.delete(orderId);
        
        // Если больше нет заказов, скрываем оверлей
        if (activeOrders.size === 0) {
            let overlay = $.GetContextPanel().FindChildTraverse("booster_confirmation_overlay");
            if (overlay) {
                overlay.style.opacity = "0";
                overlay.style.visibility = "collapse";
            } else {
            }
        } else {
        }
        
        Game.EmitSound("ui_window_close");
    }
    
    // Обработчик отклонения заказа
    function OnRejectOrder(orderId, orderData) {
        
        // Проверяем, что данные валидны перед отправкой на сервер
        if (orderData && orderData.customer_player_id !== undefined) {
            // Отправляем отклонение заказа на сервер
            GameEvents.SendCustomGameEventToServer("booster_reject_order", {
                customer_player_id: orderData.customer_player_id,
                customer_steam_id: orderData.customer_steam_id,
                game_difficulty: orderData.game_difficulty,
                customer_price: orderData.customer_price
            });
        } else {
        }
        
        // Удаляем заказ из интерфейса
        RemoveOrder(orderId);
        
        // Принудительно закрываем все окна заказов
        ForceCloseAllOrders();
    }
    
    // Принудительно закрыть все окна заказов
    function ForceCloseAllOrders() {
        
        // Очищаем все активные заказы
        activeOrders.clear();
        
        // Удаляем все элементы заказов
        if (ordersContainer) {
            let children = ordersContainer.Children();
            for (let i = 0; i < children.length; i++) {
                children[i].DeleteAsync(0);
            }
        }
        
        // Скрываем оверлей
        let overlay = $.GetContextPanel().FindChildTraverse("booster_confirmation_overlay");
        if (overlay) {
            overlay.style.opacity = "0";
            overlay.style.visibility = "collapse";
        } else {
        }
    }
    
    // Обработчик принятия заказа
    function OnAcceptOrder(orderId, orderData) {
        
        // Отправляем принятие заказа на сервер
        GameEvents.SendCustomGameEventToServer("booster_accept_order", {
            customer_player_id: orderData.customer_player_id,
            customer_steam_id: orderData.customer_steam_id,
            game_difficulty: orderData.game_difficulty,
            customer_price: orderData.customer_price,
            booster_payout: orderData.booster_payout
        });
        
        // Удаляем заказ из интерфейса
        RemoveOrder(orderId);
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
    
    // Обработчик события confirm_booster_order_executor от сервера
    function OnConfirmBoosterOrderExecutor(data) {
        
        // Показываем заказ
        ShowOrder(data);
    }
    
    
    // Регистрация обработчиков событий
    GameEvents.Subscribe("confirm_booster_order_executor", OnConfirmBoosterOrderExecutor);
    
    // Инициализация при загрузке
    Initialize();
    
})();