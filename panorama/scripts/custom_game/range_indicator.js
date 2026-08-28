--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// ============================================================================
//  ПОСТОЯННЫЙ ИНДИКАТОР ДАЛЬНОСТИ — фича батл-пасса.
//
//  Alt + ПКМ по способности или предмету в HUD закрепляет на земле круг дальности
//  применения. Повторный Alt+ПКМ по той же иконке — снимает. Аналог ванильной
//  настройки Dota «Persistent Range Indicators» (dota_settings_alt_right_range_hint),
//  но своя: работает в кастомке, учитывает наши способности и доступна по БП.
//
//  Одновременно активен ТОЛЬКО ОДИН индикатор (решение владельца): новый гасит прежний.
//
//  Партикл рисуется ЛОКАЛЬНО (Particles.CreateParticle из панорамы), поэтому:
//    • виден только самому игроку, соперникам подсказку не выдаёт;
//    • не нагружает сервер и не требует серверного кода.
//  Тот же приём уже используется в buffs_block.js для радиуса баффа.
// ============================================================================

const RI_PARTICLE = "particles/ui_mouseactions/range_display.vpcf"

// PlayerID берём В МОМЕНТ вызова, а не при загрузке скрипта: на раннем парсе HUD он
// ещё может быть -1, и тогда проверка батл-пасса навсегда возвращала бы false.
// В тулз-моде это незаметно — там IsPlayerBattlePassSubscribed всегда true.
function RI_LocalPID(){ return Players.GetLocalPlayer() }

// Текущий индикатор: { particle, abilityIndex, unit }. Держим один.
let RI_Current = null

function RI_Destroy(){
    if(RI_Current && RI_Current.particle != undefined){
        try { Particles.DestroyParticleEffect(RI_Current.particle, true) } catch(e){}
    }
    RI_Current = null
}

// Что показываем: в первую очередь дальность применения — как в ванильных
// Persistent Range Indicators. Но у безцелевых способностей (Berserker's Call,
// Anchor Smash и т.п.) cast range = 0, а полезное число там — радиус действия;
// без фолбэка такие способности выдавали бы «нет дальности», то есть выглядели
// бы сломанными. Поэтому при нулевом cast range берём AoE-радиус.
function RI_GetCastRange(abilityIndex){
    let range = 0
    try { range = Abilities.GetCastRange(abilityIndex) } catch(e){ range = 0 }
    if(!range || range <= 0){
        try { range = Abilities.GetAOERadius(abilityIndex) } catch(e){ range = 0 }
    }
    return range
}

function RI_Toggle(abilityIndex){
    if(abilityIndex == undefined || abilityIndex == -1){ return }

    // Фича батл-пасса. Без активного БП — отказ с понятным сообщением и звуком,
    // через штатный хелпер мода (тот же, что в меню настроек).
    // В тулз-моде проверка сама возвращает true (см. utils.js).
    if(!IsPlayerBattlePassSubscribed(RI_LocalPID())){
        EmitErrorToPlayer("#RANGE_INDICATOR_NEED_BP", "UUI_SOUNDS.NoGold")
        return
    }

    // Повторное нажатие по той же иконке — снять индикатор.
    if(RI_Current && RI_Current.abilityIndex === abilityIndex){
        RI_Destroy()
        return
    }

    let unit = Players.GetLocalPlayerPortraitUnit()
    if(unit == undefined || unit == -1){ return }

    let range = RI_GetCastRange(abilityIndex)
    if(!range || range <= 0){
        // Пассивка/аура/предмет без дальности — показывать нечего, но молчать плохо:
        // игрок не поймёт, почему ничего не произошло.
        EmitErrorToPlayer("#RANGE_INDICATOR_NO_RANGE", "UUI_SOUNDS.NoGold")
        return
    }

    RI_Destroy()

    let fx = Particles.CreateParticle(RI_PARTICLE, ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, unit)
    Particles.SetParticleControl(fx, 1, [range, 0, 0])
    RI_Current = { particle: fx, abilityIndex: abilityIndex, unit: unit }
}

// Сторож. Раньше он гасил круг при ЛЮБОМ несовпадении портретного юнита с тем, на кого
// круг поставлен, — из-за этого индикатор пропадал, стоило выделить курьера, второго юнита
// или иллюзию, хотя герой никуда не девался. Смена управления круг больше не трогает:
// он остаётся на том юните, для чьей способности его закрепили.
// Гасим только когда сама сущность исчезла (подмена героя, удаление юнита) — иначе партикл
// останется привязан к несуществующей сущности и повиснет на карте.
function RI_Watch(){
    if(RI_Current){
        let alive = false
        try { alive = Entities.IsValidEntity(RI_Current.unit) } catch(e){ alive = false }
        if(!alive){ RI_Destroy() }
    }
    $.Schedule(1.0, RI_Watch)
}
$.Schedule(1.0, RI_Watch)

// Вешаем обработчик ПКМ на слоты способностей и предметов HUD. Панели создаются
// асинхронно, поэтому ловим их через тот же StyleClassesChanged, что и alt-пинги.
$.RegisterForUnhandledEvent("StyleClassesChanged", function(panel){
    if(panel == null){ return }
    if(panel.type != "DOTAAbilityPanel"){ return }
    if(panel._riHooked){ return }
    panel._riHooked = true

    panel.SetPanelEvent("oncontextmenu", function(){
        if(!IsDotaAltPressed()){ return }   // без Alt — обычное поведение ПКМ не трогаем

        const itemImage = panel.FindChildTraverse("ItemImage")
        const abilityImage = panel.FindChildTraverse("AbilityImage")
        let idx = -1
        if(itemImage && itemImage.contextEntityIndex >= 0){ idx = itemImage.contextEntityIndex }
        else if(abilityImage && abilityImage.contextEntityIndex >= 0){ idx = abilityImage.contextEntityIndex }

        // Слоты нейтрала и смока переиспользуют entity-индексы — читаем их СВЕЖИМИ,
        // иначе после смены предмета покажем дальность от чужого/удалённого.
        let myUnit = Players.GetLocalPlayerPortraitUnit()
        if(panel.id == "inventory_neutral_slot"){ idx = Entities.GetItemInSlot(myUnit, 16) }
        else if(panel.id == "inventory_tpscroll_slot"){ idx = Entities.GetItemInSlot(myUnit, 15) }

        RI_Toggle(idx)
    })
})

// Наружу — чтобы можно было погасить индикатор из другого кода (например, при рестарте раунда).
GameUI.CustomUIConfig().ClearRangeIndicator = RI_Destroy
// ВАЖНО: у СПОСОБНОСТЕЙ ПКМ перехватывает панель FixCast (zxc_notifications.js создаёт её
// поверх кнопки для переключения автокаста), поэтому наш oncontextmenu на самой панели до
// способностей не доходит — предметы работали, способности нет. Оттуда и зовём эту функцию.
GameUI.CustomUIConfig().ToggleRangeIndicator = RI_Toggle