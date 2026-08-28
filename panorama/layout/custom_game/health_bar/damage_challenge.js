--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function adjustArmor(value) {
	GameEvents.SendCustomGameEventToServer("adjust_damage_challenge_stats", {
		type: "armor",
		inc: value > 0,
	});
}

function adjustMagicRes(value) {
	GameEvents.SendCustomGameEventToServer("adjust_damage_challenge_stats", {
		type: "magic_armor",
		inc: value > 0,
	});
}

function showTooltip(buttonType, inc) {
	const parent = buttonType == "armor" ? $("#armor-container") : $("#magic-armor-container")
	const buttons = parent.FindChildrenWithClassTraverse("setting-button")

	$.DispatchEvent("DOTAShowTextTooltip", inc ? buttons[0] : buttons[1], $.Localize(`#damage_challenge_${inc ? "inc" : "dec"}_${buttonType}`));
}

function hideTooltip() {
    $.DispatchEvent( "DOTAHideTextTooltip");
}

(function() {
    "use strict";
    const container = $.GetContextPanel();
    const damageContainer = container.FindChildTraverse("damage-challenge-container");
    const livesText = container.FindChildTraverse("lives-text");
    const hpFill = container.FindChildTraverse("hp-fill");
    const hpTrail = container.FindChildTraverse("hp-trail");
    const hpText = container.FindChildTraverse("hp-text");
    const timerText = container.FindChildTraverse("timer-text");
    const timerProgress = container.FindChildTraverse("timer-progress");
    const timerRing = container.FindChildTraverse("timer-ring");
    const timerInner = container.FindChildTraverse("timer-inner");
    const totalDamageText = container.FindChildTraverse("total-damage");
    const livesCircle = container.FindChildTraverse("lives-circle");
    const hpBar = container.FindChildTraverse("hp-bar");
    const timerCircle = container.FindChildTraverse("timer-circle");
    
    let currentData = null;
    let timerKey = null;
    let timeRemaining = 30;
    let maxTime = 30;
    let stage = "ready";
    let isDisabled = false;
    let isMovementBlocked = false;
    let isAttackBlocked = false;
    let isAbilityBlocked = false;
    let rechargeRemaining = 0;
    let currentHp = 0;
    let maxHp = 0;
    let displayedHp = 0;
    let previousHp = 0; // Предыдущее значение HP для определения оверкилла
    let decaySpeed = 0.3; // 30% от максимального HP в секунду
    let lastUpdateTime = 0;
    let animationTimer = null;
    
    // Стабилизация обновлений
    let lastProcessedHp = 0;
    let lastProcessedMaxHp = 0;
    let lastProcessedTimer = 0;
    let updateThrottle = 0.05; // Минимальный интервал между обновлениями (50мс)
    let lastUpdateTimestamp = 0;
    
    // Отслеживание жизней
    let previousLives = 0;
    let currentLives = 0;
    
    // Отслеживание ширины hp-trail
    let previousTrailWidth = 0;
    let currentTrailWidth = 0;
    let targetTrailWidth = 0;

    let trailHpPercentage = 100;
    let trailHpTargetPercentage = 100;
    let intervalTimerTrail = 0.01;
    let widthReductionPerTick = 100 * decaySpeed * intervalTimerTrail;
    
    function Initialize() {
        CustomNetTables.SubscribeNetTableListener("health_bar", OnDamageChallengeDataChanged);
        container.visible = false;
        
        if (hpTrail) {
            hpTrail.style.width = "100%";
        }
        
        currentHp = 0;
        maxHp = 0;
        displayedHp = 0;
        lastUpdateTime = 0;
    }
    
    function OnDamageChallengeDataChanged(tableName, key, data) {
        if (tableName !== "health_bar") return;
        
        currentData = data;
        UpdateUI();
        container.visible = true;
    }
    
    function UpdateUI() {
        if (!currentData) return;
        
        stage = currentData.stage || "ready";
        
        const lives = currentData.level || 1;
        livesText.text = lives.toString();
        
        // Проверяем изменение количества жизней
        currentLives = lives;
        const livesIncreased = (previousLives > 0 && currentLives > previousLives);
        previousLives = currentLives;
        
        const levelHp = parseInt(currentData.level_hp) || 500;
        const levelHpLeft = parseInt(currentData.level_hp_left) || 500;
        const hpPercentage = Math.max(0, Math.min(100, (levelHpLeft / levelHp) * 100));
        
        hpFill.style.width = hpPercentage + "%";
        hpText.text = levelHpLeft + " / " + levelHp;
        
        // Обновляем анимацию HP trail с учетом изменения жизней
        UpdateHpDelay(hpPercentage, livesIncreased);
        
        const totalDamage = currentData.total_damage || "0";
        totalDamageText.text = "TOTAL DAMAGE: " + FormatNumber(totalDamage);
        
        if (stage === "attacking" && currentData.timer_started) {
            const newTimerValue = currentData.timer_remaining || 30;
            // Стабилизация таймера - обновляем только при значительном изменении
            if (Math.abs(newTimerValue - lastProcessedTimer) > 0.5) {
                timeRemaining = newTimerValue;
                lastProcessedTimer = newTimerValue;
                UpdateTimerDisplay();
                if (!timerKey) {
                    StartTimer();
                }
            }
        } else if (stage === "recharge") {
            const newRechargeValue = rechargeRemaining;
            if (Math.abs(newRechargeValue - lastProcessedTimer) > 0.5) {
                timeRemaining = newRechargeValue;
                lastProcessedTimer = newRechargeValue;
                UpdateTimerDisplay();
            }
        }
        
        if (damageContainer) {
            damageContainer.RemoveClass("ready");
            damageContainer.RemoveClass("attacking");
            damageContainer.RemoveClass("recharge");
            damageContainer.RemoveClass("disabled");
            damageContainer.RemoveClass("stunned");
        }
        
        timerCircle.RemoveClass("invulnerable");
        timerCircle.RemoveClass("disabled");
        timerCircle.RemoveClass("frozen");
        timerCircle.RemoveClass("stunned");
        timerCircle.RemoveClass("ready");
        timerCircle.RemoveClass("attacking");
        timerCircle.RemoveClass("recharge");
        
        if (stage === "ready") {
            timerText.text = "30";
            if (damageContainer) {
                damageContainer.AddClass("ready");
            }
            timerCircle.AddClass("ready");
        } else if (stage === "attacking") {
            timerText.text = timeRemaining.toString();
            if (damageContainer) {
                damageContainer.AddClass("attacking");
            }
            timerCircle.AddClass("attacking");
        } else if (stage === "recharge") {
            timerText.text = rechargeRemaining.toString();
            if (damageContainer) {
                damageContainer.AddClass("recharge");
            }
            timerCircle.AddClass("recharge");
        } else if (isDisabled || (isMovementBlocked && isAttackBlocked && isAbilityBlocked)) {
            timerText.text = "0";
            if (damageContainer) {
                damageContainer.AddClass("disabled");
            }
            timerCircle.AddClass("disabled");
        } else if (isMovementBlocked) {
            timerText.text = "0";
            if (damageContainer) {
                damageContainer.AddClass("stunned");
            }
            timerCircle.AddClass("stunned");
        }
        
        AddVisualEffects(hpPercentage, lives);
    }
    
    function AddVisualEffects(hpPercentage, lives) {
        if (hpPercentage <= 25) {
            hpBar.AddClass("low-health");
        } else {
            hpBar.RemoveClass("low-health");
        }
        
        hpBar.AddClass("damage-flash");
        $.Schedule(0.3, function() {
            hpBar.RemoveClass("damage-flash");
        });
        
        if (lives > 1) {
            livesCircle.AddClass("pulse");
            $.Schedule(0.6, function() {
                livesCircle.RemoveClass("pulse");
            });
        }
        
        totalDamageText.AddClass("pulse");
        $.Schedule(0.5, function() {
            totalDamageText.RemoveClass("pulse");
        });
        
        if (timeRemaining <= 10) {
            timerCircle.AddClass("critical");
            timerProgress.style.borderColor = "#ff4444";
        } else if (timeRemaining <= 15) {
            timerCircle.RemoveClass("critical");
            timerProgress.style.borderColor = "#ff9800";
        } else {
            timerCircle.RemoveClass("critical");
            timerProgress.style.borderColor = "#4CAF50";
        }
    }
    
    function FormatNumber(numStr) {
        const num = parseInt(numStr);
        if (num >= 1000000000) {
            return (num / 1000000000).toFixed(1) + "B";
        } else if (num >= 1000000) {
            return (num / 1000000).toFixed(1) + "M";
        } else if (num >= 1000) {
            return (num / 1000).toFixed(1) + "K";
        } else {
            return num.toString();
        }
    }
    
    function StartTimer() {
        if (stage !== "attacking") return;
        
        if (timerKey) {
            GameUI.LoopTime.DelTime(timerKey);
        }
        
        timeRemaining = maxTime;
        UpdateTimerDisplay();
        
        timerKey = 'damage_challenge_timer_' + GameUI.parseInt(Math.random() * 10000) + GameUI.parseInt(Game.GetGameTime() * 1000);
        
        GameUI.LoopTime.AddTime(timerKey, 0, 1, function(times, n, gametime, isend) {
            timeRemaining--;
            UpdateTimerDisplay();
            
            if (timeRemaining <= 0) {
                GameUI.LoopTime.DelTime(timerKey);
                timerKey = null;
                OnTimerFinished();
            }
        });
    }
    
    function UpdateTimerDisplay() {
        timerText.text = timeRemaining.toString();
        
        if (timerProgress) {
            const progress = (timeRemaining / maxTime) * 100;
            
            if (progress <= 25) {
                timerCircle.AddClass("critical");
                timerProgress.style.borderColor = "#ff4444";
            } else if (progress <= 50) {
                timerCircle.RemoveClass("critical");
                timerProgress.style.borderColor = "#ff9800";
            } else {
                timerCircle.RemoveClass("critical");
                timerProgress.style.borderColor = "#4CAF50";
            }
            
            const borderWidth = Math.max(1, Math.floor(progress / 10));
            timerProgress.style.borderWidth = borderWidth + "px";
        }
    }
    function UpdateHpDelay(hpPercentage, livesIncreased = false) {
        if (!hpTrail) return;
        
        // Если ширина увеличивается - мгновенное изменение
        if (livesIncreased) {
            hpTrail.style.width = 100 + "%";
            trailHpTargetPercentage = hpPercentage;
            trailHpPercentage = 100;
        }else{
            trailHpTargetPercentage = hpPercentage;
        }
        
        StartTrailAnimation();
    }
    
    // Start Trail Animation - плавное уменьшение ширины hp-trail
    function StartTrailAnimation() {
        if(stage !== "attacking") return;
        animationTimer = 'hp_trail_animation_' + GameUI.parseInt(Math.random() * 10000) + GameUI.parseInt(Game.GetGameTime() * 1000);
        
        GameUI.LoopTime.AddTime(animationTimer, 0, intervalTimerTrail, function(times, n, gametime, isend) {
            // Проверяем, что мы все еще в стадии подсчета урона
            if (stage !== "attacking") {
                GameUI.LoopTime.DelTime(animationTimer);
                animationTimer = null;
                return;
            }

            const newTrailWidth = Math.max(trailHpTargetPercentage, trailHpPercentage - widthReductionPerTick);
            trailHpPercentage = newTrailWidth;

            hpTrail.style.width = newTrailWidth + "%";
        });
    }
    
    Initialize();
    
})();