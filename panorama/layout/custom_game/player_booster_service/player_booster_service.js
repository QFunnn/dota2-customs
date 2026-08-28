--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// Player Booster Service JavaScript
(function() {
    "use strict";
    
    // Основные элементы интерфейса
    let licensePurchaseSection = null;
    let boosterSettingsContent = null;
    let licensePurchaseButton = null;
    let confirmButton = null;
    
    // Данные текущего заказа (для совместимости)
    let currentOrderData = null;
    
    const DotaHUD = GameUI.CustomUIConfig().DotaHUD;

    DotaHUD.windowControllers["player_booster_service"] = {
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
    DotaHUD.ListenToMouseEvent(
        DotaHUD.GetCloseWindowOnOutsideClick($.GetContextPanel(), "player_booster_service")
    );
    
    // Инициализация вкладок
    function InitializeTabs() {
        // Находим элементы вкладок правой панели
        let tabOrderBoost = $.GetContextPanel().FindChildTraverse("tab_order_boost");
        let tabMyOrders = $.GetContextPanel().FindChildTraverse("tab_my_orders");
        let tabContentOrderBoost = $.GetContextPanel().FindChildTraverse("tab_content_order_boost");
        let tabContentMyOrders = $.GetContextPanel().FindChildTraverse("tab_content_my_orders");
        
        if (tabOrderBoost) {
            tabOrderBoost.SetPanelEvent("onmouseactivate", function() {
                Game.EmitSound("ui_generic_button_click");
                SwitchToRightTab("order_boost");
            });
        }
        
        if (tabMyOrders) {
            // Принудительно делаем вкладку видимой и кликабельной
            tabMyOrders.style.visibility = "visible";
            tabMyOrders.style.opacity = "1";
            
            tabMyOrders.SetPanelEvent("onmouseactivate", function() {
                Game.EmitSound("ui_generic_button_click");
                SwitchToRightTab("my_orders");
            });
        }
        
        // Находим элементы вкладок левой панели
        let tabBoosterSettings = $.GetContextPanel().FindChildTraverse("tab_booster_settings");
        let tabBoosterOrders = $.GetContextPanel().FindChildTraverse("tab_booster_orders");
        let tabContentBoosterSettings = $.GetContextPanel().FindChildTraverse("booster_settings_content");
        let tabContentBoosterOrders = $.GetContextPanel().FindChildTraverse("tab_content_booster_orders");
        
        if (tabBoosterSettings) {
            tabBoosterSettings.SetPanelEvent("onmouseactivate", function() {
                Game.EmitSound("ui_generic_button_click");
                SwitchToLeftTab("booster_settings");
            });
        }
        
        if (tabBoosterOrders) {
            tabBoosterOrders.SetPanelEvent("onmouseactivate", function() {
                Game.EmitSound("ui_generic_button_click");
                SwitchToLeftTab("booster_orders");
            });
        }
        
        // По умолчанию показываем вкладки настроек
        SwitchToRightTab("order_boost");
        SwitchToLeftTab("booster_settings");
        
        // Инициализируем видимость вкладок правой панели
        let panelHeader = $.GetContextPanel().FindChildTraverse("panel-header");
        let initTabOrderBoost = $.GetContextPanel().FindChildTraverse("tab_order_boost");
        let initTabMyOrders = $.GetContextPanel().FindChildTraverse("tab_my_orders");
        let tabContentOrderBoostDefault = $.GetContextPanel().FindChildTraverse("tab_content_order_boost");
        let tabContentMyOrdersDefault = $.GetContextPanel().FindChildTraverse("tab_content_my_orders");
        let panelTitleOrderBoost = $.GetContextPanel().FindChildTraverse("panel_title_order_boost");
        
        // По умолчанию скрываем вкладку "МОИ ЗАКАЗЫ" и заголовок
        if (initTabMyOrders) {
            initTabMyOrders.style.visibility = "collapse";
        }
        if (tabContentMyOrdersDefault) {
            tabContentMyOrdersDefault.style.visibility = "collapse";
            tabContentMyOrdersDefault.style.height = "0px";
            tabContentMyOrdersDefault.style.padding = "0px";
        }
        if (panelHeader && tabContentOrderBoostDefault && panelTitleOrderBoost) {
            panelHeader.AddClass("hidden");
            tabContentOrderBoostDefault.AddClass("no-header");
            panelTitleOrderBoost.style.visibility = "visible";
        }
        
        // Скрываем заголовок левой панели по умолчанию
        let leftPanelHeader = $.GetContextPanel().FindChildTraverse("left_panel_header");
        let tabContentBoosterSettingsDefault = $.GetContextPanel().FindChildTraverse("booster_settings_content");
        if (leftPanelHeader && tabContentBoosterSettingsDefault) {
            leftPanelHeader.AddClass("hidden");
        }
        
        // Инициализируем видимость панелей левой панели
        let initTabContentBoosterSettings = $.GetContextPanel().FindChildTraverse("tab_content_booster_settings");
        let initBoosterSettingsContent = $.GetContextPanel().FindChildTraverse("booster_settings_content");
        let initTabContentBoosterOrders = $.GetContextPanel().FindChildTraverse("tab_content_booster_orders");
        let initBoosterSettingsTitle = $.GetContextPanel().FindChildTraverse("booster_settings_title");
        
        // По умолчанию показываем панель покупки лицензии, скрываем настройки
        if (initTabContentBoosterSettings) {
            initTabContentBoosterSettings.style.visibility = "visible";
            initTabContentBoosterSettings.style.height = "fill-parent-flow(1)";
            initTabContentBoosterSettings.style.padding = "20px";
        }
        if (initBoosterSettingsContent) {
            initBoosterSettingsContent.style.visibility = "collapse";
            initBoosterSettingsContent.style.height = "0px";
            initBoosterSettingsContent.style.padding = "0px";
        }
        if (initTabContentBoosterOrders) {
            initTabContentBoosterOrders.style.visibility = "collapse";
            initTabContentBoosterOrders.style.height = "0px";
            initTabContentBoosterOrders.style.padding = "0px";
        }
        if (initBoosterSettingsTitle) {
            initBoosterSettingsTitle.style.visibility = "collapse";
        }
    }
    
    // Переключение между вкладками правой панели
    function SwitchToRightTab(tabName) {
        let tabOrderBoost = $.GetContextPanel().FindChildTraverse("tab_order_boost");
        let tabMyOrders = $.GetContextPanel().FindChildTraverse("tab_my_orders");
        let tabContentOrderBoost = $.GetContextPanel().FindChildTraverse("tab_content_order_boost");
        let tabContentMyOrders = $.GetContextPanel().FindChildTraverse("tab_content_my_orders");
        
        if (tabName === "order_boost") {
            // Активируем вкладку "ЗАКАЗАТЬ БУСТ"
            if (tabOrderBoost) {
                tabOrderBoost.AddClass("active");
            }
            if (tabMyOrders) {
                tabMyOrders.RemoveClass("active");
            }
            if (tabContentOrderBoost) {
                tabContentOrderBoost.style.visibility = "visible";
                tabContentOrderBoost.style.height = "fill-parent-flow(1)";
                tabContentOrderBoost.style.padding = "20px";
            }
            if (tabContentMyOrders) {
                tabContentMyOrders.style.visibility = "collapse";
                tabContentMyOrders.style.height = "0px";
                tabContentMyOrders.style.padding = "0px";
            }
        } else if (tabName === "my_orders") {
            // Активируем вкладку "МОИ ЗАКАЗЫ"
            if (tabOrderBoost) {
                tabOrderBoost.RemoveClass("active");
            }
            if (tabMyOrders) {
                tabMyOrders.AddClass("active");
            }
            if (tabContentOrderBoost) {
                tabContentOrderBoost.style.visibility = "collapse";
                tabContentOrderBoost.style.height = "0px";
                tabContentOrderBoost.style.padding = "0px";
            }
            if (tabContentMyOrders) {
                tabContentMyOrders.style.visibility = "visible";
                tabContentMyOrders.style.height = "fill-parent-flow(1)";
                tabContentMyOrders.style.padding = "20px";
            }
        }
    }
    
    // Переключение между вкладками левой панели
    function SwitchToLeftTab(tabName) {
        
        let tabBoosterSettings = $.GetContextPanel().FindChildTraverse("tab_booster_settings");
        let tabBoosterOrders = $.GetContextPanel().FindChildTraverse("tab_booster_orders");
        let tabContentBoosterSettings = $.GetContextPanel().FindChildTraverse("booster_settings_content");
        let tabContentBoosterOrders = $.GetContextPanel().FindChildTraverse("tab_content_booster_orders");
        
        
        if (tabName === "booster_settings") {
            // Активируем вкладку "НАСТРОЙКИ"
            if (tabBoosterSettings) {
                tabBoosterSettings.AddClass("active");
            }
            if (tabBoosterOrders) {
                tabBoosterOrders.RemoveClass("active");
            }
            if (tabContentBoosterSettings) {
                tabContentBoosterSettings.style.visibility = "visible";
                tabContentBoosterSettings.style.height = "fill-parent-flow(1)";
                tabContentBoosterSettings.style.padding = "20px";
            }
            if (tabContentBoosterOrders) {
                tabContentBoosterOrders.style.visibility = "collapse";
                tabContentBoosterOrders.style.height = "0px";
                tabContentBoosterOrders.style.padding = "0px";
            }
        } else if (tabName === "booster_orders") {
            // Активируем вкладку "МОИ ЗАКАЗЫ"
            if (tabBoosterSettings) {
                tabBoosterSettings.RemoveClass("active");
            }
            if (tabBoosterOrders) {
                tabBoosterOrders.AddClass("active");
            }
            if (tabContentBoosterSettings) {
                tabContentBoosterSettings.style.visibility = "collapse";
                tabContentBoosterSettings.style.height = "0px";
                tabContentBoosterSettings.style.padding = "0px";
            }
            if (tabContentBoosterOrders) {
                tabContentBoosterOrders.style.visibility = "visible";
                tabContentBoosterOrders.style.height = "fill-parent-flow(1)";
                tabContentBoosterOrders.style.padding = "20px";
            }
        } else {
        }
    }
    
    // Показать/скрыть вкладку "МОИ ЗАКАЗЫ" в зависимости от наличия заказов
    function UpdateMyOrdersTabVisibility(hasAnyOrders, hasActiveOrders) {
        $.Msg("DEBUG: UpdateMyOrdersTabVisibility вызвана с параметрами:", hasAnyOrders, hasActiveOrders);
        
        let tabMyOrders = $.GetContextPanel().FindChildTraverse("tab_my_orders");
        let panelHeader = $.GetContextPanel().FindChildTraverse("panel-header");
        let tabContentOrderBoost = $.GetContextPanel().FindChildTraverse("tab_content_order_boost");
        let tabContentMyOrders = $.GetContextPanel().FindChildTraverse("tab_content_my_orders");
        let panelTitleOrderBoost = $.GetContextPanel().FindChildTraverse("panel_title_order_boost");
        
        
        if (tabMyOrders && panelHeader && tabContentOrderBoost && tabContentMyOrders && panelTitleOrderBoost) {
            if (hasAnyOrders) {
                // Показываем вкладку "МОИ ЗАКАЗЫ" и заголовок вкладок
                tabMyOrders.style.visibility = "visible";
                panelHeader.RemoveClass("hidden");
                tabContentOrderBoost.RemoveClass("no-header");
                panelTitleOrderBoost.style.visibility = "collapse";
                panelTitleOrderBoost.GetParent().style.marginTop = "15px";
                
                // Переключаемся на вкладку заказов только если есть активные заказы
                if (hasActiveOrders) {
                    $.Msg("DEBUG: Переключаемся на 'my_orders' (есть активные заказы)");
                    SwitchToRightTab("my_orders");
                } else {
                    $.Msg("DEBUG: Переключаемся на 'order_boost' (нет активных заказов)");
                    SwitchToRightTab("order_boost");
                }
            } else {
                // Скрываем вкладку "МОИ ЗАКАЗЫ" и заголовок вкладок, показываем обычный заголовок
                tabMyOrders.style.visibility = "collapse";
                if (tabContentMyOrders) {
                    tabContentMyOrders.style.visibility = "collapse";
                    tabContentMyOrders.style.height = "0px";
                    tabContentMyOrders.style.padding = "0px";
                }
                panelHeader.AddClass("hidden");
                tabContentOrderBoost.AddClass("no-header");
                panelTitleOrderBoost.style.visibility = "visible";
                panelTitleOrderBoost.GetParent().style.marginTop = "0px";
                // Если скрываем вкладку, переключаемся на "ЗАКАЗАТЬ БУСТ"
                SwitchToRightTab("order_boost");
            }
        } else {
        }
    }
    
    // Показать/скрыть вкладку "МОИ ЗАКАЗЫ" для бустера
    function UpdateBoosterOrdersTabVisibility(hasAnyOrders, hasActiveOrders) {
        
        let tabBoosterOrders = $.GetContextPanel().FindChildTraverse("tab_booster_orders");
        let leftPanelHeader = $.GetContextPanel().FindChildTraverse("left_panel_header");
        let tabContentBoosterSettings = $.GetContextPanel().FindChildTraverse("booster_settings_content");
        let boosterSettingsTitle = $.GetContextPanel().FindChildTraverse("booster_settings_title");
        
        
        if (tabBoosterOrders && leftPanelHeader && tabContentBoosterSettings) {
            if (hasAnyOrders) {
                // Показываем вкладку "МОИ ЗАКАЗЫ" для бустера
                tabBoosterOrders.style.visibility = "visible";
                leftPanelHeader.RemoveClass("hidden");
                // Скрываем заголовок "НАСТРОЙКИ БУСТЕРА" когда есть вкладки
                if (boosterSettingsTitle) {
                    boosterSettingsTitle.style.visibility = "collapse";
                }
                // Добавляем отступ сверху для контента когда отображаются вкладки
                if (tabContentBoosterSettings) {
                    tabContentBoosterSettings.AddClass("no-title");
                    tabContentBoosterSettings.AddClass("with-tabs");
                }
                
                // Переключаемся на вкладку заказов только если есть активные заказы
                if (hasActiveOrders) {
                    SwitchToLeftTab("booster_orders");
                } else {
                    SwitchToLeftTab("booster_settings");
                }
            } else {
                // Скрываем вкладку "МОИ ЗАКАЗЫ" для бустера
                tabBoosterOrders.style.visibility = "collapse";
                leftPanelHeader.AddClass("hidden");
                // Показываем заголовок "НАСТРОЙКИ БУСТЕРА" когда нет вкладок
                if (boosterSettingsTitle) {
                    boosterSettingsTitle.style.visibility = "visible";
                }
                // Убираем отступы сверху для контента
                if (tabContentBoosterSettings) {
                    tabContentBoosterSettings.RemoveClass("no-title");
                    tabContentBoosterSettings.RemoveClass("with-tabs");
                }
                // Переключаемся на вкладку настроек
                SwitchToLeftTab("booster_settings");
            }
        } else {
        }
    }

    // Инициализация при загрузке
    function Initialize() {
        // Получаем ссылки на элементы
        licensePurchaseSection = $.GetContextPanel().FindChildTraverse("license_purchase_section");
        boosterSettingsContent = $.GetContextPanel().FindChildTraverse("booster_settings_content");
        licensePurchaseButton = $.GetContextPanel().FindChildTraverse("license_purchase_button2");
        confirmButton = $.GetContextPanel().FindChildTraverse("confirm_button");
        
        // Инициализация элементов окна подтверждения перенесена в глобальный HUD
        
        // Добавляем обработчики событий
        if (licensePurchaseButton) {
            licensePurchaseButton.SetPanelEvent("onmouseactivate", function() {
                $.Msg("DEBUG: OnLicensePurchaseClicked вызвана");
                Game.EmitSound("ui_generic_button_click");
                OnLicensePurchaseClicked();
            });
            licensePurchaseButton.SetPanelEvent("onmouseover", function() {
                // Убран звук при наведении
            });
        }
        
        if (confirmButton) {
            confirmButton.SetPanelEvent("onmouseactivate", function() {
                Game.EmitSound("ui_generic_button_click");
                OnConfirmSettingsClicked();
            });
        }
        
        // Обработчики для окна подтверждения перенесены в глобальный HUD
        
        // Добавляем валидацию для полей ввода цен
        SetupPriceInputValidation();
        
        // Инициализируем вкладки
        InitializeTabs();
        
        // Принудительно инициализируем вкладку "МОИ ЗАКАЗЫ"
        let tabMyOrders = $.GetContextPanel().FindChildTraverse("tab_my_orders");
        if (tabMyOrders) {
            tabMyOrders.style.visibility = "visible";
            tabMyOrders.style.opacity = "1";
        }
        
        // Убеждаемся, что содержимое вкладки "МОИ ЗАКАЗЫ" скрыто по умолчанию
        let tabContentMyOrders = $.GetContextPanel().FindChildTraverse("tab_content_my_orders");
        if (tabContentMyOrders) {
            tabContentMyOrders.style.visibility = "collapse";
            tabContentMyOrders.style.height = "0px";
            tabContentMyOrders.style.padding = "0px";
        }
        
        // Проверяем статус лицензии при загрузке
        CheckLicenseStatus();
        
        // Настраиваем интерактивность для статистики
        SetupStatsInteractivity();
        
        // Временный тест - принудительно показываем секцию через 3 секунды (ОТКЛЮЧЕНО)
        // $.Schedule(3.0, function() {
        //     let currentDealSection = $.GetContextPanel().FindChildTraverse("current_deal_section");
        //     if (currentDealSection) {
        //         currentDealSection.style.visibility = "visible";
        //         
        //         // Заполняем тестовыми данными
        //         let customerHero = currentDealSection.FindChildTraverse("deal_customer_hero");
        //         if (customerHero) {
        //             customerHero.text = "Заказчик #1234";
        //         }
        //         
        //         let difficulty = currentDealSection.FindChildTraverse("deal_difficulty");
        //         if (difficulty) {
        //             difficulty.text = "20";
        //         }
        //         
        //         let payout = currentDealSection.FindChildTraverse("deal_payout");
        //         if (payout) {
        //             payout.text = "90";
        //         }
        //         
        //         let status = currentDealSection.FindChildTraverse("deal_status");
        //         if (status) {
        //             status.text = "В процессе";
        //         }
        //         
        //     } else {
        //     }
        // });
    }
    
    // Обработчик нажатия на кнопку покупки лицензии
    function OnLicensePurchaseClicked() {
        // Сначала проверяем, хватает ли денег
        CheckMoneyForLicense();
    }
    
    // Проверка денег для покупки лицензии
    function CheckMoneyForLicense() {
        $.Msg("CheckMoneyForLicense called");
        // Отправляем запрос на сервер для проверки денег
        GameEvents.SendCustomGameEventToServer("check_money_for_license", {
            PlayerID: Players.GetLocalPlayer()
        });
        $.Msg("Check money event sent to server");
    }
    
    // Показать окно подтверждения покупки лицензии
    function ShowLicensePurchaseConfirmation() {
        $.Msg("ShowLicensePurchaseConfirmation called");
        const HUD = DotaHUD.Get();
        var confirmation_hud = HUD.FindChildTraverse("license_purchase_confirmation_hud");
        if(confirmation_hud) {
            confirmation_hud.DeleteAsync(0);
        }
        confirmation_hud = $.CreatePanel("Panel", HUD, "license_purchase_confirmation_hud");
        confirmation_hud.style.width = "100%";
        confirmation_hud.style.height = "100%";
        confirmation_hud.style.visibility = "visible";
        
        let loadResult = confirmation_hud.BLoadLayout( "file://{resources}/layout/custom_game/player_booster_service/license_purchase_confirmation.xml", false, false );
        $.Msg("Layout load result:", loadResult);
        $.Msg("Panel after load:", confirmation_hud);
        $.Msg("Panel children count:", confirmation_hud.GetChildCount());
        
        // if (!loadResult) {
        //     $.Msg("Failed to load layout, trying alternative path...");
        //     loadResult = confirmation_hud.BLoadLayout( "file://{resources}/layout/custom_game/player_booster_service/license_purchase_confirmation.xml", false, false );
        //     $.Msg("Alternative layout load result:", loadResult);
            
        //     if (!loadResult) {
        //         $.Msg("Both layout paths failed, creating manual structure...");
        //         CreateManualLicenseConfirmation(confirmation_hud);
        //         return;
        //     }
        // }
        
        // Добавляем обработчики событий
        let closeButton = confirmation_hud.FindChildTraverse("close_confirmation_button");
        let rejectButton = confirmation_hud.FindChildTraverse("reject_license_purchase");
        let confirmButton = confirmation_hud.FindChildTraverse("confirm_license_purchase");
        
        $.Msg("Close button found:", closeButton ? "yes" : "no");
        $.Msg("Reject button found:", rejectButton ? "yes" : "no");
        $.Msg("Confirm button found:", confirmButton ? "yes" : "no");
        
        if (closeButton) {
            closeButton.SetPanelEvent("onactivate", function() {
                Game.EmitSound("ui_generic_button_click");
                HideLicensePurchaseConfirmation();
            });
        }
        
        if (rejectButton) {
            rejectButton.SetPanelEvent("onactivate", function() {
                Game.EmitSound("ui_generic_button_click");
                HideLicensePurchaseConfirmation();
            });
        }
        
        if (confirmButton) {
            confirmButton.SetPanelEvent("onactivate", function() {
                Game.EmitSound("ui_generic_button_click");
                ConfirmLicensePurchase();
            });
        }
    }
    
    // Скрыть окно подтверждения покупки лицензии
    function HideLicensePurchaseConfirmation() {
        const HUD = DotaHUD.Get();
        var confirmation_hud = HUD.FindChildTraverse("license_purchase_confirmation_hud");
        if(confirmation_hud) {
            confirmation_hud.DeleteAsync(0);
        }
    }
    
    // Подтвердить покупку лицензии
    function ConfirmLicensePurchase() {
        // Скрываем окно подтверждения
        HideLicensePurchaseConfirmation();
        
        // Отправляем запрос на сервер для покупки лицензии
        GameEvents.SendCustomGameEventToServer("booster_purchase_license", {
            
        });
        
        // Показываем индикатор загрузки
        // ShowLoadingState();
    }
    
    // Обработчик ответа от сервера о проверке денег
    function OnMoneyCheckResponse(data) {
        if (data.success) {
            // Денег хватает, показываем окно подтверждения
            ShowLicensePurchaseConfirmation();
        } else {
            // Денег не хватает, показываем ошибку
            ShowNotification(data.error || 'Недостаточно денег', 'error');
        }
    }
    
    // Обработчик нажатия на кнопку подтверждения настроек
    function OnConfirmSettingsClicked() {
        // Собираем данные настроек
        let settings = CollectBoosterSettings();
        
        // Собираем все данные для отправки на сервер
        let data = {
            player_id: Players.GetLocalPlayer(),
            description: settings.description,
            is_hidden: settings.is_hidden,
            difficulty_prices: {},
            difficulty_availability: {}
        };
        
        // Заполняем цены и доступность по сложностям
        for (let difficulty in settings.prices) {
            data.difficulty_prices[difficulty] = settings.prices[difficulty].price;
            data.difficulty_availability[difficulty] = settings.prices[difficulty].enabled;
        }
        
        // Отправляем на сервер
        GameEvents.SendCustomGameEventToServer("booster_update_settings", data);
        
        // Показываем индикатор загрузки
        // ShowLoadingState();
    }
    
    // Сбор данных настроек бустера
    function CollectBoosterSettings() {
        let settings = {
            description: "",
            prices: {},
            is_hidden: false
        };
        
        // Получаем описание
        let descriptionInput = $.GetContextPanel().FindChildTraverse("description_input");
        if (descriptionInput) {
            settings.description = descriptionInput.text;
        }
        
        // Получаем цены по сложностям (ищем по классам)
        let priceInputs = $.GetContextPanel().FindChildrenWithClassTraverse("price-input");
        let toggleButtons = $.GetContextPanel().FindChildrenWithClassTraverse("toggle-button");
        
        // Сопоставляем поля цен с кнопками переключения
        for (let i = 0; i < priceInputs.length && i < toggleButtons.length; i++) {
            let difficulty = 20 - i; // Сложности идут от 20 до 1
            settings.prices[difficulty] = {
                price: parseInt(priceInputs[i].text) || 0,
                enabled: toggleButtons[i].checked
            };
        }
        
        // Получаем статус чекбокса скрытия (теперь это ToggleButton)
        let hideCheckbox = $.GetContextPanel().FindChildTraverse("hide_checkbox");
        if (hideCheckbox) {
            settings.is_hidden = hideCheckbox.checked;
        }
        
        return settings;
    }
    
    // Показать состояние загрузки
    function ShowLoadingState() {
        if (licensePurchaseButton) {
            let buttonText = licensePurchaseButton.FindChildTraverse("license-button-text");
            if (buttonText) {
                buttonText.text = $.Localize("#ui_booster_processing_button");
            }
            licensePurchaseButton.enabled = false;
        }
        
        if (confirmButton) {
            let buttonText = confirmButton.FindChildTraverse("confirm-button-text");
            if (buttonText) {
                buttonText.text = $.Localize("#ui_booster_processing_button");
            }
            confirmButton.enabled = false;
        }
    }
    
    // Сбросить состояние загрузки
    function ResetLoadingState() {
        if (licensePurchaseButton) {
            let buttonText = licensePurchaseButton.FindChildTraverse("license-button-text");
            if (buttonText) {
                buttonText.text = $.Localize("#ui_booster_buy_license_button");
            }
            licensePurchaseButton.enabled = true;
        }
        
        if (confirmButton) {
            let buttonText = confirmButton.FindChildTraverse("confirm-button-text");
            if (buttonText) {
                buttonText.text = $.Localize("#ui_booster_confirm_changes_button");
            }
            confirmButton.enabled = true;
        }
    }
    
    // Проверка статуса лицензии
    function CheckLicenseStatus() {
        // Запрашиваем статус лицензии у сервера
        GameEvents.SendCustomGameEventToServer("booster_check_license", {
            player_id: Players.GetLocalPlayer()
        });
    }
    
    // Обновление интерфейса в зависимости от статуса лицензии
    function UpdateLicenseStatus(hasLicense) {
        // Получаем ссылки на панели
        let tabContentBoosterSettings = $.GetContextPanel().FindChildTraverse("tab_content_booster_settings");
        let boosterSettingsContent = $.GetContextPanel().FindChildTraverse("booster_settings_content");
        let boosterSettingsTitle = $.GetContextPanel().FindChildTraverse("booster_settings_title");
        
        if (hasLicense) {
            // Показываем настройки бустера, скрываем покупку лицензии
            if (tabContentBoosterSettings) {
                tabContentBoosterSettings.style.visibility = "collapse";
                tabContentBoosterSettings.style.height = "0px";
                tabContentBoosterSettings.style.padding = "0px";
            }
            if (boosterSettingsContent) {
                boosterSettingsContent.style.visibility = "visible";
                boosterSettingsContent.style.height = "fill-parent-flow(1)";
                boosterSettingsContent.style.padding = "20px";
            }
            if (boosterSettingsTitle) {
                boosterSettingsTitle.style.visibility = "visible";
            }
        } else {
            // Показываем покупку лицензии, скрываем настройки
            if (tabContentBoosterSettings) {
                tabContentBoosterSettings.style.visibility = "visible";
                tabContentBoosterSettings.style.height = "fill-parent-flow(1)";
                tabContentBoosterSettings.style.padding = "20px";
            }
            if (boosterSettingsContent) {
                boosterSettingsContent.style.visibility = "collapse";
                boosterSettingsContent.style.height = "0px";
                boosterSettingsContent.style.padding = "0px";
            }
            if (boosterSettingsTitle) {
                boosterSettingsTitle.style.visibility = "collapse";
            }
        }
    }
    
    // Обработка ответа от сервера о покупке лицензии
    function OnLicensePurchaseResponse(data) {
        ResetLoadingState();
        
        if (data.success) {
            // Покупка успешна
            UpdateLicenseStatus(true);
            ShowNotification($.Localize("#ui_booster_notification_license_purchased"), "success");
        } else {
            // Ошибка покупки
            ShowNotification(data.message || $.Localize("#ui_booster_notification_license_error"), "error");
        }
    }
    
    // Обработка ответа от сервера о настройках
    function OnSettingsUpdateResponse(data) {
        ResetLoadingState();
        
        if (data.success) {
            ShowNotification($.Localize("#ui_booster_notification_settings_updated"), "success");
        } else {
            ShowNotification(data.message || $.Localize("#ui_booster_notification_settings_error"), "error");
        }
    }
    
    // Обработка ответа о статусе лицензии
    function OnLicenseStatusResponse(data) {
        UpdateLicenseStatus(data.has_license);
        
        // Если есть лицензия, загружаем настройки
        if (data.has_license && data.settings) {
            LoadBoosterSettings(data.settings);
        }
    }
    
    // Загрузка настроек бустера
    function LoadBoosterSettings(settings) {
        // Загружаем описание
        let descriptionInput = $.GetContextPanel().FindChildTraverse("description_input");
        if (descriptionInput && settings.description) {
            descriptionInput.text = settings.description;
        }
        
        // Добавляем звук для поля описания
        if (descriptionInput) {
            descriptionInput.SetPanelEvent("onfocus", function() {
                // Убран звук при наведении
            });
        }
        
        // Загружаем цены по сложностям
        let priceInputs = $.GetContextPanel().FindChildrenWithClassTraverse("price-input");
        let toggleButtons = $.GetContextPanel().FindChildrenWithClassTraverse("toggle-button");
        
        for (let i = 0; i < priceInputs.length && i < toggleButtons.length; i++) {
            let difficulty = 20 - i; // Сложности идут от 20 до 1
            if (settings.prices && settings.prices[difficulty]) {
                priceInputs[i].text = settings.prices[difficulty].price.toString();
                toggleButtons[i].checked = settings.prices[difficulty].enabled;
            }
            
            // Добавляем звук для ToggleButton
            toggleButtons[i].SetPanelEvent("onactivate", function() {
                Game.EmitSound("ui_select_md");
            });
        }
        
        // Загружаем статус скрытия
        let hideCheckbox = $.GetContextPanel().FindChildTraverse("hide_checkbox");
        if (hideCheckbox) {
            hideCheckbox.checked = settings.is_hidden || false;
            
            // Добавляем звук для чекбокса скрытия
            hideCheckbox.SetPanelEvent("onactivate", function() {
                Game.EmitSound("ui_select_md");
            });
        }
        
        // Валидируем все поля ввода цен после загрузки настроек
        ValidateAllPriceInputs();
    }
    
    // Настройка валидации для полей ввода цен
    function SetupPriceInputValidation() {
        let priceInputs = $.GetContextPanel().FindChildrenWithClassTraverse("price-input");
        
        for (let i = 0; i < priceInputs.length; i++) {
            let input = priceInputs[i];
            
            // Валидируем начальные значения при загрузке
            ValidatePriceInput(input);
            
            // Добавляем звук при фокусе на поле ввода
            input.SetPanelEvent("onfocus", function() {
                // Убран звук при наведении
            });
            
            // Добавляем обработчик изменения текста для фильтрации
            input.SetPanelEvent("ontextentrychange", function() {
                FilterNumericInput(input);
            });
            
            // Добавляем обработчик потери фокуса для валидации диапазона
            input.SetPanelEvent("onblur", function() {
                ValidatePriceInput(input);
            });
        }
    }
    
    // Фильтрация ввода - оставляем только цифры
    function FilterNumericInput(input) {
        if (!input) return;
        
        let text = input.text;
        let filteredText = text.replace(/[^0-9]/g, ''); // Удаляем все символы кроме цифр
        
        // Если текст изменился, обновляем поле
        if (text !== filteredText) {
            input.text = filteredText;
        }
        
        // Валидация в реальном времени - ограничиваем максимальное значение
        let value = parseInt(filteredText);
        if (!isNaN(value) && value > 500) {
            input.text = "500";
        }
    }
    
    // Валидация поля ввода цены
    function ValidatePriceInput(input) {
        if (!input) return;
        
        let value = parseInt(input.text);
        
        // Если значение не число или меньше 2, устанавливаем 2
        if (isNaN(value) || value < 2) {
            input.text = "2";
            return;
        }
        
        // Если значение больше 500, устанавливаем 500
        if (value > 500) {
            input.text = "500";
            return;
        }
        
        // Если все в порядке, обновляем значение
        input.text = value.toString();
    }
    
    // Принудительная валидация всех полей ввода цен
    function ValidateAllPriceInputs() {
        let priceInputs = $.GetContextPanel().FindChildrenWithClassTraverse("price-input");
        
        for (let i = 0; i < priceInputs.length; i++) {
            let input = priceInputs[i];
            if (input && input.IsValid()) {
                ValidatePriceInput(input);
            }
        }
    }
    
    // Показать уведомление
    function ShowNotification(message, type) {
        // Создаем временное уведомление
        let notificationId = "notification_" + GameUI.parseInt(Game.GetGameTime() * 1000);
        
        // Пробуем найти подходящий контейнер для уведомлений
        let contextPanel = DotaHUD.Get();
        let notification = null;
        
        if (contextPanel) {
            notification = $.CreatePanel("Panel", contextPanel, notificationId);
        }
        
        // Проверяем, что панель уведомления была создана
        if (!notification) {
            return;
        }
        
        // Настраиваем стили в зависимости от типа
        let backgroundColor, borderColor, textColor;
        
        switch (type) {
            case 'success':
                backgroundColor = 'gradient(linear, 0% 0%, 0% 100%, from(#2b6f4f), to(#1e4a3b))';
                borderColor = '#4a8a6a';
                textColor = '#ffffff';
                break;
            case 'error':
                backgroundColor = 'gradient(linear, 0% 0%, 0% 100%, from(#6f2b2b), to(#4a1e1e))';
                borderColor = '#8a4a4a';
                textColor = '#ffffff';
                break;
            case 'info':
                backgroundColor = 'gradient(linear, 0% 0%, 0% 100%, from(#2b4a6f), to(#1e3a4a))';
                borderColor = '#4a6a8a';
                textColor = '#ffffff';
                break;
            case 'warning':
                backgroundColor = 'gradient(linear, 0% 0%, 0% 100%, from(#6f5a2b), to(#4a3e1e))';
                borderColor = '#8a7a4a';
                textColor = '#ffffff';
                break;
            default:
                backgroundColor = 'gradient(linear, 0% 0%, 0% 100%, from(#2b4a6f), to(#1e3a4a))';
                borderColor = '#4a6a8a';
                textColor = '#ffffff';
        }
        
        // Применяем стили к панели уведомления
        notification.style.width = '400px';
        notification.style.minHeight = '60px';
        notification.style.margin = '30px 0px';
        notification.style.padding = '16px 20px';
        notification.style.borderRadius = '8px';
        notification.style.flowChildren = 'right';
        notification.style.horizontalAlign = 'center';
        notification.style.verticalAlign = 'top';
        notification.style.boxShadow = 'fill #00000088 0px 4px 12px 0px';
        notification.style.zIndex = '1001';
        notification.style.border = '2px solid ' + borderColor;
        notification.style.backgroundColor = backgroundColor;
        notification.style.transitionProperty = 'opacity, transform, brightness';
        notification.style.transitionDuration = '0.3s';
        notification.style.transitionTimingFunction = 'ease-in-out';
        
        // Анимация появления
        notification.style.opacity = '1';
        notification.style.transform = 'translateY(0px)';
        notification.style.brightness = '1';
        
        // Создаем контент
        let content = $.CreatePanel("Panel", notification, "content");
        content.style.width = 'fill-parent-flow(1)';
        content.style.flowChildren = 'down';
        content.style.verticalAlign = 'center';
        
        // Создаем текст уведомления
        let label = $.CreatePanel("Label", content, "notification-text");
        label.text = message;
        label.style.fontFamily = '"Radiance", "Arial Unicode MS"';
        label.style.fontSize = '16px';
        label.style.fontWeight = 'bold';
        label.style.color = textColor;
        label.style.textAlign = 'center';
        label.style.textShadow = '1px 1px 3px #000000AA';
        label.style.lineHeight = '1.4';
        label.style.textOverflow = 'clip';
        label.style.whiteSpace = 'normal';
        label.style.width = '100%';
        
        // Автоматически удаляем через 5 секунд
        $.Schedule(5.0, function() {
            if (notification && notification.IsValid()) {
                // Анимация исчезновения
                notification.style.opacity = '0';
                notification.style.transform = 'translateY(-20px)';
                notification.style.brightness = '0.8';
                
                // Удаляем после анимации
                $.Schedule(0.3, function() {
                    if (notification && notification.IsValid()) {
                        notification.DeleteAsync(0);
                    }
                });
            }
        });
        
        // Воспроизводим звук
        switch (type) {
            case 'success':
                Game.EmitSound("ui_notification_success");
                break;
            case 'error':
                Game.EmitSound("ui_notification_error");
                break;
            case 'warning':
                Game.EmitSound("ui_notification_warning");
                break;
            case 'info':
            default:
                Game.EmitSound("ui_notification_info");
                break;
        }
    }
    
    // Обновление профиля бустера
    function UpdateBoosterProfile(data) {
        try {
            
            // Проверяем, есть ли данные о заказах клиента
            
            if (data.has_license) {
                // Показываем настройки бустера
                UpdateLicenseStatus(true);
                
                // Формируем настройки из переданных данных
                let settings = {
                    description: data.description || "",
                    prices: {},
                    is_hidden: (data.is_hidden === 1 || data.is_hidden === true)
                };
                
                // Заполняем цены и доступность по сложностям
                if (data.difficulty_prices && data.difficulty_availability) {
                    for (let difficulty in data.difficulty_prices) {
                        settings.prices[difficulty] = {
                            price: data.difficulty_prices[difficulty] || 0,
                            enabled: (data.difficulty_availability[difficulty] === 1 || data.difficulty_availability[difficulty] === true)
                        };
                    }
                }
                
                // Загружаем настройки
                try {
                    LoadBoosterSettings(settings);
                } catch (e) {
                }
                
                // Обновляем статистику бустера
                try {
                    UpdateBoosterStats(data);
                } catch (e) {
                }
                
                // Обновляем информацию о текущей сделке (ВРЕМЕННО ОТКЛЮЧЕНО)
                try {
                    UpdateCurrentDealFromProfile(data);
                } catch (e) {
                }
            } else {
                // Показываем покупку лицензии
                UpdateLicenseStatus(false);
            }

            if(!DotaHUD.IsWindowOpen("player_booster_service")){
                DotaHUD.WindowOpen("player_booster_service")
            }
        } catch (e) {
        }
    }
    
    // Обновление статистики бустера
    function UpdateBoosterStats(data) {
        // Обновляем статистику бустера если есть соответствующие элементы
        let statsPanel = $.GetContextPanel().FindChildTraverse("booster_stats");
        if (statsPanel) {
            // Обновляем общее количество заказов
            let totalOrders = statsPanel.FindChildTraverse("total_orders");
            if (totalOrders) {
                totalOrders.text = data.total_orders || "0";
            }
            
            // Обновляем количество выполненных заказов
            let completedOrders = statsPanel.FindChildTraverse("completed_orders");
            if (completedOrders) {
                completedOrders.text = data.completed_orders || "0";
            }
            
            // Обновляем общий доход
            let totalEarnings = statsPanel.FindChildTraverse("total_earnings");
            if (totalEarnings) {
                totalEarnings.text = (data.total_earnings || "0") + $.Localize("#ui_booster_currency_suffix");
            }
            
            // Обновляем дату последней активности
            let lastActivity = statsPanel.FindChildTraverse("last_activity");
            if (lastActivity && data.last_activity) {
                let date = new Date(data.last_activity);
                lastActivity.text = date.toLocaleDateString() + " " + date.toLocaleTimeString();
            }
            
            // Обновляем дату создания
            let createdAt = statsPanel.FindChildTraverse("created_at");
            if (createdAt && data.created_at) {
                let date = new Date(data.created_at);
                createdAt.text = date.toLocaleDateString() + " " + date.toLocaleTimeString();
            }
        }
        
        // Обновляем статус скрытия
        let hideCheckbox = $.GetContextPanel().FindChildTraverse("hide_checkbox");
        if (hideCheckbox) {
            hideCheckbox.checked = data.is_hidden || false;
        }
        
        // Обновляем количество выполненных бустов
        let completedBoosts = $.GetContextPanel().FindChildTraverse("completed_boosts");
        if (completedBoosts) {
            completedBoosts.text = data.completed_orders || "0";
        }

        let earnedCoins = $.GetContextPanel().FindChildTraverse("earned_coins");
        if (earnedCoins) {
            earnedCoins.text = data.total_earnings || "0";
        }
        
        // Обновляем статус активности (если есть заказы, значит активен)
        let statusPanel = $.GetContextPanel().FindChildTraverse("booster_status");
        if (statusPanel) {
            if (data.total_orders > 0) {
                statusPanel.AddClass("active");
                statusPanel.RemoveClass("inactive");
            } else {
                statusPanel.AddClass("inactive");
                statusPanel.RemoveClass("active");
            }
        }
        
        // Обновляем информацию о лицензии
        UpdateLicenseInfo(data);
    }
    
    // Обновление информации о лицензии
    function UpdateLicenseInfo(data) {
        // Обновляем количество дней
        let licenseDaysRemaining = $.GetContextPanel().FindChildTraverse("license_days_remaining");
        if (licenseDaysRemaining) {
            if (data.license_info && data.license_info.is_permanent) {
                licenseDaysRemaining.text = "Неограниченно";
                licenseDaysRemaining.style.color = "#FFD700"; // Gold for permanent
            } else if (data.license_info && data.license_info.days_remaining !== undefined) {
                let days = data.license_info.days_remaining;
                licenseDaysRemaining.text = days.toString() + " дней";
                
                // Меняем цвет в зависимости от количества дней
                if (days <= 3) {
                    licenseDaysRemaining.style.color = "#FF4444"; // Красный для срочности
                } else if (days <= 7) {
                    licenseDaysRemaining.style.color = "#FFAA00"; // Желтый для предупреждения
                } else {
                    licenseDaysRemaining.style.color = "#00FF00"; // Зеленый для нормального состояния
                }
            } else {
                licenseDaysRemaining.text = "0 дней";
                licenseDaysRemaining.style.color = "#FF4444";
            }
        }
        
        // Обновляем дату покупки
        let licensePurchasedDate = $.GetContextPanel().FindChildTraverse("license_purchased_date");
        if (licensePurchasedDate && data.license_info && data.license_info.purchased_at) {
            try {
                let date = new Date(data.license_info.purchased_at);
                if (!isNaN(date.getTime())) {
                    let day = date.getDate().toString().padStart(2, '0');
                    let month = (date.getMonth() + 1).toString().padStart(2, '0');
                    let year = date.getFullYear();
                    licensePurchasedDate.text = day + "." + month + "." + year;
                } else {
                    licensePurchasedDate.text = "Неизвестно";
                }
            } catch (e) {
                licensePurchasedDate.text = "Неизвестно";
            }
        }
    }
    
    // Добавляем интерактивность для карточек статистики
    function SetupStatsInteractivity() {
        // Добавляем обработчики для карточек статистики
        let statsCards = $.GetContextPanel().FindChildrenWithClassTraverse("stats-card");
        for (let i = 0; i < statsCards.length; i++) {
            let card = statsCards[i];
            if (card) {
                card.SetPanelEvent("onmouseover", function() {
                    // Убран звук при наведении
                });
                
                card.SetPanelEvent("onactivate", function() {
                    Game.EmitSound("ui_generic_button_click");
                    // Можно добавить дополнительную информацию при клике
                });
            }
        }
        
        // Добавляем обработчики для строк лицензии
        let licenseRows = $.GetContextPanel().FindChildrenWithClassTraverse("license-detail-row");
        for (let i = 0; i < licenseRows.length; i++) {
            let row = licenseRows[i];
            if (row) {
                row.SetPanelEvent("onmouseover", function() {
                    // Убран звук при наведении
                });
            }
        }
        
        // Добавляем звуки для всех кнопок
        let buttons = $.GetContextPanel().FindChildrenWithClassTraverse("button");
        for (let i = 0; i < buttons.length; i++) {
            let button = buttons[i];
            if (button) {
                button.SetPanelEvent("onmouseover", function() {
                    // Убран звук при наведении
                });
                button.SetPanelEvent("onactivate", function() {
                    Game.EmitSound("ui_generic_button_click");
                });
            }
        }
        
        // Добавляем звуки для карточек бустеров
        let boosterCards = $.GetContextPanel().FindChildrenWithClassTraverse("booster-card");
        for (let i = 0; i < boosterCards.length; i++) {
            let card = boosterCards[i];
            if (card) {
                card.SetPanelEvent("onmouseover", function() {
                    // Убран звук при наведении
                });
            }
        }
        
        // Добавляем звуки для элементов заказов
        let orderItems = $.GetContextPanel().FindChildrenWithClassTraverse("order-item");
        for (let i = 0; i < orderItems.length; i++) {
            let item = orderItems[i];
            if (item) {
                item.SetPanelEvent("onmouseover", function() {
                    // Убран звук при наведении
                });
            }
        }
        
        // Добавляем звуки для вкладок
        let tabButtons = $.GetContextPanel().FindChildrenWithClassTraverse("tab-button");
        for (let i = 0; i < tabButtons.length; i++) {
            let tab = tabButtons[i];
            if (tab) {
                tab.SetPanelEvent("onmouseover", function() {
                    // Убран звук при наведении
                });
                tab.SetPanelEvent("onactivate", function() {
                    Game.EmitSound("ui_generic_button_click");
                });
            }
        }
    }

    // Обновление информации о текущей сделке
    function UpdateCurrentDeal(dealData) {
        
        let currentDealSection = $.GetContextPanel().FindChildTraverse("current_deal_section");
        if (!currentDealSection) {
            return;
        }
        
        if (dealData && dealData.customer_hero_name) {
            // Показываем секцию текущей сделки
            currentDealSection.style.visibility = "visible";
            
            // Обновляем аватар героя заказчика
            let customerAvatar = currentDealSection.FindChildTraverse("deal_customer_avatar");
            if (customerAvatar) {
                customerAvatar.heroname = dealData.customer_hero_name;
            }
            
            // Обновляем имя героя
            let customerHero = currentDealSection.FindChildTraverse("deal_customer_hero");
            if (customerHero) {
                customerHero.text = GetHeroDisplayName(dealData.customer_hero_name);
            }
            
            // Обновляем сложность
            let difficulty = currentDealSection.FindChildTraverse("deal_difficulty");
            if (difficulty) {
                difficulty.text = dealData.game_difficulty.toString();
            }
            
            // Обновляем выплату бустеру
            let payout = currentDealSection.FindChildTraverse("deal_payout");
            if (payout) {
                payout.text = dealData.booster_payout.toString();
            }
            
            // Обновляем статус
            let status = currentDealSection.FindChildTraverse("deal_status");
            if (status) {
                status.text = dealData.status || $.Localize("#ui_booster_status_in_progress");
            }
        } else {
            // Скрываем секцию если нет активной сделки
            currentDealSection.style.visibility = "collapse";
        }
    }

    // Обновление информации о текущей сделке из профиля бустера
    function UpdateCurrentDealFromProfile(boosterProfile) {
        try {
        
        let currentDealSection = $.GetContextPanel().FindChildTraverse("current_deal_section");
        
        // Проверяем наличие секции, но не прерываем выполнение если её нет
        if (currentDealSection) {
        } else {
        }
        
        // Проверяем есть ли заказы
        let hasAnyOrders = false;
        let hasActiveOrders = false;
        
        if (boosterProfile.boost_orders && Object.keys(boosterProfile.boost_orders).length > 0) {
            hasAnyOrders = true;
            
            // Берем первый заказ (любой статус)
            let firstOrder = null;
            for (let i = 1; i <= Object.keys(boosterProfile.boost_orders).length; i++) {
                let order = boosterProfile.boost_orders[i];
                if (order) {
                    firstOrder = order;
                    break;
                }
            }
            
            // Проверяем есть ли активные заказы для переключения вкладок
            for (let i = 1; i <= Object.keys(boosterProfile.boost_orders).length; i++) {
                let order = boosterProfile.boost_orders[i];
                if (order && (order.status === "IN_PROGRESS" || order.status === "WAITING_CONFIRMATION")) {
                    hasActiveOrders = true;
                    break;
                }
            }
            
            if (firstOrder && currentDealSection) {
                // Обновляем секцию в левой панели
                UpdateDealSection(currentDealSection, firstOrder);
                
                // Показываем секцию
                currentDealSection.style.visibility = "visible";
            } else if (currentDealSection) {
                currentDealSection.style.visibility = "collapse";
            }
        } else if (currentDealSection) {
            currentDealSection.style.visibility = "collapse";
        }
        
        // Отображаем все заказы бустера
        if (boosterProfile.boost_orders && Object.keys(boosterProfile.boost_orders).length > 0) {
            try {
                DisplayBoosterOrders(boosterProfile.boost_orders);
            } catch (e) {
            }
        } else {
        }
        
        // Обновляем видимость вкладки "МОИ ЗАКАЗЫ" для бустера
        try {
        UpdateBoosterOrdersTabVisibility(hasAnyOrders, hasActiveOrders);
        } catch (e) {
        }
        
        // Переключаемся на вкладку "МОИ ЗАКАЗЫ" если есть активные заказы
        if (hasActiveOrders) {
            try {
                SwitchToLeftTab("booster_orders");
            } catch (e) {
            }
        }
        } catch (e) {
        }
    }
    
    // Обновление конкретной секции сделки
    function UpdateDealSection(dealSection, activeOrder) {
        // Обновляем аватар героя заказчика (используем дефолтного героя, так как имя героя не передается)
        let customerAvatar = dealSection.FindChildTraverse("deal_customer_avatar");
        if (customerAvatar) {
            customerAvatar.heroname = "npc_dota_hero_abyssal_underlord"; // Дефолтный герой
        }
        
        // Обновляем имя заказчика
        let customerHero = dealSection.FindChildTraverse("deal_customer_hero");
        if (customerHero) {
            let steamId = activeOrder.customer_steam_id;
            if (typeof steamId === 'string') {
                customerHero.text = $.Localize("#ui_booster_customer_id_prefix") + steamId.slice(-4);
            } else {
                customerHero.text = $.Localize("#ui_booster_customer_id_prefix") + steamId.toString().slice(-4);
            }
        }
        
        // Обновляем сложность
        let difficulty = dealSection.FindChildTraverse("deal_difficulty");
        if (difficulty) {
            difficulty.text = activeOrder.game_difficulty.toString();
        }
        
        // Обновляем выплату бустеру
        let payout = dealSection.FindChildTraverse("deal_payout");
        if (payout) {
            payout.text = activeOrder.booster_payout.toString();
        }
        
        // Обновляем статус
        let status = dealSection.FindChildTraverse("deal_status");
        if (status) {
            let statusText = $.Localize("#ui_booster_status_in_progress");
            if (activeOrder.status === "IN_PROGRESS") {
                statusText = $.Localize("#ui_booster_status_in_progress");
            } else if (activeOrder.status === "COMPLETED") {
                statusText = $.Localize("#ui_booster_status_completed");
            } else if (activeOrder.status === "CANCELLED") {
                statusText = $.Localize("#ui_booster_status_cancelled_short");
            }
            status.text = statusText;
        }
    }
    
    // Отображение заказов бустера
    function DisplayBoosterOrders(orders) {
        
        let ordersList = $.GetContextPanel().FindChildTraverse("booster_orders_list");
        if (!ordersList) {
            return;
        }
        
        // Очищаем список
        ordersList.RemoveAndDeleteChildren();
        
        if (!orders || Object.keys(orders).length === 0) {
            return;
        }
        
        
        try {
            // Отображаем заказы в том же порядке, как приходят с базы данных
            let ordersArray = [];
            for (let i = 1; i <= Object.keys(orders).length; i++) {
                if (orders[i]) {
                    ordersArray.push(orders[i]);
                }
            }
            
            
            // Создаем элементы заказов используя снипет
            for (let i = 0; i < ordersArray.length; i++) {
                let order = ordersArray[i];
                try {
                    let createdItem = CreateBoosterOrderItem(ordersList, order);
                    if (createdItem) {
                    } else {
                    }
                } catch (e) {
                }
            }
        } catch (e) {
        }
    }
    
    // Создание элемента заказа бустера с использованием снипета
    function CreateBoosterOrderItem(parent, order) {
        try {
            
            // Создаем панель из снипета
            let orderPanel = $.CreatePanel("Panel", parent, "");
            orderPanel.BLoadLayoutSnippet("booster_order_item");
            
            // Находим элементы внутри панели по ID
            let avatar = orderPanel.FindChildTraverse("booster_order_avatar");
            let customerName = orderPanel.FindChildTraverse("booster_order_customer_name");
            let status = orderPanel.FindChildTraverse("booster_order_status");
            let difficulty = orderPanel.FindChildTraverse("booster_order_difficulty");
            let payout = orderPanel.FindChildTraverse("booster_order_payout");
            let paymentStatus = orderPanel.FindChildTraverse("booster_order_payment_status");
            let date = orderPanel.FindChildTraverse("booster_order_date");
            
            
            // Заполняем аватарку клиента
            if (avatar) {
                // Преобразуем customer_steam_id в строку если это число
                let steamId = order.customer_steam_id;
                if (typeof steamId === 'number') {
                    steamId = steamId.toString();
                }
                avatar.steamid = steamId;
            }
            
            // Заполняем имя клиента
            if (customerName) {
                // Преобразуем customer_steam_id в строку если это число
                let steamId = order.customer_steam_id;
                if (typeof steamId === 'number') {
                    steamId = steamId.toString();
                }
                customerName.steamid = steamId;
            }
            
            // Заполняем статус в заголовке
            if (status) {
                status.text = GetStatusText(order.status);
                status.AddClass(order.status);
            }
            
            // Добавляем класс active для заказов в процессе
            if (order.status === "IN_PROGRESS") {
                orderPanel.AddClass("active");
            }
            
            // Заполняем сложность
            if (difficulty) {
                difficulty.text = order.game_difficulty.toString();
            }
            
            // Заполняем выплату
            if (payout) {
                payout.text = order.booster_payout.toString();
            }
            
            // Заполняем статус оплаты
            if (paymentStatus) {
                paymentStatus.text = GetPaymentStatusText(order.payment_status);
                paymentStatus.AddClass(order.payment_status);
            }
            
            // Заполняем дату
            if (date) {
                date.text = FormatDate(order.created_at);
            }
            
            return orderPanel;
        } catch (e) {
            return null;
        }
    }
    
    // Получение текста статуса оплаты
    function GetPaymentStatusText(paymentStatus) {
        switch (paymentStatus) {
            case "HELD":
                return $.Localize("#ui_booster_payment_held");
            case "RETURNED":
                return $.Localize("#ui_booster_payment_returned");
            case "PAID_TO_BOOSTER":
                return $.Localize("#ui_booster_payment_paid_to_booster");
            default:
                return paymentStatus;
        }
    }
    
    // Форматирование даты
    function FormatDate(dateString) {
        try {
            let date = new Date(dateString);
            if (isNaN(date.getTime())) {
                return dateString; // Возвращаем исходную строку если дата невалидна
            }
            let day = date.getDate().toString().padStart(2, '0');
            let month = (date.getMonth() + 1).toString().padStart(2, '0');
            let year = date.getFullYear();
            return day + '.' + month + '.' + year;
        } catch (e) {
            return dateString;
        }
    }
    
    // Создание элемента заказа клиента с использованием снипета
    function CreateCustomerOrderItem(parent, order) {
        try {
            
            // Создаем панель из снипета
            let orderPanel = $.CreatePanel("Panel", parent, "");
            orderPanel.BLoadLayoutSnippet("customer_order_item");
            
            // Находим элементы внутри панели по ID
            let avatar = orderPanel.FindChildTraverse("order_avatar");
            let boosterName = orderPanel.FindChildTraverse("order_booster_name");
            let status = orderPanel.FindChildTraverse("order_status");
            let price = orderPanel.FindChildTraverse("order_price");
            let difficulty = orderPanel.FindChildTraverse("order_difficulty");
            let date = orderPanel.FindChildTraverse("order_date");
            let paymentStatus = orderPanel.FindChildTraverse("order_payment_status");
            
            
            // Заполняем аватарку бустера
            if (avatar) {
                avatar.steamid = order.booster_steam_id;
            }
            
            // Заполняем имя бустера
            if (boosterName) {
                boosterName.steamid = order.booster_steam_id;
            }
            
            // Заполняем статус в заголовке
            if (status) {
                status.text = GetStatusText(order.status);
                status.AddClass(order.status);
            }
            
            // Добавляем класс active для заказов в процессе
            if (order.status === "IN_PROGRESS") {
                orderPanel.AddClass("active");
            }
            
            // Заполняем стоимость
            if (price) {
                price.text = order.customer_price.toString();
            } else {
            }
            
            // Заполняем сложность
            if (difficulty) {
                difficulty.text = order.game_difficulty.toString();
            } else {
            }
            
            // Заполняем дату
            if (date) {
                date.text = FormatDate(order.created_at);
            } else {
            }
            
            // Заполняем статус оплаты
            if (paymentStatus) {
                paymentStatus.text = GetPaymentStatusText(order.payment_status);
                paymentStatus.AddClass(order.payment_status);
            } else {
            }
            
            // Проверяем, что все элементы заполнены
            
            return orderPanel;
        } catch (e) {
            return null;
        }
    }

    // Отображение заказов клиента
    function DisplayCustomerOrders(orders) {
        
        let ordersList = $.GetContextPanel().FindChildTraverse("customer_orders_list");
        if (!ordersList) {
            return;
        }
        
        // Очищаем список
        ordersList.RemoveAndDeleteChildren();
        
        if (!orders || Object.keys(orders).length === 0) {
            return;
        }
        
        
        try {
            // Отображаем заказы в том же порядке, как приходят с базы данных
            let ordersArray = [];
            for (let i = 1; i <= Object.keys(orders).length; i++) {
                if (orders[i]) {
                    ordersArray.push(orders[i]);
                }
            }
            
            
            // Создаем элементы заказов используя снипет
            for (let i = 0; i < ordersArray.length; i++) {
                let order = ordersArray[i];
                try {
                    CreateCustomerOrderItem(ordersList, order);
                } catch (e) {
                }
            }
        } catch (e) {
        }
    }
    
    // Создание элемента заказа
    function CreateOrderItem(parent, order, type) {
        
        try {
            let orderItem = $.CreatePanel("Panel", parent, "order_item_" + Math.random());
            orderItem.AddClass("order-item");
            
            // Заголовок с статусом и датой
            let header = $.CreatePanel("Panel", orderItem, "order_header");
            header.AddClass("order-header");
            
            let status = $.CreatePanel("Label", header, "order_status");
            status.AddClass("order-status");
            status.AddClass(order.status);
            status.text = GetStatusText(order.status);
            
            let date = $.CreatePanel("Label", header, "order_date");
            date.AddClass("order-date");
            
            try {
                let dateObj = new Date(order.created_at);
                if (isNaN(dateObj.getTime())) {
                    date.text = $.Localize("#ui_booster_unknown_date");
                } else {
                    // Используем более простой формат даты для совместимости с Panorama UI
                    let day = dateObj.getDate().toString().padStart(2, '0');
                    let month = (dateObj.getMonth() + 1).toString().padStart(2, '0');
                    let year = dateObj.getFullYear();
                    date.text = day + "." + month + "." + year;
                }
            } catch (e) {
                date.text = $.Localize("#ui_booster_unknown_date");
            }
        } catch (e) {
            throw e;
        }
        
        try {
            // Детали заказа
            let details = $.CreatePanel("Panel", orderItem, "order_details");
            details.AddClass("order-details");
            
            if (type === "booster") {
                // Для бустера показываем информацию о заказчике
                let customerSteamId = order.customer_steam_id;
                let customerId = typeof customerSteamId === 'string' ? customerSteamId.slice(-4) : customerSteamId.toString().slice(-4);
                CreateDetailRow(details, $.Localize("#ui_booster_customer_id_prefix"), $.Localize("#ui_booster_id_prefix") + customerId);
                CreateDetailRow(details, $.Localize("#ui_booster_difficulty_short") + ":", order.game_difficulty.toString());
                CreateDetailRow(details, $.Localize("#ui_booster_customer_price_label"), order.customer_price.toString() + $.Localize("#ui_booster_currency_suffix"));
                CreateDetailRow(details, $.Localize("#ui_booster_commission_label"), order.commission_amount.toString() + $.Localize("#ui_booster_currency_suffix"));
                CreateDetailRow(details, $.Localize("#ui_booster_your_payout_label"), order.booster_payout.toString() + $.Localize("#ui_booster_currency_suffix"));
            } else {
                // Для клиента показываем информацию о бустере
                let boosterSteamId = order.booster_steam_id;
                let boosterId = typeof boosterSteamId === 'string' ? boosterSteamId.slice(-4) : boosterSteamId.toString().slice(-4);
                CreateDetailRow(details, $.Localize("#ui_booster_booster_id_prefix"), $.Localize("#ui_booster_id_prefix") + boosterId);
                CreateDetailRow(details, $.Localize("#ui_booster_difficulty_short") + ":", order.game_difficulty.toString());
                CreateDetailRow(details, $.Localize("#ui_booster_price_label"), order.customer_price.toString() + $.Localize("#ui_booster_currency_suffix"));
                CreateDetailRow(details, $.Localize("#ui_booster_commission_label"), order.commission_amount.toString() + $.Localize("#ui_booster_currency_suffix"));
                CreateDetailRow(details, $.Localize("#ui_booster_booster_payout_label"), order.booster_payout.toString() + $.Localize("#ui_booster_currency_suffix"));
            }
            
            CreateDetailRow(details, $.Localize("#ui_booster_payment_status_full_label"), order.payment_status);
            CreateDetailRow(details, $.Localize("#ui_booster_current_match_label"), (order.is_current_match === 1 || order.is_current_match === true) ? $.Localize("#ui_booster_yes") : $.Localize("#ui_booster_no"));
            
        } catch (e) {
            throw e;
        }
    }
    
    // Создание строки деталей заказа
    function CreateDetailRow(parent, label, value) {
        let row = $.CreatePanel("Panel", parent, "detail_row_" + Math.random());
        row.AddClass("order-detail-row");
        
        let labelElement = $.CreatePanel("Label", row, "detail_label");
        labelElement.AddClass("order-detail-label");
        labelElement.text = label;
        
        let valueElement = $.CreatePanel("Label", row, "detail_value");
        valueElement.AddClass("order-detail-value");
        valueElement.text = value;
    }
    
    // Получение текста статуса
    function GetStatusText(status) {
        switch (status) {
            case "WAITING_CONFIRMATION":
                return $.Localize("#ui_booster_status_waiting_confirmation");
            case "IN_PROGRESS":
                return $.Localize("#ui_booster_status_in_progress");
            case "COMPLETED":
                return $.Localize("#ui_booster_status_completed");
            case "FAILED":
                return $.Localize("#ui_booster_status_failed");
            case "CANCELLED":
                return $.Localize("#ui_booster_status_cancelled");
            default:
                return status;
        }
    }

    // Получить отображаемое имя героя
    function GetHeroDisplayName(heroName) {
        // Убираем префикс npc_dota_hero_
        if (heroName && heroName.startsWith("npc_dota_hero_")) {
            return heroName.replace("npc_dota_hero_", "").replace(/_/g, " ").toUpperCase();
        }
        return heroName || "Unknown Hero";
    }

    // Обработка данных команды бустеров
    function UpdateTeamBoosters(data) {
        
        // Проверяем, есть ли данные - может быть массивом или объектом с team_boosters
        let boostersArray = data;
        if (data && data.team_boosters) {
            boostersArray = data.team_boosters;
        }
        
        // Если это объект с числовыми ключами, преобразуем в массив
        if (boostersArray && typeof boostersArray === 'object' && !Array.isArray(boostersArray)) {
            boostersArray = Object.values(boostersArray);
        }
        
        // Находим контейнер для списка бустеров команды
        let boostersList = $.GetContextPanel().FindChildTraverse("boosters-list");
        if (!boostersList) {
            return;
        }
        
        // Очищаем существующие карточки бустеров
        ClearBoosterCards(boostersList);
        
        // Проверяем, есть ли бустеры
        if (!boostersArray || !Array.isArray(boostersArray) || boostersArray.length === 0) {
            // Показываем сообщение о том, что бустеров нет
            ShowNoBoostersMessage(boostersList);
            return;
        }
        
        // Создаем карточки для каждого бустера команды
        for (let i = 0; i < boostersArray.length; i++) {
            let boosterData = boostersArray[i];
            if (boosterData.success && boosterData.booster_profile) {
                CreateBoosterCard(boostersList, boosterData.booster_profile, boosterData.user_steam_id, boosterData.hero_name, boosterData.PlayerID);
            }
        }
    }
    
    // Обработка данных случайных бустеров
    function UpdateRandomBoosters(data) {
        
        // Проверяем, есть ли данные - может быть массивом или объектом
        let boostersArray = data;
        if (data && data.random_boosters) {
            boostersArray = data.random_boosters;
        }
        
        // Если это объект с числовыми ключами, преобразуем в массив
        if (boostersArray && typeof boostersArray === 'object' && !Array.isArray(boostersArray)) {
            boostersArray = Object.values(boostersArray);
        }
        
        // Находим контейнер для списка случайных бустеров
        let randomBoostersList = $.GetContextPanel().FindChildTraverse("random_boosters_list");
        if (!randomBoostersList) {
            return;
        }
        
        // Очищаем существующие карточки бустеров
        ClearBoosterCards(randomBoostersList);
        
        // Проверяем, есть ли бустеры
        if (!boostersArray || !Array.isArray(boostersArray) || boostersArray.length === 0) {
            // Показываем сообщение о том, что случайных бустеров нет
            ShowNoRandomBoostersMessage(randomBoostersList);
            return;
        }
        
        // Создаем карточки для каждого случайного бустера
        for (let i = 0; i < boostersArray.length; i++) {
            let boosterData = boostersArray[i];
            if (boosterData.success && boosterData.booster_profile) {
                CreateRandomBoosterCard(randomBoostersList, boosterData.booster_profile, boosterData.user_steam_id, boosterData.hero_name);
            }
        }
    }
    
    // Очистка существующих карточек бустеров
    function ClearBoosterCards(container) {
        if (!container) return;
        
        // Удаляем все существующие карточки бустеров
        let existingCards = container.FindChildrenWithClassTraverse("booster-card");
        for (let i = 0; i < existingCards.length; i++) {
            if (existingCards[i] && existingCards[i].IsValid()) {
                existingCards[i].DeleteAsync(0);
            }
        }
        
        // Удаляем сообщение о том, что бустеров нет
        let noBoostersMessage = container.FindChildTraverse("no_boosters_message");
        if (noBoostersMessage && noBoostersMessage.IsValid()) {
            noBoostersMessage.DeleteAsync(0);
        }
        
        // Удаляем сообщение о том, что случайных бустеров нет
        let noRandomBoostersMessage = container.FindChildTraverse("no_random_boosters_message");
        if (noRandomBoostersMessage && noRandomBoostersMessage.IsValid()) {
            noRandomBoostersMessage.DeleteAsync(0);
        }
    }
    
    // Показать сообщение о том, что бустеров нет
    function ShowNoBoostersMessage(container) {
        if (!container) return;
        
        // Создаем панель с сообщением
        let messagePanel = $.CreatePanel("Panel", container, "no_boosters_message");
        messagePanel.AddClass("no-boosters-message");
        
        // Создаем иконку
        let iconPanel = $.CreatePanel("Panel", messagePanel, "no_boosters_icon");
        iconPanel.AddClass("no-boosters-icon");
        
        // Добавляем изображение иконки (используем встроенную иконку из Dota 2)
        let iconImage = $.CreatePanel("Image", iconPanel, "no_boosters_icon_image");
        iconImage.AddClass("no-boosters-icon-image");
        // Используем иконку валюты (рубли) - красный кристалл
        // Это подходящая иконка для сообщения об отсутствии бустеров
        iconImage.SetImage("file://{images}/no_boosters_icon.png");
        
        // Создаем заголовок
        let titleLabel = $.CreatePanel("Label", messagePanel, "no_boosters_title");
        titleLabel.AddClass("no-boosters-title");
        titleLabel.text = $.Localize("#ui_booster_no_boosters_title");
        
        // Создаем описание
        let descriptionLabel = $.CreatePanel("Label", messagePanel, "no_boosters_description");
        descriptionLabel.AddClass("no-boosters-description");
        descriptionLabel.text = $.Localize("#ui_booster_no_boosters_description");
    }
    
    // Показать сообщение о том, что случайных бустеров нет
    function ShowNoRandomBoostersMessage(container) {
        if (!container) return;
        
        // Создаем панель с сообщением
        let messagePanel = $.CreatePanel("Panel", container, "no_random_boosters_message");
        messagePanel.AddClass("no-boosters-message");
        
        // Создаем иконку
        let iconPanel = $.CreatePanel("Panel", messagePanel, "no_random_boosters_icon");
        iconPanel.AddClass("no-boosters-icon");
        
        // Добавляем изображение иконки (используем встроенную иконку из Dota 2)
        let iconImage = $.CreatePanel("Image", iconPanel, "no_random_boosters_icon_image");
        iconImage.AddClass("no-boosters-icon-image");
        // Используем иконку "пустого состояния" - можно заменить на подходящую иконку
        iconImage.SetImage("file://{images}/no_boosters_icon.png");
        
        // Создаем заголовок
        let titleLabel = $.CreatePanel("Label", messagePanel, "no_random_boosters_title");
        titleLabel.AddClass("no-boosters-title");
        titleLabel.text = $.Localize("#ui_booster_no_random_boosters_title");
        
        // Создаем описание
        let descriptionLabel = $.CreatePanel("Label", messagePanel, "no_random_boosters_description");
        descriptionLabel.AddClass("no-boosters-description");
        descriptionLabel.text = $.Localize("#ui_booster_no_random_boosters_description");
    }
    
    // Глобальная переменная для хранения заказов клиента
    let customerOrdersData = null;

    // Проверка, заказан ли уже бустер
    function IsBoosterAlreadyOrdered(boosterSteamId) {
        // Проверяем, есть ли активный заказ с этим бустером
        if (customerOrdersData) {
            for (let orderId in customerOrdersData) {
                let order = customerOrdersData[orderId];
                if (order.booster_steam_id == boosterSteamId && 
                    (order.status === "IN_PROGRESS" || order.status === "WAITING_CONFIRMATION")) {
                    return true;
                }
            }
        }
        return false;
    }

    // Обновление списка бустеров после изменения заказов
    function UpdateBoostersListAfterOrderChange() {
        
        // Находим контейнер списка бустеров
        let boostersList = $.GetContextPanel().FindChildTraverse("boosters-list");
        if (!boostersList) {
            return;
        }
        
        // Обновляем каждую карточку бустера
        let boosterCards = boostersList.FindChildrenWithClassTraverse("booster-card");
        for (let i = 0; i < boosterCards.length; i++) {
            let card = boosterCards[i];
            let steamId = card.id.replace("booster_card_", "");
            
            // Проверяем, заказан ли этот бустер
            let isAlreadyOrdered = IsBoosterAlreadyOrdered(steamId);
            
            // Находим элементы карточки
            let orderButton = card.FindChildTraverse("order_button");
            let boosterPricePanel = card.FindChildTraverse("booster_price_panel");
            let existingStatus = card.FindChildTraverse("already_ordered_status");
            
            if (isAlreadyOrdered) {
                // Скрываем кнопку заказа и цену
                if (orderButton) {
                    orderButton.style.visibility = "collapse";
                }
                if (boosterPricePanel) {
                    boosterPricePanel.style.visibility = "collapse";
                }
                
                // Показываем статус "УЖЕ ЗАКАЗАН" если его еще нет
                if (!existingStatus) {
                    let statusLabel = $.CreatePanel("Label", card, "already_ordered_status");
                    statusLabel.AddClass("already-ordered-status");
                    statusLabel.text = $.Localize("#ui_booster_already_ordered");
                }
            } else {
                // Показываем кнопку заказа и цену
                if (orderButton) {
                    orderButton.style.visibility = "visible";
                }
                if (boosterPricePanel) {
                    boosterPricePanel.style.visibility = "visible";
                }
                
                // Удаляем статус "Уже заказан" если он есть
                if (existingStatus) {
                    existingStatus.DeleteAsync(0);
                }
            }
        }
    }

    // Создание карточки бустера
    function CreateBoosterCard(container, boosterProfile, steamId, hero_name, PlayerID) {
        if (!container || !boosterProfile) return;
        
        // Проверяем, заказан ли уже этот бустер
        let isAlreadyOrdered = IsBoosterAlreadyOrdered(steamId);
        
        // Создаем карточку бустера используя снипет
        let cardPanel = $.CreatePanel("Panel", container, "booster_card_" + steamId);
        cardPanel.BLoadLayoutSnippet("booster_card");
        
        // Находим минимальную цену среди доступных сложностей
        let minPrice = GetMinAvailablePrice(boosterProfile);
        
        // Обновляем данные в созданной карточке
        let avatarImage = cardPanel.FindChildTraverse("avatar_image");
        if (avatarImage) {
            // let heroName = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( boosterProfile.PlayerID ));
            avatarImage.heroname = hero_name;
        }

        let avatarImage2 = cardPanel.FindChildTraverse("avatar_image2");
        if (avatarImage) {
            // let heroName = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex( boosterProfile.PlayerID ));
            avatarImage2.steamid = steamId
        }
        
        let userName = cardPanel.FindChildTraverse("booster_name");
        if (userName) {
            userName.steamid = steamId.toString();
        }
        
        let statsLabel = cardPanel.FindChildTraverse("booster_stats");
        if (statsLabel) {
            let completedOrders = boosterProfile.completed_orders || 0;
            statsLabel.text = "<font color='#00FF00'>" + completedOrders + " " + $.Localize("#ui_booster_orders_completed") + "</font>";
            statsLabel.html = true;
        }
        
        let descriptionLabel = cardPanel.FindChildTraverse("booster_description");
        if (descriptionLabel) {
            descriptionLabel.text = boosterProfile.description || $.Localize("#ui_booster_no_description");
        }
        
        let priceLabel = cardPanel.FindChildTraverse("price_label");
        if (priceLabel) {
            if (isAlreadyOrdered) {
                // Скрываем цену если бустер уже заказан
                priceLabel.style.visibility = "collapse";
            } else {
                priceLabel.text = minPrice.toString();
            }
        }
        
        // Добавляем обработчик клика на кнопку заказа или показываем статус
        let orderButton = cardPanel.FindChildTraverse("order_button");
        if (orderButton) {
            if (isAlreadyOrdered) {
                // Скрываем кнопку заказа если бустер уже заказан
                orderButton.style.visibility = "collapse";
                
                // Создаем статус "УЖЕ ЗАКАЗАН" на месте кнопки
                let statusLabel = $.CreatePanel("Label", cardPanel, "already_ordered_status");
                statusLabel.AddClass("already-ordered-status");
                statusLabel.text = $.Localize("#ui_booster_already_ordered");
                statusLabel.style.color = "#FFD700";
                statusLabel.style.fontWeight = "bold";
                statusLabel.style.fontSize = "14px";
                statusLabel.style.horizontalAlign = "center";
                statusLabel.style.verticalAlign = "center";
                statusLabel.style.textAlign = "center";
                
            } else {
                orderButton.SetPanelEvent("onactivate", function() {
                    Game.EmitSound("ui_generic_button_click");
                    OnOrderButtonClicked(steamId, boosterProfile, PlayerID);
                });
                orderButton.SetPanelEvent("onmouseover", function() {
                    // Убран звук при наведении
                });
            }
        }

        let boosterPrice = cardPanel.FindChildTraverse("booster_price");
        if (boosterPrice) {
            boosterPrice.text = boosterProfile.current_difficulty_price.toString();
        }
    }
    
    // Получение минимальной доступной цены
    function GetMinAvailablePrice(boosterProfile) {
        if (!boosterProfile.difficulty_prices || !boosterProfile.difficulty_availability) {
            return 100; // Цена по умолчанию
        }
        
        let minPrice = Infinity;
        let prices = boosterProfile.difficulty_prices;
        let availability = boosterProfile.difficulty_availability;
        
        // Ищем минимальную цену среди доступных сложностей
        for (let difficulty in prices) {
            if (availability[difficulty] && prices[difficulty] > 0) {
                minPrice = Math.min(minPrice, prices[difficulty]);
            }
        }
        
        return minPrice === Infinity ? 100 : minPrice;
    }
    
    // Создание карточки случайного бустера (без цены и кнопки заказа)
    function CreateRandomBoosterCard(container, boosterProfile, steamId, hero_name) {
        if (!container || !boosterProfile) return;
        
        // Создаем карточку бустера используя снипет
        let cardPanel = $.CreatePanel("Panel", container, "random_booster_card_" + steamId);
        cardPanel.BLoadLayoutSnippet("booster_card");
        
        // Добавляем класс для скрытия цены и кнопки
        cardPanel.AddClass("booster-card-no-price");
        
        // Обновляем данные в созданной карточке
        let avatarImage = cardPanel.FindChildTraverse("avatar_image");
        if (avatarImage) {
            avatarImage.style.visibility = "collapse";
        }
        let avatarImage2 = cardPanel.FindChildTraverse("avatar_image2");
        if (avatarImage2) {
            avatarImage2.steamid = steamId.toString();
        }
        let boosterHero = cardPanel.GetChild(0);
        if (boosterHero) {
            boosterHero.RemoveClass("booster-hero");
            boosterHero.AddClass("booster-avatar");
        }
        
        let userName = cardPanel.FindChildTraverse("booster_name");
        if (userName) {
            userName.steamid = steamId;
        }
        
        let statsLabel = cardPanel.FindChildTraverse("booster_stats");
        if (statsLabel) {
            let completedOrders = boosterProfile.completed_orders || 0;
            statsLabel.text = "<font color='#00FF00'>" + completedOrders + " " + $.Localize("#ui_booster_orders_completed") + "</font>";
            statsLabel.html = true;
        }
        
        let descriptionLabel = cardPanel.FindChildTraverse("booster_description");
        if (descriptionLabel) {
            descriptionLabel.text = boosterProfile.description || $.Localize("#ui_booster_no_description");
        }
        
        // Скрываем панель цены и кнопку заказа
        let pricePanel = cardPanel.FindChildTraverse("booster_price");
        if (pricePanel) {
            pricePanel.style.visibility = "collapse";
        }
        
        let orderButton = cardPanel.FindChildTraverse("order_button");
        if (orderButton) {
            orderButton.style.visibility = "collapse";
        }
    }
    
    // Обработчик клика на кнопку заказа
    function OnOrderButtonClicked(steamId, boosterProfile, PlayerID) {
        
        // Создаем данные для окна подтверждения
        let orderData = {
            booster_player_id: PlayerID,
            booster_steam_id: steamId,
            booster_profile: boosterProfile,
        };

        GameEvents.SendCustomGameEventToServer("booster_create_order", orderData);
    }
    
    // Функции окна подтверждения заказа перенесены в глобальный HUD
    
    // Обработчик события confirm_booster_order от сервера (для заказчика)
    function OnConfirmBoosterOrder(data) {
        
        const HUD = DotaHUD.Get();
        var confirmation_hud = HUD.FindChildTraverse("customer_order_confirmation_hud");
        if(confirmation_hud) {
            confirmation_hud.DeleteAsync(0);
        }
        confirmation_hud = $.CreatePanel("Panel", HUD, "customer_order_confirmation_hud");
        confirmation_hud.BLoadLayout( "file://{resources}/layout/custom_game/player_booster_service/customer_order_confirmation.xml", false, false );

        // Отправляем данные в глобальное окно через событие
        // $.DispatchEvent("CustomEvent", "show_order_confirmation", data);
    }

    // Обработчик события confirm_booster_order_executor от сервера (для бустера)
    function OnConfirmBoosterOrderExecutor(data) {
        
        const HUD = DotaHUD.Get();
        var booster_confirmation_hud = HUD.FindChildTraverse("booster_order_confirmation_hud");
        if(booster_confirmation_hud) {
            booster_confirmation_hud.DeleteAsync(0);
        }
        booster_confirmation_hud = $.CreatePanel("Panel", HUD, "booster_order_confirmation_hud");
        booster_confirmation_hud.BLoadLayout( "file://{resources}/layout/custom_game/player_booster_service/booster_order_confirmation.xml", false, false );

        // Отправляем данные в глобальное окно через событие
        // $.DispatchEvent("CustomEvent", "show_booster_order_confirmation", data);
    }

    // Обработчик события обновления текущей сделки
    function OnCurrentDealUpdate(data) {
        UpdateCurrentDeal(data);
    }


    // Обновление истории заказов клиента
    function UpdateCustomerOrders(customerOrders) {
        try {
            
            // Сохраняем данные о заказах в глобальной переменной для проверки
            customerOrdersData = customerOrders;
            
            if (!customerOrders || Object.keys(customerOrders).length === 0) {
                // Скрываем вкладку "МОИ ЗАКАЗЫ" если нет заказов
                UpdateMyOrdersTabVisibility(false, false);
                return;
            }
            
            
            // Отображаем заказы клиента
            DisplayCustomerOrders(customerOrders);
            
            // Проверяем, есть ли активные заказы для переключения вкладки по умолчанию
            let hasActiveCustomerOrders = false;
            let hasAnyCustomerOrders = Object.keys(customerOrders).length > 0;
            
            for (let orderId in customerOrders) {
                let order = customerOrders[orderId];
                if (order.status === "IN_PROGRESS" || order.status === "WAITING_CONFIRMATION") {
                    hasActiveCustomerOrders = true;
                    break;
                }
            }
            
            // Обновляем видимость вкладки "МОИ ЗАКАЗЫ" для клиента
            // Показываем вкладку если есть любые заказы, но по умолчанию открываем только если есть активные
            UpdateMyOrdersTabVisibility(hasAnyCustomerOrders, hasActiveCustomerOrders);
            
            // Обновляем список бустеров, чтобы скрыть уже заказанных
            UpdateBoostersListAfterOrderChange();
            
        } catch (e) {
        }
    }

    // Обработчик уведомления о принятии заказа
    function OnBoosterOrderAcceptedNotification(data) {
        ShowNotification($.Localize("#ui_booster_notification_order_accepted"), "success");
    }
    
    // Обработчик уведомления об отклонении заказа
    function OnBoosterOrderRejectedNotification(data) {
        ShowNotification($.Localize("#ui_booster_notification_order_rejected"), "error");
    }
    
    // Обработчик ответа проверки денег для покупки лицензии
    function OnMoneyCheckResponse(data) {
        $.Msg("OnMoneyCheckResponse", data);
        if (data.success) {
            // Показываем окно подтверждения покупки лицензии
            ShowLicensePurchaseConfirmation();
        } else {
            // Показываем ошибку
            ShowNotification(data.error || $.Localize("#ui_booster_notification_license_error"), "error");
        }
    }
    

    // Регистрация обработчиков событий от сервера
    GameEvents.Subscribe("booster_license_purchase_response", OnLicensePurchaseResponse);
    GameEvents.Subscribe("booster_settings_update_response", OnSettingsUpdateResponse);
    GameEvents.Subscribe("booster_license_status_response", OnLicenseStatusResponse);
    GameEvents.Subscribe("confirm_booster_order", OnConfirmBoosterOrder);
    GameEvents.Subscribe("confirm_booster_order_executor", OnConfirmBoosterOrderExecutor);
    GameEvents.Subscribe("update_current_deal", OnCurrentDealUpdate);
    GameEvents.Subscribe("money_check_response", OnMoneyCheckResponse);

    GameEvents.Subscribe("update_booster_profile", UpdateBoosterProfile);
    GameEvents.Subscribe("update_team_boosters", UpdateTeamBoosters);
    GameEvents.Subscribe("update_random_boosters", UpdateRandomBoosters);
    GameEvents.Subscribe("update_customer_orders", UpdateCustomerOrders);
    
    // Обработчики уведомлений
    GameEvents.Subscribe("booster_order_accepted_notification", OnBoosterOrderAcceptedNotification);
    GameEvents.Subscribe("booster_order_rejected_notification", OnBoosterOrderRejectedNotification);
    
    // Инициализация при загрузке
    Initialize();
    
})();