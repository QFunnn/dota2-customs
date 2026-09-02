--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


"use strict";

const DOTA_HUD_ROOT = $.GetContextPanel().GetParent().GetParent();

var DotaHUD = {
    mouseCallbacks: [],
    windowControllers: {},
    loadingPanels: {}, // Хранилище активных панелей загрузки
    loadingPanelCounter: 0, // Счетчик для генерации уникальных ID
};

DotaHUD.Get = function() {
    return DOTA_HUD_ROOT;
};

DotaHUD.ShowError = function(message) {
    GameEvents.SendEventClientSide("dota_hud_error_message", {
        reason: 80,
        message: message
    });
};

DotaHUD.ListenToMouseEvent = function(callback) {
    try {
        if(typeof callback !== 'function') {
            throw "Expected callback as function.";
        }
    } 
    catch (err) 
    {
        $.Msg("DotaHUD.ListenToMouseEvent throws error.");
        $.Msg(err);
        $.Msg(err.stack);
        return "";
    }
    DotaHUD.mouseCallbacks.push(callback);
};

DotaHUD.IsCursorOverPanel = function(panel) {
    if(panel == null) {
        return false;
    }
    
    let cursorPos = GameUI.GetCursorPosition();

    if (cursorPos[0] < panel.actualxoffset 
        || panel.actualxoffset + panel.contentwidth < cursorPos[0] 
        || cursorPos[1] < panel.actualyoffset 
        || panel.actualyoffset + panel.contentheight < cursorPos[1]
    ) 
    {
        return true;
    }
    return false;
};

function FireMouseEvent(eventType, clickBehavior)
{
    for(let i = 0; i < DotaHUD.mouseCallbacks.length; i++) {
        if (DotaHUD.mouseCallbacks[i]) {
            try 
            {
                DotaHUD.mouseCallbacks[i](eventType, clickBehavior); 
            } 
            catch (err) 
            { 
                $.Msg("FireMouseEvent callback error.");
                $.Msg(err);
                $.Msg(err.stack);
            }
        }
    }
}

DotaHUD.WindowOpen = function(key){
    for(let i = 0; i < Object.keys(DotaHUD.windowControllers).length; i++){
        if(Object.keys(DotaHUD.windowControllers)[i] == key){
            if(DotaHUD.windowControllers[key].is_open == false){
                DotaHUD.windowControllers[key].open()
                DotaHUD.windowControllers[key].is_open = true
            }else{
                DotaHUD.WindowClose(key)
            }
        }else{
            DotaHUD.WindowClose(Object.keys(DotaHUD.windowControllers)[i])
        }
    }
}
DotaHUD.WindowClose = function(key){
    if(DotaHUD.windowControllers[key].is_open == true){
        DotaHUD.windowControllers[key].close()
        DotaHUD.windowControllers[key].is_open = false
    }
}
DotaHUD.WindowCloseAnyway = function(key){
    DotaHUD.windowControllers[key].is_open = false
    DotaHUD.WindowClose(key)
}
DotaHUD.IsWindowOpen = function(key){
    return DotaHUD.windowControllers[key].is_open
}
DotaHUD.formatNumber = function(value){
    if (value >= 1_000_000_000) {
        return (value / 1_000_000_000).toFixed(1) + 'B';
    } else if (value >= 1_000_000) {
        return (value / 1_000_000).toFixed(1) + 'M';
    } else if (value >= 1_000) {
        return (value / 1_000).toFixed(1) + 'K';
    } else {
        return value.toString();
    }
}

/**
 * @param {Panel} panel - Panel to check bounds against.
 * @param {string|function} windowNameOrCallback - If string: calls DotaHUD.WindowClose(name). If function: calls it on outside click.
 */
DotaHUD.GetCloseWindowOnOutsideClick = function (panel, windowNameOrCallback) {
    return (eventType, clickBehavior) => {
        if (eventType !== "pressed") return;
        if (clickBehavior !== 0 && clickBehavior !== 1) return;
        if (!panel || (panel.IsValid && !panel.IsValid())) return;
        let cursorPos = GameUI.GetCursorPosition();
        let pos = panel.GetPositionWithinWindow();
        let x = pos.x, y = pos.y;
        let width = Number(panel.actuallayoutwidth) || 0;
        let height = Number(panel.actuallayoutheight) || 0;
        let inside = cursorPos[0] >= x && (x + width) >= cursorPos[0] && cursorPos[1] >= y && (y + height) >= cursorPos[1];
        if (!inside) {
            if (typeof windowNameOrCallback === "function") {
                windowNameOrCallback();
            } else {
                DotaHUD.WindowClose(windowNameOrCallback);
            }
        }
    };
};

/**
 * Создает панель загрузки в центре экрана
 * @param {string} text - Текст сообщения загрузки (будет локализован, если начинается с #)
 * @param {Panel|object} contextPanelOrOptions - Контекстная панель страницы ИЛИ объект options (если передается только options)
 * @param {object} options - Опциональные параметры (timeout, styles и т.д.) - используется только если contextPanelOrOptions является Panel
 * @returns {string} Уникальный ID панели загрузки
 */
DotaHUD.ShowLoadingPanel = function(text, contextPanelOrOptions, options) {
    // Инициализируем actualOptions сразу, чтобы избежать ошибок
    var actualOptions = {};
    var contextPanel = null;
    
    // Определяем, что было передано: контекстная панель или options
    // Проверяем, является ли второй параметр панелью (имеет метод GetParent)
    if (contextPanelOrOptions != null && 
        typeof contextPanelOrOptions === 'object' && 
        typeof contextPanelOrOptions.GetParent === 'function') {
        // Передана контекстная панель
        contextPanel = contextPanelOrOptions;
        if (options != null && typeof options === 'object' && typeof options.GetParent !== 'function') {
            actualOptions = options;
        }
    } else {
        // Передан только options (старый способ вызова) или ничего не передано
        if (contextPanelOrOptions != null && typeof contextPanelOrOptions === 'object' && typeof contextPanelOrOptions.GetParent !== 'function') {
            actualOptions = contextPanelOrOptions;
        }
    }
    
    // Финальная защита: убеждаемся, что actualOptions всегда объект
    if (typeof actualOptions !== 'object' || actualOptions === null || actualOptions === undefined) {
        actualOptions = {};
    }
    
    // Генерируем уникальный ID
    DotaHUD.loadingPanelCounter++;
    const panelId = "loading_panel_" + DotaHUD.loadingPanelCounter + "_" + Date.now();
    
    // Определяем родительский контейнер
    let parentContainer = null;
    if (contextPanel) {
        // Используем переданную контекстную панель
        parentContainer = contextPanel;
    } else {
        // Используем стандартный контейнер для кастомного UI (как было до этого)
        parentContainer = DOTA_HUD_ROOT.FindChildTraverse("CustomUIContainer_Hud");
        if (!parentContainer) {
            $.Msg("[DotaHUD.ShowLoadingPanel] CustomUIContainer_Hud not found");
            return null;
        }
    }
    
    // Создаем основную панель загрузки
    const loadingPanel = $.CreatePanel('Panel', parentContainer, panelId);
    
    // Позиционирование в центре экрана
    loadingPanel.style.width = "100%";
    loadingPanel.style.height = "100%";
    loadingPanel.style.horizontalAlign = "center";
    loadingPanel.style.verticalAlign = "center";
    loadingPanel.style.zIndex = "1000"; // Отображаем поверх других элементов
    
    // Создаем контейнер для содержимого (прямоугольная панель)
    const contentPanel = $.CreatePanel('Panel', loadingPanel, panelId + "_content");
    
    // Размеры и стили контейнера (компактная версия)
    const backgroundColor = actualOptions.backgroundColor || "rgba(20, 20, 20, 0.95)";
    
    // Устанавливаем размеры только если они указаны в options, иначе панель подстроится под содержимое
    if (actualOptions.width) {
        contentPanel.style.width = actualOptions.width;
    }
    if (actualOptions.height) {
        contentPanel.style.height = actualOptions.height;
    }
    contentPanel.style.horizontalAlign = "center";
    contentPanel.style.verticalAlign = "center";
    contentPanel.style.backgroundColor = backgroundColor;
    contentPanel.style.borderRadius = "6px";
    contentPanel.style.boxShadow = "0px 0px 15px 3px rgba(0, 0, 0, 0.8)";
    contentPanel.style.padding = "12px 16px";
    contentPanel.style.flowChildren = "right"; // Горизонтальное расположение для компактности
    
    // Подготавливаем локализованный текст
    let localizedText = "";
    if (text) {
        // Добавляем # в начало, если его нет
        const localizationKey = text.charAt(0) === '#' ? text : '#' + text;
        // Всегда локализуем
        localizedText = $.Localize(localizationKey);
    }
    
    // Создаем текстовый блок для сообщения загрузки
    const textLabel = $.CreatePanel('Label', contentPanel, panelId + "_text");
    textLabel.text = localizedText;
    
    // Стилизация текста (компактная версия)
    const textColor = actualOptions.textColor || "#FFFFFF";
    const fontSize = actualOptions.fontSize || "16px";
    
    textLabel.style.color = textColor;
    textLabel.style.fontSize = fontSize;
    textLabel.style.fontWeight = "bold";
    textLabel.style.textAlign = "left";
    textLabel.style.horizontalAlign = "left";
    textLabel.style.verticalAlign = "center";
    textLabel.style.marginRight = "12px"; // Отступ между текстом и спиннером
    
    // Создаем крутящийся кружок (spinner) в стиле Dota 2 (компактная версия)
    const spinner = $.CreatePanel('Panel', contentPanel, panelId + "_spinner");
    const spinnerSize = actualOptions.spinnerSize || "24px";
    
    // Применяем все стили из .Spinner класса Dota 2
    spinner.style.width = spinnerSize;
    spinner.style.height = spinnerSize;
    spinner.style.horizontalAlign = "center";
    spinner.style.verticalAlign = "center";
    spinner.style.backgroundImage = 'url("s2r://panorama/images/status_icons/loadingthrobber_round_psd.vtex")';
    spinner.style.backgroundRepeat = "no-repeat";
    spinner.style.backgroundPosition = "50% 50%";
    spinner.style.backgroundSize = "contain";
    
    // Параметры анимации появления
    const fadeInDuration = actualOptions.fadeInDuration || 0.3;
    const fadeOutDuration = actualOptions.fadeOutDuration || 0.3;
    const useScaleAnimation = actualOptions.useScaleAnimation !== false; // По умолчанию включено
    
    // Начальное состояние для анимации появления
    contentPanel.style.opacity = "0";
    if (useScaleAnimation) {
        contentPanel.style.transform = "scale3d(0.8, 0.8, 1)";
        contentPanel.style.transformOrigin = "50% 50%";
    }
    
    // Сохраняем панель в хранилище
    DotaHUD.loadingPanels[panelId] = {
        panel: loadingPanel,
        contentPanel: contentPanel,
        spinner: spinner,
        textLabel: textLabel,
        text: text,
        options: actualOptions,
        rotationAngle: 0, // Текущий угол вращения
        fadeInDuration: fadeInDuration,
        fadeOutDuration: fadeOutDuration,
        useScaleAnimation: useScaleAnimation
    };
    
    // Запускаем анимацию вращения spinner
    DotaHUD.StartSpinnerAnimation(panelId);
    
    // Анимация появления (fade-in) с плавным переходом
    $.Schedule(0.01, function() {
        const panelData = DotaHUD.loadingPanels[panelId];
        if (!panelData || !panelData.contentPanel) {
            return;
        }
        
        // Настраиваем transition для плавной анимации
        panelData.contentPanel.style.transitionProperty = "opacity" + (panelData.useScaleAnimation ? ", transform" : "");
        panelData.contentPanel.style.transitionDuration = panelData.fadeInDuration + "s";
        panelData.contentPanel.style.transitionTimingFunction = "ease-out";
        
        // Запускаем анимацию
        panelData.contentPanel.style.opacity = "1";
        if (panelData.useScaleAnimation) {
            panelData.contentPanel.style.transform = "scale3d(1, 1, 1)";
        }
    });
    
    return panelId;
}

/**
 * Запускает анимацию вращения spinner для панели загрузки
 * Имитирует @keyframes SpinnerRotate с animation-direction: reverse
 * @param {string} panelId - ID панели загрузки
 */
DotaHUD.StartSpinnerAnimation = function(panelId) {
    const loadingData = DotaHUD.loadingPanels[panelId];
    if (!loadingData || !loadingData.spinner) {
        return;
    }
    
    // Параметры анимации из .Spinner класса Dota 2
    const animationDuration = 1.0; // 1.0s
    const frameRate = 60; // ~60 FPS
    const frameTime = 1.0 / frameRate; // Время одного кадра
    const totalFrames = Math.floor(animationDuration * frameRate);
    
    // Значения из @keyframes SpinnerRotate (в reverse направлении: от 100% к 0%)
    // 100% -> 0.1deg, 50% -> 180deg, 0% -> 359.9deg
    const startAngle = 0.1; // 100% keyframe
    const midAngle = 180.0; // 50% keyframe
    const endAngle = 359.9; // 0% keyframe
    
    let currentFrame = 0;
    loadingData.rotationAngle = startAngle;
    
    function animateSpinner() {
        if (!DotaHUD.loadingPanels[panelId] || !DotaHUD.loadingPanels[panelId].spinner) {
            return; // Панель была удалена
        }
        
        // Вычисляем текущий угол на основе прогресса анимации
        const progress = currentFrame / totalFrames;
        let angle;
        
        if (progress <= 0.5) {
            // Первая половина: от 0.1deg к 180deg
            const localProgress = progress * 2; // 0.0 -> 1.0
            angle = startAngle + (midAngle - startAngle) * localProgress;
        } else {
            // Вторая половина: от 180deg к 359.9deg
            const localProgress = (progress - 0.5) * 2; // 0.0 -> 1.0
            angle = midAngle + (endAngle - midAngle) * localProgress;
        }
        
        // Применяем вращение через transform
        loadingData.spinner.style.transform = "rotateZ(" + angle + "deg)";
        loadingData.spinner.style.transformOrigin = "50% 50%";
        
        // Переходим к следующему кадру
        currentFrame++;
        if (currentFrame > totalFrames) {
            currentFrame = 0; // Начинаем заново (infinite)
        }
        
        // Продолжаем анимацию
        $.Schedule(frameTime, animateSpinner);
    }
    
    // Запускаем анимацию
    animateSpinner();
}

/**
 * Удаляет панель загрузки по ID
 * @param {string} panelId - ID панели, полученный от ShowLoadingPanel
 * @returns {boolean} true если панель была удалена, false если не найдена
 */
DotaHUD.HideLoadingPanel = function(panelId) {
    if (!panelId || !DotaHUD.loadingPanels[panelId]) {
        return false;
    }
    
    const loadingData = DotaHUD.loadingPanels[panelId];
    
    // Останавливаем анимацию spinner (удаление из хранилища остановит анимацию)
    // Но сначала запускаем fade-out
    
    // Анимация исчезновения (fade-out) с плавным переходом
    if (loadingData.contentPanel) {
        // Настраиваем transition для плавной анимации исчезновения
        loadingData.contentPanel.style.transitionProperty = "opacity" + (loadingData.useScaleAnimation ? ", transform" : "");
        loadingData.contentPanel.style.transitionDuration = loadingData.fadeOutDuration + "s";
        loadingData.contentPanel.style.transitionTimingFunction = "ease-in";
        
        // Запускаем анимацию исчезновения
        loadingData.contentPanel.style.opacity = "0";
        if (loadingData.useScaleAnimation) {
            loadingData.contentPanel.style.transform = "scale3d(0.8, 0.8, 1)";
        }
    }
    
    // Удаляем панель после завершения анимации
    $.Schedule(loadingData.fadeOutDuration, function() {
        // Проверяем, что панель все еще существует (на случай, если была удалена другим способом)
        if (DotaHUD.loadingPanels[panelId] && loadingData.panel) {
            loadingData.panel.DeleteAsync(0);
        }
        // Удаляем из хранилища (это остановит анимацию spinner)
        delete DotaHUD.loadingPanels[panelId];
    });
    
    return true;
}


DotaHUD.ChangeIconTopButton = function(key, image_path){
    if(DotaHUD.windowControllers[key]){
		const ButtonBar = DotaHUD.Get().FindChildTraverse("ButtonBar");
		let panel = ButtonBar.FindChildTraverse(key);
		const image = panel.GetChild(0);
        if (image && image.SetImage) {
            image.SetImage(image_path);
        }
    }
}


/**
 * Создает кнопку в топ-баре (ButtonBar)
 * @param {string} imagePath - Путь к изображению кнопки
 * @param {string} buttonName - Уникальное имя кнопки (будет использовано как ID панели)
 * @param {function} onClickCallback - Функция, вызываемая при клике на кнопку
 * @param {string} tooltipText - Текст подсказки при наведении (опционально). Автоматически локализуется через $.Localize()
 * @returns {Panel} Созданная панель кнопки или существующая, если уже была создана
 */
DotaHUD.CreateTopBarButton = function(imagePath, buttonName, onClickCallback, tooltipText) {
    const ButtonBar = DotaHUD.Get().FindChildTraverse("ButtonBar");
    if (!ButtonBar) {
        $.Msg("[DotaHUD.CreateTopBarButton] ButtonBar not found");
        return null;
    }

    // Подготавливаем локализованный текст подсказки
    let localizedTooltip = null;
    if (tooltipText) {
        // Добавляем # в начало, если его нет
        const localizationKey = tooltipText.charAt(0) === '#' ? tooltipText : '#' + tooltipText;
        // Всегда локализуем
        localizedTooltip = $.Localize(localizationKey);
    }

    // Проверяем, не создана ли уже кнопка
    let panel = ButtonBar.FindChildTraverse(buttonName);
    if (panel) {
        // Кнопка уже существует, обновляем обработчики и изображение
        if (onClickCallback) {
            panel.SetPanelEvent("onmouseactivate", function() {
                Game.EmitSound("ui_custom_lobby_dialog_slide");
                onClickCallback();
            });
        }
        panel.SetPanelEvent("onmouseover", function() {
            if (localizedTooltip) {
                $.DispatchEvent("DOTAShowTextTooltip", panel, localizedTooltip);
            }
            panel.style.opacity = "1.0";
            Game.EmitSound("ui_select_arrow");
        });
        panel.SetPanelEvent("onmouseout", function() {
            if (localizedTooltip) {
                $.DispatchEvent("DOTAHideTextTooltip");
            }
            panel.style.opacity = "0.7";
        });
        if (localizedTooltip) {
            panel.style.tooltipPosition = 'bottom';
        }
        // Обновляем изображение, если оно изменилось
        const image = panel.GetChild(0);
        if (image && image.SetImage) {
            image.SetImage(imagePath);
        }
        return panel;
    }

    // Создаем панель кнопки
    panel = $.CreatePanel('Panel', ButtonBar, buttonName);
    panel.AddClass("TopBarButton");
    
    // Применяем все стили из DOTAHudMenuButtons Button с чистыми отличиями для кастомных кнопок
    panel.style.width = "30px";
    panel.style.height = "30px";
    panel.style.marginTop = "0px";
    panel.style.marginBottom = "0px";
    panel.style.marginLeft = "3px";
    panel.style.marginRight = "3px";
    panel.style.verticalAlign = "middle";
    panel.style.horizontalAlign = "center";
    panel.style.backgroundRepeat = "no-repeat";
    panel.style.backgroundSize = "100%";
    panel.style.backgroundPosition = "center";
    // Увеличиваем начальную прозрачность для более заметного отличия
    panel.style.opacity = "0.7";
    // Чистый светло-голубой оттенок для визуального отличия кастомных кнопок
    panel.style.washColor = "#E8F4FF";
    panel.style.transitionProperty = "opacity";
    panel.style.transitionDuration = "0.2s";
    panel.style.tooltipPosition = "bottom";
    
    // Создаем изображение внутри панели
    const image = $.CreatePanel('Image', panel, '');
    image.SetImage(imagePath);
    image.style.width = "100%";
    image.style.height = "100%";
    // Чистая белая тень для визуального отличия
    image.style.imgShadow = "0px 0px 4px 2 rgba(255, 255, 255, 0.3)";
    
    // Устанавливаем обработчик клика
    if (onClickCallback) {
        panel.SetPanelEvent("onmouseactivate", function() {
            Game.EmitSound("ui_custom_lobby_dialog_slide");
            onClickCallback();
        });
    }
    
    // Устанавливаем обработчики для подсказки и эффекта наведения
    panel.SetPanelEvent("onmouseover", function() {
        if (localizedTooltip) {
            $.DispatchEvent("DOTAShowTextTooltip", panel, localizedTooltip);
        }
        panel.style.opacity = "1.0";
        Game.EmitSound("ui_select_arrow");
    });
    panel.SetPanelEvent("onmouseout", function() {
        if (localizedTooltip) {
            $.DispatchEvent("DOTAHideTextTooltip");
        }
        panel.style.opacity = "0.7";
    });
    if (localizedTooltip) {
        panel.style.tooltipPosition = 'bottom';
    }
    
    return panel;
}

/**
 * Добавляет к кнопке в топ-баре (ButtonBar) callback на правую кнопку мыши (контекстное меню и т.п.)
 * @param {string} buttonName - Уникальное имя кнопки (кнопка должна быть создана ДО применения данной функции)
 * @param {function} onClickCallback - Функция, вызываемая при клике на кнопку
 */
DotaHUD.AttachRightClickToTopBarButton = function(buttonName, onClickCallback) {
    const ButtonBar = DotaHUD.Get().FindChildTraverse("ButtonBar");
    if (!ButtonBar) {
        $.Msg("[DotaHUD.AttachRightClickToTopBarButton] ButtonBar not found");
        return;
    }
	
    const panel = ButtonBar.FindChildTraverse(buttonName);
    if (!panel) {
        $.Msg(`[DotaHUD.AttachRightClickToTopBarButton] Button \`${buttonName}\` not found in ButtonBar`);
		return;
	}
	
    if (onClickCallback) {
        panel.SetPanelEvent("oncontextmenu", function() {
            Game.EmitSound("ui_custom_lobby_dialog_slide");
            onClickCallback();
        });
    }
}

/**
 * Создает панель загрузки в центре экрана
 * @param {string} text - Текст сообщения загрузки (будет локализован, если начинается с #)
 * @param {Panel|object} contextPanelOrOptions - Контекстная панель страницы ИЛИ объект options (если передается только options)
 * @param {object} options - Опциональные параметры (timeout, styles и т.д.) - используется только если contextPanelOrOptions является Panel
 * @returns {string} Уникальный ID панели загрузки
 */
DotaHUD.ShowLoadingPanel = function(text, contextPanelOrOptions, options) {
    // Инициализируем actualOptions сразу, чтобы избежать ошибок
    var actualOptions = {};
    var contextPanel = null;
    
    // Определяем, что было передано: контекстная панель или options
    // Проверяем, является ли второй параметр панелью (имеет метод GetParent)
    if (contextPanelOrOptions != null && 
        typeof contextPanelOrOptions === 'object' && 
        typeof contextPanelOrOptions.GetParent === 'function') {
        // Передана контекстная панель
        contextPanel = contextPanelOrOptions;
        if (options != null && typeof options === 'object' && typeof options.GetParent !== 'function') {
            actualOptions = options;
        }
    } else {
        // Передан только options (старый способ вызова) или ничего не передано
        if (contextPanelOrOptions != null && typeof contextPanelOrOptions === 'object' && typeof contextPanelOrOptions.GetParent !== 'function') {
            actualOptions = contextPanelOrOptions;
        }
    }
    
    // Финальная защита: убеждаемся, что actualOptions всегда объект
    if (typeof actualOptions !== 'object' || actualOptions === null || actualOptions === undefined) {
        actualOptions = {};
    }
    
    // Генерируем уникальный ID
    DotaHUD.loadingPanelCounter++;
    const panelId = "loading_panel_" + DotaHUD.loadingPanelCounter + "_" + Date.now();
    
    // Определяем родительский контейнер
    let parentContainer = null;
    if (contextPanel) {
        // Используем переданную контекстную панель
        parentContainer = contextPanel;
    } else {
        // Используем стандартный контейнер для кастомного UI (как было до этого)
        parentContainer = DOTA_HUD_ROOT.FindChildTraverse("CustomUIContainer_Hud");
        if (!parentContainer) {
            $.Msg("[DotaHUD.ShowLoadingPanel] CustomUIContainer_Hud not found");
            return null;
        }
    }
    
    // Создаем основную панель загрузки
    const loadingPanel = $.CreatePanel('Panel', parentContainer, panelId);
    
    // Позиционирование в центре экрана
    loadingPanel.style.width = "100%";
    loadingPanel.style.height = "100%";
    loadingPanel.style.horizontalAlign = "center";
    loadingPanel.style.verticalAlign = "center";
    loadingPanel.style.zIndex = "1000"; // Отображаем поверх других элементов
    
    // Создаем контейнер для содержимого (прямоугольная панель)
    const contentPanel = $.CreatePanel('Panel', loadingPanel, panelId + "_content");
    
    // Размеры и стили контейнера (компактная версия)
    const backgroundColor = actualOptions.backgroundColor || "rgba(20, 20, 20, 0.95)";
    
    // Устанавливаем размеры только если они указаны в options, иначе панель подстроится под содержимое
    if (actualOptions.width) {
        contentPanel.style.width = actualOptions.width;
    }
    if (actualOptions.height) {
        contentPanel.style.height = actualOptions.height;
    }
    contentPanel.style.horizontalAlign = "center";
    contentPanel.style.verticalAlign = "center";
    contentPanel.style.backgroundColor = backgroundColor;
    contentPanel.style.borderRadius = "6px";
    contentPanel.style.boxShadow = "0px 0px 15px 3px rgba(0, 0, 0, 0.8)";
    contentPanel.style.padding = "12px 16px";
    contentPanel.style.flowChildren = "right"; // Горизонтальное расположение для компактности
    
    // Подготавливаем локализованный текст
    let localizedText = "";
    if (text) {
        // Добавляем # в начало, если его нет
        const localizationKey = text.charAt(0) === '#' ? text : '#' + text;
        // Всегда локализуем
        localizedText = $.Localize(localizationKey);
    }
    
    // Создаем текстовый блок для сообщения загрузки
    const textLabel = $.CreatePanel('Label', contentPanel, panelId + "_text");
    textLabel.text = localizedText;
    
    // Стилизация текста (компактная версия)
    const textColor = actualOptions.textColor || "#FFFFFF";
    const fontSize = actualOptions.fontSize || "16px";
    
    textLabel.style.color = textColor;
    textLabel.style.fontSize = fontSize;
    textLabel.style.fontWeight = "bold";
    textLabel.style.textAlign = "left";
    textLabel.style.horizontalAlign = "left";
    textLabel.style.verticalAlign = "center";
    textLabel.style.marginRight = "12px"; // Отступ между текстом и спиннером
    
    // Создаем крутящийся кружок (spinner) в стиле Dota 2 (компактная версия)
    const spinner = $.CreatePanel('Panel', contentPanel, panelId + "_spinner");
    const spinnerSize = actualOptions.spinnerSize || "24px";
    
    // Применяем все стили из .Spinner класса Dota 2
    spinner.style.width = spinnerSize;
    spinner.style.height = spinnerSize;
    spinner.style.horizontalAlign = "center";
    spinner.style.verticalAlign = "center";
    spinner.style.backgroundImage = 'url("s2r://panorama/images/status_icons/loadingthrobber_round_psd.vtex")';
    spinner.style.backgroundRepeat = "no-repeat";
    spinner.style.backgroundPosition = "50% 50%";
    spinner.style.backgroundSize = "contain";
    
    // Параметры анимации появления
    const fadeInDuration = actualOptions.fadeInDuration || 0.3;
    const fadeOutDuration = actualOptions.fadeOutDuration || 0.3;
    const useScaleAnimation = actualOptions.useScaleAnimation !== false; // По умолчанию включено
    
    // Начальное состояние для анимации появления
    contentPanel.style.opacity = "0";
    if (useScaleAnimation) {
        contentPanel.style.transform = "scale3d(0.8, 0.8, 1)";
        contentPanel.style.transformOrigin = "50% 50%";
    }
    
    // Сохраняем панель в хранилище
    DotaHUD.loadingPanels[panelId] = {
        panel: loadingPanel,
        contentPanel: contentPanel,
        spinner: spinner,
        textLabel: textLabel,
        text: text,
        options: actualOptions,
        rotationAngle: 0, // Текущий угол вращения
        fadeInDuration: fadeInDuration,
        fadeOutDuration: fadeOutDuration,
        useScaleAnimation: useScaleAnimation
    };
    
    // Запускаем анимацию вращения spinner
    DotaHUD.StartSpinnerAnimation(panelId);
    
    // Анимация появления (fade-in) с плавным переходом
    $.Schedule(0.01, function() {
        const panelData = DotaHUD.loadingPanels[panelId];
        if (!panelData || !panelData.contentPanel) {
            return;
        }
        
        // Настраиваем transition для плавной анимации
        panelData.contentPanel.style.transitionProperty = "opacity" + (panelData.useScaleAnimation ? ", transform" : "");
        panelData.contentPanel.style.transitionDuration = panelData.fadeInDuration + "s";
        panelData.contentPanel.style.transitionTimingFunction = "ease-out";
        
        // Запускаем анимацию
        panelData.contentPanel.style.opacity = "1";
        if (panelData.useScaleAnimation) {
            panelData.contentPanel.style.transform = "scale3d(1, 1, 1)";
        }
    });
    
    return panelId;
}

/**
 * Запускает анимацию вращения spinner для панели загрузки
 * Имитирует @keyframes SpinnerRotate с animation-direction: reverse
 * @param {string} panelId - ID панели загрузки
 */
DotaHUD.StartSpinnerAnimation = function(panelId) {
    const loadingData = DotaHUD.loadingPanels[panelId];
    if (!loadingData || !loadingData.spinner) {
        return;
    }
    
    // Параметры анимации из .Spinner класса Dota 2
    const animationDuration = 1.0; // 1.0s
    const frameRate = 60; // ~60 FPS
    const frameTime = 1.0 / frameRate; // Время одного кадра
    const totalFrames = Math.floor(animationDuration * frameRate);
    
    // Значения из @keyframes SpinnerRotate (в reverse направлении: от 100% к 0%)
    // 100% -> 0.1deg, 50% -> 180deg, 0% -> 359.9deg
    const startAngle = 0.1; // 100% keyframe
    const midAngle = 180.0; // 50% keyframe
    const endAngle = 359.9; // 0% keyframe
    
    let currentFrame = 0;
    loadingData.rotationAngle = startAngle;
    
    function animateSpinner() {
        if (!DotaHUD.loadingPanels[panelId] || !DotaHUD.loadingPanels[panelId].spinner) {
            return; // Панель была удалена
        }
        
        // Вычисляем текущий угол на основе прогресса анимации
        const progress = currentFrame / totalFrames;
        let angle;
        
        if (progress <= 0.5) {
            // Первая половина: от 0.1deg к 180deg
            const localProgress = progress * 2; // 0.0 -> 1.0
            angle = startAngle + (midAngle - startAngle) * localProgress;
        } else {
            // Вторая половина: от 180deg к 359.9deg
            const localProgress = (progress - 0.5) * 2; // 0.0 -> 1.0
            angle = midAngle + (endAngle - midAngle) * localProgress;
        }
        
        // Применяем вращение через transform
        loadingData.spinner.style.transform = "rotateZ(" + angle + "deg)";
        loadingData.spinner.style.transformOrigin = "50% 50%";
        
        // Переходим к следующему кадру
        currentFrame++;
        if (currentFrame > totalFrames) {
            currentFrame = 0; // Начинаем заново (infinite)
        }
        
        // Продолжаем анимацию
        $.Schedule(frameTime, animateSpinner);
    }
    
    // Запускаем анимацию
    animateSpinner();
}

/**
 * Удаляет панель загрузки по ID
 * @param {string} panelId - ID панели, полученный от ShowLoadingPanel
 * @returns {boolean} true если панель была удалена, false если не найдена
 */
DotaHUD.HideLoadingPanel = function(panelId) {
    if (!panelId || !DotaHUD.loadingPanels[panelId]) {
        return false;
    }
    
    const loadingData = DotaHUD.loadingPanels[panelId];
    
    // Останавливаем анимацию spinner (удаление из хранилища остановит анимацию)
    // Но сначала запускаем fade-out
    
    // Анимация исчезновения (fade-out) с плавным переходом
    if (loadingData.contentPanel) {
        // Настраиваем transition для плавной анимации исчезновения
        loadingData.contentPanel.style.transitionProperty = "opacity" + (loadingData.useScaleAnimation ? ", transform" : "");
        loadingData.contentPanel.style.transitionDuration = loadingData.fadeOutDuration + "s";
        loadingData.contentPanel.style.transitionTimingFunction = "ease-in";
        
        // Запускаем анимацию исчезновения
        loadingData.contentPanel.style.opacity = "0";
        if (loadingData.useScaleAnimation) {
            loadingData.contentPanel.style.transform = "scale3d(0.8, 0.8, 1)";
        }
    }
    
    // Удаляем панель после завершения анимации
    $.Schedule(loadingData.fadeOutDuration, function() {
        // Проверяем, что панель все еще существует (на случай, если была удалена другим способом)
        if (DotaHUD.loadingPanels[panelId] && loadingData.panel) {
            loadingData.panel.DeleteAsync(0);
        }
        // Удаляем из хранилища (это остановит анимацию spinner)
        delete DotaHUD.loadingPanels[panelId];
    });
    
    return true;
}

GameUI.CustomUIConfig().DotaHUD = DotaHUD;

function RegisterKeyBind(name, callback) {
    if (Game.Events[name] == null) {
      RegisterKeyBindHandler(name);
      var key = GetKeyBind(name);
      if (key !== '') Game.CreateCustomKeyBind(key, GetCommandName(name));
    }
  
    Game.Events[name][callback.name] = callback;
}
  
GameUI.CustomUIConfig().RegisterKeyBind = RegisterKeyBind;


GameUI.parseInt = function (num, radix, mr) {
    num = parseInt(num, radix);
    if (isNaN(num)) {
        if (mr != undefined) {
            num = mr;
        } else {
            num = 0;
        }
    }
    return num;
};


function SetClasses()
{
    DOTA_HUD_ROOT.SetHasClass("ShopOpened", Game.IsShopOpen());
    DOTA_HUD_ROOT.SetHasClass("AltPressed", GameUI.IsAltDown());
    DOTA_HUD_ROOT.SetHasClass("CtrlPressed", GameUI.IsControlDown());
    DOTA_HUD_ROOT.SetHasClass("ShiftPressed", GameUI.IsShiftDown());
    DOTA_HUD_ROOT.SetHasClass("IsToolsMode", Game.IsInToolsMode());

    let selectedUnit = Players.GetLocalPlayerPortraitUnit();
    DOTA_HUD_ROOT.SetHasClass("NonHero", !Entities.IsHero(selectedUnit));
    $.Schedule(0.05, SetClasses);
}

function HideModifiersBar() {
    let BuffContainer = DOTA_HUD_ROOT.FindChildTraverse("BuffContainer")

    if (BuffContainer) {
        BuffContainer.style.marginLeft = "0px"
        BuffContainer.style.marginBottom = "0px"
        BuffContainer.style.width = "100%"

        BuffContainer.style.marginBottom = "30px"

        let buffsContainer = DOTA_HUD_ROOT.FindChildTraverse("buffs")
        if (buffsContainer) {
            buffsContainer.style.visibility = "collapse";

            if (!buffsContainer._customBuffsContainer) {
                let buffsContainerParent = buffsContainer.GetParent();

                let customBuffsContainer = $.CreatePanel('Panel', buffsContainerParent, '');
                customBuffsContainer.SetHasClass("customBuffs", true);
                customBuffsContainer.BLoadLayout('file://{resources}/layout/custom_game/hud/dota_hud_buff_list.xml', false, false);
                buffsContainerParent.MoveChildAfter(customBuffsContainer, buffsContainer);

                buffsContainer._customBuffsContainer = customBuffsContainer;
            }
        } else {
            $.Msg("Valve break something or did major changes to UI (can't find buffs container).");
        }

        let debuffsContainer = DOTA_HUD_ROOT.FindChildTraverse("debuffs");
        if (debuffsContainer) {
            debuffsContainer.style.visibility = "collapse";

            if (!debuffsContainer._customDebuffsContainer) {
                let debuffsContainerParent = debuffsContainer.GetParent();

                let customDebuffsContainer = $.CreatePanel('Panel', debuffsContainerParent, '');
                customDebuffsContainer.SetHasClass("customDebuffs", true);
                customDebuffsContainer.BLoadLayout('file://{resources}/layout/custom_game/hud/dota_hud_buff_list.xml', false, false);
                debuffsContainerParent.MoveChildAfter(customDebuffsContainer, debuffsContainer);

                debuffsContainer._customDebuffsContainer = customDebuffsContainer;
            }
        } else {
            $.Msg("Valve break something or did major changes to UI (can't find debuffs container).");
        }
    }
}

function GetLocalPlayerSelectedUnit() {
	let selectedUnit = Players.GetQueryUnit(Game.GetLocalPlayerID())
	if (selectedUnit < 0) {
		selectedUnit = Players.GetLocalPlayerPortraitUnit()
	}
	return selectedUnit;
}

function FixNeutralItemSlot() {
    const neutral = DOTA_HUD_ROOT.FindChildTraverse("inventory_neutral_slot")
    neutral.SetPanelEvent('onmouseover', function(){
        $.DispatchEvent("DOTAShowAbilityInventoryItemTooltip", neutral, GetLocalPlayerSelectedUnit(), 16)
    })
    neutral.SetPanelEvent('onmouseout', function(){
        $.DispatchEvent('DOTAHideAbilityTooltip')
    })
}

function FindDotaHudElement(panel) {
	return $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse(panel);
}

(function() {

    let pShop = FindDotaHudElement("GridBasicItems");
    pShop.RemoveAndDeleteChildren();

    let pShop2 = FindDotaHudElement("GridUpgradeItems");
    pShop2.RemoveAndDeleteChildren();


	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false)
	
    GameEvents.Subscribe('mountain_dota_hud_show_hud_error', function(data) {
        DotaHUD.ShowError(data.message);
    });
    GameEvents.Subscribe('EmitSoundPanorama', (data)=>{
        Game.EmitSound(data.sound);
    });

    GameUI.SetMouseCallback(function(eventType, clickBehavior) {
        FireMouseEvent(eventType, clickBehavior);
        return false;
    });

	SetClasses();

	HideModifiersBar();
	FixNeutralItemSlot()
})();