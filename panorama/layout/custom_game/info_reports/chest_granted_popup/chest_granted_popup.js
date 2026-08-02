--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


var POPUP_RARITY = { common:"#b0c3d9", uncommon:"#5e98d9", rare:"#4b69ff", mythical:"#8847ff", legendary:"#d32ce6", immortal:"#e4ae39" }
var POPUP_DROP_SLOT = 70
var POPUP_START_SPEED = 5890
var POPUP_INFO = null
var POPUP_ANIM = false
var POPUP_DROP_POS = [0, 0]
var POPUP_SOUND_TICK = 128
var popup_loop_sound = undefined

function ChestGrantedGetRoot()
{
    let ctx = $.GetContextPanel()
    if (!ctx) { return null }
    if (ctx.BHasClass("ChestGrantedRoot")) { return ctx }
    let found = ctx.FindChildTraverse("ChestGrantedRoot")
    return found ? found : ctx
}

function PopupFind(id)
{
    let root = ChestGrantedGetRoot()
    return root ? root.FindChildTraverse(id) : null
}

function PopupLoadChestWindow()
{
    let holder = PopupFind("chest_window_holder")
    if (!holder) { return }
    holder.BLoadLayout("file://{resources}/layout/custom_game/info_reports/chest_window.xml", false, false)
    let pair = PopupFind("ChestHudMainPanel")
    if (pair)
    {
        pair.AddClass("ChestHudPairMode")
        pair.AddClass("ChestGrantedPairHidden")
    }
    let close_icon = PopupFind("CloseChestHudIcon")
    if (close_icon)
    {
        close_icon.SetPanelEvent("onactivate", function() { ChestGrantedClose() })
    }
    let reroll = PopupFind("ItemDropRerollButton")
    if (reroll) { reroll.visible = false }
}

function PopupGetChestData()
{
    return CustomNetTables.GetTableValue("chest_data", Players.GetLocalPlayer()) || {}
}


function GetPairChestInfo(kind, chest_id)
{
    if (chest_id == null) { return null }
    let is_rich = kind == "rich" || kind == 2
    let pool = CustomNetTables.GetTableValue("shop_items", is_rich ? "rich_chests" : "poor_chests")
    if (!pool) { return null }
    return pool[chest_id] != null ? pool[chest_id] : null
}

function PopupSetChestIcons()
{
    let chest_data = PopupGetChestData()
    let poor_pool = CustomNetTables.GetTableValue("shop_items", "poor_chests")
    let rich_pool = CustomNetTables.GetTableValue("shop_items", "rich_chests")
    let poor_icon = PopupFind("ChestGrantedIconPoor")
    let rich_icon = PopupFind("ChestGrantedIconRich")

    let poor_name = PopupFind("ChestGrantedNamePoor")
    let rich_name = PopupFind("ChestGrantedNameRich")

    if (poor_icon)
    {
        let poor_exists = chest_data.poor_id != null && poor_pool && poor_pool[chest_data.poor_id]
        poor_icon.GetParent().visible = poor_exists ? true : false
        if (poor_exists)
        {
            poor_name.text = $.Localize("#chest_pair_poor_line")
            poor_icon.style.backgroundImage = 'url("s2r://panorama/images/' + poor_pool[chest_data.poor_id].chest_image + '.png")'
            poor_icon.style.backgroundSize = "100%"
        }
    }
    if (rich_icon)
    {
        let rich_exists = chest_data.rich_id != null && rich_pool && rich_pool[chest_data.rich_id]
        rich_icon.GetParent().visible = rich_exists ? true : false
        if (rich_exists)
        {
            rich_name.text = $.Localize("#chest_pair_rich_line")
            rich_icon.style.backgroundImage = 'url("s2r://panorama/images/' + rich_pool[chest_data.rich_id].chest_image + '.png")'
            rich_icon.style.backgroundSize = "100%"
        }
    }
}


function ChestGrantedShow()
{
    let root = ChestGrantedGetRoot()
    if (!root) { return }
    let notif = PopupFind("ChestGrantedWindow")
    let pair = PopupFind("ChestHudMainPanel")
    if (notif) { notif.style.visibility = "visible" }
    if (pair) { pair.AddClass("ChestGrantedPairHidden") }

    let popup_mode = GameUI.CustomUIConfig().chest_popup_mode
    let title = PopupFind("ChestGrantedTitle")
    if (title) { title.text = $.Localize(popup_mode == "granted" ? "#chest_granted_title" : "#chest_granted_title") }

    PopupSetChestIcons()
    root.hittest = true
    root.RemoveClass("ChestGrantedHidden")
    root.AddClass("ChestGrantedShown")

    let old_bg = root.FindChildTraverse("ChestGrantedBgEffect")
    if (old_bg) { old_bg.DeleteAsync(0) }

    Game.EmitSound("UI.Weekly_complete")
    Game.EmitSound("UI.Weekly_complete2")

    let bg_parent = $.CreatePanel("Panel", root, "")
    bg_parent.AddClass("ChestGrantedBgEffectParent")

    let bg = $.CreatePanel("DOTAParticleScenePanel", bg_parent, "ChestGrantedBgEffect", {particleName:"particles/generic/panorama_effect.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 400", lookAt:"0 0 0", fov:"70"})
    bg.AddClass("ChestGrantedBgEffect")
    bg.hittest = false

    let glow = $.CreatePanel("DOTAParticleScenePanel", bg_parent, "ChestGrantedBgEffect", {particleName:"particles/generic/panorama_glow.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 150", lookAt:"0 0 0", fov:"70"})
    glow.AddClass("ChestGrantedBgEffect")
    glow.hittest = false
}



function ChestGrantedClose()
{
    let root = ChestGrantedGetRoot()
    if (!root) { return }
    root.hittest = false
    Game.EmitSound("UI.Click")
    root.RemoveClass("ChestGrantedShown")
    root.AddClass("ChestGrantedHidden")
    GameUI.CustomUIConfig().chest_popup_driving = false
    POPUP_ANIM = false
    if (popup_loop_sound != undefined) { Game.StopSound(popup_loop_sound); popup_loop_sound = undefined }
}

function ChestGrantedOpen()
{
    let notif = PopupFind("ChestGrantedWindow")
    let pair = PopupFind("ChestHudMainPanel")

    Game.EmitSound("UI.Weekly_open")

    if (notif) { notif.style.visibility = "collapse" }
    if (pair)
    {
        pair.AddClass("ChestHudPairMode")
        pair.RemoveClass("ChestGrantedPairHidden")
        pair.style.opacity = "1"
        pair.hittest = true
    }
    GameUI.CustomUIConfig().chest_popup_driving = true
    POPUP_ANIM = false
    GameEvents.SendCustomGameEventToServer_custom("chest_pair_get_info", {})
}

GameEvents.Subscribe_custom("chest_pair_info", PopupChestInfo)
function PopupChestInfo(data)
{
    if (!GameUI.CustomUIConfig().chest_popup_driving) { return }
    if (!data || !data.chest_info) { return }
    PopupInitPair(data.chest_info)
}

GameEvents.Subscribe_custom("chest_pair_roll_result", PopupRollResult)
function PopupRollResult(data)
{
    if (!GameUI.CustomUIConfig().chest_popup_driving) { return }
    if (!data || data.drop_id == null) { POPUP_ANIM = false; return }
    PopupOpenLine(data.which, data.drop_id, data.is_dup, data.shards)
}

function PopupGetItemDisplayName(item)
{
    if (!item) { return "" }
    if (item.is_sound == 1) { return $.Localize("#" + item.item_name) }
    return item.item_name
}

function PopupCreateItem(panel, item, is_drop)
{
    let p = $.CreatePanel("Panel", panel, is_drop ? "popup_dropped" : "")
    p.AddClass("item_panel_roll")
    let icon = $.CreatePanel("Panel", p, "item_icon")
    icon.AddClass("item_icon")

    let real_icon = icon

    if (item.drop_type == "category_tip")
    {
        let tip_icon = $.CreatePanel("Panel", p, "item_icon_tip")
        tip_icon.AddClass("item_icon_tip")
        real_icon = tip_icon
    }

    real_icon.style.backgroundImage = 'url("' + item.item_icon + '")'
    real_icon.style.backgroundRepeat = 'no-repeat'
    real_icon.style.backgroundSize = "100%"

    if (item.is_sound == 1)
    {
        let sound_name = $.CreatePanel("Label", p, "item_sound_name")
        sound_name.AddClass("item_sound_name")
        sound_name.text = $.Localize("#" + item.item_name)
    }
    let border = $.CreatePanel("Panel", p, "item_panel_border")
    border.AddClass("item_panel_border")
    let color = POPUP_RARITY[item.rare] || POPUP_RARITY["common"]
    border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + color + '), to( rgba(0,0,0,0.1) ) )'

    let tooltip_name = PopupGetItemDisplayName(item)
    p.SetPanelEvent('onmouseover', function() {
    $.DispatchEvent('DOTAShowTextTooltip', p, tooltip_name) });

    p.SetPanelEvent('onmouseout', function() {
    $.DispatchEvent('DOTAHideTextTooltip', p); });

    $.Schedule(0.1, function() { p.style.opacity = "1" })
}

function PopupFillLine(rollPanel, items)
{
    if (!rollPanel) { return }
    rollPanel.RemoveAndDeleteChildren()
    let arr = []
    for (let k in items) { if (items[k]) { arr.push(items[k]) } }
    if (arr.length == 0) { return }
    for (let i = 0; i <= 100; i++)
    {
        let it = arr[Math.floor(Math.random() * arr.length)]
        PopupCreateItem(rollPanel, it, POPUP_DROP_SLOT == i)
    }
    rollPanel.style.position = "0px 0px 0px"
}

function PopupInitPair(info)
{
    POPUP_INFO = info
    POPUP_ANIM = false

    let poor_unit = PopupFind("ChestPairLineUnitPoor")
    if (poor_unit) { poor_unit.visible = info.poor != null }
    let rich_unit = PopupFind("ChestPairLineUnitRich")
    if (rich_unit) { rich_unit.visible = info.rich != null }

    let poor_icon_reset = PopupFind("RollLineChestIconPoor")
    if (poor_icon_reset) { poor_icon_reset.RemoveClass("RollLineGray") }
    let rich_icon_reset = PopupFind("RollLineChestIconRich")
    if (rich_icon_reset) { rich_icon_reset.RemoveClass("RollLineGray") }

    PopupFillLine(PopupFind("RollItemsListMain"), info.poor ? info.poor.chest_items : {})
    PopupFillLine(PopupFind("RollItemsListMain2"), info.rich ? info.rich.chest_items : {})

    let poor_line = PopupFind("RollLineBack")
    if (poor_line)
    {
        poor_line.SetHasClass("RollLineGray", info.poor != null && info.poor.opened == 1)
    }

    let rich_line = PopupFind("RollLineBack2")
    let rich_text = PopupFind("RollLineLockLabel")
    if (rich_line)
    {
        rich_line.SetHasClass("RollLineLocked", info.is_sub != 1)
        if (rich_text) { rich_text.SetHasClass("RollLineLocked", info.is_sub != 1) }
        rich_line.SetHasClass("RollLineGray", info.is_sub != 1 || (info.rich != null && info.rich.opened == 1))
    }


    let poor_title_icon = PopupFind("RollLineChestIconPoor")
    if (poor_title_icon && info.poor && info.poor.chest_image)
    {
        poor_title_icon.style.backgroundImage = 'url("s2r://panorama/images/' + info.poor.chest_image + '.png")'

        poor_title_icon.SetPanelEvent("onmouseover", () => 
        {
            Game.CustomTooltipOpened = true
            $.DispatchEvent(
                "UIShowCustomLayoutParametersTooltip",
                poor_title_icon,
                "chest_tooltip",
                "file://{resources}/layout/custom_game/info_reports/chest_tooltip/chest_tooltip.xml",
                "type=poor&id=" + info.poor.id,
            );
        });
        poor_title_icon.SetPanelEvent("onmouseout", () => 
        {
            Game.CustomTooltipOpened = false
            $.DispatchEvent("UIHideCustomLayoutTooltip", poor_title_icon, "chest_tooltip");
        });
        poor_title_icon.style.backgroundSize = "100%"
    }

    let rich_title_icon = PopupFind("RollLineChestIconRich")
    if (rich_title_icon && info.rich && info.rich.chest_image)
    {
        rich_title_icon.style.backgroundImage = 'url("s2r://panorama/images/' + info.rich.chest_image + '.png")'
        rich_title_icon.style.backgroundSize = "100%"

        rich_title_icon.SetPanelEvent("onmouseover", () => 
        {
            Game.CustomTooltipOpened = true
            $.DispatchEvent(
                "UIShowCustomLayoutParametersTooltip",
                rich_title_icon,
                "chest_tooltip",
                "file://{resources}/layout/custom_game/info_reports/chest_tooltip/chest_tooltip.xml",
                "type=rich&id=" + info.rich.id,
            );
        });
        rich_title_icon.SetPanelEvent("onmouseout", () => 
        {
            Game.CustomTooltipOpened = false
            $.DispatchEvent("UIHideCustomLayoutTooltip", rich_title_icon, "chest_tooltip");
        });
    }

    let drop = PopupFind("DropItemPanel")
    if (drop) { drop.SetHasClass("DropItemPanelVisible", false) }
    PopupUpdateButton()
}

function PopupNextSlot()
{
    if (!POPUP_INFO) { return null }
    if (POPUP_INFO.poor && POPUP_INFO.poor.opened != 1) { return "poor" }
    if (POPUP_INFO.rich && POPUP_INFO.is_sub == 1 && POPUP_INFO.rich.opened != 1) { return "rich" }
    return null
}


function PopupUpdateButton()
{
    if (!POPUP_INFO) { return }
    let poorBtn = PopupFind("OpenChestButtonPoor")
    let richBtn = PopupFind("OpenChestButtonRich")
    let poorLbl = PopupFind("OpenChestButtonPoorLabel")
    let richLbl = PopupFind("OpenChestButtonRichLabel")

    let poor_opened = POPUP_INFO.poor != null && POPUP_INFO.poor.opened == 1
    let rich_exists = POPUP_INFO.rich != null
    let rich_opened = rich_exists && POPUP_INFO.rich.opened == 1
    let rich_active = rich_exists && !rich_opened && POPUP_INFO.is_sub == 1

    if (poorBtn)
    {
        let poor_locked = poor_opened || POPUP_ANIM
        poorBtn.RemoveClass("chest_btn_hidden")
        poorBtn.SetHasClass("ChestLocked", poor_locked)
        if (poorLbl) { poorLbl.SetHasClass("ChestLockedTextCommon", poor_locked) }
        poorBtn.SetHasClass("OpenChestButtonCommon", !poor_locked)
        if (poorLbl) { poorLbl.text = $.Localize(poor_opened ? "#chest_is_opened" : "#open_chest") }
        poorBtn.SetPanelEvent("onactivate", function()
        {
            if (POPUP_ANIM) { return }
            if (!(POPUP_INFO.poor && POPUP_INFO.poor.opened != 1)) { return }
            POPUP_ANIM = true
            PopupUpdateButton()
            GameEvents.SendCustomGameEventToServer_custom("chest_pair_open", { which: "poor" })
        })
    }
    if (richBtn)
    {
        let rich_need_sub = rich_exists && !rich_opened && POPUP_INFO.is_sub != 1
        let rich_locked = (!rich_active && !rich_need_sub) || POPUP_ANIM
        richBtn.RemoveClass("chest_btn_hidden")
        richBtn.RemoveClass("is_chest_no_buy")
        richBtn.SetHasClass("ChestLocked", (rich_locked) || (rich_need_sub && !POPUP_ANIM))

        if (richLbl) { richLbl.SetHasClass("ChestLockedTextRare", rich_locked) }
        richBtn.SetHasClass("OpenChestButtonRare", rich_active && !POPUP_ANIM)
        if (richLbl) { richLbl.text = $.Localize(rich_opened ? "#chest_is_opened" : (rich_need_sub ? "#chest_closed" : "#open_chest")) }

        if (rich_need_sub)
        {
            richBtn.SetPanelEvent("onmouseover", function()
            {
               // $.DispatchEvent('DOTAShowTextTooltip', richBtn, $.Localize("#chest_pair_rich_locked"))
            })
            richBtn.SetPanelEvent("onmouseout", function()
            {
               // $.DispatchEvent('DOTAHideTextTooltip', richBtn);
            })
        }
        else
        {
            richBtn.ClearPanelEvent("onmouseover")
            richBtn.ClearPanelEvent("onmouseout")
        }

        richBtn.SetPanelEvent("onactivate", function()
        {
            if (POPUP_ANIM) { return }
            if (!(POPUP_INFO.rich && POPUP_INFO.rich.opened != 1 && POPUP_INFO.is_sub == 1)) { return }
            POPUP_ANIM = true
            PopupUpdateButton()
            GameEvents.SendCustomGameEventToServer_custom("chest_pair_open", { which: "rich" })
        })
    }
}

function PopupComputeDropPos(rollPanel)
{
    if (!rollPanel) { return }
    let dropped = rollPanel.FindChildTraverse("popup_dropped")
    if (!dropped) { return }
    let check_pos = dropped.style.position
    if (!check_pos) { return }
    let spaceFind = check_pos.indexOf('px')
    if (spaceFind < 0) { return }
    let width = dropped.actuallayoutwidth / dropped.actualuiscale_x
    if (!width || width <= 0) { return }
    let center = Number(check_pos.substring(0, spaceFind))
    POPUP_SOUND_TICK = width + (5 * 2)
    POPUP_DROP_POS[0] = -((center - (width * 3) - (5 * 4)) - width)
    POPUP_DROP_POS[1] = -(center - (width * 3) - (5 * 4))
}

function SetDropSlotIcon(slot_drop, drop_info)
{
    if (!slot_drop || !drop_info) { return }
    let item_icon = slot_drop.FindChildTraverse("item_icon")
    let old_tip_icon = slot_drop.FindChildTraverse("item_icon_tip")
    if (old_tip_icon) { old_tip_icon.DeleteAsync(0) }
    if (drop_info.drop_type == "category_tip")
    {
        if (item_icon) { item_icon.style.backgroundImage = 'url("")' }
        let tip_icon = $.CreatePanel("Panel", slot_drop, "item_icon_tip")
        tip_icon.AddClass("item_icon_tip")
        tip_icon.style.backgroundImage = 'url("' + drop_info.item_icon + '")'
        tip_icon.style.backgroundRepeat = 'no-repeat'
        tip_icon.style.backgroundSize = "100%"
    }
    else if (item_icon)
    {
        item_icon.style.backgroundImage = 'url("' + drop_info.item_icon + '")'
        item_icon.style.backgroundRepeat = 'no-repeat'
        item_icon.style.backgroundSize = "100%"
    }
}

function PopupGetItemPos(id, items)
{
    for (let i = 0; i <= Object.keys(items).length; i++)
    {
        if (items[i] && items[i].item_id == id) { return i }
    }
    return null
}

function PopupOpenLine(which, drop_id, is_dup, shards)
{
    if (!POPUP_INFO) { POPUP_ANIM = false; return }
    let info = which == "poor" ? POPUP_INFO.poor : POPUP_INFO.rich
    let rollPanel = PopupFind(which == "poor" ? "RollItemsListMain" : "RollItemsListMain2")
    if (!info) { POPUP_ANIM = false; return }
    if (!rollPanel) { POPUP_ANIM = false; return }
    let pos = PopupGetItemPos(drop_id, info.chest_items)
    let drop_info = pos != null ? info.chest_items[pos] : null
    if (!drop_info) { POPUP_ANIM = false; return }

    let dropped = rollPanel.FindChildTraverse("popup_dropped")
    if (dropped)
    {
        SetDropSlotIcon(dropped, drop_info)
        let border = dropped.FindChildTraverse("item_panel_border")
        if (border)
        {
            let color = POPUP_RARITY[drop_info.rare] || POPUP_RARITY["common"]
            border.style.borderBrush = 'gradient( linear, 0% 100%, 0% 20%, from(' + color + '), to( rgba(0,0,0,0.1) ) )'
        }
        let old_sound_name = dropped.FindChildTraverse("item_sound_name")
        if (old_sound_name) { old_sound_name.DeleteAsync(0) }
        if (drop_info.is_sound == 1)
        {
            let sound_name = $.CreatePanel("Label", dropped, "item_sound_name")
            sound_name.AddClass("item_sound_name")
            sound_name.text = $.Localize("#" + drop_info.item_name)
        }
    }

    Game.EmitSound("UI.Chest_open")
    popup_loop_sound = Game.EmitSound("UI.Chest_open2")
    PopupComputeDropPos(rollPanel)
    let dist = Math.floor(Math.random() * (POPUP_DROP_POS[1] - POPUP_DROP_POS[0] + 1) + POPUP_DROP_POS[0])
    PopupAnimate(rollPanel, 0, dist, POPUP_START_SPEED, POPUP_SOUND_TICK, which, drop_info, is_dup, shards)
}

function PopupAnimate(rollPanel, current, dist, speed, sound_tick, which, drop_info, is_dup, shards)
{
    let root = ChestGrantedGetRoot()
    if (!root || root.BHasClass("ChestGrantedHidden")) { POPUP_ANIM = false; return }
    if (current <= dist)
    {
        $.Schedule(0.1, function() { PopupGiveDrop(which, drop_info, is_dup, shards) })
        return
    }
    current = current - (speed * Game.GetGameFrameTime())
    sound_tick = sound_tick - (speed * Game.GetGameFrameTime())
    if (sound_tick <= 0) { sound_tick = POPUP_SOUND_TICK; Game.EmitSound("random_wheel_lever") }
    if (current <= 0.37 * dist) { speed = speed - (speed * Game.GetGameFrameTime()) }
    speed = Math.max(30, speed)
    rollPanel.style.position = current + "px 0px 0px"
    $.Schedule(Game.GetGameFrameTime(), function()
    {
        PopupAnimate(rollPanel, current, dist, speed, sound_tick, which, drop_info, is_dup, shards)
    })
}

function PopupSetDropCategory(drop_type, shards)
{
    let category = PopupFind("ItemDropCategory")
    if (!category) { return }
    category.SetHasClass("panel_hidden", drop_type == null)
    if (drop_type == null) { return }
    let text = PopupFind("ItemDropCategoryText")
    let icon = PopupFind("ItemDropCategoryIcon")
    if (drop_type == "category_dup_shards")
    {
        text.text = ((shards > 0) ? ($.Localize("#chest_already_have2") + shards) : "") + $.Localize("#" + drop_type)
    }
    else
    {
        text.text = $.Localize("#" + drop_type)
    }

    icon.SetHasClass("panel_hidden", !drop_type.startsWith("npc_") && !drop_type.startsWith("item_"))
    icon.SetHasClass("ItemDropCategoryIconItem", drop_type.startsWith("item_"))

    if (drop_type.startsWith("item_"))
    {
        let name = drop_type.replace(/^item_/, "");

        icon.style.backgroundImage = 'url( "file://{images}/custom_game/shop/effects/section/' + name + '.png" );'
        text.text = $.Localize("#category_effect")
    }

    if (drop_type.startsWith("npc_"))
    {
        let name = Game.GetHeroImage(Game.GetLocalPlayerID(), drop_type)
        icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + name + '.png" );'
    }
    icon.style.backgroundSize = 'contain';
    icon.style.backgroundRepeat = 'no-repeat'
}

function PopupGiveDrop(which, drop_info, is_dup, shards)
{
    let drop = PopupFind("DropItemPanel")
    if (drop) { drop.SetHasClass("DropItemPanelVisible", true) }

    let pair_panel = PopupFind("ChestHudMainPanel")
    if (pair_panel)
    {
        let drop_effect = $.CreatePanel("DOTAParticleScenePanel", pair_panel, "", {particleName:"particles/ui/ui_generic_treasure_impact.vpcf", renderdeferred:"true", particleonly:"false", startActive:"true", cameraOrigin:"0 0 300", lookAt:"0 0 0", fov:"60"})
        drop_effect.AddClass("item_drop_effect")
        drop_effect.hittest = false
        drop_effect.DeleteAsync(3)
    }

    let drop_type = drop_info != null && drop_info.drop_type != null ? drop_info.drop_type : null
    let icon = PopupFind("ItemDropIcon")
    let name = PopupFind("ItemDropName")

    if (is_dup == 1)
    {
        if (icon)
        {
            icon.SetHasClass("ItemDropIconSquare", false)
            icon.style.backgroundImage = 'url("file://{images}/econ/tools/battle_points_ti11_levels_5.png")'
            icon.style.backgroundSize = "100%"
        }
        if (name) { name.text = $.Localize("#chest_already_have"); name.SetHasClass("ItemDropNamePhrase", false) }
        drop_type = "category_dup_shards"
    }
    else
    {
        if (icon)
        {
            let is_square = drop_info.drop_type == "category_tip"
            icon.SetHasClass("ItemDropIconSquare", is_square)
            icon.style.backgroundImage = 'url("' + drop_info.item_icon + '")'
            icon.style.backgroundSize = is_square ? "85% 85%" : "100%"
            icon.style.backgroundRepeat = "no-repeat"
            icon.style["background-position"] = "50%"
        }
        if (name) { name.text = PopupGetItemDisplayName(drop_info); name.SetHasClass("ItemDropNamePhrase", drop_info.is_sound == 1) }
    }
    Game.EmitSound("ui.treasure_01")
    if (popup_loop_sound != undefined) { Game.StopSound(popup_loop_sound); popup_loop_sound = undefined }

    if (POPUP_INFO && POPUP_INFO[which]) { POPUP_INFO[which].opened = 1 }
    let opened_line = PopupFind(which == "rich" ? "RollLineBack2" : "RollLineBack")
    if (opened_line) { opened_line.AddClass("RollLineGray") }
    let opened_icon = PopupFind(which == "rich" ? "RollLineChestIconRich" : "RollLineChestIconPoor")
    if (opened_icon) { opened_icon.AddClass("RollLineGray") }
    PopupUpdateButton()

    PopupSetDropCategory(drop_type, shards)

    PopupFind("ItemDropClaimButtonLabel").text = $.Localize("#" + (is_dup ? "claim_reward_shards" : "claim_reward"))
    let claim = PopupFind("ItemDropClaimButton")
    if (claim)
    {
        claim.SetPanelEvent("onactivate", function()
        {
            Game.EmitSound("UI.Weekly_Click")
            Game.EmitSound("UI.Click")
            if (drop) { drop.SetHasClass("DropItemPanelVisible", false) }
            POPUP_ANIM = false
            PopupUpdateButton()
        })
    }
}

(function()
{
    GameUI.CustomUIConfig().chest_popup_driving = false
    PopupLoadChestWindow()
    ChestGrantedShow()
})()