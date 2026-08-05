--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
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

    function Initialize() {
        if (g_Initialized) return;

        var root = $.GetContextPanel();
        if (!root) return;

        setupEventHandlers();
        g_Initialized = true;
    }

    function setupEventHandlers() {
        var root = $.GetContextPanel();
        
        // Close button handler
        var closeButton = root.FindChildTraverse("CasinoCloseButton");
        if (closeButton) {
            closeButton.SetPanelEvent("onactivate", function() {
                GameEvents.SendCustomGameEventToServer("casino_close", {});
                root.visible = false;
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
        
        if (g_IsSpinning) {
            // Если анимация идет и кнопка активна, пропускаем её
            var playButton = root.FindChildTraverse("PlayButton");
            if (playButton && playButton.enabled) {
                skipAnimation(root);
            }
            return;
        }

        clearAllSlots(root);
        setSpinningState(root, true);
        setupSpinTimeout();
        startAnticipationAnimation(root);
    }
    
    function skipAnimation(root) {
        if (!g_IsSpinning) return;
        
        // Пропускаем анимацию до конца
        stopSpinAnimation(root, true);
        finishSpin();
    }

    function startAnticipationAnimation(root) {
        var playButton = root.FindChildTraverse("PlayButton");
        if (playButton) playButton.AddClass("button-pressed");

        Game.EmitSound("ui_generic_button_click");

        for (var i = 0; i < SLOT_CARDS.length; i++) {
            var slotCard = root.FindChildTraverse(SLOT_CARDS[i]);
            if (slotCard) slotCard.AddClass("anticipation");
        }

        // Минимальная задержка для визуального эффекта anticipation
        $.Schedule(0.05, function() {
            for (var i = 0; i < SLOT_CARDS.length; i++) {
                var slotCard = root.FindChildTraverse(SLOT_CARDS[i]);
                if (slotCard) slotCard.RemoveClass("anticipation");
            }

            clearAllSlots(root);
            setSpinningState(root, true);
            setupSpinTimeout();
            var currencyParam = g_SelectedCurrency === "shield" ? "shield" : "ruby";
            GameEvents.SendCustomGameEventToServer("casino_spin", {
                currency: currencyParam,
                bet: g_SelectedBet
            });
        });
    }

    function onSpinResult(result) {
        if (!result.item1 || !result.item2 || !result.item3) {
            finishSpin();
            return;
        }

        var root = $.GetContextPanel();
        
        // startAllSlotsAnimation(root, [
        //     {item: result.item1, duration: 1.0, speed: g_SelectedSpeed, fillerItems: result.fillerItems1},
        //     {item: result.item2, duration: 1.5, speed: g_SelectedSpeed, fillerItems: result.fillerItems2},
        //     {item: result.item3, duration: 2.0, speed: g_SelectedSpeed, fillerItems: result.fillerItems3}
        // ], null, finishSpin);
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

        // Очищаем DROP_POS после небольшой задержки, чтобы предметы успели отобразиться
        $.Schedule(0.2, function() {
            // Даем время на отображение предметов перед очисткой
        });

        setSpinningState(root, false);
    }

    GameEvents.Subscribe("casino_spin_result", onSpinResult);
    GameUI.LoopTime.Schedule(0.0, Initialize);
})();