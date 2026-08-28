--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";

    var g_Initialized = false;
    var g_IsSpinning = false;
    var g_SpinTimeout = null;
    var SLOT_CARDS = ["SlotCard1", "SlotCard2", "SlotCard3"];
    var g_SelectedSpeed = 1; // По умолчанию x1
    var g_SelectedCurrency = "shield"; // По умолчанию щитки
    var g_SelectedBet = 10; // По умолчанию ставка 10 (щиты)
    const DotaHUD = GameUI.CustomUIConfig().DotaHUD;
    var g_LoadingPanelId = null; // ID панели загрузки
    var g_ServerNowDate = null; // Date на момент ответа сервера
    var g_ServerNowClientMs = 0; // client ms when server time received
    var g_HistoryLastId = null; // ID последней загруженной записи для пагинации
    var g_HistoryHasMore = false; // Есть ли еще записи для загрузки
    var g_IsLoadingHistory = false; // Флаг загрузки истории (чтобы избежать дублирования запросов)
    var g_CasinoData = { inventory: [], claimed_history: [], sold_history: [], sold_totals: { ruby: 0, shield: 0 } };
    var g_InventoryActiveTab = "items"; // "items" | "claimed" | "claimed_history"
    var g_LastSpinIsWin = false;

    function pluralRu(n, form1, form2, form5) {
        n = Math.abs(n) % 100;
        var n1 = n % 10;
        if (n > 10 && n < 20) return form5;
        if (n1 === 1) return form1;
        if (n1 >= 2 && n1 <= 4) return form2;
        return form5;
    }

    function parseIsoDateSafe(isoStr) {
        if (!isoStr || typeof isoStr !== "string") return null;
        var s = isoStr.trim();
        // JS (Panorama) может не парсить микросекунды (6 знаков) → режем до миллисекунд.
        s = s.replace(/(\.\d{3})\d+/, "$1");
        // Нормализуем UTC оффсет в Z
        s = s.replace(/\+00:00$/, "Z");
        var d = new Date(s);
        if (isNaN(d.getTime())) return null;
        return d;
    }

    function getNowForHistory() {
        if (g_ServerNowDate) {
            var clientNowMs = (new Date()).getTime();
            var deltaMs = clientNowMs - g_ServerNowClientMs;
            if (deltaMs < 0) deltaMs = 0;
            return new Date(g_ServerNowDate.getTime() + deltaMs);
        }
        return new Date();
    }

    function formatTimeAgo(isoStr) {
        var date = parseIsoDateSafe(isoStr);
        if (!date) return "";
        var now = getNowForHistory();
        var diffMs = Math.max(0, now - date);
        var diffMins = Math.floor(diffMs / 60000);
        var diffHours = Math.floor(diffMins / 60);
        var diffDays = Math.floor(diffHours / 24);
        if (diffMins < 1) return "только что";
        if (diffMins < 60) return diffMins + " " + pluralRu(diffMins, "мин.", "мин.", "мин.") + " назад";
        if (diffHours < 24) return diffHours + " " + pluralRu(diffHours, "час", "часа", "часов") + " назад";
        return diffDays + " " + pluralRu(diffDays, "день", "дня", "дней") + " назад";
    }

    function setWinMessage(text) {
        var root = $.GetContextPanel();
        if (!root) return;
        var lbl = root.FindChildTraverse("WinMessageLabel");
        if (lbl) {
            lbl.text = text || "";
            lbl.RemoveClass("pop");
            lbl.AddClass("pop");
        }
    }
    
    // Настройка windowController для casv2
    var main = $.GetContextPanel();
    DotaHUD.windowControllers["casv2"] = {
        is_open: false,
        open: function(){
            main.visible = true;
            main.FindChildTraverse("GameHeader").visible = true;
            main.FindChildTraverse("GameContentWrapper").visible = true;
            // Показываем панель загрузки
            var root = $.GetContextPanel();
            if (root && DotaHUD && typeof DotaHUD.ShowLoadingPanel === 'function') {
                g_LoadingPanelId = DotaHUD.ShowLoadingPanel("#loading_casino", root);
            }
            
            // Активируем отслеживание пробела
            if (GameUI.CustomUIConfig().SpaceKeyHandler && GameUI.CustomUIConfig().SpaceKeyHandler.Activate) {
                $.Schedule(0.1, function() {
                    GameUI.CustomUIConfig().SpaceKeyHandler.Activate();
                });
            }
            
            requestCasinoData();
        },
        close: function(){
            main.visible = false;
            main.FindChildTraverse("GameHeader").visible = false;
            main.FindChildTraverse("GameContentWrapper").visible = false;
            // Деактивируем отслеживание пробела
            if (GameUI.CustomUIConfig().SpaceKeyHandler && GameUI.CustomUIConfig().SpaceKeyHandler.Deactivate) {
                GameUI.CustomUIConfig().SpaceKeyHandler.Deactivate();
            }
            
            // Скрываем панель загрузки, если она активна
            if (g_LoadingPanelId && DotaHUD && typeof DotaHUD.HideLoadingPanel === 'function') {
                DotaHUD.HideLoadingPanel(g_LoadingPanelId);
                g_LoadingPanelId = null;
            }
        }
    };
    DotaHUD.ListenToMouseEvent(
        DotaHUD.GetCloseWindowOnOutsideClick(main, "casv2")
    );
    main.visible = false;

    function Initialize() {
        if (g_Initialized) return;

        var root = $.GetContextPanel();
        if (!root) return;

        setupEventHandlers();
        
        // Регистрируем обработчик пробела
        if (GameUI.CustomUIConfig().SpaceKeyHandler && GameUI.CustomUIConfig().SpaceKeyHandler.Register) {
            GameUI.CustomUIConfig().SpaceKeyHandler.Register(
                function() {
                    onPlayButtonClicked();
                },
                function() {
                    return main && main.visible;
                }
            );
        }
        
        g_Initialized = true;
    }

    function setupEventHandlers() {
        var root = $.GetContextPanel();
        
        DotaHUD.CreateTopBarButton("file://{images}/shop/cas.png", "casino", ()=>{
            if (DotaHUD) {
                DotaHUD.WindowOpen("casv2");
            }
        }, "casino");

        // Close button handler
        var closeButton = root.FindChildTraverse("CasinoCloseButton");
        if (closeButton) {
            closeButton.SetPanelEvent("onactivate", function() {
                if (DotaHUD) {
                    DotaHUD.WindowClose("casv2");
                }
            });
        }
        
        var playButton = root.FindChildTraverse("PlayButton");
        if (playButton) {
            playButton.SetPanelEvent("onactivate", onPlayButtonClicked);
        }
        
        // Настройка обработчиков для кнопок скорости
        var speed1x = root.FindChildTraverse("Speed1x");
        var speed2x = root.FindChildTraverse("Speed2x");
        var speed4x = root.FindChildTraverse("Speed4x");
        
        if (speed1x) {
            speed1x.SetPanelEvent("onactivate", function() {
                setSpeed(1);
            });
        }
        
        if (speed2x) {
            speed2x.SetPanelEvent("onactivate", function() {
                setSpeed(2);
            });
        }
        
        if (speed4x) {
            speed4x.SetPanelEvent("onactivate", function() {
                setSpeed(4);
            });
        }
        
        // Устанавливаем x1 по умолчанию
        setSpeed(1);
        
        // Настройка обработчиков для вкладок валют
        var tabShield = root.FindChildTraverse("TabShield");
        var tabCrystal = root.FindChildTraverse("TabCrystal");
        
        if (tabShield) {
            tabShield.SetPanelEvent("onactivate", function() {
                setSelectedCurrency("shield");
            });
        }
        
        if (tabCrystal) {
            tabCrystal.SetPanelEvent("onactivate", function() {
                setSelectedCurrency("crystal");
            });
        }
        
        // Настройка обработчиков для кнопок выбора ставки (щиты)
        setupBetButtons(root, "shield", ["BetShield10", "BetShield20", "BetShield40", "BetShield80"]);
        
        // Настройка обработчиков для кнопок выбора ставки (кристаллы)
        setupBetButtons(root, "crystal", ["BetCrystal1", "BetCrystal2", "BetCrystal4", "BetCrystal8"]);
        
        // Устанавливаем щитки и ставку 10 по умолчанию
        setSelectedCurrency("shield");
        setSelectedBet(10);
        
        // Настройка обработчика для кнопки "ЗАГРУЗИТЬ ЕЩЕ"
        var loadMoreButton = root.FindChildTraverse("LoadMoreWinnersButton");
        if (loadMoreButton) {
            loadMoreButton.SetPanelEvent("onactivate", function() {
                loadMoreHistory();
            });
            // Изначально скрываем кнопку, покажем когда будет известно, что есть еще записи
            loadMoreButton.style.visibility = "collapse";
        }
        
        // Настройка обработчика для кнопки инвентаря
        var inventoryButton = root.FindChildTraverse("InventoryButton");
        if (inventoryButton) {
            inventoryButton.SetPanelEvent("onactivate", function() {
                var overlay = root.FindChildTraverse("InventoryModalOverlay");
                if (overlay && overlay.BHasClass("visible")) closeInventoryModal();
                else openInventoryModal();
            });
        }
        
        // Настройка обработчика для кнопки закрытия инвентаря
        var inventoryModalClose = root.FindChildTraverse("InventoryModalClose");
        if (inventoryModalClose) {
            inventoryModalClose.SetPanelEvent("onactivate", function() {
                closeInventoryModal();
            });
        }

        // Вкладки инвентаря
        var tabItems = root.FindChildTraverse("InventoryTabItems");
        var tabClaimed = root.FindChildTraverse("InventoryTabClaimed");
        var tabClaimedHistory = root.FindChildTraverse("InventoryTabClaimedHistory");
        if (tabItems) {
            tabItems.SetPanelEvent("onactivate", function() {
                g_InventoryActiveTab = "items";
                loadInventoryItems();
            });
        }
        if (tabClaimed) {
            tabClaimed.SetPanelEvent("onactivate", function() {
                g_InventoryActiveTab = "claimed";
                loadInventoryItems();
            });
        }
        if (tabClaimedHistory) {
            tabClaimedHistory.SetPanelEvent("onactivate", function() {
                g_InventoryActiveTab = "claimed_history";
                loadInventoryItems();
            });
        }

        // Кнопки «Продать все» и «Забрать все»
        var sellAllBtn = root.FindChildTraverse("InventorySellAll");
        var claimAllBtn = root.FindChildTraverse("InventoryClaimAll");
        if (sellAllBtn) {
            sellAllBtn.SetPanelEvent("onactivate", function() {
                GameEvents.SendCustomGameEventToServer("casv2_sell_all", {});
            });
        }
        if (claimAllBtn) {
            claimAllBtn.SetPanelEvent("onactivate", function() {
                GameEvents.SendCustomGameEventToServer("casv2_claim_all", {});
            });
        }
        
        updateInventoryButtonText();
    }

    function applyInventoryTab() {
        var root = $.GetContextPanel();
        if (!root) return;
        var itemsPanel = root.FindChildTraverse("InventoryItemsPanel");
        var claimedPanel = root.FindChildTraverse("InventoryClaimedPanel");
        var tabItems = root.FindChildTraverse("InventoryTabItems");
        var tabClaimed = root.FindChildTraverse("InventoryTabClaimed");
        var tabClaimedHistory = root.FindChildTraverse("InventoryTabClaimedHistory");
        var bulkActions = root.FindChildTraverse("InventoryBulkActions");
        if (g_InventoryActiveTab === "items") {
            if (itemsPanel) itemsPanel.style.visibility = "visible";
            if (claimedPanel) claimedPanel.style.visibility = "collapse";
            if (tabItems) tabItems.AddClass("inventory-tab--active");
            if (tabClaimed) tabClaimed.RemoveClass("inventory-tab--active");
            if (tabClaimedHistory) tabClaimedHistory.RemoveClass("inventory-tab--active");
            if (bulkActions) bulkActions.style.visibility = "visible";
        } else {
            if (itemsPanel) itemsPanel.style.visibility = "collapse";
            if (claimedPanel) claimedPanel.style.visibility = "visible";
            if (tabItems) tabItems.RemoveClass("inventory-tab--active");
            if (tabClaimed) { if (g_InventoryActiveTab === "claimed") tabClaimed.AddClass("inventory-tab--active"); else tabClaimed.RemoveClass("inventory-tab--active"); }
            if (tabClaimedHistory) { if (g_InventoryActiveTab === "claimed_history") tabClaimedHistory.AddClass("inventory-tab--active"); else tabClaimedHistory.RemoveClass("inventory-tab--active"); }
            if (bulkActions) bulkActions.style.visibility = "collapse";
        }
    }
    
    function setSpeed(speed) {
        if (g_SelectedSpeed === speed) return;
        
        var root = $.GetContextPanel();
        if (!root) return;
        
        // Убираем selected со всех кнопок
        var speed1x = root.FindChildTraverse("Speed1x");
        var speed2x = root.FindChildTraverse("Speed2x");
        var speed4x = root.FindChildTraverse("Speed4x");
        
        if (speed1x) speed1x.RemoveClass("selected");
        if (speed2x) speed2x.RemoveClass("selected");
        if (speed4x) speed4x.RemoveClass("selected");
        
        // Добавляем selected к выбранной кнопке
        var selectedButton = null;
        if (speed === 1 && speed1x) {
            selectedButton = speed1x;
        } else if (speed === 2 && speed2x) {
            selectedButton = speed2x;
        } else if (speed === 4 && speed4x) {
            selectedButton = speed4x;
        }
        
        if (selectedButton) {
            selectedButton.AddClass("selected");
            g_SelectedSpeed = speed;
            Game.EmitSound("ui_generic_button_click");
        }
    }
    
    function setupBetButtons(root, currency, buttonIds) {
        for (var i = 0; i < buttonIds.length; i++) {
            var button = root.FindChildTraverse(buttonIds[i]);
            if (button) {
                var betValue = parseInt(button.GetAttributeString("data-value", "1"));
                button.SetPanelEvent("onactivate", function(value, curr) {
                    return function() {
                        if (g_SelectedCurrency === curr) {
                            setSelectedBet(value);
                        }
                    };
                }(betValue, currency));
            }
        }
    }
    
    function setSelectedCurrency(currency) {
        if (g_SelectedCurrency === currency) return;
        
        var root = $.GetContextPanel();
        if (!root) return;
        
        var tabShield = root.FindChildTraverse("TabShield");
        var tabCrystal = root.FindChildTraverse("TabCrystal");
        var betOptionsShield = root.FindChildTraverse("BetOptionsShield");
        var betOptionsCrystal = root.FindChildTraverse("BetOptionsCrystal");
        
        // Обновляем вкладки
        if (tabShield) {
            if (currency === "shield") {
                tabShield.AddClass("CurrencyTab--Active");
            } else {
                tabShield.RemoveClass("CurrencyTab--Active");
            }
        }
        
        if (tabCrystal) {
            if (currency === "crystal") {
                tabCrystal.AddClass("CurrencyTab--Active");
            } else {
                tabCrystal.RemoveClass("CurrencyTab--Active");
            }
        }
        
        // Показываем/скрываем панели выбора ставки
        if (betOptionsShield) {
            if (currency === "shield") {
                betOptionsShield.style.visibility = "visible";
            } else {
                betOptionsShield.style.visibility = "collapse";
            }
        }
        
        if (betOptionsCrystal) {
            if (currency === "crystal") {
                betOptionsCrystal.style.visibility = "visible";
            } else {
                betOptionsCrystal.style.visibility = "collapse";
            }
        }
        
        g_SelectedCurrency = currency;
        Game.EmitSound("ui_generic_button_click");
        
        // Устанавливаем ставку по умолчанию для новой валюты
        var defaultBet = currency === "shield" ? 10 : 1;
        setSelectedBet(defaultBet);
    }
    
    function setSelectedBet(betValue) {
        if (g_SelectedBet === betValue && g_SelectedCurrency) {
            // Проверяем, не выбрана ли уже эта ставка
            var root = $.GetContextPanel();
            if (!root) return;
            
            var currencyPrefix = g_SelectedCurrency === "shield" ? "BetShield" : "BetCrystal";
            var currentButton = root.FindChildTraverse(currencyPrefix + betValue);
            if (currentButton && currentButton.BHasClass("BetOption--Selected")) {
                return; // Уже выбрана
            }
        }
        
        g_SelectedBet = betValue;
        
        var root = $.GetContextPanel();
        if (!root) return;
        
        // Разные значения ставок для разных валют
        var betValues = g_SelectedCurrency === "shield" ? [10, 20, 40, 80] : [1, 2, 4, 8];
        var currencyPrefix = g_SelectedCurrency === "shield" ? "BetShield" : "BetCrystal";
        
        // Убираем выделение со всех кнопок ставки для текущей валюты
        for (var i = 0; i < betValues.length; i++) {
            var button = root.FindChildTraverse(currencyPrefix + betValues[i]);
            if (button) {
                button.RemoveClass("BetOption--Selected");
            }
        }
        
        // Добавляем выделение к выбранной кнопке
        var selectedButton = root.FindChildTraverse(currencyPrefix + betValue);
        if (selectedButton) {
            selectedButton.AddClass("BetOption--Selected");
            Game.EmitSound("ui_generic_button_click");
        }
    }

    function setupSpinTimeout() {
        if (g_SpinTimeout) {
            GameUI.LoopTime.DelTime(g_SpinTimeout);
        }
        var timeoutKey = 'spintimeout_' + Date.now() + '_' + Math.random();
        GameUI.LoopTime.AddTime(timeoutKey, 1, 10.0, function() {
            if (g_IsSpinning) finishSpin();
        }, 1);
        g_SpinTimeout = timeoutKey;
    }

    function setSpinningState(root, enabled) {
        g_IsSpinning = enabled;
        // При начале анимации кнопка неактивна до реального старта
        updatePlayButtonState(root, enabled, enabled ? false : undefined);
    }
    
    function enableSkipButton(root) {
        // Активируем кнопку пропуска когда анимация реально началась
        updatePlayButtonState(root, true, true);
    }
    
    function updatePlayButtonState(root, isSpinning, canSkip) {
        var playButton = root.FindChildTraverse("PlayButton");
        var playButtonText = root.FindChildTraverse("PlayButtonText");
        
        if (playButton) {
            if (isSpinning) {
                // Во время анимации - серый цвет и текст "ПРОПУСТИТЬ"
                playButton.AddClass("skip-mode");
                if (canSkip === true) {
                    // Анимация реально началась - другой цвет
                    playButton.AddClass("skip-active");
                } else {
                    // Анимация еще не началась - серый цвет
                    playButton.RemoveClass("skip-active");
                }
                if (playButtonText) {
                    playButtonText.text = "ПРОПУСТИТЬ";
                }
                // Кнопка активна только если анимация уже началась (canSkip = true)
                playButton.enabled = canSkip !== false;
            } else {
                // После завершения - возвращаем обычный вид
                playButton.RemoveClass("skip-mode");
                playButton.RemoveClass("skip-active");
                if (playButtonText) {
                    playButtonText.text = "ИГРАТЬ";
                }
                playButton.enabled = true;
            }
        }
    }

    function onPlayButtonClicked() {
        var root = $.GetContextPanel();
        if (!root) {
            return;
        }
        
        if (g_IsSpinning) {
            var playButton = root.FindChildTraverse("PlayButton");
            if (playButton && playButton.enabled) skipAnimation(root);
            return;
        }

        clearAllSlots(root);
        setSpinningState(root, true);
        setupSpinTimeout();
        startAnticipationAnimation(root);
    }
    
    // Экспортируем функцию для использования в других скриптах
    if (!GameUI.CustomUIConfig().Casv2) {
        GameUI.CustomUIConfig().Casv2 = {};
    }
    GameUI.CustomUIConfig().Casv2.onPlayButtonClicked = onPlayButtonClicked;
    
    function skipAnimation(root) {
        if (!g_IsSpinning) return;
        
        // Пропускаем анимацию до конца
        stopSpinAnimation(root, true);
        finishSpin();
    }

    function startAnticipationAnimation(root) {
        var playButton = root.FindChildTraverse("PlayButton");
        if (playButton) {
            playButton.AddClass("button-pressed");
        }

        Game.EmitSound("ui_generic_button_click");

        for (var i = 0; i < SLOT_CARDS.length; i++) {
            var slotCard = root.FindChildTraverse(SLOT_CARDS[i]);
            if (slotCard) {
                slotCard.AddClass("anticipation");
            }
        }

        // Минимальная задержка для визуального эффекта anticipation
        $.Schedule(0.05, function() {
            for (var i = 0; i < SLOT_CARDS.length; i++) {
                var slotCard = root.FindChildTraverse(SLOT_CARDS[i]);
                if (slotCard) {
                    slotCard.RemoveClass("anticipation");
                }
            }

            clearAllSlots(root);
            setSpinningState(root, true);
            setupSpinTimeout();
            setWinMessage("Игра запущена");
            var currencyParam = g_SelectedCurrency === "shield" ? "shield" : "ruby";
            GameEvents.SendCustomGameEventToServer("casino_spin", {
                currency: currencyParam,
                bet: g_SelectedBet
            });
        });
    }

    function onSpinResult(result) {
        g_LastSpinIsWin = result.is_win === true;
        if (!result.item1 || !result.item2 || !result.item3) {
            finishSpin();
            return;
        }

        var root = $.GetContextPanel();
        if (!root) {
            return;
        }
        
        // Обновляем профиль, если данные пришли в ответе
        if (result.profile) {
            updatePlayerProfile(result.profile);
        }
        
        // Обновляем карточки наград, если данные пришли в ответе
        if (result.rewards) {
            fillRewardCards(result.rewards);
        }
        
        requestCasinoData();

        var d3 = result.item1 == result.item2 ? 1.7 : 1.3;
        startAllSlotsAnimation(root, [
            {item: result.item1, duration: 0.7, speed: g_SelectedSpeed},
            {item: result.item2, duration: 1.0, speed: g_SelectedSpeed},
            {item: result.item3, duration: d3, speed: g_SelectedSpeed}
        ], null, finishSpin, enableSkipButton);
    }

    function finishSpin() {
        var root = $.GetContextPanel();

        if (g_SpinTimeout) {
            GameUI.LoopTime.DelTime(g_SpinTimeout);
            g_SpinTimeout = null;
        }

        for (var i = 0; i < SLOT_CARDS.length; i++) {
            var slotCard = root.FindChildTraverse(SLOT_CARDS[i]);
            if (slotCard) {
                slotCard.RemoveClass("spinning");
                slotCard.RemoveClass("winning");
                slotCard.RemoveClass("hovering");
                slotCard.RemoveClass("anticipation");
                slotCard.RemoveClass("stopped");
                slotCard.RemoveClass("slowing");
            }
        }

        if (g_LastSpinIsWin) {
            setWinMessage("Поздравляю с победой");
            g_LastSpinIsWin = false;
        } else {
            setWinMessage("Неудача");
        }
        setSpinningState(root, false);
    }

    // Функция для форматирования чисел с разделителями тысяч (пробелы)
    function formatNumber(num) {
        if (num === undefined || num === null) {
            return "0";
        }
        var numStr = Math.floor(num).toString();
        var result = "";
        var count = 0;
        for (var i = numStr.length - 1; i >= 0; i--) {
            if (count > 0 && count % 3 === 0) {
                result = " " + result;
            }
            result = numStr[i] + result;
            count++;
        }
        return result;
    }
    
    // Функция для обновления профиля игрока в UI
    function updatePlayerProfile(profileData) {
        if (!profileData) {
            return;
        }
        
        var root = $.GetContextPanel();
        if (!root) {
            return;
        }
        
        // Обновляем уровень игрока
        var levelText = root.FindChildTraverse("PlayerLevelText");
        if (levelText && profileData.level !== undefined) {
            levelText.text = "УР. " + profileData.level;
        }
        
        // Обновляем значения опыта (текущий опыт в уровне / суммарный опыт для следующего уровня)
        var expValues = root.FindChildTraverse("ExpValues");
        if (expValues) {
            // Используем новые поля, если они есть, иначе fallback на старые
            var currentExp = profileData.current_experience_in_level !== undefined 
                ? profileData.current_experience_in_level 
                : (profileData.experience || 0);
            var expToNext = profileData.total_experience_for_next_level !== undefined 
                ? profileData.total_experience_for_next_level 
                : (profileData.experience_to_next_level || 0);
            // Форматируем числа с разделителями тысяч
            var formattedCurrent = formatNumber(Math.max(0, Math.floor(currentExp)));
            var formattedNext = formatNumber(Math.max(0, Math.floor(expToNext)));
            expValues.text = formattedCurrent + " / " + formattedNext;
        }
        
        // Обновляем прогресс-бар опыта
        var expProgressFill = root.FindChildTraverse("ExpProgressFill");
        if (expProgressFill) {
            // Используем level_progress_percent из данных, если есть, иначе рассчитываем сами
            var progressPercent = 0;
            if (profileData.level_progress_percent !== undefined) {
                progressPercent = Math.max(0, Math.min(100, profileData.level_progress_percent));
            } else if (profileData.current_experience_in_level !== undefined && profileData.total_experience_for_next_level !== undefined) {
                // Рассчитываем процент самостоятельно, если его нет в данных
                var current = profileData.current_experience_in_level || 0;
                var total = profileData.total_experience_for_next_level || 1;
                if (total > 0) {
                    progressPercent = Math.max(0, Math.min(100, (current / total) * 100));
                }
            }
            expProgressFill.style.width = progressPercent + "%";
        }
        
        // Обновляем награду за следующий уровень
        var levelUpReward = root.FindChildTraverse("LevelUpReward");
        if (levelUpReward) {
            // Используем награду следующего уровня, если она есть
            var rewardAmount = profileData.next_level_reward_amount !== undefined 
                ? profileData.next_level_reward_amount 
                : (profileData.reward_amount || 0);
            if (rewardAmount > 0) {
                var rewardCurrency = profileData.next_level_reward_currency || profileData.reward_currency || 'shield';
                var currencySymbol = rewardCurrency === 'shield' ? '🛡' : '💎';
                levelUpReward.text = "+" + formatNumber(rewardAmount) + " " + currencySymbol;
            } else {
                levelUpReward.text = "";
            }
        }
        
        // Обновляем баланс кристаллов (rubies)
        var playerCrystals = root.FindChildTraverse("PlayerCrystals");
        if (playerCrystals && profileData.rubies !== undefined) {
            playerCrystals.text = formatNumber(profileData.rubies);
        }
        
        // Обновляем баланс щитов (shields)
        var playerShields = root.FindChildTraverse("PlayerShields");
        if (playerShields && profileData.shields !== undefined) {
            playerShields.text = formatNumber(profileData.shields);
        }
    }
    
    // Функция для заполнения карточек наград данными
    function fillRewardCards(rewardData) {
        if (!rewardData) {
            return;
        }
        
        var root = $.GetContextPanel();
        if (!root) {
            return;
        }
        
        if (rewardData.dragon) {
            var dragonCard = root.FindChildTraverse("RewardCardDragon");
            if (dragonCard) {
                // Обновляем прогресс-бар
                var dragonProgress = root.FindChildTraverse("RewardProgressFillDragon");
                if (dragonProgress && rewardData.dragon.progress !== undefined) {
                    var progressPercent = Math.max(0, Math.min(100, rewardData.dragon.progress));
                    dragonProgress.style.height = progressPercent + "%";
                }

                var dragonChanceText = root.FindChildTraverse("RewardChanceTextDragon");
                if (dragonChanceText && rewardData.dragon.chance_text) {
                    dragonChanceText.text = rewardData.dragon.chance_text;
                }
                
                // Обновляем аватар победителя
                var dragonAvatar = root.FindChildTraverse("RewardWinnerAvatarDragon");
                if (dragonAvatar && rewardData.dragon.winner_steamid) {
                    dragonAvatar.steamid = rewardData.dragon.winner_steamid;
                }
            }
        }
        
        // Заполняем вторую карточку (Second Prize)
        if (rewardData.second) {
            var secondCard = root.FindChildTraverse("RewardCardSecond");
            if (secondCard) {
                // Обновляем прогресс-бар
                var secondProgress = root.FindChildTraverse("RewardProgressFillSecond");
                if (secondProgress && rewardData.second.progress !== undefined) {
                    var progressPercent = Math.max(0, Math.min(100, rewardData.second.progress));
                    secondProgress.style.height = progressPercent + "%";
                }

                var secondChanceText = root.FindChildTraverse("RewardChanceTextSecond");
                if (secondChanceText && rewardData.second.chance_text) {
                    secondChanceText.text = rewardData.second.chance_text;
                }
                
                // Обновляем аватар победителя
                var secondAvatar = root.FindChildTraverse("RewardWinnerAvatarSecond");
                if (secondAvatar && rewardData.second.winner_steamid) {
                    secondAvatar.steamid = rewardData.second.winner_steamid;
                }
            }
        }
    }
    
    // Обработчик для скрытия панели загрузки после получения данных от сервера
    function onCasinoDataReceived(data) {
        var root = $.GetContextPanel();
        if (!root) {
            return;
        }
        
        // Скрываем панель загрузки
        if (g_LoadingPanelId && DotaHUD && typeof DotaHUD.HideLoadingPanel === 'function') {
            DotaHUD.HideLoadingPanel(g_LoadingPanelId);
            g_LoadingPanelId = null;
        }
        
        if (data && data.success) {
            // Убеждаемся, что страница казино видна
            if (root) {
                root.visible = true;
            }
            
            // Обновляем профиль игрока, если данные получены
            if (data.profile) {
                updatePlayerProfile(data.profile);
            }
            
            // Заполняем карточки наград, если данные получены
            if (data.rewards) {
                fillRewardCards(data.rewards);
            }

            // Сохраняем время сервера (чтобы "как давно" считалось от него, а не от часов игрока)
            var serverNowStr = data.server_now_utc || data.server_now || null;
            if (serverNowStr) {
                var parsedServerNow = parseIsoDateSafe(serverNowStr);
                if (parsedServerNow) {
                    g_ServerNowDate = parsedServerNow;
                    g_ServerNowClientMs = (new Date()).getTime();
                }
            }
            
            // Обновляем историю из GetCasinoData (последние 10 спинов)
            var history = normalizeHistoryArray(data && data.history);
            
            // Устанавливаем last_id из последнего элемента истории для продолжения пагинации
            if (history && history.length > 0) {
                var lastItem = history[history.length - 1];
                if (lastItem && lastItem.id) {
                    g_HistoryLastId = lastItem.id;
                    // Предполагаем, что есть еще записи (если загрузилось 10, скорее всего есть еще)
                    g_HistoryHasMore = true;
                } else {
                    g_HistoryLastId = null;
                    g_HistoryHasMore = false;
                }
            } else {
                g_HistoryLastId = null;
                g_HistoryHasMore = false;
            }
            
            updateHistoryDisplay(history, true); // true = полная перерисовка
            
            // Обновляем видимость кнопки "Загрузить еще"
            updateLoadMoreButtonVisibility();

            // Кэш инвентаря казино
            g_CasinoData.inventory = data.inventory || [];
            g_CasinoData.claimed_history = data.claimed_history || [];
            g_CasinoData.sold_history = data.sold_history || [];
            g_CasinoData.sold_totals = data.sold_totals || { ruby: 0, shield: 0 };
            updateInventoryButtonText();
            // Если модалка инвентаря открыта — обновить отображение
            var overlay = root.FindChildTraverse("InventoryModalOverlay");
            if (overlay && overlay.BHasClass("visible")) loadInventoryItems();
        } else if (data && !data.success) {
            // Обработать ошибку загрузки данных
            // При ошибке тоже показываем страницу (можно показать сообщение об ошибке)
            if (root) {
                root.visible = true;
            }
        }
    }
    
    // Запрос данных казино (GetCasinoData) с сервера
    function requestCasinoData() {
        GameEvents.SendCustomGameEventToServer("casv2_load_data", {});
    }

    function normalizeHistoryArray(raw) {
        if (!raw) return [];
        if (Array.isArray && Array.isArray(raw)) return raw;
        if (typeof raw === "object") {
            var arr = [];
            for (var k in raw) {
                if (raw.hasOwnProperty(k)) arr.push(raw[k]);
            }
            return arr;
        }
        return [];
    }

    // Отрисовка истории в существующей панели winners-grid
    // replaceAll: если true - полная перерисовка (удаляем все и добавляем заново)
    //            если false - добавляем новые элементы к существующим
    function updateHistoryDisplay(history, replaceAll) {
        var root = $.GetContextPanel();
        if (!root) {
            return;
        }
        
        history = history || [];
        replaceAll = replaceAll === true;
        
        // Ищем контейнер winners-grid через WinnersPanel
        var winnersPanel = root.FindChildTraverse("WinnersPanel");
        if (!winnersPanel) {
            return;
        }
        
        // Ищем winners-list-panel (это дочерний элемент WinnersPanel)
        var winnersListPanel = null;
        var panelCount = winnersPanel.GetChildCount();
        for (var i = 0; i < panelCount; i++) {
            var child = winnersPanel.GetChild(i);
            if (child && child.BHasClass("winners-list-panel")) {
                winnersListPanel = child;
                break;
            }
        }
        if (!winnersListPanel) {
            return;
        }
        
        // Ищем winners-grid внутри winners-list-panel
        var winnersGrid = null;
        var listPanelCount = winnersListPanel.GetChildCount();
        for (var i = 0; i < listPanelCount; i++) {
            var child = winnersListPanel.GetChild(i);
            if (child && child.BHasClass("winners-grid")) {
                winnersGrid = child;
                break;
            }
        }
        if (!winnersGrid) {
            return;
        }
        
        // Находим колонки
        var column1 = null;
        var column2 = null;
        var gridCount = winnersGrid.GetChildCount();
        for (var i = 0; i < gridCount; i++) {
            var child = winnersGrid.GetChild(i);
            if (child && child.BHasClass("winners-column")) {
                if (!column1) {
                    column1 = child;
                } else if (!column2) {
                    column2 = child;
                    break;
                }
            }
        }
        
        if (!column1 || !column2) {
            return;
        }

        // Если полная перерисовка - очищаем колонки
        if (replaceAll) {
            var col1CountBefore = column1.GetChildCount();
            var col2CountBefore = column2.GetChildCount();
            column1.RemoveAndDeleteChildren();
            column2.RemoveAndDeleteChildren();
        }
        
        // Подсчитываем текущее количество карточек для правильной нумерации
        var currentCardCount = 0;
        if (!replaceAll) {
            var col1Count = column1.GetChildCount();
            var col2Count = column2.GetChildCount();
            currentCardCount = col1Count + col2Count;
        }

        // Добавляем элементы истории
        for (var i = 0; i < history.length; i++) {
            var historyItem = history[i];
            var cardIndex = currentCardCount + i + 1; // +1 потому что индексы начинаются с 1
            
            // Определяем в какую колонку добавлять (чередуем)
            var targetColumn = (cardIndex % 2 === 1) ? column1 : column2;
            
            try {
                // Создаем контейнер для карточки
                var cardContainer = $.CreatePanel("Panel", targetColumn, "WinnerCardContainer" + cardIndex);
                if (!cardContainer) {
                    continue;
                }
                
                cardContainer.BLoadLayoutSnippet("winner_card");

                // Время
                var timeLabel = cardContainer.FindChildTraverse("winner-time");
                if (timeLabel && historyItem && historyItem.roll_date) {
                    var date = parseIsoDateSafe(historyItem.roll_date);
                    if (date) {
                        var now = getNowForHistory();
                        var diffMs = Math.max(0, now - date);
                        var diffMins = Math.floor(diffMs / 60000);
                        var diffHours = Math.floor(diffMins / 60);
                        var diffDays = Math.floor(diffHours / 24);
                        if (diffMins < 1) {
                            timeLabel.text = "только что";
                        } else if (diffMins < 60) {
                            timeLabel.text = diffMins + " " + pluralRu(diffMins, "минуту", "минуты", "минут") + " назад";
                        } else if (diffHours < 24) {
                            timeLabel.text = diffHours + " " + pluralRu(diffHours, "час", "часа", "часов") + " назад";
                        } else {
                            timeLabel.text = diffDays + " " + pluralRu(diffDays, "день", "дня", "дней") + " назад";
                        }
                    }
                }
                
                // Аватар
                var avatar = cardContainer.FindChildTraverse("winner-avatar");
                if (avatar && historyItem.user_steamid) {
                    avatar.steamid = historyItem.user_steamid;
                }

                // Предмет
                var itemName = (historyItem.is_win && historyItem.winning_item && historyItem.winning_item.item_name)
                    ? historyItem.winning_item.item_name
                    : (historyItem.item1 && historyItem.item1.item_name ? historyItem.item1.item_name : null);
                if (itemName) {
                    var winnerItem = cardContainer.FindChildTraverse("winner-item");
                    if (winnerItem) {
                        winnerItem.itemname = itemName;
                    }
                }
            } catch (e) {
                // Продолжаем создание других карточек даже при ошибке
            }
        }
    }
    
    // Загрузка дополнительной истории через GetCasinoHistory API
    function loadMoreHistory() {
        if (g_IsLoadingHistory) {
            return; // Уже идет загрузка
        }
        
        if (!g_HistoryHasMore && g_HistoryLastId === null) {
            // Нет данных для загрузки
            return;
        }
        
        g_IsLoadingHistory = true;
        
        // Обновляем состояние кнопки (показываем загрузку)
        var root = $.GetContextPanel();
        var loadMoreButton = root ? root.FindChildTraverse("LoadMoreWinnersButton") : null;
        if (loadMoreButton) {
            loadMoreButton.enabled = false;
            // Можно добавить индикатор загрузки
        }
        
        // Отправляем запрос на сервер
        var requestData = {
            limit: 10, // Загружаем по 10 записей
        };
        
        // Если есть last_id, используем его для курсорной пагинации
        if (g_HistoryLastId !== null) {
            requestData.last_id = g_HistoryLastId;
        }
        
        GameEvents.SendCustomGameEventToServer("casv2_load_history", requestData);
    }
    
    // Обработчик ответа от сервера с историей
    function onCasinoHistoryReceived(data) {
        g_IsLoadingHistory = false;
        
        var root = $.GetContextPanel();
        var loadMoreButton = root ? root.FindChildTraverse("LoadMoreWinnersButton") : null;
        
        if (data && data.success) {
            var history = normalizeHistoryArray(data.history);
            
            if (history && history.length > 0) {
                // Обновляем состояние пагинации
                // Используем last_id из ответа сервера (более надежно)
                if (data.last_id !== null && data.last_id !== undefined) {
                    g_HistoryLastId = data.last_id;
                } else {
                    // Fallback: берем из последнего элемента истории
                    var lastItem = history[history.length - 1];
                    if (lastItem && lastItem.id) {
                        g_HistoryLastId = lastItem.id;
                    }
                }
                g_HistoryHasMore = data.has_more === true;
                
                // Добавляем новые элементы к существующим (не заменяем)
                updateHistoryDisplay(history, false);
            } else {
                // Нет новых записей
                g_HistoryHasMore = false;
                // Если сервер вернул last_id, сохраняем его на случай следующего запроса
                if (data.last_id !== null && data.last_id !== undefined) {
                    g_HistoryLastId = data.last_id;
                }
            }
        } else {
            // Ошибка загрузки
            g_HistoryHasMore = false;
        }
        
        // Обновляем видимость кнопки
        updateLoadMoreButtonVisibility();
        
        // Восстанавливаем состояние кнопки
        if (loadMoreButton) {
            loadMoreButton.enabled = true;
        }
    }
    
    // Обновление видимости кнопки "Загрузить еще"
    function updateLoadMoreButtonVisibility() {
        var root = $.GetContextPanel();
        var loadMoreButton = root ? root.FindChildTraverse("LoadMoreWinnersButton") : null;
        if (loadMoreButton) {
            if (g_HistoryHasMore) {
                loadMoreButton.style.visibility = "visible";
            } else {
                loadMoreButton.style.visibility = "collapse";
            }
        }
    }
    
    // ============================================
    // INVENTORY MODAL
    // ============================================
    
    function updateInventoryButtonText() {
        var root = $.GetContextPanel();
        if (!root) return;
        var lbl = root.FindChildTraverse("InventoryButtonText");
        if (!lbl) return;
        var inv = normalizeHistoryArray(g_CasinoData.inventory);
        var count = inv ? inv.length : 0;
        lbl.text = (count > 0) ? ("ИНВЕНТАРЬ (" + count + ")") : "ИНВЕНТАРЬ";
    }

    function openInventoryModal() {
        var root = $.GetContextPanel();
        var overlay = root.FindChildTraverse("InventoryModalOverlay");
        if (overlay) {
            overlay.AddClass("visible");
            loadInventoryItems();
        }
    }
    
    function closeInventoryModal() {
        var root = $.GetContextPanel();
        var overlay = root.FindChildTraverse("InventoryModalOverlay");
        if (overlay) {
            overlay.RemoveClass("visible");
        }
    }
    
    function loadInventoryItems() {
        var root = $.GetContextPanel();
        if (!root) return;
        var inv = normalizeHistoryArray(g_CasinoData.inventory);
        var claimed = normalizeHistoryArray(g_CasinoData.claimed_history);
        var sold = normalizeHistoryArray(g_CasinoData.sold_history);

        var sumRuby = 0, sumShield = 0;
        for (var i = 0; i < inv.length; i++) {
            var it = inv[i];
            if (it.currency === "ruby") sumRuby += (it.price || 0) | 0;
            else sumShield += (it.price || 0) | 0;
        }
        var lblRuby = root.FindChildTraverse("InventorySellAllRubyVal");
        var lblShield = root.FindChildTraverse("InventorySellAllShieldVal");
        if (lblRuby) {
            lblRuby.text = formatNumber(sumRuby);
            var rubyPanel = lblRuby.GetParent();
            if (rubyPanel) rubyPanel.visible = (sumRuby > 0);
        }
        if (lblShield) {
            lblShield.text = formatNumber(sumShield);
            var shieldPanel = lblShield.GetParent();
            if (shieldPanel) shieldPanel.visible = (sumShield > 0);
        }

        // Сетка предметов (с кнопками Продать/Забрать)
        var grid = root.FindChildTraverse("InventoryGrid");
        var emptyMsg = root.FindChildTraverse("InventoryEmptyMessage");
        if (grid) grid.RemoveAndDeleteChildren();
        if (emptyMsg) emptyMsg.visible = (inv.length === 0);
        for (var i = 0; i < inv.length; i++) {
            var it = inv[i];
            var card = $.CreatePanel("Panel", grid, "InvCard" + (it.id || i));
            card.BLoadLayoutSnippet("inventory_item_card");

            // Режим "Новые": показываем кнопки, скрываем исторический чип цены
            var histChipNew = card.FindChildTraverse("InvHistChip");
            if (histChipNew) histChipNew.style.visibility = "collapse";
            var btnsNew = card.FindChildTraverse("InvItemButtons");
            if (btnsNew) btnsNew.style.visibility = "visible";

            var img = card.FindChildTraverse("InvItemImage");
            if (img) img.itemname = it.item_name || "";

            var lblName = card.FindChildTraverse("InvItemName");
            if (lblName) lblName.text = it.item_name || "—";

            var lblTime = card.FindChildTraverse("InvItemTime");
            if (lblTime) lblTime.text = formatTimeAgo(it.received_at);

            var sellPrice = card.FindChildTraverse("InvSellPrice");
            if (sellPrice) sellPrice.text = formatNumber(it.price || 0);

            var sellCur = card.FindChildTraverse("InvSellCurrency");
            if (sellCur) {
                sellCur.SetImage((it.currency === "ruby")
                    ? "file://{images}/custom_game/currency_icon/currency_ruby_16x16.png"
                    : "file://{images}/custom_game/currency_icon/currency_shield_16x16.png"
                );
            }

            var btnSell = card.FindChildTraverse("InvBtnSell");
            if (btnSell) {
                btnSell.SetPanelEvent("onactivate", (function(id) { return function() {
                    GameEvents.SendCustomGameEventToServer("casv2_sell_item", { inventory_id: id });
                }; })(it.id));
            }

            var btnClaim = card.FindChildTraverse("InvBtnClaim");
            var blockedText = card.FindChildTraverse("InvClaimBlockedText");
            if (btnClaim) {
                if (it.can_claim === true) {
                    btnClaim.style.visibility = "visible";
                    if (blockedText) blockedText.style.visibility = "collapse";
                    btnClaim.SetPanelEvent("onactivate", (function(id) { return function() {
                        GameEvents.SendCustomGameEventToServer("casv2_claim_item", { inventory_id: id });
                    }; })(it.id));
                } else {
                    btnClaim.style.visibility = "collapse";
                    if (blockedText) blockedText.style.visibility = "visible";
                }
            }
        }

        // Кнопки «Продать все» / «Забрать все»
        var sellAllBtn = root.FindChildTraverse("InventorySellAll");
        var claimAllBtn = root.FindChildTraverse("InventoryClaimAll");
        if (sellAllBtn) sellAllBtn.enabled = (inv.length > 0);
        var hasClaimable = false;
        for (var k = 0; k < inv.length; k++) { if (inv[k].can_claim === true) { hasClaimable = true; break; } }
        if (claimAllBtn) claimAllBtn.enabled = hasClaimable;

        // Сетка истории (Полученные / Проданные)
        var claimedGrid = root.FindChildTraverse("ClaimedGrid");
        var claimedEmpty = root.FindChildTraverse("ClaimedEmptyMessage");
        if (claimedGrid) claimedGrid.RemoveAndDeleteChildren();
        var hist = (g_InventoryActiveTab === "claimed_history") ? sold : claimed;
        if (claimedEmpty) {
            claimedEmpty.visible = (hist.length === 0);
            claimedEmpty.text = (g_InventoryActiveTab === "claimed_history") ? "Нет проданных предметов" : "Нет полученных предметов";
        }
        for (var j = 0; j < hist.length; j++) {
            var c = hist[j];
            var cardC = $.CreatePanel("Panel", claimedGrid, "ClaimedCard" + (c.id || j));
            cardC.BLoadLayoutSnippet("inventory_item_card");

            // Режим "Полученные/Проданные": скрываем кнопки, показываем исторический чип цены
            var btnsC = cardC.FindChildTraverse("InvItemButtons");
            if (btnsC) btnsC.style.visibility = "collapse";

            var rootC = cardC.FindChildTraverse("InvCardRoot");
            if (rootC) rootC.AddClass("inventory-item-card--claimed");

            var imgC = cardC.FindChildTraverse("InvItemImage");
            if (imgC) imgC.itemname = c.item_name || "";

            var nameC = cardC.FindChildTraverse("InvItemName");
            if (nameC) nameC.text = c.item_name || "—";

            var timeIso = (g_InventoryActiveTab === "claimed_history") ? c.sold_at : c.claimed_at;
            var tC = cardC.FindChildTraverse("InvItemTime");
            if (tC) tC.text = formatTimeAgo(timeIso);

            // В истории показываем отдельный price-chip и прячем кнопки
            var histChip = cardC.FindChildTraverse("InvHistChip");
            if (histChip) histChip.style.visibility = "visible";
            var histPrice = cardC.FindChildTraverse("InvHistPrice");
            if (histPrice) histPrice.text = formatNumber(c.price || 0);
            var histCur = cardC.FindChildTraverse("InvHistCurrency");
            if (histCur) {
                histCur.SetImage((c.currency === "ruby")
                    ? "file://{images}/custom_game/currency_icon/currency_ruby_16x16.png"
                    : "file://{images}/custom_game/currency_icon/currency_shield_16x16.png"
                );
            }
        }

        applyInventoryTab();
    }
    
    function onCasinoSellResult(data) {
        if (!data) return;
        if (data.success) {
            g_CasinoData.inventory = data.inventory || [];
            g_CasinoData.claimed_history = data.claimed_history || [];
            g_CasinoData.sold_history = data.sold_history || [];
            g_CasinoData.sold_totals = data.sold_totals || { ruby: 0, shield: 0 };
            if (data.profile) updatePlayerProfile(data.profile);
            updateInventoryButtonText();
            loadInventoryItems();
        }
    }

    function onCasinoClaimResult(data) {
        if (!data) return;
        if (data.success) {
            g_CasinoData.inventory = data.inventory || [];
            g_CasinoData.claimed_history = data.claimed_history || [];
            g_CasinoData.sold_history = data.sold_history || [];
            g_CasinoData.sold_totals = data.sold_totals || { ruby: 0, shield: 0 };
            if (data.profile) updatePlayerProfile(data.profile);
            updateInventoryButtonText();
            loadInventoryItems();
        } else {
            // При 400 сервер может прислать актуальный inventory с can_claim — обновляем UI
            if (data.inventory && (data.inventory.length !== undefined || typeof data.inventory === "object")) {
                g_CasinoData.inventory = data.inventory;
                updateInventoryButtonText();
                loadInventoryItems();
            } else {
                requestCasinoData();
            }
        }
    }

    // ============================================
    // УВЕДОМЛЕНИЯ (выигрыши союзников, до 3 шт., 10 сек, новые сверху)
    // ============================================
    var NOTIF_DURATION = 10;
    var NOTIF_MAX = 3;
    var NOTIF_HIDE_ANIM_MS = 0.3; // секунды

    function addAllyWinNotification(data) {
        if (!main || !main.IsValid()) return;
        var list = main.FindChildTraverse("CasinoNotificationsList");
        if (!list) return;

        var steamid = (data && data.steamid) ? String(data.steamid) : "0";
        var heroname = (data && data.heroname) ? String(data.heroname) : "npc_dota_hero_axe";
        var itemName = (data && data.item_name) ? String(data.item_name) : "item_branches";
        var titleText = (data && data.title) ? String(data.title) : "Игрок выиграл!";

        // Если уже 3 — анимированно убираем самое старое (последнее в списке)
        if (list.GetChildCount() >= NOTIF_MAX) {
            var oldest = list.GetChild(list.GetChildCount() - 1);
            var innerOld = oldest.GetChild(0);
            if (innerOld) innerOld.AddClass("hiding");
            $.Schedule(NOTIF_HIDE_ANIM_MS, function() {
                if (oldest && oldest.IsValid()) oldest.DeleteAsync(0);
            });
        }

        var id = "ally_win_" + Date.now() + "_" + Math.floor(Math.random() * 10000);
        var wrap = $.CreatePanel("Panel", list, id);
        if (wrap.BLoadLayoutSnippet("ally_win_notification") === false) return;
        var card = wrap.GetChild(0);
        if (!card) return;

        var avatar = wrap.FindChildTraverse("AllyWinNotifAvatar");
        var hero = wrap.FindChildTraverse("AllyWinNotifHero");
        var item = wrap.FindChildTraverse("AllyWinNotifItem");
        var name = wrap.FindChildTraverse("AllyWinNotifName");
        var titleEl = wrap.FindChildTraverse("AllyWinNotifTitle");

        if (avatar) avatar.steamid = steamid;
        if (hero) hero.heroname = heroname;
        if (item) item.itemname = itemName;
        if (name) name.steamid = steamid;
        if (titleEl) titleEl.text = titleText;

        // CreatePanel(parent, id) уже добавил wrap в list; ставим новое уведомление сверху
        if (list.GetChildCount() > 1) {
            list.MoveChildBefore(wrap, list.GetChild(0));
        }

        $.Schedule(0, function() {
            if (wrap && wrap.IsValid()) wrap.AddClass("visible");
        });

        $.Schedule(NOTIF_DURATION, function() {
            if (!wrap.IsValid()) return;
            if (card && card.IsValid()) card.AddClass("hiding");
            $.Schedule(NOTIF_HIDE_ANIM_MS, function() {
                if (wrap && wrap.IsValid()) wrap.DeleteAsync(0);
            });
        });
    }

    function onAllyWinNotification(data) {
        addAllyWinNotification(data);
    }

    // Подписываемся на события
    GameEvents.Subscribe("casino_spin_result", onSpinResult);
    GameEvents.Subscribe("casv2_data", onCasinoDataReceived);
    GameEvents.Subscribe("casv2_history", onCasinoHistoryReceived);
    GameEvents.Subscribe("casv2_sell_result", onCasinoSellResult);
    GameEvents.Subscribe("casv2_claim_result", onCasinoClaimResult);
    GameEvents.Subscribe("casv2_ally_win", onAllyWinNotification);

    GameUI.LoopTime.Schedule(0.0, Initialize);
})();