--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


// Custom Health Bar Engine
// Автоматически создает health bar панели для юнитов с модификатором modifier_damage_challenge

(function() {
    "use strict";
    
    // Получаем корневой элемент HUD
    const HUD_ROOT = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("HeroRelicProgress");
    HUD_ROOT.hittestchildren = true;
    
    // Хранилище для всех созданных health bar панелей
    const healthBarPanels = {};
    let healthBarWinIdCounter = 0;
    let healthBarUpdateTimer = null;
    
    // Кэш для оптимизации
    const healthBarCache = {
        playerId: null,
        playerHeroIndex: null,
        playerOrigin: null,
        screenWidth: null,
        screenHeight: null,
        lastUpdate: 0,
        updateInterval: 100 // Обновляем кэш каждые 100мс
    };
    
    // Функция для обновления кэша игрока
    function updatePlayerCache() {
        const now = Date.now();
        if (now - healthBarCache.lastUpdate < healthBarCache.updateInterval) {
            return; // Кэш еще актуален
        }
        
        healthBarCache.playerId = Players.GetLocalPlayer();
        healthBarCache.playerHeroIndex = Players.GetPlayerHeroEntityIndex(healthBarCache.playerId);
        healthBarCache.playerOrigin = Entities.GetAbsOrigin(healthBarCache.playerHeroIndex);
        healthBarCache.screenWidth = Game.GetScreenWidth();
        healthBarCache.screenHeight = Game.GetScreenHeight();
        healthBarCache.lastUpdate = now;
    }
    
    // Оптимизированная функция проверки видимости
    function isHealthBarVisible(posX, posY, originZ) {
        return !(posX < 0 || posX > healthBarCache.screenWidth || 
                 posY < 0 || posY > healthBarCache.screenHeight || 
                 originZ < -500);
    }
    
    // Оптимизированная функция расчета расстояния
    function calculateDistance(origin1, origin2) {
        const dx = origin1[0] - origin2[0];
        const dy = origin1[1] - origin2[1];
        const dz = origin1[2] - origin2[2];
        return Math.sqrt(dx * dx + dy * dy + dz * dz);
    }
    
    // Оптимизированная функция обновления всех health bar панелей
    function UpdateAllHealthBarPanels() {
        // Быстрый выход если нет панелей
        const panelCount = Object.keys(healthBarPanels).length;
        if (panelCount === 0) return;
        
        // Обновляем кэш игрока
        updatePlayerCache();
        
        // Проверяем валидность данных игрока один раз
        if (!healthBarCache.playerOrigin || healthBarCache.playerOrigin.length < 3) {
            return;
        }
        
        // Обрабатываем только активные панели
        const activePanels = [];
        const deadUnits = [];
        
        // Предварительная фильтрация
        for (let unitId in healthBarPanels) {
            const panel = healthBarPanels[unitId];
            
            // Проверяем наличие панели
            if (!panel.panel) {
                continue;
            }
            
            // Проверяем, что юнит жив
            const unitIdNum = parseInt(unitId);
            if (!Entities.IsAlive(unitIdNum)) {
                deadUnits.push(unitId);
                continue;
            }
            
            activePanels.push({ unitId, unitIdNum, panel });
        }
        
        // Удаляем панели мертвых юнитов
        for (const unitId of deadUnits) {
            remove_health_bar_panel({ unit_id: unitId });
        }
        
        // Обрабатываем только активные панели
        for (const { unitId, unitIdNum, panel } of activePanels) {
            const origin = Entities.GetAbsOrigin(unitIdNum);
            
            // Быстрая проверка валидности origin
            if (!origin || origin.length < 3) {
                continue;
            }
            
            // Кэшируем вычисления координат
            const posX = Game.WorldToScreenX(origin[0], origin[1], origin[2]);
            const posY = Game.WorldToScreenY(origin[0], origin[1], origin[2]);
            
            // Быстрая проверка валидности координат
            if (isNaN(posX) || isNaN(posY)) {
                continue;
            }
            
            // Проверяем видимость
            if (!isHealthBarVisible(posX, posY, origin[2])) {
                // Полностью скрываем панель если она за краем экрана
                if (panel.panel.style.visibility !== "collapse") {
                    panel.panel.style.visibility = "collapse";
                }
                continue;
            } else {
                // Показываем панель если она в видимой области
                if (panel.panel.style.visibility !== "visible") {
                    panel.panel.style.visibility = "visible";
                }
            }
            
            // Вычисляем offset для позиционирования над юнитом
            let offSet = Entities.GetHealthBarOffset(unitIdNum);
            if (offSet < 200) {
                offSet = 200;
            }
            
            // Вычисляем координаты панели
            const panelX = Game.WorldToScreenX(origin[0], origin[1], origin[2] + offSet);
            const panelY = Game.WorldToScreenY(origin[0], origin[1], origin[2] + offSet);
            
            // Проверяем валидность координат
            if (isNaN(panelX) || isNaN(panelY)) {
                continue;
            }
            
            // Позиционируем панель
            const panelTransform = `translate3d(${(panelX - panel.panel.actuallayoutwidth / 2) / panel.panel.actualuiscale_x}px,${(panelY - panel.panel.actuallayoutheight) / panel.panel.actualuiscale_y}px,0)`;
            
            // Обновляем transform только если он изменился
            if (panel.panel.style.transform !== panelTransform) {
                panel.panel.style.transform = panelTransform;
            }
        }
    }
    
    // Функция создания health bar панели
    function create_health_bar_panel(t) {
        const unitId = t.unit_id;
        
        // Проверяем, не создана ли уже панель для этого юнита
        if (healthBarPanels[unitId]) {
            $.Msg("Health bar panel already exists for unit:", unitId);
            return;
        }
        
        // Создаем уникальный winid для каждой панели
        healthBarWinIdCounter++;
        const winId = "health_bar_" + unitId + "_" + healthBarWinIdCounter;
        
        // Удаляем существующую панель если она есть
        const existingPanel = HUD_ROOT.FindChildTraverse("health_bar_panel_" + unitId);
        if (existingPanel) {
            existingPanel.DeleteAsync(0);
        }
        
        // Создаем новую панель
        const new_panel = $.CreatePanel("Panel", HUD_ROOT, "health_bar_panel_" + unitId);
        new_panel.BLoadLayout("s2r://panorama/layout/custom_game/health_bar/damage_challenge.xml", false, false);
        
        // Устанавливаем видимость как visible по умолчанию
        new_panel.style.visibility = "visible";
        
        // Сохраняем информацию о созданной панели
        healthBarPanels[unitId] = {
            panel: new_panel,
            winId: winId,
            unitId: unitId
        };
        
        // Принудительно обновляем панель после создания
        $.Schedule(0.1, function() {
            if (healthBarPanels[unitId] && healthBarPanels[unitId].panel) {
                // Триггерим обновление данных
                const data = CustomNetTables.GetTableValue("health_bar", unitId);
                if (data) {
                    // Вызываем функцию обновления панели
                    const panel = healthBarPanels[unitId].panel;
                    if (panel && panel.OnDamageChallengeDataChanged) {
                        panel.OnDamageChallengeDataChanged("health_bar", unitId, data);
                    }
                }
            }
        });
        
        $.Msg("Created health bar panel for unit:", unitId, "WinId:", winId);
        
        // Запускаем общий таймер если он еще не запущен
        if (!healthBarUpdateTimer) {
            healthBarUpdateTimer = GameUI.LoopTime.AddTime("health_bar_update", 0, 0, UpdateAllHealthBarPanels, false);
            $.Msg("Started health bar update timer");
        }
    }
    
    // Функция удаления health bar панели
    function remove_health_bar_panel(t) {
        const unitId = t.unit_id;
        
        // Проверяем, существует ли панель для этого юнита
        if (!healthBarPanels[unitId]) {
            $.Msg("Health bar panel not found for unit:", unitId);
            return;
        }
        
        const panel = healthBarPanels[unitId];
        
        // Удаляем панель из DOM
        if (panel.panel) {
            panel.panel.DeleteAsync(0);
        }
        
        $.Msg("Removed health bar panel for unit:", unitId);
        
        // Удаляем из хранилища
        delete healthBarPanels[unitId];
        
        // Если больше нет панелей, останавливаем общий таймер
        if (Object.keys(healthBarPanels).length === 0 && healthBarUpdateTimer) {
            GameUI.LoopTime.DelTime("health_bar_update");
            healthBarUpdateTimer = null;
            $.Msg("Stopped health bar update timer - no more panels");
        }
    }
    
    // Функция для отладки - показывает все созданные панели
    function debug_health_bar_panels() {
        $.Msg("=== Health Bar Panels Debug ===");
        $.Msg("Total panels:", Object.keys(healthBarPanels).length);
        $.Msg("WinId Counter:", healthBarWinIdCounter);
        for (let unitId in healthBarPanels) {
            const panel = healthBarPanels[unitId];
            $.Msg("Unit", unitId, "- Panel exists:", !!panel.panel, "WinId:", panel.winId);
        }
        $.Msg("==============================");
    }
    
    // Функция для принудительного обновления всех панелей
    function force_update_all_health_bars() {
        for (let unitId in healthBarPanels) {
            const panel = healthBarPanels[unitId];
            if (panel.panel) {
                panel.panel.style.visibility = "visible";
            }
        }
        UpdateAllHealthBarPanels();
    }
    
    // Функция для принудительной очистки кэша
    function clear_health_bar_cache() {
        healthBarCache.playerId = null;
        healthBarCache.playerHeroIndex = null;
        healthBarCache.playerOrigin = null;
        healthBarCache.screenWidth = null;
        healthBarCache.screenHeight = null;
        healthBarCache.lastUpdate = 0;
    }
    
    // Подписываемся на события
    GameEvents.Subscribe("create_health_bar_panel", create_health_bar_panel);
    GameEvents.Subscribe("remove_health_bar_panel", remove_health_bar_panel);
    GameEvents.Subscribe("debug_health_bar_panels", debug_health_bar_panels);
    GameEvents.Subscribe("force_update_all_health_bars", force_update_all_health_bars);
    GameEvents.Subscribe("clear_health_bar_cache", clear_health_bar_cache);
    
    // Подписываемся на изменения NetTables для автоматического создания панелей
    CustomNetTables.SubscribeNetTableListener("health_bar", function(tableName, key, data) {
        if (tableName !== "health_bar") return;
        
        const unitId = key;
        
        if (data && data.level) {
            // Данные есть - создаем панель
            if (!healthBarPanels[unitId]) {
                create_health_bar_panel({ unit_id: unitId });
            }
        } else {
            // Данных нет - удаляем панель
            if (healthBarPanels[unitId]) {
                remove_health_bar_panel({ unit_id: unitId });
            }
        }
    });
    
})();