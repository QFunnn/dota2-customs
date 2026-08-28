--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// Notification System JavaScript
(function() {
    "use strict";
    
    // Хранилище активных уведомлений
    let activeNotifications = new Map();
    let notificationsContainer = null;
    let notificationCounter = 0;
    
    // Конфигурация системы уведомлений
    const NOTIFICATION_CONFIG = {
        DEFAULT_DURATION: 5000, // 5 секунд
        MAX_NOTIFICATIONS: 5,   // Максимум уведомлений на экране
        ANIMATION_DURATION: 300, // Длительность анимации
        AUTO_REMOVE_DELAY: 100   // Задержка перед автоудалением
    };
    
    // Типы уведомлений
    const NOTIFICATION_TYPES = {
        SUCCESS: 'success',
        ERROR: 'error',
        INFO: 'info',
        WARNING: 'warning'
    };
    
    // Инициализация системы уведомлений
    function Initialize() {
        $.Msg("Notification System: Initializing");
        
        // Получаем контейнер для уведомлений
        notificationsContainer = $.GetContextPanel().FindChildTraverse("notifications_container");
        
        if (!notificationsContainer) {
            $.Msg("Notification System: Container not found!");
            return;
        }
        
        // Скрываем контейнер по умолчанию
        notificationsContainer.style.visibility = "visible";
        
        $.Msg("Notification System: Initialized successfully");
    }
    
    // Создать уведомление
    function CreateNotification(options) {
        if (!notificationsContainer) {
            $.Msg("Notification System: Container not available");
            return null;
        }
        
        // Проверяем лимит уведомлений
        if (activeNotifications.size >= NOTIFICATION_CONFIG.MAX_NOTIFICATIONS) {
            // Удаляем самое старое уведомление
            RemoveOldestNotification();
        }
        
        // Генерируем уникальный ID
        const notificationId = "notification_" + (++notificationCounter);
        
        // Создаем панель уведомления
        const notificationPanel = $.CreatePanel("Panel", notificationsContainer, notificationId);
        notificationPanel.AddClass("notification");
        notificationPanel.AddClass("notification-" + (options.type || NOTIFICATION_TYPES.INFO));
        
        // Добавляем анимацию появления
        notificationPanel.AddClass("animate-in");
        
        // Создаем структуру уведомления
        CreateNotificationStructure(notificationPanel, options);
        
        // Сохраняем уведомление
        const notificationData = {
            id: notificationId,
            panel: notificationPanel,
            type: options.type || NOTIFICATION_TYPES.INFO,
            duration: options.duration || NOTIFICATION_CONFIG.DEFAULT_DURATION,
            autoRemove: options.autoRemove !== false,
            important: options.important || false,
            timer: null
        };
        
        activeNotifications.set(notificationId, notificationData);
        
        // Настраиваем автоудаление
        if (notificationData.autoRemove) {
            SetupAutoRemoval(notificationData);
        }
        
        // Воспроизводим звук
        PlayNotificationSound(notificationData.type);
        
        $.Msg("Notification System: Created notification", notificationId, options);
        
        return notificationPanel;
    }
    
    // Создать структуру уведомления
    function CreateNotificationStructure(panel, options) {
        // Иконка
        const icon = $.CreatePanel("Panel", panel, "icon");
        icon.AddClass("notification-icon");
        
        // Контент
        const content = $.CreatePanel("Panel", panel, "content");
        content.AddClass("notification-content");
        
        // Заголовок
        if (options.title) {
            const title = $.CreatePanel("Label", content, "title");
            title.AddClass("notification-title");
            title.text = options.title;
        }
        
        // Текст
        const text = $.CreatePanel("Label", content, "text");
        text.AddClass("notification-text");
        text.text = options.message || options.text || "";
        
        // Кнопка закрытия
        const closeButton = $.CreatePanel("Button", panel, "close");
        closeButton.AddClass("notification-close");
        closeButton.SetPanelEvent("onactivate", function() {
            RemoveNotification(panel.id);
        });
        
        const closeText = $.CreatePanel("Label", closeButton, "close_text");
        closeText.AddClass("notification-close-text");
        closeText.text = "×";
        
        // Таймер (если включен)
        if (options.showTimer !== false) {
            const timer = $.CreatePanel("Panel", panel, "timer");
            timer.AddClass("notification-timer");
            
            const timerFill = $.CreatePanel("Panel", timer, "timer_fill");
            timerFill.AddClass("notification-timer-fill");
        }
        
        // Добавляем класс для важных уведомлений
        if (options.important) {
            panel.AddClass("notification-important");
        }
    }
    
    // Настроить автоудаление уведомления
    function SetupAutoRemoval(notificationData) {
        const panel = notificationData.panel;
        const duration = notificationData.duration;
        
        // Настраиваем анимацию таймера
        const timerFill = panel.FindChildTraverse("timer_fill");
        if (timerFill) {
            // Анимируем прогресс-бар
            timerFill.style.width = "100%";
            $.Schedule(duration / 1000, function() {
                if (timerFill && timerFill.IsValid()) {
                    timerFill.style.width = "0%";
                }
            });
        }
        
        // Устанавливаем таймер удаления
        notificationData.timer = $.Schedule(duration / 1000, function() {
            RemoveNotification(notificationData.id);
        });
    }
    
    // Удалить уведомление
    function RemoveNotification(notificationId) {
        const notificationData = activeNotifications.get(notificationId);
        
        if (!notificationData) {
            $.Msg("Notification System: Notification not found", notificationId);
            return;
        }
        
        const panel = notificationData.panel;
        
        // Отменяем таймер
        if (notificationData.timer) {
            $.CancelScheduledEvent(notificationData.timer);
        }
        
        // Добавляем анимацию исчезновения
        panel.AddClass("animate-out");
        
        // Удаляем панель после анимации
        $.Schedule(NOTIFICATION_CONFIG.ANIMATION_DURATION / 1000, function() {
            if (panel && panel.IsValid()) {
                panel.DeleteAsync(0);
            }
        });
        
        // Удаляем из хранилища
        activeNotifications.delete(notificationId);
        
        $.Msg("Notification System: Removed notification", notificationId);
    }
    
    // Удалить самое старое уведомление
    function RemoveOldestNotification() {
        if (activeNotifications.size === 0) return;
        
        const oldestId = activeNotifications.keys().next().value;
        RemoveNotification(oldestId);
    }
    
    // Очистить все уведомления
    function ClearAllNotifications() {
        $.Msg("Notification System: Clearing all notifications");
        
        for (const [id, data] of activeNotifications) {
            if (data.timer) {
                $.CancelScheduledEvent(data.timer);
            }
            if (data.panel && data.panel.IsValid()) {
                data.panel.DeleteAsync(0);
            }
        }
        
        activeNotifications.clear();
    }
    
    // Воспроизвести звук уведомления
    function PlayNotificationSound(type) {
        switch (type) {
            case NOTIFICATION_TYPES.SUCCESS:
                Game.EmitSound("ui_notification_success");
                break;
            case NOTIFICATION_TYPES.ERROR:
                Game.EmitSound("ui_notification_error");
                break;
            case NOTIFICATION_TYPES.WARNING:
                Game.EmitSound("ui_notification_warning");
                break;
            case NOTIFICATION_TYPES.INFO:
            default:
                Game.EmitSound("ui_notification_info");
                break;
        }
    }
    
    // Показать уведомление о принятии заказа
    function ShowOrderAcceptedNotification(data) {
        CreateNotification({
            type: NOTIFICATION_TYPES.SUCCESS,
            title: $.Localize("#ui_booster_notification_order_accepted_title"),
            message: $.Localize("#ui_booster_notification_order_accepted"),
            duration: 4000,
            important: true
        });
    }
    
    // Показать уведомление об отклонении заказа
    function ShowOrderRejectedNotification(data) {
        CreateNotification({
            type: NOTIFICATION_TYPES.ERROR,
            title: $.Localize("#ui_booster_notification_order_rejected_title"),
            message: $.Localize("#ui_booster_notification_order_rejected"),
            duration: 4000,
            important: true
        });
    }
    
    // Показать уведомление о покупке лицензии
    function ShowLicensePurchasedNotification(data) {
        CreateNotification({
            type: NOTIFICATION_TYPES.SUCCESS,
            title: $.Localize("#ui_booster_notification_license_purchased_title"),
            message: $.Localize("#ui_booster_notification_license_purchased"),
            duration: 5000,
            important: true
        });
    }
    
    // Показать уведомление об обновлении настроек
    function ShowSettingsUpdatedNotification(data) {
        CreateNotification({
            type: NOTIFICATION_TYPES.INFO,
            title: $.Localize("#ui_booster_notification_settings_updated_title"),
            message: $.Localize("#ui_booster_notification_settings_updated"),
            duration: 3000
        });
    }
    
    // Показать уведомление об ошибке
    function ShowErrorNotification(message, title) {
        CreateNotification({
            type: NOTIFICATION_TYPES.ERROR,
            title: title || $.Localize("#ui_booster_notification_error_title"),
            message: message,
            duration: 5000,
            important: true
        });
    }
    
    // Показать информационное уведомление
    function ShowInfoNotification(message, title) {
        CreateNotification({
            type: NOTIFICATION_TYPES.INFO,
            title: title || $.Localize("#ui_booster_notification_info_title"),
            message: message,
            duration: 4000
        });
    }
    
    // Показать предупреждение
    function ShowWarningNotification(message, title) {
        CreateNotification({
            type: NOTIFICATION_TYPES.WARNING,
            title: title || $.Localize("#ui_booster_notification_warning_title"),
            message: message,
            duration: 5000,
            important: true
        });
    }
    
    // Обработчики событий от сервера
    function OnBoosterOrderAcceptedNotification(data) {
        $.Msg("Notification System: Order accepted notification received", data);
        ShowOrderAcceptedNotification(data);
    }
    
    function OnBoosterOrderRejectedNotification(data) {
        $.Msg("Notification System: Order rejected notification received", data);
        ShowOrderRejectedNotification(data);
    }
    
    function OnLicensePurchasedNotification(data) {
        $.Msg("Notification System: License purchased notification received", data);
        ShowLicensePurchasedNotification(data);
    }
    
    function OnSettingsUpdatedNotification(data) {
        $.Msg("Notification System: Settings updated notification received", data);
        ShowSettingsUpdatedNotification(data);
    }
    
    // Регистрация обработчиков событий
    GameEvents.Subscribe("booster_order_accepted_notification", OnBoosterOrderAcceptedNotification);
    GameEvents.Subscribe("booster_order_rejected_notification", OnBoosterOrderRejectedNotification);
    GameEvents.Subscribe("booster_license_purchased_notification", OnLicensePurchasedNotification);
    GameEvents.Subscribe("booster_settings_updated_notification", OnSettingsUpdatedNotification);
    
    // Экспорт функций в глобальную область
    window.NotificationSystem = {
        show: CreateNotification,
        showSuccess: function(message, title) {
            return CreateNotification({
                type: NOTIFICATION_TYPES.SUCCESS,
                title: title,
                message: message
            });
        },
        showError: function(message, title) {
            return CreateNotification({
                type: NOTIFICATION_TYPES.ERROR,
                title: title,
                message: message
            });
        },
        showInfo: function(message, title) {
            return CreateNotification({
                type: NOTIFICATION_TYPES.INFO,
                title: title,
                message: message
            });
        },
        showWarning: function(message, title) {
            return CreateNotification({
                type: NOTIFICATION_TYPES.WARNING,
                title: title,
                message: message
            });
        },
        remove: RemoveNotification,
        clear: ClearAllNotifications,
        getActiveCount: function() {
            return activeNotifications.size;
        }
    };
    
    // Регистрация обработчиков событий
    GameEvents.Subscribe("booster_order_accepted_notification", OnBoosterOrderAcceptedNotification);
    GameEvents.Subscribe("booster_order_rejected_notification", OnBoosterOrderRejectedNotification);
    GameEvents.Subscribe("booster_license_purchased_notification", OnLicensePurchasedNotification);
    GameEvents.Subscribe("booster_settings_updated_notification", OnSettingsUpdatedNotification);
    
    // Инициализация при загрузке
    Initialize();
    
})();