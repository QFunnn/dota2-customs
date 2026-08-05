--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


const HUD_ROOT = $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse("HeroRelicProgress");
HUD_ROOT.hittestchildren = true

// Хранилище для всех созданных NPC overlay
const npcOverlays = {};
let npcWinIdCounter = 0;
let npcUpdateTimer = null;

// Кэш для оптимизации
const npcCache = {
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
    if (now - npcCache.lastUpdate < npcCache.updateInterval) {
        return; // Кэш еще актуален
    }
    
    npcCache.playerId = Players.GetLocalPlayer();
    npcCache.playerHeroIndex = Players.GetPlayerHeroEntityIndex(npcCache.playerId);
    npcCache.playerOrigin = Entities.GetAbsOrigin(npcCache.playerHeroIndex);
    npcCache.screenWidth = Game.GetScreenWidth();
    npcCache.screenHeight = Game.GetScreenHeight();
    npcCache.lastUpdate = now;
}

// Оптимизированная функция проверки видимости
function isNpcVisible(posX, posY, originZ) {
    return !(posX < 0 || posX > npcCache.screenWidth || 
             posY < 0 || posY > npcCache.screenHeight || 
             originZ < -500);
}

// Оптимизированная функция расчета расстояния
function calculateDistanceSqr(origin1, origin2) {
    const dx = origin1[0] - origin2[0];
    const dy = origin1[1] - origin2[1];
    const dz = origin1[2] - origin2[2];
    return dx * dx + dy * dy + dz * dz;
}

// Оптимизированная функция обновления всех NPC
function UpdateAllNpcOverlays() {
    // Быстрый выход если нет NPC
    const npcCount = Object.keys(npcOverlays).length;
    if (npcCount === 0) return;
    
    // Обновляем кэш игрока
    updatePlayerCache();
    
    // Проверяем валидность данных игрока один раз
    if (!npcCache.playerOrigin || npcCache.playerOrigin.length < 3) {
        return;
    }
    
    // Обрабатываем только активные NPC
    const activeNpcs = [];
    const deadNpcs = [];
    
    // Предварительная фильтрация
    for (let unitId in npcOverlays) {
        const overlay = npcOverlays[unitId];
        
        // Проверяем наличие панелей
        if (!overlay.panel || !overlay.label || !overlay.button || !overlay.labelContainer) {
            continue;
        }
        
        // Проверяем, что юнит жив
        const unitIdNum = parseInt(unitId);
        if (!Entities.IsAlive(unitIdNum)) {
            deadNpcs.push(unitId);
            continue;
        }
        
        activeNpcs.push({ unitId, unitIdNum, overlay });
    }
    
    // Удаляем мертвые NPC
    for (const unitId of deadNpcs) {
        remove_npc_button({ unit_id: unitId });
    }
    
    // Обрабатываем только активные NPC
    for (const { unitId, unitIdNum, overlay } of activeNpcs) {
        // Вызываем анимацию свечения только для активных
        if (overlay.animateGlow) {
            overlay.animateGlow();
        }
        
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
        if (!isNpcVisible(posX, posY, origin[2])) {
            // Полностью скрываем оверлей если он за краем экрана
            if (overlay.panel.style.visibility !== "collapse") {
                overlay.panel.style.visibility = "collapse";
            }
            if (overlay.label.style.visibility !== "collapse") {
                overlay.label.style.visibility = "collapse";
            }
            continue;
        } else {
            // Показываем оверлей если он в видимой области
            if (overlay.panel.style.visibility !== "visible") {
                overlay.panel.style.visibility = "visible";
            }
            if (overlay.label.style.visibility !== "visible") {
                overlay.label.style.visibility = "visible";
            }
        }
        
        // Вычисляем offset один раз
        let offSet = Entities.GetHealthBarOffset(unitIdNum);
        if (offSet < 150) {
            offSet = 150;
        }
        
        // Вычисляем координаты кнопки и лейбла
        const labelX = Game.WorldToScreenX(origin[0], origin[1], origin[2] + offSet);
        const labelY = Game.WorldToScreenY(origin[0], origin[1], origin[2] + offSet + 100);
        const buttonX = Game.WorldToScreenX(origin[0], origin[1], origin[2] + offSet);
        const buttonY = Game.WorldToScreenY(origin[0], origin[1], origin[2] + offSet + 100);
        
        // Проверяем валидность координат
        if (isNaN(labelX) || isNaN(labelY) || isNaN(buttonX) || isNaN(buttonY)) {
            continue;
        }
        
        // Вычисляем расстояние до игрока
        const distanceSqr = calculateDistanceSqr(origin, npcCache.playerOrigin);
        
        if (isNaN(distanceSqr)) {
            continue;
        }
        
        // Определяем активность
        const interactionRadius = overlay.required_distance || 200;
        const isActive = distanceSqr <= (interactionRadius * interactionRadius);
        
        // Оптимизированное обновление состояния элементов
        const wasActive = overlay.button.BHasClass('active');
        
        if (isActive && !wasActive) {
            // Переключаем на активное состояние
            overlay.button.RemoveClass('inactive');
            overlay.button.AddClass('active');
            overlay.label.RemoveClass('inactive');
            overlay.label.AddClass('active');
            overlay.labelContainer.RemoveClass('inactive');
            overlay.labelContainer.AddClass('active');
        } else if (!isActive && wasActive) {
            // Переключаем на неактивное состояние
            overlay.button.RemoveClass('active');
            overlay.button.AddClass('inactive');
            overlay.label.RemoveClass('active');
            overlay.label.AddClass('inactive');
            overlay.labelContainer.RemoveClass('active');
            overlay.labelContainer.AddClass('inactive');
        }
        
        // Оптимизированное позиционирование элементов
        const labelTransform = `translate3d(${(labelX - overlay.label.actuallayoutwidth / 2) / overlay.label.actualuiscale_x}px,${(labelY - overlay.label.actuallayoutheight) / overlay.label.actualuiscale_y}px,0)`;
        const panelTransform = `translate3d(${(buttonX - overlay.panel.actuallayoutwidth / 2) / overlay.panel.actualuiscale_x}px,${buttonY / overlay.panel.actualuiscale_y}px,0)`;
        
        // Обновляем transform только если он изменился
        if (overlay.label.style.transform !== labelTransform) {
            overlay.label.style.transform = labelTransform;
        }
        if (overlay.panel.style.transform !== panelTransform) {
            overlay.panel.style.transform = panelTransform;
        }
    }
}

function create_npc_button(t){
    // $.Msg("create_npc_button for unit:", t.unit_id)
    const unitId = t.unit_id
    const required_distance = t.distance || 200
    const name = t.name || "NPC"
    
    // Проверяем, не создан ли уже overlay для этого NPC
    if (npcOverlays[unitId]) {
        // $.Msg("NPC overlay already exists for unit:", unitId);
        return;
    }
    
    // Создаем уникальный winid для каждого overlay
    npcWinIdCounter++;
    const winId = "npc_overlay_" + unitId + "_" + npcWinIdCounter;
    // Удаляем существующие панели если они есть
    const existingPanel = HUD_ROOT.FindChildTraverse("npc_button_" + unitId);
    const existingLabel = HUD_ROOT.FindChildTraverse("npc_label_label_" + unitId);
    if (existingPanel) {
        existingPanel.DeleteAsync(0);
    }
    if (existingLabel) {
        existingLabel.DeleteAsync(0);
    }
    
    const new_panel = $.CreatePanel("Panel", HUD_ROOT, "npc_button_" + unitId);
    new_panel.BLoadLayout("s2r://panorama/layout/custom_game/npc_overlay/npc_button.xml", false, false);
    const new_label = $.CreatePanel("Panel", HUD_ROOT, "npc_label_label_" + unitId);
    new_label.BLoadLayout("s2r://panorama/layout/custom_game/npc_overlay/npc_label.xml", false, false);
    new_label.FindChildTraverse("npc_label").text = $.Localize(name);
    
    // Получаем элементы кнопки и лейбла
    const button = new_panel.FindChildTraverse("npc_button");
    const buttonText = new_panel.FindChildTraverse("npc_button_text");
    const label = new_label.FindChildTraverse("npc_label");
    const labelContainer = new_label.FindChildTraverse("npc_label_container");
    
    // Инициализируем как неактивные
    button.AddClass('inactive');
    label.AddClass('inactive');
    labelContainer.AddClass('inactive');
    
    // Устанавливаем видимость как visible по умолчанию
    new_panel.style.visibility = "visible";
    new_label.style.visibility = "visible";
    
    // Переменные для анимации
    let glowIntensity = 0.6;
    let glowDirection = 1;
    
    // Добавляем обработчик клика
    button.SetPanelEvent("onactivate", function() {
        // $.Msg("NPC button clicked for unit:", unitId);
        Game.EmitSound("General.ButtonClick")
        GameEvents.SendCustomGameEventToServer("npc_interact", { unit_id: unitId, name: name});
    });
    
    // Оптимизированная функция анимации свечения
    const animateGlow = function() {
        if (!button.BHasClass('active')) {
            return; // Быстрый выход если неактивен
        }
        
        const overlay = npcOverlays[unitId];
        if (!overlay) return;
        
        // Обновляем интенсивность свечения
        overlay.glowIntensity += overlay.glowDirection * 0.02;
        
        if (overlay.glowIntensity >= 1.0) {
            overlay.glowIntensity = 1.0;
            overlay.glowDirection = -1;
        } else if (overlay.glowIntensity <= 0.4) {
            overlay.glowIntensity = 0.4;
            overlay.glowDirection = 1;
        }
        
        // Кэшируем вычисления
        const glowValue = Math.floor(overlay.glowIntensity * 96).toString(16).padStart(2, '0');
        const glowSize = 15 + overlay.glowIntensity * 10;
        const textGlowSize = 10 + overlay.glowIntensity * 10;
        
        // Обновляем стили только если они изменились
        const buttonBackground = button.FindChildTraverse("npc_button_background");
        if (buttonBackground) {
            const newBoxShadow = `0px 2px 8px 0px #00000040, 0px 0px ${glowSize}px 0px #ffd700${glowValue}`;
            if (buttonBackground.style.boxShadow !== newBoxShadow) {
                buttonBackground.style.boxShadow = newBoxShadow;
            }
        }
        
        const newTextShadow = `2px 2px 0px #0000ff, -2px -2px 0px #0000ff, 2px -2px 0px #0000ff, -2px 2px 0px #0000ff, 0px 0px ${textGlowSize}px #ffd700${glowValue}`;
        if (label.style.textShadow !== newTextShadow) {
            label.style.textShadow = newTextShadow;
        }
    };
    
    // Сохраняем информацию о созданном overlay
    npcOverlays[unitId] = {
        panel: new_panel,
        label: new_label,
        button: button,
        labelContainer: labelContainer,
        winId: winId,
        required_distance: required_distance,
        animateGlow: animateGlow,
        glowIntensity: 0.6,
        glowDirection: 1
    };

    // Запускаем общий таймер если он еще не запущен
    if (!npcUpdateTimer) {
        // Используем более низкую частоту обновления для лучшей производительности
        npcUpdateTimer = GameUI.LoopTime.AddTime("npc_overlay_update", 0, 0, UpdateAllNpcOverlays, false);
        // $.Msg("Started global NPC update timer");
    }
    
    // $.Msg("NPC overlay created for unit:", unitId, "with winId:", winId);
}

function remove_npc_button(t){
    const unitId = t.unit_id;
    
    // Проверяем, существует ли overlay для этого NPC
    if (!npcOverlays[unitId]) {
        // $.Msg("NPC overlay not found for unit:", unitId);
        return;
    }
    
    const overlay = npcOverlays[unitId];
    
    // Удаляем панели из DOM
    if (overlay.panel) {
        overlay.panel.DeleteAsync(0);
    }
    if (overlay.label) {
        overlay.label.DeleteAsync(0);
    }
    
    // Удаляем из хранилища
    delete npcOverlays[unitId];
    
    // Если больше нет NPC, останавливаем общий таймер
    if (Object.keys(npcOverlays).length === 0 && npcUpdateTimer != null) {
        GameUI.LoopTime.RemoveTime("npc_overlay_update");
        npcUpdateTimer = null;
        // $.Msg("Stopped global NPC update timer - no more NPCs");
    }
    
    // $.Msg("NPC overlay removed for unit:", unitId);
}

// Функция для отладки - показывает все созданные NPC
function debug_npc_overlays() {
    $.Msg("=== NPC Overlays Debug ===");
    $.Msg("Total NPC overlays:", Object.keys(npcOverlays).length);
    $.Msg("WinId Counter:", npcWinIdCounter);
    for (let unitId in npcOverlays) {
        const overlay = npcOverlays[unitId];
        $.Msg("NPC", unitId, "- Panel exists:", !!overlay.panel, "Label exists:", !!overlay.label, "WinId:", overlay.winId);
    }
    $.Msg("========================");
}

// Функция для принудительного обновления всех NPC
function force_update_all_npc() {
    // $.Msg("Force updating all NPC overlays...");
    for (let unitId in npcOverlays) {
        const overlay = npcOverlays[unitId];
        if (overlay.panel && overlay.label) {
            // Принудительно показываем панели
            overlay.panel.style.visibility = "visible";
            overlay.label.style.visibility = "visible";
            // $.Msg("Forced visibility for NPC", unitId);
        }
    }
    // Принудительно обновляем все оверлеи
    UpdateAllNpcOverlays();
}

// Функция для принудительной очистки кэша
function clear_npc_cache() {
    npcCache.playerId = null;
    npcCache.playerHeroIndex = null;
    npcCache.playerOrigin = null;
    npcCache.screenWidth = null;
    npcCache.screenHeight = null;
    npcCache.lastUpdate = 0;
    // $.Msg("NPC cache cleared");
}

// Подписываемся на события
GameEvents.Subscribe( "create_npc_button", create_npc_button)
GameEvents.Subscribe( "remove_npc_button", remove_npc_button)
GameEvents.Subscribe( "debug_npc_overlays", debug_npc_overlays)
GameEvents.Subscribe( "force_update_all_npc", force_update_all_npc)
GameEvents.Subscribe( "clear_npc_cache", clear_npc_cache)

GameEvents.SendCustomGameEventToServer("request_npc_interactions_data", {})