--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);



CustomNetTables.SubscribeNetTableListener( "sub_data", update_sub_data );
CustomNetTables.SubscribeNetTableListener( "upgrades_player", update_upgrades_player );

var full_talents = 0
var common_bonus = 0
var ChoiseOpened = false
var use_short_table = {1: 0, 2: 0, 3: 0, 4: 0}

function update_sub_data(table, key, data)
{
    if (table != "sub_data") return
    if (key == -1 || key == "-1" || key == "") return
    if (key != String(Game.GetLocalPlayerID())) return

    full_talents = data.full_talents
}

function update_upgrades_player(table, key, data)
{
    if (table != "upgrades_player") return

    const hero = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()))

    if (key != hero) return
    common_bonus = data.common_bonus/100
}


function init() 
{
    GameEvents.Subscribe_custom('show_choise', OnShow)
    GameEvents.Subscribe_custom('end_choise', EndChoise)

    const hero = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()))
    var sub_data = CustomNetTables.GetTableValue("sub_data", String(Game.GetLocalPlayerID()));

    if (sub_data && sub_data.full_talents) 
    {
        full_talents = sub_data.full_talents
    }

    var player_table = CustomNetTables.GetTableValue("upgrades_player", hero)

    if (player_table && player_table.common_bonus)
    {
        common_bonus = player_table.common_bonus/100
    }
}


init();

var global_choise = []
var max = 0
var can_refresh = 0

function OnShow(kv)
{
    var table = kv.choise

    var alert = kv.alert
    var hasup = kv.hasup
    var stack = kv.mods
    var after_legen = kv.after_legen
    var perma_info = kv.perma_info

    can_refresh = kv.refresh

    var alert_window = $.GetContextPanel().FindChildTraverse("alert_window")

    alert_window.AddClass("card_hidden")
    alert_window.RemoveClass("alert_window_close")
    alert_window.RemoveClass("alert_window_open")

    $.DispatchEvent("DropInputFocus")

    Game.EmitSound("UI.Choise_show")

    if (alert == 1 && false) 
    {
        alert_window.RemoveClass("card_hidden")
        alert_window.AddClass("alert_window_open")

        $.Schedule(0.4, function()
        {
            if (alert_window.BHasClass("alert_window_open"))
            alert_window.RemoveClass("alert_window_open")
        })
    }

    var main = $.GetContextPanel().FindChildTraverse("Cards")
	const hero = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()))
    let hero_index = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())

    use_short_table = {1: 0, 2: 0, 3: 0, 4: 0}

    let use_new_system = false
    if (Game.new_talent_system[hero])
        use_new_system = true

    global_choise = []

    let cards = $.GetContextPanel().FindChildTraverse("Cards")
    max = Object.keys(table).length

    cards.style.width = String(max * 400) + "px"

    let pick_rate_table = {}

    for (var i = 1; i <= max; i++) 
    {
        ClearCard(i)

        let name = table[i]

        let table_name = hero
        let talent_data = Game.talents_values[table_name][name]

        if (talent_data == undefined)
        {
            for (find_table_name in Game.talents_values)
            {
                if (Game.talents_values[find_table_name][name] != undefined)
                {
                    talent_data = Game.talents_values[find_table_name][name]
                    table_name = find_table_name
                    break
                }
            }
        }

        if (talent_data == undefined)
            continue


        let refresh_table = {}
        refresh_table["name"] = name
        refresh_table["skill_number"] = talent_data["skill_number"]

        global_choise.push(refresh_table)

        let rarity = talent_data["rarity"]
        let skill_number = talent_data["skill_number"]
        let max_level = Game.GetMaxLevel(talent_data)
        if (talent_data["max_level"])
            max_level = talent_data["max_level"]

        let panel = rarity + "_skill"
        let icon_name = "skills/" + talent_data["skill_icon"]
        let complexity = talent_data["complexity"]
        let skill_change = talent_data["skill_change"]

        let skill_name = null 
        let base_icon_name = null

        if (Game.spells_by_number[hero] && Game.spells_by_number[hero][skill_number])
        {
            skill_name = Game.spells_by_number[hero][skill_number]["name"]
            base_icon_name = Game.spells_by_number[hero][skill_number]["skill_icon"]
        }

        if (rarity == "orange" || (table_name != hero && table_name != "general" && table_name !="broodmother_spiders"))
            max_level = 0

        let card = $.GetContextPanel().FindChildTraverse("card" + String(i))
        card.AddClass("card_opened")

        let text = card.FindChildTraverse("text" + String(i))
        let short_label = card.FindChildTraverse("short_text" + String(i))
        let stacks = card.FindChildTraverse("stacks" + String(i))
        let icon = card.FindChildTraverse("card_icon" + String(i))
        let perma = card.FindChildTraverse("perma" + String(i))
        let ability_icon = card.FindChildTraverse("ability_icon" + i)
        let info_text = card.FindChildTraverse("card_info_text_" + String(i))
        let card_body = card.FindChildTraverse("card_body_main_" + String(i))
        let talent_effects = card.FindChildTraverse("talent_effects" + String(i))
        let complexity_block = card.FindChildTraverse("complexity_block" + i)

        if (!complexity || alert == 0)
        {
            if (complexity_block)
                complexity_block.DeleteAsync(0)
        }else
        {
            if (!complexity_block)
            {
                complexity_block = $.CreatePanel("Panel", card, "complexity_block" + i)
                complexity_block.AddClass("complexity_block")

                let complexity_text = $.CreatePanel("Label", complexity_block, "")
                complexity_text.AddClass("complexity_block_text")
                complexity_text.text = $.Localize("#talent_complexity")
            }

            let complexity_levels = card.FindChildTraverse("complexity_levels" + i)
            if (complexity_levels)
                complexity_levels.DeleteAsync(0)

            complexity_levels = $.CreatePanel("Panel", complexity_block, "complexity_levels" + i)
            complexity_levels.AddClass("complexity_levels")

            for (var j = 1; j <= 3; j++)
            {
                level = $.CreatePanel("Panel", complexity_levels, "")
                level.AddClass("complexity_level")

                if (j > complexity)
                    level.AddClass("complexity_level_disable")
            } 
        }

        talent_effects.RemoveAndDeleteChildren(0)
        text.html = true
        short_label.html = true
        text.RemoveClass("text_hidden")

        ability_icon.AddClass("card_hidden")

        if (icon.BHasClass("card_icon")) 
            icon.RemoveClass("card_icon")
        
        if (icon.BHasClass("card_icon_skill")) 
            icon.RemoveClass("card_icon_skill")
        
        if (use_new_system && skill_number == 0 && table_name == hero)
        {
            icon.AddClass("card_icon_hero") 
                panel = rarity + "_hero"  

            icon.style.backgroundImage = 'url( "file://{images}/heroes/' + Game.GetHeroImage(Game.GetLocalPlayerID(), hero) + '.png" );'
            icon.style.backgroundSize = 'contain';
            icon.style.backgroundRepeat = 'no-repeat'

        }else
        {
            if (table_name != hero && table_name != "broodmother_spiders" && talent_data["alt_panel"] == undefined)
            {
                panel = rarity + "_item"
                icon_name = "items/" + talent_data["skill_icon"]
                icon.AddClass("card_icon")
            }else
            {
                icon.AddClass("card_icon_skill")    
            }

            if (skill_name && skill_name != "" && skill_name != null && base_icon_name == talent_data["skill_icon"])
            {
                ability_icon.RemoveClass("card_hidden")

                let ability = Entities.GetAbilityByName(hero_index, skill_name)
                if (ability)
                    ability_icon.contextEntityIndex =  ability
                ability_icon.abilityname = skill_name
            }else
            {
                icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/' + icon_name + '.png")';
                icon.style.backgroundSize = "contain";
            }
        }

        card_body.style.backgroundImage = 'url("file://{images}/custom_game/' + panel + '.png")';
        card_body.style.backgroundSize = "contain";
        card_body.AddClass("card_blur_" + rarity)

        if (rarity == "orange")
        {
            info_text.RemoveClass("card_info_text_purple")
            info_text.AddClass("card_info_text_orange")
        }else
        {
            info_text.RemoveClass("card_info_text_orange")
            info_text.AddClass("card_info_text_purple")
        }

        pick_rate_table[i] = -1

        if (Game.pickrate_talents[hero] && Game.pickrate_talents[hero][Game.local_chosen_build])
            pick_rate_table[i] = (Game.pickrate_talents[hero][Game.local_chosen_build][name]*100).toFixed(0)

        let short_epic ="#epic_disc_" + table[i]
        let short_loc = $.Localize(short_epic)
        
        use_short_table[i] = ((rarity == "orange" || (rarity == "purple" && short_loc != short_epic)) && full_talents == 0) ? 1 : 0

		if (rarity == "gray") 
        {
            let general_value = talent_data["general_bonus"]

            let number = general_value * (1 + common_bonus)
            if (number !== Math.floor(number))
                number = (general_value * (1 + common_bonus)).toFixed(1)
            text.text = "<b><font color=#53ea48>" + '+' + String(number) + "</font></b>" + $.Localize('#talent_disc_' + name)
        }

        if (rarity == "orange")
        {
            text.text = Game.ShowTalentValues("#upgrade_disc_" + name, name, stack[i] + 1, false, true)
            short_label.text = Game.ShowTalentValues("#" + hero + '_legendary_' + String(skill_number), name, 1, false, false) 
        }
        if (rarity == "blue" || rarity == "purple")
        {
            text.text = Game.ShowTalentValues("#upgrade_disc_" + name, name, stack[i] + 1, false, false)
            short_label.text = Game.ShowTalentValues(short_epic, name, 1, false, false) 
        }

        short_label.style.fontSize = '19px'
        text.style.fontSize = GetFontSize(name, rarity)

        if (perma_info && perma_info[i] && perma_info[i].stack !== -1)
            SetPermaInfo(perma, perma_info[i].stack, perma_info[i].max) 

        if (max_level !== 0)
            SetLevelInfo(stacks, rarity == "blue", stack[i], max_level)
        
        let talent_cd = Game.GetTalentValue(name, "talent_cd")
        let is_basher = Game.GetTalentValue(name, "is_basher")
        let cd_panel = $.GetContextPanel().FindChildTraverse("talent_cd" + String(i))
        let basher_icon = $.GetContextPanel().FindChildTraverse("basher_icon" + String(i))
        let skill_change_icon = $.GetContextPanel().FindChildTraverse("skill_change_icon" + String(i))

        if (skill_change != undefined)
        {
            skill_change_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero + '/' + skill_change + '.png")';
            skill_change_icon.style.backgroundSize = 'contain';

            let change_text = $.Localize("#" + hero + "_" + skill_change)

            skill_change_icon.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTextTooltip', skill_change_icon, change_text) });
            
            skill_change_icon.SetPanelEvent('onmouseout', function() {
            $.DispatchEvent('DOTAHideTextTooltip', skill_change_icon); });

            skill_change_icon.RemoveClass("talent_effects_icon_hidden")

        }else
            skill_change_icon.AddClass("talent_effects_icon_hidden")

        if (is_basher != undefined)
        {
            let text = $.Localize("#tooltip_talent_basher")
            
            basher_icon.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTextTooltip', basher_icon, text) });
            
            basher_icon.SetPanelEvent('onmouseout', function() {
            $.DispatchEvent('DOTAHideTextTooltip', basher_icon); });
            basher_icon.RemoveClass("talent_effects_icon_hidden")
        }else
            basher_icon.AddClass("talent_effects_icon_hidden")

        if (talent_cd != undefined)
        {
            let cd_panel = $.GetContextPanel().FindChildTraverse("talent_cd" + String(i))
            let text = $.Localize("#talent_cd")
            
            cd_panel.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTextTooltip', cd_panel, text) });
            
            cd_panel.SetPanelEvent('onmouseout', function() {
            $.DispatchEvent('DOTAHideTextTooltip', cd_panel); });

            let cd_text = $.GetContextPanel().FindChildTraverse("talent_cd_text" + String(i))
            cd_text.text = Game.ShowTalentValues("*talent_cd*", name, stack[i] + 1, false, false)

            cd_panel.RemoveClass("talent_effects_icon_hidden")
        }else
            cd_panel.AddClass("talent_effects_icon_hidden")

        //SetTalentEffects(name, String(i))

        SetAltDown(i)

        let card_number = i
        card_body.SetPanelEvent("onactivate", function() 
        {
            if (!card.BHasClass("card_open"))
                GameEvents.SendCustomGameEventToServer_custom("activate_choise", { chosen: card_number })
        })
    }

    var ClosePanel = $.GetContextPanel().FindChildTraverse("ClosePanel");
    var close = $.GetContextPanel().FindChildTraverse("close")
    var close_text = $.GetContextPanel().FindChildTraverse("close_text")

    close_text.text = $.Localize('#choise_hide')

    ClosePanel.RemoveClass("card_hidden")
    ClosePanel.RemoveClass("ClosePanel_close")
    ClosePanel.AddClass("ClosePanel_open")

    $.Schedule(0.4, function()
    {
        if (ClosePanel.BHasClass("ClosePanel_open"))
        ClosePanel.RemoveClass("ClosePanel_open")
    })


    close.SetPanelEvent("onactivate", function() 
    {
        hide_cards()
    })

    var refresh = $.GetContextPanel().FindChildTraverse("refresh");
    DeleteChoise(refresh)
    refresh.AddClass("card_hidden")

    if (can_refresh == 1) 
    {
        refresh.RemoveClass("card_hidden")

        refresh.SetPanelEvent("onactivate", function() 
        {
            refresh_choise(after_legen)
        })
    }   


    for (var i = 1; i <= 4; i++) 
    {
        let card = $.GetContextPanel().FindChildTraverse("card" + String(i))

        card.style.width = String(100/max) + "%"

        card.RemoveClass("card_hidden_opacity")
        card.RemoveClass("card_close")
        card.RemoveClass("card_close_chosen")
        card.RemoveClass("card_open")
        card.RemoveClass("card_hidden_button")
        card.AddClass("card_hidden")
      
        if (i <= max)
        {
            card.RemoveClass("card_hidden")
            card.AddClass("card_open")

            $.Schedule(0.4, function()
            {
                if (card.BHasClass("card_open"))
                card.RemoveClass("card_open")
            })
        }   
    }


    let max_rate = -1
    let max_id = -1
    let chosen_legendary = ""


    for (skill_number in Game.spells_by_number[hero])
    {
        let skill_data = Game.spells_by_number[hero][skill_number]
        if (Game.local_chosen_build && skill_data.skill_icon == Game.local_chosen_build)
        {
            chosen_legendary = $.Localize("#DOTA_Tooltip_ability_" + skill_data.name)
            break
        }
    }

    for (id in pick_rate_table)
    {
        let pickrate = Number(pick_rate_table[id])
        let pick_rate_panel = $.GetContextPanel().FindChildTraverse("Pickrate_panel" + id)
        pick_rate_panel.AddClass("Pickrate_panel_low")
        pick_rate_panel.RemoveClass("Pickrate_panel_high")

        let text = $.Localize("#pick_rate_tooltip") + chosen_legendary

        pick_rate_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', pick_rate_panel, text) });
        
        pick_rate_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', pick_rate_panel); });

        if (pickrate > max_rate)
        {
            max_rate = pickrate
            max_id = id
        }

        if (pickrate > -1 && alert != 1)
        {
            pick_rate_panel.RemoveClass("card_hidden")
            let pick_rate_text = pick_rate_panel.FindChildTraverse("Pickrate_text")
            if (pick_rate_text)
                pick_rate_text.text = pickrate + "%"
        }else
        {
            pick_rate_panel.AddClass("card_hidden")
        }
    }

    let max_panel = $.GetContextPanel().FindChildTraverse("Pickrate_panel" + max_id)
    if (max_panel)
    {
        max_panel.RemoveClass("Pickrate_panel_low")
        max_panel.AddClass("Pickrate_panel_high")
    }

    ChoiseOpened = true
    $.Schedule(0.1, CheckChoiseAlt)
}

function CheckChoiseAlt()
{
    if (ChoiseOpened == true)
    {   
        for (var i = 1; i <= 4; i++) 
        {
            SetAltDown(i)
        }
        $.Schedule(0.1, CheckChoiseAlt)
    }
}

function SetAltDown(i)
{
    let card = $.GetContextPanel().FindChildTraverse("card" + i)

    let card_info_1 = card.FindChildTraverse("card_info_" + i)
    let text = card.FindChildTraverse("text" + i)
    let short_label = card.FindChildTraverse("short_text" + i)
    let effects_and_cd = card.FindChildTraverse("effects_and_cd" + i)
    let perma = card.FindChildTraverse("perma" + String(i))

    let use_short = use_short_table[i] == 1 && !GameUI.IsAltDown()

    effects_and_cd.SetHasClass("panel_collapse", use_short)
    perma.SetHasClass("panel_collapse", use_short)
    short_label.SetHasClass("panel_collapse", !use_short)
    text.SetHasClass("panel_collapse", use_short)
    card_info_1.SetHasClass("panel_collapse", !use_short)
}



function SetTalentEffects(name, i)
{

    let panel = $.GetContextPanel().FindChildTraverse("talent_effects" + String(i))

    if (true)
        return

    let is_breakable = Game.GetTalentValue(name, "is_breakable")
    let is_purgable = Game.GetTalentValue(name, "is_purgable")
    let is_through_bkb = Game.GetTalentValue(name, "is_through_bkb")
    let is_root_disabled = Game.GetTalentValue(name, "is_root_disabled")
    let is_purgable_self = Game.GetTalentValue(name, "is_purgable_self")
    let is_blockable = Game.GetTalentValue(name, "is_blockable")
    let is_basher = Game.GetTalentValue(name, "is_basher")

    if (is_breakable != 1 && is_purgable != 1 && is_through_bkb != 1 && is_root_disabled != 1 && is_purgable_self != 1 && is_blockable != 1 && is_basher != 1)
    {
        panel.AddClass("talent_effects_icon_hidden")
        return
    }

    panel.RemoveClass("talent_effects_icon_hidden")

    let main = $.GetContextPanel().FindChildTraverse("card_body_main_" + String(i))
    if (!main)
        return


    if (is_basher == 1)
    {
        let basher_panel = $.CreatePanel("Panel", panel, "")
        basher_panel.AddClass("talent_effects_icon")
        basher_panel.AddClass("talent_effects_basher")

        let text = $.Localize("#tooltip_talent_basher")

        basher_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', basher_panel, text) });
        
        basher_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', basher_panel); });
    }
    if (is_breakable == 1)
    {
        let break_panel = $.CreatePanel("Panel", panel, "")
        break_panel.AddClass("talent_effects_icon")
        break_panel.AddClass("talent_effects_break")

        let text = $.Localize("#tooltip_talent_breakable")

        break_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', break_panel, text) });
        
        break_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', break_panel); });
    }

    if (is_purgable == 1)
    {
        let dispell_panel = $.CreatePanel("Panel", panel, "")
        dispell_panel.AddClass("talent_effects_icon")
        dispell_panel.AddClass("talent_effects_dispell")

        let text = $.Localize("#tooltip_talent_purgable")

        dispell_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', dispell_panel, text) });
        
        dispell_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', dispell_panel); });
    }

    if (is_through_bkb == 1)
    {
        let bkb_panel = $.CreatePanel("Panel", panel, "")
        bkb_panel.AddClass("talent_effects_icon")
        bkb_panel.AddClass("talent_effects_bkb")

        let text = $.Localize("#tooltip_talent_through_bkb")

        bkb_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', bkb_panel, text) });
        
        bkb_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', bkb_panel); });
    }

    if (is_blockable == 1)
    {
        let block_panel = $.CreatePanel("Panel", panel, "")
        block_panel.AddClass("talent_effects_icon")
        block_panel.AddClass("talent_effects_block")

        let text = $.Localize("#tooltip_talent_block")

        block_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', block_panel, text) });
        
        block_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', block_panel); });
    }

    if (is_root_disabled == 1)
    {
        let root_panel = $.CreatePanel("Panel", panel, "")
        root_panel.AddClass("talent_effects_icon")
        root_panel.AddClass("talent_effects_root")

        let text = $.Localize("#tooltip_talent_root")

        root_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', root_panel, text) });
        
        root_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', root_panel); });
    }
    if (is_purgable_self == 1)
    {
        let purge_self_panel = $.CreatePanel("Panel", panel, "")
        purge_self_panel.AddClass("talent_effects_icon")
        purge_self_panel.AddClass("talent_effects_purge_self")

        let text = $.Localize("#tooltip_talent_purge_self")

        purge_self_panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', purge_self_panel, text) });
        
        purge_self_panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', purge_self_panel); });
    }
}




function ClearCard(i)
{
    let main = $.GetContextPanel().FindChildTraverse("card" + i)
    let body = $.GetContextPanel().FindChildTraverse("card_body_main_" + i)
    let text = $.GetContextPanel().FindChildTraverse("text" + i)
    let perma = $.GetContextPanel().FindChildTraverse("perma" + i)
    let stacks = $.GetContextPanel().FindChildTraverse("stacks" + i)
    let icon = $.GetContextPanel().FindChildTraverse("card_icon" + i)
    let info_button = $.GetContextPanel().FindChildTraverse("card_info_" + i)

    main.RemoveClass("card_opened")
    stacks.AddClass("text_hidden")
    perma.AddClass("text_hidden")
    text.AddClass("text_hidden")
    text.text = ""
    body.RemoveClass("card_blur_gray")
    body.RemoveClass("card_blur_blue")
    body.RemoveClass("card_blur_purple")
    body.RemoveClass("card_blur_orange")
}




function hide_all(card_number) 
{
    ChoiseOpened = false
    Game.EmitSound("UI.Talent_chose")

    var close = $.GetContextPanel().FindChildTraverse("close")
    var refresh = $.GetContextPanel().FindChildTraverse("refresh")


    var alert_window = $.GetContextPanel().FindChildTraverse("alert_window")

    if (false && !alert_window.BHasClass("card_hidden"))
    {
        alert_window.AddClass("alert_window_close")
        $.Schedule(0.4, function()
        {
            if (alert_window.BHasClass("alert_window_close"))
            {
                alert_window.RemoveClass("alert_window_close")
                alert_window.AddClass("card_hidden")

            }
        })
    }

    DeleteChoise(refresh)
    DeleteChoise(close)


    var ClosePanel = $.GetContextPanel().FindChildTraverse("ClosePanel");

    ClosePanel.AddClass("ClosePanel_close")

    $.Schedule(0.45, function()
    {
        if (ClosePanel.BHasClass("ClosePanel_close"))
        {
            ClosePanel.RemoveClass("ClosePanel_close")
            ClosePanel.AddClass("card_hidden")
        }
    })



    for (var i = 1; i <= max; i++) 
    {
        let main = $.GetContextPanel().FindChildTraverse("card" + i)
        let body = $.GetContextPanel().FindChildTraverse("card_body_main_" + i)

        main.RemoveClass("card_opened")
        DeleteChoise(body)

        let interval = 0.45
        let class_name = "card_close"

        if (card_number != undefined && card_number && card_number == i)
        {
            interval = 0.65
            class_name = "card_close_chosen"
        }

        main.AddClass(class_name)

        $.Schedule(interval, function()
        {
            if (main.BHasClass("card_close") || main.BHasClass("card_close_chosen"))
            {
                main.RemoveClass("card_close")
                main.RemoveClass("card_close_chosen")
                main.AddClass("card_hidden_opacity")
            }
        })

        $.Schedule(0.65, function()
        {
            if (main.BHasClass("card_hidden_opacity"))
            {
                main.RemoveClass("card_hidden_opacity")
                main.AddClass("card_hidden")
            }
        })
    }


    $.DispatchEvent("DropInputFocus")
}




function refresh_choise(after_legen) 
{
    for (var i = 1; i <= max; i++) 
    {
        let card = $.GetContextPanel().FindChildTraverse("card" + i)
        DeleteChoise(card)
    }

    hide_all()

    $.Schedule(0.3, function() 
    {
        GameEvents.SendCustomGameEventToServer_custom("refresh_sphere", {global_choise, after_legen})
    })
}



function hide_cards()
{

    Game.EmitSound("UI.Choise_hide")

    var text = $.GetContextPanel().FindChildTraverse("close_text")
    var refresh = $.GetContextPanel().FindChildTraverse("refresh")
    var card = $.GetContextPanel().FindChildTraverse("card1")

    var flag = false


    if (card.BHasClass("card_hidden_button")) 
    {
        flag = false
        text.text = $.Localize('#choise_hide')

        if (can_refresh == 1) 
        {
            refresh.RemoveClass("card_hidden")
        }

    } else 
    {
        flag = true
        text.text = $.Localize('#choise_show')

        if (can_refresh == 1) 
        {

            refresh.AddClass("card_hidden")
        }

    }

    for (var i = 1; i <= max; i++) 
    {
        let card = $.GetContextPanel().FindChildTraverse("card" + String(i))
        if (flag == false)
        {
            card.RemoveClass("card_hidden_button")
        } else 
        {
            card.AddClass("card_hidden_button")
        }
    }
}






function GetFontSize(name, rarity)
{
    let font_size = $.Localize("#font_disc_" + name) + "px"

    if (font_size == "#font_disc_" + name + "px")
    {
        if (rarity == "gray")
        {
            font_size = "21px"    
        }
        if (rarity == "blue")
        {
            font_size = "19px"    
        }
        if (rarity == "purple")
        {
            font_size = "18px"    
        }
        if (rarity == "orange")
        {
            font_size = "17px"    
        }
    }  

    return font_size
}



function SetPermaInfo(panel, stack, max) 
{

    panel.RemoveClass("text_hidden")

    panel.html = true
    panel.style.color = '#d7d7d7'

    let stack_text = String(stack)

    if ((stack >= max) && (max !== -1))
    {
        stack_text = "<b><font color='#53ea48'>" + String(stack) + "</font></b>"
    }

    stack_text = $.Localize('#perma_progress') + stack_text

    if (max !== -1)
    {
        stack_text = stack_text + "/" + String(max)
    }

    panel.text = stack_text
}


function SetLevelInfo(panel, is_blue, level, max_level) 
{
    panel.RemoveClass("text_hidden")

    panel.html = true
    panel.text = String(level) + "/" + String(max_level)
    if (is_blue == true) 
    {
        panel.style.color = '#a5cdff'
    } else 
    {
        panel.style.color = '#cfb0f7'
    }
}

function DeleteChoise(card) {
    card.SetPanelEvent("onactivate", function() {})
}




function EndChoise(kv) 
{
    let choise = kv.choise
    hide_all(choise)
}

