--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const RightHintsContainer = $("#RightHintsContainer")

GameEvents.Subscribe("cha_hint_visible", cha_hint_visible);

function cha_hint_visible(params)
{
    // ========== РАУНДОВЫЕ ПОДСКАЗКИ (по порядку раундов) ==========
    
    // arena_hint_1 - Википедия (раунд 1)
    if (params.hint == "wiki")
    {
        CreateHintWithOutline("arena_hint_1", "wiki")
    }
    // arena_hint_5 - Прокачка навыков (раунд 5)
    else if (params.hint == "skills")
    {
        let SkillsPlayer = FindDotaHudElement("SkillsPlayer")
        if (SkillsPlayer)
        {
            CreateHint("arena_hint_5", SkillsPlayer, true)
        }
    }
    // arena_hint_9 - Перемещение способностей (раунд 9)
    else if (params.hint == "swap")
    {
        let abilities = FindDotaHudElement("abilities")
        if (abilities)
        {
            let ability = abilities.FindChildTraverse("Ability0")
            if (ability)
            {
                CreateHint("arena_hint_9", ability)
            }
        }   
    }
    // arena_hint_11 - Похвала игрока (раунд 11)
    else if (params.hint == "tips")
    {
        CreateHint("arena_hint_11", null)
    }
    // arena_hint_12 - Магические предметы (раунд 12)
    else if (params.hint == "items")
    {
        CreateHint("arena_hint_12", null)
    }
    // arena_hint_15 - Информация справа (раунд 15)
    else if (params.hint == "info_panel")
    {
        CreateHintWithOutline("arena_hint_15", "info_panel")
    }
    // arena_hint_20 - Меню настроек (раунд 20)
    else if (params.hint == "settings")
    {
        CreateHintWithOutline("arena_hint_20", "settings")
    }
    // arena_hint_25 - Подробности о крипах (раунд 25)
    else if (params.hint == "creeps_info")
    {
        CreateHintWithOutline("arena_hint_25", "creeps_info")
    }
    // arena_hint_31 - Раунды по очереди (раунд 31)
    else if (params.hint == "queue_rounds")
    {
        CreateHint("arena_hint_31", null)
    }
    // arena_hint_40 - Нейтральные предметы в магазине (раунд 40)
    else if (params.hint == "shop_neutrals")
    {
        CreateHint("arena_hint_40", null)
    }
    // arena_hint_45 - Book of Paragon (раунд 45)
    else if (params.hint == "paragon_book_2")
    {
        CreateHint("arena_hint_45", null)
    }
    // arena_hint_50 - Бонусный тайник (раунд 50)
    else if (params.hint == "bonus_stash")
    {
        CreateHintWithOutline("arena_hint_50", "bonus_stash")
    }
    // arena_hint_70 - Book of Paragon 2 (раунд 70)
    else if (params.hint == "paragon_book")
    {
        CreateHint("arena_hint_70", null)
    }
    // arena_hint_71 - Neutral Book (раунд 71)
    else if (params.hint == "neutral_book")
    {
        CreateHint("arena_hint_71", null)
    }
    
    // ========== СОБЫТИЙНЫЕ ПОДСКАЗКИ ==========
    
    // arena_hint_fly - Способности с полетом
    else if (params.hint == "creeps")
    {
        CreateHint("arena_hint_fly", null)
    }
    // arena_hint_relearn - Книга переобучения
    else if (params.hint == "reroll_book")
    {
        CreateHint("arena_hint_relearn", null)
    }
}

// Глобальное хранилище частиц обводок
if (!GameUI.CustomUIConfig().HintOutlineParticles) {
    GameUI.CustomUIConfig().HintOutlineParticles = {}
}

// Глобальная функция для создания частиц обводки (доступна для всех UI контекстов)
GameUI.CustomUIConfig().CreateHintParticle = function(targetPanel, contextPanel) {
    if (!targetPanel) return null
    
    // Если контекстная панель не передана, используем текущую
    if (!contextPanel) {
        contextPanel = $.GetContextPanel()
    }
    
    // Создаем эффект обводки через частицы
    let hint = $.CreatePanel("DOTAParticleScenePanel", contextPanel, "", {
        particleName: "particles/cha/hint_ui.vpcf",
        particleonly: "true",
        startActive: "true",
        cameraOrigin: "0 0 165",
        lookAt: "0 0 0",
        fov: "65",
        squarePixels: "true"
    })
    
    let m = Game.GetScreenHeight() / 1080
    let pos = targetPanel.GetPositionWithinWindow()
    let width = targetPanel.actuallayoutwidth
    let height = targetPanel.actuallayoutheight
    
    // Размер particles эффекта (125px в базовом разрешении 1080p)
    let particleSize = 125 * m
    
    // Находим центр элемента
    let centerX = pos.x + width / 2
    let centerY = pos.y + height / 2
    
    // Позиционируем particles так, чтобы его центр совпадал с центром элемента
    let particleX = centerX - particleSize / 2
    let particleY = centerY - particleSize / 2
    
    hint.SetPositionInPixels(particleX / m, particleY / m, 0)
    hint.hittest = false
    hint.AddClass("HintUIParticle")
    
    // Удаляем через 20 секунд
    hint.DeleteAsync(20)
    
    return hint
}

// Функция для создания подсказки с обводкой
function CreateHintWithOutline(hintText, outlineId) {
    CreateHint(hintText, null, false, function() {
        let particle = GameUI.CustomUIConfig().HintOutlineParticles?.[outlineId]
        if (particle && particle.IsValid()) {
            particle.DeleteAsync(0)
            delete GameUI.CustomUIConfig().HintOutlineParticles[outlineId]
        }
    })
}


function CreateHint(text, panel_target, skills, closeCallback)
{ 
    let hint = null
    if (panel_target != null)
    {
        var m = Game.GetScreenHeight() / 1080   
        var pos = panel_target.GetPositionWithinWindow()
        hint = $.CreatePanel("DOTAParticleScenePanel", $.GetContextPanel(), "", {particleName : "particles/cha/hint_ui.vpcf", particleonly : "true", startActive : "true", cameraOrigin : "0 0 165", lookAt : "0 0 0", fov : "65", squarePixels : "true"})
        
        // Для подсказки навыков смещаем вниз
        var offsetY = skills ? 80 : 0
        hint.SetPositionInPixels(pos.x / m, (pos.y / m) + offsetY, 0)
        hint.hittest = false
        if (skills)
        {
            hint.AddClass("HintUIParticle2")
        } 
        else
        {
            hint.AddClass("HintUIParticle")
        }
        hint.DeleteAsync(20)
    }

    let HintPanel = $.CreatePanel("Panel", $("#HintInfo"), "")
    HintPanel.AddClass("HintPanel")
    
    // Сохраняем callback для этой конкретной подсказки
    if (closeCallback) {
        HintPanel.hintCallback = closeCallback
    }

    let HintLabel = $.CreatePanel("Label", HintPanel, text)
    HintLabel.AddClass("HintLabel")
    HintLabel.html = true
    HintLabel.text = $.Localize("#"+text)
    HintPanel.DeleteAsync(20)

    let Close = $.CreatePanel("Panel", HintPanel, "")
    Close.AddClass("Close")

    Close.SetPanelEvent("onactivate", function()
    {
        // Вызываем callback для конкретной подсказки если он есть
        if (HintPanel.hintCallback && typeof HintPanel.hintCallback === 'function') {
            HintPanel.hintCallback()
        }
        
        if (hint != null)
        {
            hint.DeleteAsync(0)
        }
        HintPanel.DeleteAsync(0)
    })

    Game.EmitSound("ui.npe_objective_given")
}

RightHintsContainer.RemoveAndDeleteChildren()

GameEvents.Subscribe("set_hint_dota_style", set_hint_dota_style);

function set_hint_dota_style(info)
{
    let panel = $.CreatePanel("Panel", RightHintsContainer, "")
    panel.BLoadLayoutSnippet("HintPanelTop")
    panel.AddClass("movement_panel")

    if (info.image == "aegis")
    {
        panel.AddClass("Aegis")
    }
    else if (info.image == "creep") 
    {
        panel.AddClass("Creep")
    }
    else if (info.image == "awarn")
    {
        panel.AddClass("Awarn")
    }
    else
    {
        panel.AddClass("Wizard")
    }

    panel.SetDialogVariable("hint_text", $.Localize(info.text))

    panel.DeleteAsync(info.duration+1)

    $.Schedule( info.duration, function()
    {
        panel.RemoveClass("movement_panel")
    })

    Game.EmitSound("ui.contextual_tip.popup")
}