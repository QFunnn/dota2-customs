--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * Движок визуализации спинов для слот-машины
 */

"use strict";

// Константы
var STARTING_SPEED = 6000;
var DROP_SLOT = 50;
var SOUND_TICK_WIDTH = 160;
var SLOT_STOP_DELAY = 0;
var SLOWING_DISTANCE_RATIO = 0.25;
var SLOT_ANIMATIONS = ["SlotAnimation1", "SlotAnimation2", "SlotAnimation3"];
var SLOT_CARDS = ["SlotCard1", "SlotCard2", "SlotCard3"];

// Список предметов для филерных слотов
var FILLER_ITEMS = [
    "item_treasure_1",      "item_treasure_2",      "item_treasure_3",      "item_treasure_4",      "item_treasure_5",
    "item_armor_aura",      "item_base_damage_aura","item_expiriance_aura", "item_move_aura",       "item_attack_speed_aura",
    "item_hp_aura",         "item_cd_aura",         "item_lifesteal_aura",  "item_spell_aura",      "item_gold_aura",
    "item_bkb_flask",       "item_krest",           "item_str_atribute",    "item_agi_atribute",    "item_int_atribute",
    "item_chest_d",         "item_ticket2",         "item_mp_bag",          "item_health_bag",      "item_book_of_knowledge",
    "item_dado_stone",      "item_triss_stone",     "item_destroyer_stone", "item_mana_plate",      "item_heavy_shield",
    "item_heavy_plate",     "item_life_catcher",    "item_immune_mask",     "item_grave_shoulder",  "item_armor_of_god",
    "item_bloody_knife",    "item_winter_cloak",    "item_hell_blade",      "item_talisman_of_evasion_lua", "item_blasting_shot",
    "item_doom_sword",      "item_doom_spear",      "item_gu",              "item_magic_boots",     "item_magic_amulet",
    "item_magic_soul",      "item_critical_ring",   "item_dark_mist",       "item_god_tribute",     "item_block_shield",
    "item_power_pendant",   "item_dark_stick",      "item_physical_immune", "item_crit_blade",      "item_des_blade",
    "item_universal_lua"
];

// Состояние
var DROP_POS = {};
var g_IsSpinning = false;

// Утилиты
function objectToArray(obj) {
    if (!obj) return [];
    if (Array.isArray(obj)) return obj;
    var arr = [];
    for (var key in obj) {
        if (obj.hasOwnProperty(key)) {
            var index = parseInt(key);
            if (!isNaN(index)) arr[index - 1] = obj[key];
        }
    }
    return arr;
}

function formatItemName(itemName) {
    if (!itemName) return "Item";
    
    // Получаем локализованное название
    var localizedKey = "#DOTA_Tooltip_ability_" + itemName;
    var localizedText = $.Localize(localizedKey);
    
    // Если локализация найдена и отличается от ключа, используем её
    if (localizedText && localizedText !== localizedKey) {
        // Сокращаем до 15 символов, если длина больше 20 символов
        if (localizedText.length > 16) {
            return localizedText.substring(0, 12) + "..";
        }
        return localizedText;
    }
    
    // Fallback: форматируем имя из item_* в читаемый вид
    var formattedName;
    if (itemName.indexOf("item_") === 0) {
        formattedName = itemName.substring(5).split("_").map(function(word) {
            return word.charAt(0).toUpperCase() + word.slice(1);
        }).join(" ");
    } else {
        formattedName = itemName;
    }
    
    // Сокращаем до 15 символов, если длина больше 20 символов
    if (formattedName.length > 20) {
        return formattedName.substring(0, 15) + "..";
    }
    
    return formattedName;
}

function getSlotPanel(root, slotIndex, type) {
    return root.FindChildTraverse((type === "card" ? SLOT_CARDS : SLOT_ANIMATIONS)[slotIndex]);
}

// Управление слотами
function clearSlot(root, slotIndex) {
    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (animContainer) {
        animContainer.RemoveAndDeleteChildren();
        animContainer.style.position = "0px 0px 0px";
    }
    var slotCard = getSlotPanel(root, slotIndex, "card");
    if (slotCard) {
        var classesToRemove = ["spinning", "stopped-1", "stopped-2", "winning", "stopped", "slowing", "hovering", "anticipation"];
        for (var i = 0; i < classesToRemove.length; i++) {
            slotCard.RemoveClass(classesToRemove[i]);
        }
    }
}

function clearAllSlots(root) {
    for (var i = 0; i < 3; i++) {
        clearSlot(root, i);
    }
}

function createSlotItem(animContainer, index, itemName, isFinalItem) {
    var itemWrapper = $.CreatePanel("Panel", animContainer, isFinalItem ? "dropped_item" : "SlotFillerWrapper_" + index);
    itemWrapper.AddClass("slot-item-wrapper");

    var itemPanel = $.CreatePanel("DOTAItemImage", itemWrapper, isFinalItem ? "SlotItem1" : "SlotFiller_" + index);
    itemPanel.AddClass("slot-item");
    itemPanel.AddClass(isFinalItem ? "slot-item-main" : "slot-item-filler");
    itemPanel.itemname = itemName;

    var itemLabel = $.CreatePanel("Label", itemWrapper, isFinalItem ? "SlotItemLabel1" : "SlotFillerLabel_" + index);
    itemLabel.AddClass("slot-item-label");
    itemLabel.html = true;
    itemLabel.text = formatItemName(itemName);
    if (!isFinalItem) itemLabel.AddClass("slot-item-label-filler");
}

function updateSlotItem(itemWrapper, itemName, isFinalItem, index) {
    if (!itemWrapper) return;
    
    // Обновляем ID панели, если это выигрышный предмет
    if (isFinalItem && itemWrapper.id !== "dropped_item") {
        itemWrapper.id = "dropped_item";
    } else if (!isFinalItem && itemWrapper.id === "dropped_item") {
        itemWrapper.id = "SlotFillerWrapper_" + index;
    }
    
    // Находим панель изображения
    var itemPanel = null;
    var childCount = itemWrapper.GetChildCount();
    for (var i = 0; i < childCount; i++) {
        var child = itemWrapper.GetChild(i);
        if (child && child.BHasClass("slot-item")) {
            itemPanel = child;
            break;
        }
    }
    
    if (itemPanel) {
        // Обновляем ID панели изображения
        if (isFinalItem) {
            itemPanel.id = "SlotItem1";
            itemPanel.RemoveClass("slot-item-filler");
            itemPanel.AddClass("slot-item-main");
        } else {
            itemPanel.id = "SlotFiller_" + index;
            itemPanel.RemoveClass("slot-item-main");
            itemPanel.AddClass("slot-item-filler");
        }
        itemPanel.itemname = itemName;
    }
    
    // Находим и обновляем текст
    var itemLabel = null;
    for (var i = 0; i < childCount; i++) {
        var child = itemWrapper.GetChild(i);
        if (child && child.BHasClass("slot-item-label")) {
            itemLabel = child;
            break;
        }
    }
    
    if (itemLabel) {
        // Обновляем ID метки
        if (isFinalItem) {
            itemLabel.id = "SlotItemLabel1";
            itemLabel.RemoveClass("slot-item-label-filler");
        } else {
            itemLabel.id = "SlotFillerLabel_" + index;
            itemLabel.AddClass("slot-item-label-filler");
        }
        itemLabel.text = formatItemName(itemName);
    }
}

function getRandomFillerItem() {
    if (FILLER_ITEMS.length === 0) {
        return "item_bkb_flask";
    }
    return FILLER_ITEMS[Math.floor(Math.random() * FILLER_ITEMS.length)];
}

function getFillerItem(fillerItems, index) {
    if (index < fillerItems.length && fillerItems[index]) {
        return fillerItems[index];
    }
    if (fillerItems.length > 0) {
        return fillerItems[Math.floor(Math.random() * fillerItems.length)] || getRandomFillerItem();
    }
    return getRandomFillerItem();
}

function getPanelHeight(panel) {
    if (!panel) return 0;
    if (panel.actuallayoutheight !== undefined && panel.actualuiscale_y !== undefined && panel.actualuiscale_y > 0) {
        return panel.actuallayoutheight / panel.actualuiscale_y;
    }
    if (panel.actuallayoutheight !== undefined && panel.actuallayoutheight > 0) {
        return panel.actuallayoutheight;
    }
    return 0;
}

function getDefaultHeightWithScale(defaultHeight) {
    var root = $.GetContextPanel();
    if (root && root.actualuiscale_y && root.actualuiscale_y > 0) {
        return defaultHeight / root.actualuiscale_y;
    }
    return defaultHeight;
}

function calculateSpinSettings(totalDuration, slowdownDuration, actualWrapperHeight, speedMultiplier) {
    speedMultiplier = speedMultiplier || 1;
    
    // Количество предметов рассчитывается на основе БАЗОВОЙ скорости, без учета множителя
    // Множитель скорости влияет только на скорость движения, а не на количество предметов
    var dropSlot = 1;
    var constantSpeedDuration = totalDuration - slowdownDuration;
    var distanceConstant = STARTING_SPEED * constantSpeedDuration;
    var distanceSlowdown = STARTING_SPEED * slowdownDuration * 0.6;
    var totalDistance = distanceConstant + distanceSlowdown;
    var itemsNeeded = Math.ceil(totalDistance / actualWrapperHeight) + 5;
    var slowingDistanceRatio = distanceSlowdown / totalDistance;
    var slowdownFactor = 3 / slowdownDuration;
    
    return {
        dropSlot: dropSlot,
        totalItems: itemsNeeded,
        totalDistance: totalDistance,
        slowingDistanceRatio: slowingDistanceRatio,
        slowdownFactor: slowdownFactor,
        constantSpeedDuration: constantSpeedDuration,
        slowdownDuration: slowdownDuration,
        speedMultiplier: speedMultiplier
    };
}

function calculateDropPosition(root, slotIndex, dropSlot, wrapperHeight, totalItems) {
    if (!DROP_POS[slotIndex]) DROP_POS[slotIndex] = [0, 0];

    var slotCard = getSlotPanel(root, slotIndex, "card");
    var animContainer = getSlotPanel(root, slotIndex, "anim");
    
    if (!slotCard || !animContainer) {
        DROP_POS[slotIndex] = [0, 0];
        return;
    }

    var containerHeight = getPanelHeight(slotCard) || getDefaultHeightWithScale(320);
    var droppedItem = animContainer.FindChildTraverse("dropped_item");
    
    var actualWrapperHeight = wrapperHeight;
    if (!actualWrapperHeight || actualWrapperHeight <= 0) {
        if (droppedItem) {
            actualWrapperHeight = getPanelHeight(droppedItem);
        }
        if (!actualWrapperHeight || actualWrapperHeight <= 0) {
            actualWrapperHeight = getDefaultHeightWithScale(160);
        }
    }
    
    var itemHeight = 100;
    if (droppedItem) {
        var itemImage = droppedItem.FindChildTraverse("SlotItem1");
        if (itemImage) {
            itemHeight = getPanelHeight(itemImage) || getDefaultHeightWithScale(100);
        }
    }

    var winningItemTopY = dropSlot * actualWrapperHeight;
    var winningItemCenterY = winningItemTopY + (itemHeight / 2);
    var containerCenterY = containerHeight / 2;
    var targetY = containerCenterY - winningItemCenterY;
    
    var lastItemIndex = (totalItems || 100) - 1;
    var lastItemTopY = lastItemIndex * actualWrapperHeight;
    var lastItemCenterY = lastItemTopY + (itemHeight / 2);
    var startY = containerCenterY - lastItemCenterY;

    DROP_POS[slotIndex][0] = startY;
    DROP_POS[slotIndex][1] = targetY;
}

function initItemsInSlot(root, slotIndex, fillerItems, finalItem, dropSlot, totalItems, onReady) {
    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (!animContainer) {
        if (onReady) onReady(slotIndex);
        return;
    }

    // Скрываем контейнер во время создания предметов
    animContainer.style.visibility = "collapse";
    animContainer.style.opacity = "0";

    if (!Array.isArray(fillerItems)) fillerItems = [];
    var currentDropSlot = (dropSlot !== undefined && dropSlot !== null) ? dropSlot : DROP_SLOT;
    var itemsCount = totalItems || Math.max(100, fillerItems.length + 20);

    // Получаем существующие панели из контейнера для переиспользования
    var existingPanels = [];
    var childCount = animContainer.GetChildCount();
    for (var i = 0; i < childCount; i++) {
        var child = animContainer.GetChild(i);
        if (child && child.BHasClass("slot-item-wrapper")) {
            existingPanels.push(child);
        }
    }

    // Переиспользуем существующие панели или создаем новые
    for (var i = 0; i < itemsCount; i++) {
        var isFinalItem = (i === currentDropSlot);
        var itemName = isFinalItem ? finalItem : getFillerItem(fillerItems, i);
        
        if (i < existingPanels.length) {
            // Переиспользуем существующую панель, обновляя данные
            updateSlotItem(existingPanels[i], itemName, isFinalItem, i);
        } else {
            // Создаем новую панель
            createSlotItem(animContainer, i, itemName, isFinalItem);
        }
    }

    // Удаляем лишние панели, если их больше чем нужно
    if (existingPanels.length > itemsCount) {
        for (var i = itemsCount; i < existingPanels.length; i++) {
            var panel = existingPanels[i];
            if (panel && panel.IsValid()) {
                panel.DeleteAsync(0);
            }
        }
    }

    var retryCount = 0;
    var maxRetries = 5;
    
    function tryCalculatePosition() {
        var droppedItem = animContainer.FindChildTraverse("dropped_item");
        var wrapperHeight = getDefaultHeightWithScale(160);
        
        if (droppedItem) {
            var heightFromDOM = getPanelHeight(droppedItem);
            if (heightFromDOM > 0) {
                wrapperHeight = heightFromDOM;
            } else if (retryCount < maxRetries) {
                retryCount++;
                GameUI.LoopTime.Schedule(0.05, tryCalculatePosition);
                return;
            }
        } else if (retryCount < maxRetries) {
            retryCount++;
            GameUI.LoopTime.Schedule(0.05, tryCalculatePosition);
            return;
        }
        
        calculateDropPosition(root, slotIndex, currentDropSlot, wrapperHeight, itemsCount);
        
        // Вызываем колбэк готовности
        if (onReady && typeof onReady === 'function') {
            onReady(slotIndex);
        }
    }
    
    // Запускаем расчет позиций сразу, без задержки
    tryCalculatePosition();
}

// Анимация
function handleSlotStop(root, slotIndex, stopPosition, onSlotStopped) {
    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (animContainer) animContainer.style.position = "0px " + stopPosition + "px 0px";

    var slotCard = getSlotPanel(root, slotIndex, "card");
    if (slotCard) {
        var classesToRemove = ["spinning", "slowing-1", "slowing-2", "slowing-3", "hovering", "slowing"];
        for (var i = 0; i < classesToRemove.length; i++) {
            slotCard.RemoveClass(classesToRemove[i]);
        }
        slotCard.AddClass("stopped");
        slotCard.AddClass("slot-stopped-flash");
        createStopParticles(root, slotIndex, slotCard);
        GameUI.LoopTime.Schedule(0.3, function() {
            if (slotCard) slotCard.RemoveClass("slot-stopped-flash");
        });
    }

    Game.EmitSound("ui_generic_button_click");
    if (onSlotStopped) onSlotStopped(slotIndex);
}

function animateSlot(root, slotIndex, currentY, dropDistance, speed, soundTick, finalTargetY, slowingDistanceRatio, isSpinningCallback, onSlotStopped, elapsedTime, constantSpeedDuration, slowdownFactor, totalDuration, speedMultiplier) {
    if (isSpinningCallback && typeof isSpinningCallback === 'function' && !isSpinningCallback()) return;

    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (!animContainer) return;

    var startY = DROP_POS[slotIndex][0];
    var originalTargetY = finalTargetY || DROP_POS[slotIndex][1];
    var targetStopY = originalTargetY;
    var distanceToStop = targetStopY - currentY;
    var frameTime = Game.GetGameFrameTime();
    elapsedTime = (elapsedTime || 0) + frameTime;

    speedMultiplier = speedMultiplier || 1;
    var MIN_SPEED = 25 * speedMultiplier;
    var isConstantSpeedPhase = constantSpeedDuration > 0 && elapsedTime < constantSpeedDuration;

    // Проверяем, не прошли ли мы уже цель (движемся в неправильном направлении)
    // Если startY < targetY (анимация идет вниз), то currentY должен быть <= targetY
    // Если startY > targetY (анимация идет вверх), то currentY должен быть >= targetY
    var isMovingDown = startY < targetStopY;
    var hasPassedTarget = isMovingDown ? (currentY > targetStopY) : (currentY < targetStopY);
    
    // Проверяем, не истекло ли время анимации
    var timeExpired = totalDuration && elapsedTime >= totalDuration;
    
    if (hasPassedTarget || timeExpired) {
        // Мы прошли цель или время истекло, останавливаемся немедленно
        speed = 0;
        currentY = targetStopY;
        handleSlotStop(root, slotIndex, originalTargetY, onSlotStopped);
        return;
    }

    if (!isConstantSpeedPhase && speed > MIN_SPEED && distanceToStop > 0) {
        var remainingTime = totalDuration ? (totalDuration - elapsedTime) : 0;
        
        if (totalDuration && remainingTime > 0 && distanceToStop > 0) {
            var requiredSpeed = distanceToStop / remainingTime;
            
            if (distanceToStop > 30) {
                requiredSpeed = Math.max(MIN_SPEED, requiredSpeed);
            } else {
                requiredSpeed = Math.max(0, requiredSpeed);
            }
            
            var speedDiff = speed - requiredSpeed;
            if (speedDiff > 0) {
                var deceleration = Math.min(speedDiff / remainingTime, 3000);
                speed = speed - deceleration * frameTime;
            }
            
            if (distanceToStop > 30) {
                speed = Math.max(MIN_SPEED, speed);
            }
            
            var slotCard = getSlotPanel(root, slotIndex, "card");
            if (slotCard && !slotCard.BHasClass("slowing")) slotCard.AddClass("slowing");
        } else if (distanceToStop > 0) {
            // Замедляемся, если не используем totalDuration
            var decelerationRate = 2000;
            speed = speed - decelerationRate * frameTime;
            speed = Math.max(MIN_SPEED, speed);
            
            var slotCard = getSlotPanel(root, slotIndex, "card");
            if (slotCard && !slotCard.BHasClass("slowing")) slotCard.AddClass("slowing");
        }
    }

    var nextY = currentY + speed * frameTime;
    
    // Проверяем, не пройдем ли мы цель на следующем шаге
    var willPassTarget = isMovingDown ? (nextY > targetStopY) : (nextY < targetStopY);
    
    // Если время истекло или мы близко к цели, останавливаемся
    if (timeExpired || willPassTarget || (Math.abs(distanceToStop) <= 10)) {
        speed = 0;
        currentY = targetStopY;
        handleSlotStop(root, slotIndex, originalTargetY, onSlotStopped);
        return;
    }
    
    if (distanceToStop > 10 && distanceToStop <= 30) {
        var safeSpeed = distanceToStop / (frameTime * 1.5);
        if (speed > safeSpeed) {
            speed = safeSpeed;
        }
        nextY = currentY + speed * frameTime;
        // Проверяем еще раз после корректировки скорости
        willPassTarget = isMovingDown ? (nextY > targetStopY) : (nextY < targetStopY);
        if (willPassTarget) {
            nextY = targetStopY;
            speed = 0;
        }
    }
    
    currentY = nextY;
    
    // Финальная проверка после обновления позиции
    hasPassedTarget = isMovingDown ? (currentY > targetStopY) : (currentY < targetStopY);
    timeExpired = totalDuration && elapsedTime >= totalDuration;
    if (hasPassedTarget || timeExpired || Math.abs(currentY - targetStopY) < 1) {
        currentY = targetStopY;
        handleSlotStop(root, slotIndex, originalTargetY, onSlotStopped);
        return;
    }
    
    soundTick -= speed * frameTime;
    if (soundTick <= 0) {
        soundTick = SOUND_TICK_WIDTH;
        Game.EmitSound("ui_generic_button_click");
    }

    speed = Math.max(0, speed);

    animContainer.style.position = "0px " + currentY + "px 0px";
    GameUI.LoopTime.Schedule(frameTime, function() {
        animateSlot(root, slotIndex, currentY, dropDistance, speed, soundTick, finalTargetY, null, isSpinningCallback, onSlotStopped, elapsedTime, constantSpeedDuration, null, totalDuration, speedMultiplier);
    });
}

function startSlotAnimation(root, slotIndex, animationSettings, isSpinningCallback, onSlotStopped) {
    if (isSpinningCallback && typeof isSpinningCallback === 'function' && !isSpinningCallback()) return;

    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (!animContainer) return;

    if (!DROP_POS[slotIndex] || DROP_POS[slotIndex][1] === undefined) {
        // Если позиции еще не готовы, ждем минимальное время
        GameUI.LoopTime.Schedule(0.01, function() {
            startSlotAnimation(root, slotIndex, animationSettings, isSpinningCallback, onSlotStopped);
        });
        return;
    }

    var settings = animationSettings || {};
    var startingSpeed = settings.startingSpeed !== undefined ? settings.startingSpeed : STARTING_SPEED;
    var stopDelay = settings.stopDelay !== undefined ? settings.stopDelay : SLOT_STOP_DELAY;
    var constantSpeedDuration = settings.constantSpeedDuration !== undefined ? settings.constantSpeedDuration : 0;
    var totalDuration = settings.totalDuration !== undefined ? settings.totalDuration : undefined;
    // Вычисляем множитель скорости для масштабирования MIN_SPEED
    var speedMultiplier = startingSpeed / STARTING_SPEED;

    var slotCard = getSlotPanel(root, slotIndex, "card");
    if (slotCard) slotCard.AddClass("spinning");

    var targetY = DROP_POS[slotIndex][1];
    var startY = DROP_POS[slotIndex][0];
    var adjustedDropDistance = targetY;

    if (stopDelay > 0) {
        var extraDistance = startingSpeed * stopDelay * 0.6;
        adjustedDropDistance = targetY + extraDistance;
        if (adjustedDropDistance <= startY) {
            adjustedDropDistance = startY + (Math.abs(DROP_POS[slotIndex][0] - DROP_POS[slotIndex][1]) / 10 || 160);
        }
    }
    if (startY >= adjustedDropDistance) {
        startY = adjustedDropDistance - 1600;
        DROP_POS[slotIndex][0] = startY;
    }

    // Устанавливаем начальную позицию и показываем контейнер перед запуском анимации
    if (animContainer) {
        animContainer.style.position = "0px " + startY + "px 0px";
        animContainer.style.visibility = "visible";
        animContainer.style.opacity = "1";
    }

    animateSlot(root, slotIndex, startY, adjustedDropDistance, startingSpeed, SOUND_TICK_WIDTH, targetY, null, isSpinningCallback, onSlotStopped, 0, constantSpeedDuration, null, totalDuration, speedMultiplier);
}

// Частицы
function createStopParticles(root, slotIndex, slotCard) {
    if (!slotCard) return;

    var particlesContainer = slotCard.FindChildTraverse("ParticlesContainer");
    if (!particlesContainer) {
        particlesContainer = $.CreatePanel("Panel", slotCard, "ParticlesContainer");
        particlesContainer.AddClass("particles-container");
    }

    for (var i = 0; i < 10; i++) {
        var particle = $.CreatePanel("Panel", particlesContainer, "Particle_" + slotIndex + "_" + i);
        particle.AddClass("particle");
        particle.AddClass("particle-gold");

        var angle = (360 / 10) * i + (Math.random() * 20 - 10);
        var distance = 60 + Math.random() * 40;
        var startX = Math.cos(angle * Math.PI / 180) * distance;
        var startY = Math.sin(angle * Math.PI / 180) * distance;

        particle.style.position = startX + "px " + startY + "px 0px";
        var duration = 0.8 + Math.random() * 0.4;
        particle.AddClass("particle-animating");
        GameUI.LoopTime.Schedule(duration + (i * 0.05), function(p) {
            return function() {
                if (p && p.IsValid()) p.DeleteAsync(0);
            };
        }(particle));
    }
}

// Публичные функции
function startSpinAnimation(root, slotIndex, spinData, isSpinningCallback, onSpinComplete) {
    if (!root || slotIndex === undefined || slotIndex < 0 || slotIndex > 2) return;
    if (!spinData || !spinData.item) return;

    clearSlot(root, slotIndex);
    if (!g_IsSpinning) g_IsSpinning = true;

    var fillerItems = spinData.fillerItems ? objectToArray(spinData.fillerItems) : null;
    var animationSettings = spinData.animationSettings || null;
    var dropSlot = spinData.dropSlot;
    var duration = spinData.duration;

    if (duration !== undefined && duration !== null) {
        var slowdownDuration = duration * 0.4;
        var defaultWrapperHeight = getDefaultHeightWithScale(160);
        var speedMultiplier = spinData.speed || 1;
        var spinSettings = calculateSpinSettings(duration, slowdownDuration, defaultWrapperHeight, speedMultiplier);
        dropSlot = spinSettings.dropSlot;
        // При увеличении скорости, фактическое время анимации уменьшается пропорционально
        // Если скорость x2, то время должно быть в 2 раза меньше для того же расстояния
        animationSettings = {
            startingSpeed: STARTING_SPEED * speedMultiplier,
            stopDelay: 0,
            constantSpeedDuration: spinSettings.constantSpeedDuration / speedMultiplier,
            totalDuration: duration / speedMultiplier
        };
        
        initItemsInSlot(root, slotIndex, fillerItems, spinData.item, dropSlot, spinSettings.totalItems, null);
    } else {
        var speedMultiplier = spinData.speed || 1;
        if (animationSettings) {
            animationSettings.startingSpeed = (animationSettings.startingSpeed || STARTING_SPEED) * speedMultiplier;
        } else {
            animationSettings = {
                startingSpeed: STARTING_SPEED * speedMultiplier,
                stopDelay: 0
            };
        }
        initItemsInSlot(root, slotIndex, fillerItems, spinData.item, dropSlot, null, null);
    }

    var checkSpinning = isSpinningCallback;
    if (!checkSpinning || typeof checkSpinning !== 'function') {
        checkSpinning = function() {
            return g_IsSpinning;
        };
    }

    var onSlotStopped = function(stoppedSlotIndex) {
        if (stoppedSlotIndex === slotIndex && onSpinComplete && typeof onSpinComplete === 'function') {
            var callback = onSpinComplete;
            var currentSlotIndex = slotIndex;
            GameUI.LoopTime.Schedule(0.5, function() {
                if (callback && typeof callback === 'function') {
                    callback(currentSlotIndex);
                }
            });
        }
    };

    // Запускаем анимацию сразу без задержки
    startSlotAnimation(root, slotIndex, animationSettings, checkSpinning, onSlotStopped);
}

function startAllSlotsAnimation(root, slotsData, isSpinningCallback, onAllSlotsComplete, onAnimationStarted) {
    if (!root) return;
    
    // slotsData должен быть массивом из 3 объектов: [{item, duration, fillerItems?}, ...]
    // или можно передать один объект для всех слотов: {item, durations: [1.0, 1.5, 3.0], speed, fillerItems?}
    var items = [];
    var durations = [];
    var speed = 1;
    var fillerItemsArray = [null, null, null];
    var animationSettingsArray = [null, null, null];
    
    if (Array.isArray(slotsData)) {
        // Если передан массив, используем его
        for (var i = 0; i < 3; i++) {
            if (slotsData[i]) {
                items[i] = slotsData[i].item;
                durations[i] = slotsData[i].duration;
                if (slotsData[i].fillerItems) {
                    fillerItemsArray[i] = objectToArray(slotsData[i].fillerItems);
                }
                if (slotsData[i].speed !== undefined) {
                    speed = slotsData[i].speed;
                }
            }
        }
    } else if (slotsData) {
        // Если передан один объект
        var item = slotsData.item;
        if (Array.isArray(slotsData.durations) && slotsData.durations.length >= 3) {
            durations = slotsData.durations;
        } else {
            durations = [1.0, 1.5, 3.0]; // Значения по умолчанию
        }
        speed = slotsData.speed || 1;
        
        for (var i = 0; i < 3; i++) {
            items[i] = item;
            if (Array.isArray(slotsData.fillerItems) && slotsData.fillerItems[i]) {
                fillerItemsArray[i] = objectToArray(slotsData.fillerItems[i]);
            } else if (slotsData.fillerItems) {
                fillerItemsArray[i] = objectToArray(slotsData.fillerItems);
            }
        }
    }
    
    // Подготавливаем настройки анимации для всех слотов
    clearAllSlots(root);
    if (!g_IsSpinning) g_IsSpinning = true;
    
    for (var i = 0; i < 3; i++) {
        if (items[i] && durations[i] !== undefined && durations[i] !== null) {
            var slowdownDuration = durations[i] * 0.4;
            var defaultWrapperHeight = getDefaultHeightWithScale(160);
            var speedMultiplier = speed;
            // Количество предметов рассчитывается на основе базовой скорости (без множителя)
            var spinSettings = calculateSpinSettings(durations[i], slowdownDuration, defaultWrapperHeight, speedMultiplier);
            // При увеличении скорости, фактическое время анимации уменьшается пропорционально
            animationSettingsArray[i] = {
                startingSpeed: STARTING_SPEED * speedMultiplier,
                stopDelay: 0,
                constantSpeedDuration: spinSettings.constantSpeedDuration / speedMultiplier,
                totalDuration: durations[i] / speedMultiplier
            };
        } else if (items[i]) {
            var speedMultiplier = speed;
            animationSettingsArray[i] = {
                startingSpeed: STARTING_SPEED * speedMultiplier,
                stopDelay: 0
            };
        }
    }
    
    // Отслеживание готовности всех слотов (создание панелей)
    var readySlots = [false, false, false];
    var slotsReady = false;
    
    function checkAllSlotsReady() {
        if (readySlots[0] && readySlots[1] && readySlots[2] && !slotsReady) {
            slotsReady = true;
            // Все панели созданы, запускаем анимацию
            startAllSlotsAnimations();
        }
    }
    
    function onSlotReady(slotIndex) {
        if (slotIndex !== undefined && slotIndex !== null && slotIndex >= 0 && slotIndex <= 2) {
            readySlots[slotIndex] = true;
            checkAllSlotsReady();
        }
    }
    
    // Создаем панели для всех слотов
    for (var i = 0; i < 3; i++) {
        if (items[i]) {
            var dropSlot = 1; // По умолчанию
            var totalItems = null;
            
            if (durations[i] !== undefined && durations[i] !== null) {
            var slowdownDuration = durations[i] * 0.4;
            var defaultWrapperHeight = getDefaultHeightWithScale(160);
            var speedMultiplier = speed;
            // Количество предметов рассчитывается на основе базовой скорости (без множителя)
            var spinSettings = calculateSpinSettings(durations[i], slowdownDuration, defaultWrapperHeight, speedMultiplier);
            dropSlot = spinSettings.dropSlot;
            totalItems = spinSettings.totalItems;
            }
            
            initItemsInSlot(root, i, fillerItemsArray[i], items[i], dropSlot, totalItems, onSlotReady);
        } else {
            // Если нет предмета для слота, считаем его готовым
            readySlots[i] = true;
            checkAllSlotsReady();
        }
    }
    
    // Отслеживание завершения всех слотов (анимация)
    var completedSlots = [false, false, false];
    
    function checkAllSlotsCompleted() {
        if (completedSlots[0] && completedSlots[1] && completedSlots[2]) {
            if (onAllSlotsComplete && typeof onAllSlotsComplete === 'function') {
                onAllSlotsComplete();
            }
        }
    }
    
    function onSlotComplete(slotIndex) {
        if (slotIndex !== undefined && slotIndex !== null && slotIndex >= 0 && slotIndex <= 2) {
            completedSlots[slotIndex] = true;
            checkAllSlotsCompleted();
        }
    }
    
    // Функция запуска анимации всех слотов (вызывается после создания всех панелей)
    function startAllSlotsAnimations() {
        var checkSpinning = isSpinningCallback;
        if (!checkSpinning || typeof checkSpinning !== 'function') {
            checkSpinning = function() {
                return g_IsSpinning;
            };
        }
        
        // Активируем кнопку пропуска, так как анимация реально началась
        if (onAnimationStarted && typeof onAnimationStarted === 'function') {
            onAnimationStarted(root);
        }
        
        // Запускаем все слоты одновременно без задержек
        for (var i = 0; i < 3; i++) {
            if (items[i] && animationSettingsArray[i] && DROP_POS[i] && DROP_POS[i][1] !== undefined) {
                // Используем замыкание для правильного захвата индекса
                (function(slotIdx, settings) {
                    var onSlotStopped = function(stoppedSlotIndex) {
                        if (stoppedSlotIndex === slotIdx && onSlotComplete && typeof onSlotComplete === 'function') {
                            var callback = onSlotComplete;
                            var currentSlotIndex = slotIdx;
                            GameUI.LoopTime.Schedule(0.5, function() {
                                if (callback && typeof callback === 'function') {
                                    callback(currentSlotIndex);
                                }
                            });
                        }
                    };
                    
                    // Запускаем анимацию одновременно для всех слотов
                    startSlotAnimation(root, slotIdx, settings, checkSpinning, onSlotStopped);
                })(i, animationSettingsArray[i]);
            }
        }
    }
}

function stopSpinAnimation(root, immediate) {
    g_IsSpinning = false;

    if (immediate) {
        // Ждем, пока все панели будут созданы и позиции рассчитаны
        var maxWaitTime = 1.0; // Максимальное время ожидания (1 секунда)
        var checkInterval = 0.05; // Проверяем каждые 50мс
        var elapsedTime = 0;
        
        function waitForPanelsAndSkip() {
            var allReady = true;
            
            for (var i = 0; i < 3; i++) {
                var animContainer = getSlotPanel(root, i, "anim");
                if (animContainer) {
                    // Проверяем, есть ли предметы в контейнере
                    var hasItems = animContainer.GetChildCount() > 0;
                    
                    // Если позиции еще не рассчитаны или нет предметов, ждем
                    if (!DROP_POS[i] || DROP_POS[i][1] === undefined || !hasItems) {
                        allReady = false;
                    } else {
                        // Позиции готовы и есть предметы - показываем их сразу
                        animContainer.style.position = "0px " + DROP_POS[i][1] + "px 0px";
                        animContainer.style.visibility = "visible";
                        animContainer.style.opacity = "1";
                    }
                    
                    var slotCard = getSlotPanel(root, i, "card");
                    if (slotCard) {
                        slotCard.RemoveClass("spinning");
                        slotCard.RemoveClass("slowing");
                        slotCard.RemoveClass("hovering");
                        slotCard.AddClass("stopped");
                    }
                } else {
                    allReady = false;
                }
            }
            
            if (allReady || elapsedTime >= maxWaitTime) {
                // Все готово или время истекло - завершаем
                // Если не все готово, но время истекло, все равно показываем то, что есть
                for (var i = 0; i < 3; i++) {
                    var animContainer = getSlotPanel(root, i, "anim");
                    if (animContainer && DROP_POS[i] && DROP_POS[i][1] !== undefined) {
                        animContainer.style.position = "0px " + DROP_POS[i][1] + "px 0px";
                        animContainer.style.visibility = "visible";
                        animContainer.style.opacity = "1";
                    }
                }
                // Не очищаем DROP_POS сразу, чтобы позиции остались для отображения
                return;
            }
            
            elapsedTime += checkInterval;
            GameUI.LoopTime.Schedule(checkInterval, waitForPanelsAndSkip);
        }
        
            // Начинаем ожидание
        waitForPanelsAndSkip();
    } else {
        clearDropPos();
    }
}

function clearDropPos() {
    DROP_POS = {};
}