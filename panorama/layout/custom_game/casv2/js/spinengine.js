--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


"use strict";
// Анимация барабанов: заполнение слотов, расчёт позиций, движение с замедлением, остановка по target Y.
var STARTING_SPEED = 6000;
var DROP_SLOT = 50;
var SOUND_TICK_WIDTH = 160;
var SLOT_STOP_DELAY = 0;
var SLOWING_DISTANCE_RATIO = 0.25;
var SLOT_ANIMATIONS = ["SlotAnimation1", "SlotAnimation2", "SlotAnimation3"];
var SLOT_CARDS = ["SlotCard1", "SlotCard2", "SlotCard3"];

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

var slotDropPositions = {};
var isSpinning = false;

function toArray(obj) {
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

    var localizedKey = "#DOTA_Tooltip_ability_" + itemName;
    var localizedText = $.Localize(localizedKey);

    if (localizedText && localizedText !== localizedKey) {
        if (localizedText.length > 16) {
            return localizedText.substring(0, 12) + "..";
        }
        return localizedText;
    }

    var formattedName;
    if (itemName.indexOf("item_") === 0) {
        formattedName = itemName.substring(5).split("_").map(function(word) {
            return word.charAt(0).toUpperCase() + word.slice(1);
        }).join(" ");
    } else {
        formattedName = itemName;
    }

    if (formattedName.length > 20) {
        return formattedName.substring(0, 15) + "..";
    }
    
    return formattedName;
}

function getSlotPanel(root, slotIndex, type) {
    return root.FindChildTraverse((type === "card" ? SLOT_CARDS : SLOT_ANIMATIONS)[slotIndex]);
}

function clearSlot(root, slotIndex) {
    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (animContainer) {
        animContainer.RemoveAndDeleteChildren();
        animContainer.style.position = "0px 0px 0px";
    }
    var slotCard = getSlotPanel(root, slotIndex, "card");
    if (slotCard) {
        var classesToRemove = ["spinning", "winning", "stopped", "slowing", "hovering", "anticipation"];
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

    if (isFinalItem && itemWrapper.id !== "dropped_item") {
        itemWrapper.id = "dropped_item";
    } else if (!isFinalItem && itemWrapper.id === "dropped_item") {
        itemWrapper.id = "SlotFillerWrapper_" + index;
    }

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

    var itemLabel = null;
    for (var i = 0; i < childCount; i++) {
        var child = itemWrapper.GetChild(i);
        if (child && child.BHasClass("slot-item-label")) {
            itemLabel = child;
            break;
        }
    }

    if (itemLabel) {
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
    if (!slotDropPositions[slotIndex]) slotDropPositions[slotIndex] = [0, 0];

    var slotCard = getSlotPanel(root, slotIndex, "card");
    var animContainer = getSlotPanel(root, slotIndex, "anim");
    
    if (!slotCard || !animContainer) {
        slotDropPositions[slotIndex] = [0, 0];
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

    slotDropPositions[slotIndex][0] = startY;
    slotDropPositions[slotIndex][1] = targetY;
}

function initItemsInSlot(root, slotIndex, fillerItems, finalItem, dropSlot, totalItems, onReady) {
    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (!animContainer) {
        if (onReady) onReady(slotIndex);
        return;
    }

    animContainer.style.visibility = "collapse";
    animContainer.style.opacity = "0";

    if (!Array.isArray(fillerItems)) fillerItems = [];
    var currentDropSlot = (dropSlot !== undefined && dropSlot !== null) ? dropSlot : DROP_SLOT;
    var itemsCount = totalItems || Math.max(100, fillerItems.length + 20);

    var existingPanels = [];
    var childCount = animContainer.GetChildCount();
    for (var i = 0; i < childCount; i++) {
        var child = animContainer.GetChild(i);
        if (child && child.BHasClass("slot-item-wrapper")) {
            existingPanels.push(child);
        }
    }

    for (var i = 0; i < itemsCount; i++) {
        var isFinalItem = (i === currentDropSlot);
        var itemName = isFinalItem ? finalItem : getFillerItem(fillerItems, i);

        if (i < existingPanels.length) {
            updateSlotItem(existingPanels[i], itemName, isFinalItem, i);
        } else {
            createSlotItem(animContainer, i, itemName, isFinalItem);
        }
    }

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

        if (onReady && typeof onReady === 'function') {
            onReady(slotIndex);
        }
    }

    tryCalculatePosition();
}

function handleSlotStop(root, slotIndex, stopPosition, onSlotStopped) {
    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (animContainer) animContainer.style.position = "0px " + stopPosition + "px 0px";

    var slotCard = getSlotPanel(root, slotIndex, "card");
    if (slotCard) {
        var classesToRemove = ["spinning", "hovering", "slowing"];
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

    (typeof GameUI !== "undefined" && GameUI.CasUiClickSound ? GameUI.CasUiClickSound() : Game.EmitSound("General.ButtonClick"));
    if (onSlotStopped) onSlotStopped(slotIndex);
}

function animateSlot(root, slotIndex, currentY, dropDistance, speed, soundTick, finalTargetY, slowingDistanceRatio, isSpinningCallback, onSlotStopped, elapsedTime, constantSpeedDuration, slowdownFactor, totalDuration, speedMultiplier) {
    if (isSpinningCallback && typeof isSpinningCallback === 'function' && !isSpinningCallback()) return;

    var animContainer = getSlotPanel(root, slotIndex, "anim");
    if (!animContainer) return;

    var startY = slotDropPositions[slotIndex][0];
    var originalTargetY = finalTargetY || slotDropPositions[slotIndex][1];
    var targetStopY = originalTargetY;
    var distanceToStop = targetStopY - currentY;
    var frameTime = Game.GetGameFrameTime();
    elapsedTime = (elapsedTime || 0) + frameTime;

    speedMultiplier = speedMultiplier || 1;
    var MIN_SPEED = 25 * speedMultiplier;
    var isConstantSpeedPhase = constantSpeedDuration > 0 && elapsedTime < constantSpeedDuration;

    var isMovingDown = startY < targetStopY;
    var hasPassedTarget = isMovingDown ? (currentY > targetStopY) : (currentY < targetStopY);
    var timeExpired = totalDuration && elapsedTime >= totalDuration;

    if (hasPassedTarget || timeExpired) {
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
            var decelerationRate = 2000;
            speed = speed - decelerationRate * frameTime;
            speed = Math.max(MIN_SPEED, speed);
            
            var slotCard = getSlotPanel(root, slotIndex, "card");
            if (slotCard && !slotCard.BHasClass("slowing")) slotCard.AddClass("slowing");
        }
    }

    var nextY = currentY + speed * frameTime;
    var willPassTarget = isMovingDown ? (nextY > targetStopY) : (nextY < targetStopY);

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
        willPassTarget = isMovingDown ? (nextY > targetStopY) : (nextY < targetStopY);
        if (willPassTarget) {
            nextY = targetStopY;
            speed = 0;
        }
    }
    
    currentY = nextY;
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
        (typeof GameUI !== "undefined" && GameUI.CasUiClickSound ? GameUI.CasUiClickSound() : Game.EmitSound("General.ButtonClick"));
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

    if (!slotDropPositions[slotIndex] || slotDropPositions[slotIndex][1] === undefined) {
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
    var speedMultiplier = startingSpeed / STARTING_SPEED;

    var slotCard = getSlotPanel(root, slotIndex, "card");
    if (slotCard) slotCard.AddClass("spinning");

    var targetY = slotDropPositions[slotIndex][1];
    var startY = slotDropPositions[slotIndex][0];
    var adjustedDropDistance = targetY;

    if (stopDelay > 0) {
        var extraDistance = startingSpeed * stopDelay * 0.6;
        adjustedDropDistance = targetY + extraDistance;
        if (adjustedDropDistance <= startY) {
            adjustedDropDistance = startY + (Math.abs(slotDropPositions[slotIndex][0] - slotDropPositions[slotIndex][1]) / 10 || 160);
        }
    }
    if (startY >= adjustedDropDistance) {
        startY = adjustedDropDistance - 1600;
        slotDropPositions[slotIndex][0] = startY;
    }

    if (animContainer) {
        animContainer.style.position = "0px " + startY + "px 0px";
        animContainer.style.visibility = "visible";
        animContainer.style.opacity = "1";
    }

    animateSlot(root, slotIndex, startY, adjustedDropDistance, startingSpeed, SOUND_TICK_WIDTH, targetY, null, isSpinningCallback, onSlotStopped, 0, constantSpeedDuration, null, totalDuration, speedMultiplier);
}

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

function startSpinAnimation(root, slotIndex, spinData, isSpinningCallback, onSpinComplete) {
    if (!root || slotIndex === undefined || slotIndex < 0 || slotIndex > 2) return;
    if (!spinData || !spinData.item) return;

    clearSlot(root, slotIndex);
    if (!isSpinning) isSpinning = true;

    var fillerItems = spinData.fillerItems ? toArray(spinData.fillerItems) : null;
    var animationSettings = spinData.animationSettings || null;
    var dropSlot = spinData.dropSlot;
    var duration = spinData.duration;

    if (duration !== undefined && duration !== null) {
        var slowdownDuration = duration * 0.4;
        var defaultWrapperHeight = getDefaultHeightWithScale(160);
        var speedMultiplier = spinData.speed || 1;
        var spinSettings = calculateSpinSettings(duration, slowdownDuration, defaultWrapperHeight, speedMultiplier);
        dropSlot = spinSettings.dropSlot;
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
            return isSpinning;
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

    startSlotAnimation(root, slotIndex, animationSettings, checkSpinning, onSlotStopped);
}

function startAllSlotsAnimation(root, slotsData, isSpinningCallback, onAllSlotsComplete, onAnimationStarted) {
    if (!root) return;

    var items = [];
    var durations = [];
    var speed = 1;
    var fillerItemsArray = [null, null, null];
    var animationSettingsArray = [null, null, null];

    if (Array.isArray(slotsData)) {
        for (var i = 0; i < 3; i++) {
            if (slotsData[i]) {
                items[i] = slotsData[i].item;
                durations[i] = slotsData[i].duration;
                if (slotsData[i].fillerItems) {
                    fillerItemsArray[i] = toArray(slotsData[i].fillerItems);
                }
                if (slotsData[i].speed !== undefined) {
                    speed = slotsData[i].speed;
                }
            }
        }
    } else if (slotsData) {
        var item = slotsData.item;
        if (Array.isArray(slotsData.durations) && slotsData.durations.length >= 3) {
            durations = slotsData.durations;
        } else {
            durations = [1.0, 1.5, 3.0];
        }
        speed = slotsData.speed || 1;
        
        for (var i = 0; i < 3; i++) {
            items[i] = item;
            if (Array.isArray(slotsData.fillerItems) && slotsData.fillerItems[i]) {
                fillerItemsArray[i] = toArray(slotsData.fillerItems[i]);
            } else if (slotsData.fillerItems) {
                fillerItemsArray[i] = toArray(slotsData.fillerItems);
            }
        }
    }

    clearAllSlots(root);
    if (!isSpinning) isSpinning = true;
    
    for (var i = 0; i < 3; i++) {
        if (items[i] && durations[i] !== undefined && durations[i] !== null) {
            var slowdownDuration = durations[i] * 0.4;
            var defaultWrapperHeight = getDefaultHeightWithScale(160);
            var speedMultiplier = speed;
            var spinSettings = calculateSpinSettings(durations[i], slowdownDuration, defaultWrapperHeight, speedMultiplier);
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

    var readySlots = [false, false, false];
    var slotsReady = false;
    
    function checkAllSlotsReady() {
        if (readySlots[0] && readySlots[1] && readySlots[2] && !slotsReady) {
            slotsReady = true;
            startAllSlotsAnimations();
        }
    }
    
    function onSlotReady(slotIndex) {
        if (slotIndex !== undefined && slotIndex !== null && slotIndex >= 0 && slotIndex <= 2) {
            readySlots[slotIndex] = true;
            checkAllSlotsReady();
        }
    }

    for (var i = 0; i < 3; i++) {
        if (items[i]) {
            var dropSlot = 1;
            var totalItems = null;
            
            if (durations[i] !== undefined && durations[i] !== null) {
            var slowdownDuration = durations[i] * 0.4;
            var defaultWrapperHeight = getDefaultHeightWithScale(160);
            var speedMultiplier = speed;
            var spinSettings = calculateSpinSettings(durations[i], slowdownDuration, defaultWrapperHeight, speedMultiplier);
            dropSlot = spinSettings.dropSlot;
            totalItems = spinSettings.totalItems;
            }
            
            initItemsInSlot(root, i, fillerItemsArray[i], items[i], dropSlot, totalItems, onSlotReady);
        } else {
            readySlots[i] = true;
            checkAllSlotsReady();
        }
    }

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

    function startAllSlotsAnimations() {
        var checkSpinning = isSpinningCallback;
        if (!checkSpinning || typeof checkSpinning !== 'function') {
            checkSpinning = function() {
                return isSpinning;
            };
        }

        if (onAnimationStarted && typeof onAnimationStarted === 'function') {
            onAnimationStarted(root);
        }

        for (var i = 0; i < 3; i++) {
            if (items[i] && animationSettingsArray[i] && slotDropPositions[i] && slotDropPositions[i][1] !== undefined) {
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

                    startSlotAnimation(root, slotIdx, settings, checkSpinning, onSlotStopped);
                })(i, animationSettingsArray[i]);
            }
        }
    }
}

function stopSpinAnimation(root, immediate) {
    isSpinning = false;

    if (immediate) {
        var maxWaitTime = 1.0;
        var checkInterval = 0.05;
        var elapsedTime = 0;
        
        function waitForPanelsAndSkip() {
            var allReady = true;
            
            for (var i = 0; i < 3; i++) {
                var animContainer = getSlotPanel(root, i, "anim");
                if (animContainer) {
                    var hasItems = animContainer.GetChildCount() > 0;

                    if (!slotDropPositions[i] || slotDropPositions[i][1] === undefined || !hasItems) {
                        allReady = false;
                    } else {
                        animContainer.style.position = "0px " + slotDropPositions[i][1] + "px 0px";
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
                for (var i = 0; i < 3; i++) {
                    var animContainer = getSlotPanel(root, i, "anim");
                    if (animContainer && slotDropPositions[i] && slotDropPositions[i][1] !== undefined) {
                        animContainer.style.position = "0px " + slotDropPositions[i][1] + "px 0px";
                        animContainer.style.visibility = "visible";
                        animContainer.style.opacity = "1";
                    }
                }
                return;
            }
            
            elapsedTime += checkInterval;
            GameUI.LoopTime.Schedule(checkInterval, waitForPanelsAndSkip);
        }

        waitForPanelsAndSkip();
    } else {
        clearDropPos();
    }
}

function clearDropPos() {
    slotDropPositions = {};
}