--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var AlertWindow = $("#StartQuestAlert")
var AlertContent = $("#StartQuestAlertContent")
var AlertIcons = $("#StartQuestAlertIcons")  
var AlertClose = $("#StartQuestAlertClose")  
var CurrentQuestsContent = $("#CurrentQuestsContent") 
var CurrentQuestsCompleted = $("#CurrentQuestsCompleted") 
var StartQuestPointer = $("#StartQuestPointer") 
var StartQuestPointerArrow = $("#StartQuestPointerArrow")

var show_state = false
var show_state_completed = false
var show_quest_cd = false
var need_show_quest = false
var quest_count = 0

var tips_array = []
var tips_index = 0

const TaskManager = {
    tasks: {},
    schedule: (name, delay, callback) => {
        TaskManager.tasks[name] = false;
        $.Schedule(delay, () => {
            if (TaskManager.tasks[name] === false) {
                callback();
            }
        });
    },
    cancel: (name) => {
        TaskManager.tasks[name] = true; 
    }
};


function init()
{
    GameEvents.Subscribe_custom("ShowQuestAlert", ShowQuestAlert)
    GameEvents.Subscribe_custom("HideQuestAlert", HideQuestAlert)
    GameEvents.Subscribe_custom("UpdateCurrentQuests", UpdateCurrentQuests)
    GameEvents.SendCustomGameEventToServer_custom("RequestCurrentQuests", {})
    InitTips()
}


init()
function ClearWindow()
{
    AlertContent.RemoveAndDeleteChildren()
    AlertIcons.RemoveAndDeleteChildren()

    AlertContent.RemoveClass("StartQuestAlertContent_full")
    AlertContent.RemoveClass("StartQuestAlertContent_normal")
    AlertContent.RemoveClass("StartQuestAlertContent_small")
    AlertContent.RemoveClass("StartQuestAlertContent_supersmall")

    AlertIcons.RemoveClass("StartQuestAlertIcons_normal")
    AlertIcons.RemoveClass("StartQuestAlertIcons_big")
    AlertIcons.RemoveClass("StartQuestAlertIcons_huge")

    AlertWindow.RemoveClass("StartQuestAlert_Quest")
    AlertWindow.RemoveClass("StartQuestAlert_Tip")
    AlertWindow.RemoveClass("StartQuestAlert_big")
    AlertWindow.RemoveClass("StartQuestAlert_normal")
    AlertWindow.RemoveClass("StartQuestAlert_normal_2")
    AlertWindow.RemoveClass("StartQuestAlert_small")
    AlertWindow.RemoveClass("StartQuestAlert_normal_thin")
    AlertWindow.RemoveClass("StartQuestAlert_normal_long")

    AlertWindow.RemoveClass("panel_hidden")
    AlertWindow.RemoveClass("StartQuestAlert_hide")

    if (!AlertWindow.BHasClass("StartQuestAlert_show"))
        AlertWindow.AddClass("StartQuestAlert_show")

}


//$.Schedule(1, function()
//{
 // ShowQuestAlert({type: "Quest_end_1"})
//})

function TestTip()
{
    ShowQuestAlert({is_tip: 1})
  //  $.Schedule(5, TestTip)
}

//TestTip()

var current_window = null
var quest_sound = ""
function ShowQuestAlert(data)
{
    ClearWindow()

    let type = data.type
    let is_tip = data.is_tip
    let timer = data.timer
    let use_close = true
    need_show_quest = true

    TaskManager.cancel(current_window);

    if (type)
    {
        current_window = type
        AlertWindow.AddClass("StartQuestAlert_Quest")
        quest_sound = "StartQuest.Quest_start"

        switch (type)
        {
            case "Quest_Start":
                quest_sound = "StartQuest.Quest_pick"
                Quest_Start()
                use_close = false
                need_show_quest = false
            break;
            case "Quest_1":
                DefaultQuest("", "#DiscStartQuest_1_1", "#DiscStartQuest_1_2", null, true)
                Quest_1()
            break;
            case "Quest_2":
                DefaultQuest("", "#DiscStartQuest_2_1", "#DiscStartQuest_2_2", "item_gray_upgrade")
                Quest_2()
            break;
            case "Quest_3":
                DefaultQuest("StartQuest3_icon", "#DiscStartQuest_3_1", "#DiscStartQuest_3_2")
                Quest_3()
            break;
            case "Quest_4":
                DefaultQuest("", "#DiscStartQuest_4_1", "#DiscStartQuest_4_2", "item_blue_upgrade")
                Quest_4()
            break;
            case "Quest_5":
                DefaultQuest("", "#DiscStartQuest_5_1", "#DiscStartQuest_5_2", "item_purple_upgrade")
            break;
            case "Quest_5_1":
                DefaultQuest("", "#DiscStartQuest_5_1", "#DiscStartQuest_5_3", "item_purple_upgrade")
                Quest_5_1()
                need_show_quest = false
            break;
            case "Quest_6":
                DefaultQuest("", "#DiscStartQuest_6_1", "#DiscStartQuest_6_2", "item_legendary_upgrade")
            break;
            case "Quest_7":
                DefaultQuest("StartQuest7_icon", "#DiscStartQuest_7_1", "#DiscStartQuest_7_2")
            break;
            case "Quest_8":
                DefaultQuest("StartQuest8_icon", "#DiscStartQuest_8_1", "#DiscStartQuest_8_2")
                Quest_8()       
            break;
            case "Quest_9":
                DefaultQuest("StartQuest9_icon", "#DiscStartQuest_9_1", "#DiscStartQuest_9_2")
            break;
            case "Quest_10":
                DefaultQuest("StartQuest10_icon", "#DiscStartQuest_10_1", "#DiscStartQuest_10_2") 
            break;
            case "Quest_10_1":  
                DefaultQuest("StartQuest10_1_icon", "#DiscStartQuest_10_1", "#DiscStartQuest_10_3")
                need_show_quest = false
            break;
            case "Quest_11":
                DefaultQuest("StartQuest11_icon", "#DiscStartQuest_11_1", "#DiscStartQuest_11_2")
            break;
            case "Quest_11_1":
                DefaultQuest("", "#DiscStartQuest_11_1", "#DiscStartQuest_11_3", "item_patrol_razor")
                need_show_quest = false
            break;
            case "Quest_end":
                Quest_end()
                need_show_quest = false
            break;
            case "Quest_end_1":
                Quest_end_1()
                need_show_quest = false 
            break;
            case "Quest_shop":
                if (!Game.AllowShop(Game.GetLocalPlayerID()))
                    return
                need_show_quest = false 
                quest_sound = "StartQuest.Quest_shards"
                DefaultQuest("StartQuestShop_icon", "#StartQuestShop_1", "#StartQuestShop_2")
                Quest_shop()  
            break;
        }
    }


    if (is_tip)
    {
        AlertWindow.AddClass("StartQuestAlert_Tip")
        need_show_quest = false

        let tip_type = "Tip_" + tips_array[tips_index]
        current_window = tip_type

        tips_index = tips_index + 1

        if (tips_index >= tips_array.length)
            tips_index = 0

        switch (tip_type)
        {
            case "Tip_1":
                DefaultTip("", "#Tip_text_1", "item_crimson_guard_custom")
            break;
            case "Tip_2":
                DefaultTip("TipIcon2", "#Tip_text_2")
                Tip_2()
            break;
            case "Tip_3":
                DefaultTip("TipIcon3", "#Tip_text_3")
            break;
            case "Tip_4":
                DefaultTip("", "#Tip_text_4", "item_spell_breaker")
            break;
            case "Tip_5":
                DefaultTip("TipIcon5", "#Tip_text_5")
                Tip_5()
            break;
            case "Tip_6":
                DefaultTip("TipIcon6", "#Tip_text_6")
            break;
            case "Tip_7":
                DefaultTip("", "#Tip_text_7", "item_travel_boots_2_custom")
            break;
            case "Tip_8":
                DefaultTip("", "#Tip_text_8", "item_patrol_trap")
            break;
            case "Tip_9":
                DefaultTip("", "#Tip_text_9", "item_purple_upgrade")
            break;
            case "Tip_10":
                DefaultTip("TipIcon10", "#Tip_text_10")
            break;
            case "Tip_11":
                DefaultTip("TipIcon11", "#Tip_text_11")
            break;
            case "Tip_12":
                DefaultTip("TipIcon12", "#Tip_text_12")
            break;
            case "Tip_13":
                DefaultTip("TipIcon13", "#Tip_text_13")
            break;
            case "Tip_14":
                DefaultTip("", "#Tip_text_14", null, ["item_orb_of_corrosion_custom", "item_falcon_blade_custom", "item_soul_ring_custom"])
            break;
            case "Tip_15":
                DefaultTip("TipIcon15", "#Tip_text_15")
            break;
            case "Tip_16":
                DefaultTip("TipIcon16", "#Tip_text_16")
            break;
            case "Tip_17":
                DefaultTip("TipIcon17", "#Tip_text_17")
            break;
            case "Tip_18":
                DefaultTip("", "#Tip_text_18", null, ["item_spirit_vessel_custom"])
            break;
            case "Tip_19":
                DefaultTip("TipIcon10", "#Tip_text_19")
            break;
            case "Tip_20":
                DefaultTip("TipIcon20", "#Tip_text_20")
            break;
            case "Tip_21":
                DefaultTip("", "#Tip_text_21", null, ["item_assault_custom", "item_skadi_custom"])
            break;
            case "Tip_22":
                DefaultTip("", "#Tip_text_22", null, ["item_celestial_spear_custom", "item_gungir_custom"])
            break;
            case "Tip_23":
                DefaultTip("", "#Tip_text_23", "item_aeon_disk_custom")
            break;
            case "Tip_24":
                DefaultTip("", "#Tip_text_24", "item_hand_of_midas_custom")
            break;
            case "Tip_25":
                DefaultTip("TipIcon25", "#Tip_text_25")
            break;
            case "Tip_26":
                DefaultTip("TipIcon26", "#Tip_text_26")
            break;
            case "Tip_27":
                DefaultTip("TipIcon27", "#Tip_text_27")
            break;
            case "Tip_28":
                DefaultTip("", "#Tip_text_28", null, ["item_soulguard_custom", "item_bloodstone_custom"])
            break;
            case "Tip_29":
                DefaultTip("", "#Tip_text_29", "item_patrol_razor")
            break;
            case "Tip_30":
                DefaultTip("TipIcon30", "#Tip_text_30")
            break;
            case "Tip_31":
                DefaultTip("TipIcon31", "#Tip_text_31")
            break;
            case "Tip_32":
                DefaultTip("TipIcon32", "#Tip_text_32")
                Tip_32()
            break;
            case "Tip_33":
                DefaultTip("TipIcon10", "#Tip_text_33")
            break;
            case "Tip_34":
                DefaultTip("TipIcon34", "#Tip_text_34")
            break;
            case "Tip_35":
                DefaultTip("TipIcon35", "#Tip_text_35")
            break;
            case "Tip_36":
                DefaultTip("TipIcon36", "#Tip_text_36")
            break;
            case "Tip_37":
                DefaultTip("TipIcon37", "#Tip_text_37")
        }
    }

    AlertClose.SetHasClass("panel_hidden", use_close == false)

    if (timer > 0)
    {
        TaskManager.schedule(current_window, timer, () => {
            HideQuestAlert()
        });
    }
}


function DefaultTip(icon_style, text, item_name, item_table)
{
    AlertWindow.AddClass("StartQuestAlert_normal")
    AlertContent.AddClass("StartQuestAlertContent_small")
    AlertIcons.AddClass("StartQuestAlertIcons_big")

    if (item_table)
    {
        let item_container = $.CreatePanel("Panel", AlertIcons, "")
        item_container.AddClass("StartQuest1_ItemContainer")

        for (let name of item_table)
        { 
            let item_icon = $.CreatePanel("DOTAItemImage", item_container, "StartQuest_item");
            item_icon.AddClass("StartQuest_item_normal")
            item_icon.itemname = name;
        }
    }
    else if (!item_name)
    {
        let icon = $.CreatePanel("Panel", AlertIcons, "");
        icon.AddClass("Tip_icon")
        icon.AddClass(icon_style)
    }else
    {
        let item_container = $.CreatePanel("Panel", AlertIcons, "")
        item_container.AddClass("StartQuest2_ItemContainer")
        
        let item_icon = $.CreatePanel("DOTAItemImage", item_container, "StartQuest_item");
        item_icon.AddClass("StartQuest_item_big")
        item_icon.itemname = item_name;
    }

    let header = $.CreatePanel("Label", AlertContent, "")
    header.AddClass("StartQuest_header")
    header.AddClass("Tips_Header")

    header.html = true
    header.text = $.Localize("#Tip_text_header")

    let label = $.CreatePanel("Label", AlertContent, "")
    label.AddClass("StartQuest_label")
    label.AddClass("StartQuest1_Text")

    label.html = true
    label.text = $.Localize(text)
}

function Tip_2()
{
    AlertWindow.AddClass("StartQuestAlert_normal_2")
}

function Tip_5()
{
    AlertWindow.AddClass("StartQuestAlert_normal_2")
}

function Tip_32()
{
    AlertIcons.AddClass("StartQuestAlertIcons_huge")
    AlertContent.AddClass("StartQuestAlertContent_supersmall")
    AlertWindow.AddClass("StartQuestAlert_normal_thin")
}




function Quest_Start()
{
    Game.EmitSound(quest_sound)
    AlertWindow.AddClass("StartQuestAlert_normal")
    AlertContent.AddClass("StartQuestAlertContent_normal")
    AlertIcons.AddClass("StartQuestAlertIcons_normal")

    let dota_icon = $.CreatePanel("Panel", AlertIcons, "")
    dota_icon.AddClass("StartQuestIcon")

    let header = $.CreatePanel("Label", AlertContent, "")
    header.AddClass("StartQuest_header")
    header.AddClass("StartQuestAlertHeader")

    header.html = true
    header.text = $.Localize("#DiscStartQuest_0_1")

    let label = $.CreatePanel("Label", AlertContent, "")
    label.AddClass("StartQuest_label")
    label.AddClass("StartQuestAlertText")

    label.html = true
    label.text = $.Localize("#DiscStartQuest_0_2")

    let bottom_panel = $.CreatePanel("Panel", AlertContent, "")
    bottom_panel.AddClass("StartQuestAlertBottom")

    let button_yes = $.CreatePanel("Panel", bottom_panel, "")
    button_yes.AddClass("StartQuestAlertButton")
    button_yes.AddClass("StartQuestAlertButton_yes")

    let label_yes = $.CreatePanel("Label", button_yes, "")
    label_yes.AddClass("StartQuest_button_text")
    label_yes.AddClass("StartQuestAlertButtonText")

    label_yes.text = $.Localize("#StartQuest_button_yes")

    let button_no = $.CreatePanel("Panel", bottom_panel, "")
    button_no.AddClass("StartQuestAlertButton")
    button_no.AddClass("StartQuestAlertButton_no")

    let label_no = $.CreatePanel("Label", button_no, "")
    label_no.AddClass("StartQuest_button_text")
    label_no.AddClass("StartQuestAlertButtonText")

    label_no.text = $.Localize("#StartQuest_button_no")

    button_yes.SetPanelEvent("onactivate", function() {
        Game.EmitSound("UI.Click")
        HideQuestAlert()
    });

    button_no.SetPanelEvent("onactivate", function() {
        Game.EmitSound("UI.Click")
        GameEvents.SendCustomGameEventToServer_custom("ChangeSettings", {type: 3, override: 1})
        CloseShowSettings()
    });
}

function DefaultQuest(icon_style, text_1, text_2, item_name, ignore_icons)
{
    Game.EmitSound(quest_sound)
    AlertWindow.AddClass("StartQuestAlert_normal")
    AlertContent.AddClass("StartQuestAlertContent_small")
    AlertIcons.AddClass("StartQuestAlertIcons_big")

    if (!ignore_icons)
    {
        if (!item_name)
        {
            let icon = $.CreatePanel("Panel", AlertIcons, "");
            icon.AddClass("StartQuest_icon")
            icon.AddClass(icon_style)
        }else
        {
            let item_container = $.CreatePanel("Panel", AlertIcons, "")
            item_container.AddClass("StartQuest2_ItemContainer")
            
            let item_icon = $.CreatePanel("DOTAItemImage", item_container, "StartQuest_item");
            item_icon.AddClass("StartQuest_item_big")
            item_icon.itemname = item_name;
        }
    }

    let header = $.CreatePanel("Label", AlertContent, "")
    header.AddClass("StartQuest_header")
    header.AddClass("StartQuest2_Header")

    header.html = true
    header.text = $.Localize(text_1)

    let label = $.CreatePanel("Label", AlertContent, "")
    label.AddClass("StartQuest_label")
    label.AddClass("StartQuest1_Text")

    label.html = true
    label.text = $.Localize(text_2)
}


function Quest_1()
{
    AlertWindow.AddClass("StartQuestAlert_normal")
    AlertContent.AddClass("StartQuestAlertContent_normal")
    AlertIcons.AddClass("StartQuestAlertIcons_normal")

    let items = 
    [
        "item_bracer_custom",
        "item_null_talisman_custom",
        "item_wraith_band_custom"
    ]

    let item_container = $.CreatePanel("Panel", AlertIcons, "")
    item_container.AddClass("StartQuest1_ItemContainer")

    for (let name of items)
    { 
        let item_icon = $.CreatePanel("DOTAItemImage", item_container, "StartQuest_item");
        item_icon.AddClass("StartQuest_item_normal")
        item_icon.itemname = name;
    }
}

function Quest_2()
{
    AlertWindow.AddClass("StartQuestAlert_normal_thin")
    ClearPointer("left")
    StartQuestPointer.AddClass("StartQuestPointer_quest_2")
    $("#StartQuestPointerBlockText").text = $.Localize("#DiscStartQuest_2_pointer")
}

function Quest_3()
{
    AlertWindow.AddClass("StartQuestAlert_normal_thin")
}

function Quest_4()
{
    ClearPointer("right")
    StartQuestPointer.AddClass("StartQuestPointer_quest_4")
    $("#StartQuestPointerBlockText").text = $.Localize("#DiscStartQuest_4_pointer")
}

function Quest_5_1()
{
    ClearPointer("right")
    StartQuestPointer.AddClass("StartQuestPointer_quest_5")
    $("#StartQuestPointerBlockText").text = $.Localize("#DiscStartQuest_5_pointer")
}

function Quest_8()
{
    AlertWindow.AddClass("StartQuestAlert_big")
}

function Quest_end()
{

    Game.EmitSound("StartQuest.Quest_end")
    AlertWindow.AddClass("StartQuestAlert_normal_long")
    AlertContent.AddClass("StartQuestAlertContent_normal")
    AlertIcons.AddClass("StartQuestAlertIcons_normal")

    let dota_icon = $.CreatePanel("Panel", AlertIcons, "")
    dota_icon.AddClass("StartQuestIcon")

    let header = $.CreatePanel("Label", AlertContent, "")
    header.AddClass("StartQuest_header")
    header.AddClass("StartQuest2_Header")

    header.html = true
    header.text = $.Localize("#DiscStartQuest_end_1")

    let label = $.CreatePanel("Label", AlertContent, "")
    label.AddClass("StartQuest_label")
    label.AddClass("StartQuestEnd_Text")

    label.html = true
    label.text = $.Localize("#DiscStartQuest_end_2")

    $.Schedule(25, function()
    {
        HideQuestAlert()
    })
}

function Quest_end_1()
{
    AlertWindow.AddClass("StartQuestAlert_normal")
    AlertContent.AddClass("StartQuestAlertContent_normal")
    AlertIcons.AddClass("StartQuestAlertIcons_normal")

    let dota_icon = $.CreatePanel("Panel", AlertIcons, "")
    dota_icon.AddClass("StartQuestIcon")

    let header = $.CreatePanel("Label", AlertContent, "")
    header.AddClass("StartQuest_header")
    header.AddClass("StartQuest2_Header")

    header.html = true
    header.text = $.Localize("#DiscStartQuest_end_1")

    let label = $.CreatePanel("Label", AlertContent, "")
    label.AddClass("StartQuest_label")
    label.AddClass("StartQuestEnd_Text")

    label.html = true
    label.text = $.Localize("#DiscStartQuest_end_3")
    $.Schedule(10, function()
    {
        HideQuestAlert()
    })
}


function Quest_shop()
{
    ClearPointer("right")
    StartQuestPointer.AddClass("StartQuestPointer_quest_shop")
    $("#StartQuestPointerBlockText").text = $.Localize("#DiscStartQuest_shop_pointer")
}

function CloseShowSettings(data)
{
    ClearWindow()
    AlertWindow.AddClass("StartQuestAlert_small")
    AlertContent.AddClass("StartQuestAlertContent_full")
    AlertClose.SetHasClass("panel_hidden", false)

    let settings_icon = $.CreatePanel("Panel", AlertContent, "")
    settings_icon.AddClass("StartQuestSettingsInfo")

    let settings_text = $.CreatePanel("Label", AlertContent, "")
    settings_text.AddClass("StartQuest_label")
    settings_text.AddClass("StartQuestSettingsInfo_Text")

    settings_text.text = $.Localize("#DiscStartQuest_settings")

    $.Schedule(7, function()
    {
        HideQuestAlert()
    })
}

function ClearPointer(dir)
{
    StartQuestPointer.RemoveClass("panel_hidden") 
    StartQuestPointer.RemoveClass("StartQuestPointer_quest_2")
    StartQuestPointer.RemoveClass("StartQuestPointer_quest_4")
    StartQuestPointer.RemoveClass("StartQuestPointer_quest_5")
    StartQuestPointer.RemoveClass("StartQuestPointer_left")
    StartQuestPointer.RemoveClass("StartQuestPointer_right")
    StartQuestPointerArrow.RemoveClass("StartQuestPointerArrow_left")
    StartQuestPointerArrow.RemoveClass("StartQuestPointerArrow_right")

    if (dir == "left")
    {
        StartQuestPointer.AddClass("StartQuestPointer_left")
        StartQuestPointerArrow.AddClass("StartQuestPointerArrow_left")
    }else
    {
        StartQuestPointer.AddClass("StartQuestPointer_right")
        StartQuestPointerArrow.AddClass("StartQuestPointerArrow_right")
    }
}

function HideQuestAlert(data)
{

    if (data && data.completed_quest && data.completed_quest != current_window)
        return

    if (need_show_quest)
    {
        need_show_quest = false
        ShowQuestsAuto()
    }

    if (current_window == "Quest_end")
    {
        $.Schedule(1, function()
        {
            ShowQuestAlert({type: "Quest_end_1"})
        })
    }

    TaskManager.cancel(current_window);

    StartQuestPointer.AddClass("panel_hidden")
    let AlertWindow = $("#StartQuestAlert")
    AlertWindow.RemoveClass("StartQuestAlert_show")
    AlertWindow.AddClass("StartQuestAlert_hide")

    $.Schedule(0.28, function()
    {
        AlertWindow.AddClass("panel_hidden")
    })
}

function UpdateCurrentQuests(data)
{
    let main_panel = $("#CurrentQuests")
    main_panel.RemoveClass("panel_hidden")

    let got_quest = false
    quest_count = 0
    let completed_count = 0
    let max_quest = data.max_quest

    for (let id in data.quest_data)
    {   
        let quest_data = data.quest_data[id]
        let name = quest_data.name
        let goal = quest_data.goal
        let progress = quest_data.progress
        let completed = quest_data.completed
        let quest_panel = $.GetContextPanel().FindChildTraverse("quest_panel_" + name)
        if (completed == 1)
        {
            completed_count = completed_count + 1
            CompleteQuest(name)
        }else
        {
            quest_count = quest_count + 1
            got_quest = true
            if (!quest_panel)
            {
                quest_panel = $.CreatePanel("Label", CurrentQuestsContent, "quest_panel_" + name)
                quest_panel.html = true
                quest_panel.AddClass("CurrentQuestsContentText")
            }
            quest_panel.text = id + ") " + $.Localize("#Start" + name) + " (" + progress + "/" + goal + ")"

            let full_text = $.Localize("#DiscStart" + name + "_2")
            quest_panel.SetPanelEvent('onmouseover', function() 
            {
                $.DispatchEvent('DOTAShowTextTooltip', quest_panel, full_text) 
            });
            quest_panel.SetPanelEvent('onmouseout', function() 
            {
                $.DispatchEvent('DOTAHideTextTooltip', quest_panel);
            });


        }
    }

    let no_quest = $.GetContextPanel().FindChildTraverse("no_quest_label") 
    let header = $("#CurrentQuestsHeaderText")
    header.text = $.Localize("#CurrentQuestsHeader") + " (" + completed_count + "/" + max_quest + ")"

    if (got_quest == false)
    {
        if (!no_quest)
        {
            no_quest = $.CreatePanel("Label", CurrentQuestsContent, "no_quest_label") 
            no_quest.AddClass("CurrentQuestsContentText")
            no_quest.text = $.Localize("#StartQuestNo")
        }
    }else
    {
        if (no_quest)
            no_quest.DeleteAsync(0)
    }
}

function CompleteQuest(name)
{
    let quest_panel = $.GetContextPanel().FindChildTraverse("quest_panel_" + name)
    if (quest_panel)
    {
        quest_panel.DeleteAsync(0)
    }else
        return

    Game.EmitSound("StartQuest.Quest_complete")
    let text = $.CreatePanel("Label", CurrentQuestsCompleted, "quest_completed_" + name )
    text.html = true
    text.AddClass("CurrentQuestsContentText")
    text.AddClass("CurrentQuestsContentText_completed")
    text.text = $.Localize("#Start" + name)

    $.Schedule(5, function()
    {
        text.DeleteAsync(0)
    })  

    if (show_state_completed)
        return

    CurrentQuestsCompleted.RemoveClass("panel_hidden")
    CurrentQuestsCompleted.AddClass("CurrentQuestsContent_show")
    CurrentQuestsCompleted.RemoveClass("CurrentQuestsContent_hide")
    show_state_completed = true

    $.Schedule(3, function()
    {
        show_state_completed = false
        CurrentQuestsCompleted.RemoveClass("CurrentQuestsContent_show")
        CurrentQuestsCompleted.AddClass("CurrentQuestsContent_hide")
        $.Schedule(0.25, function()
        {
            CurrentQuestsCompleted.AddClass("panel_hidden")
        }) 
    })
}


function ShowQuestsAuto()
{
    if (show_state == true || quest_count == 0)
        return

    ToggleShowQuests()

    $.Schedule(3, function()
    {
        if (show_state == true)
            ToggleShowQuests()  
    })
}

function ToggleShowQuests()
{

    if (show_quest_cd)
        return

    var CurrentQuestsHeaderButton = $("#CurrentQuestsHeaderButton") 
  
    if (show_state == true)
    {
        CurrentQuestsContent.RemoveClass("CurrentQuestsContent_show")
        CurrentQuestsContent.AddClass("CurrentQuestsContent_hide")
        $.Schedule(0.25, function()
        {
            CurrentQuestsContent.AddClass("panel_hidden")
        })
        show_state = false
    }else
    {
        CurrentQuestsContent.RemoveClass("panel_hidden")
        CurrentQuestsContent.AddClass("CurrentQuestsContent_show")
        CurrentQuestsContent.RemoveClass("CurrentQuestsContent_hide")
        show_state = true
    }   

    show_quest_cd = true
    $.Schedule(0.35, function()
    {
        show_quest_cd = false
    })

    CurrentQuestsHeaderButton.SetHasClass("CurrentQuestsHeaderButton_opened", show_state == true)
    CurrentQuestsHeaderButton.SetHasClass("CurrentQuestsHeaderButton_closed", show_state == false)
}

function InitTips()
{
    let array = []
    for (let i = 1; i <= 100; i++)
    {
        let text = "#Tip_text_" + i
        let tip = $.Localize(text)

        if (tip == text)
            break

        array.push(i)
    }
    tips_array = array.sort(() => Math.random() - 0.5);
}
