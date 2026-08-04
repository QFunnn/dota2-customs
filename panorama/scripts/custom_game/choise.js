--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
$.GetContextPanel().SetParent(parentHUDElements);



CustomNetTables.SubscribeNetTableListener( "sub_data", update_sub_data );
CustomNetTables.SubscribeNetTableListener( "upgrades_player", update_upgrades_player );

var full_talents = 0
var show_mode = 0
var common_bonus = 0
var ChoiseOpened = false
var use_short_table = {1: 0, 2: 0, 3: 0, 4: 0}
var current_small
var current_close
var last_data
var save_mode

const styles_normal =
{
    "icon_skill" : "card_icon_skill",
    "icon_item" : "card_icon",
    "icon_hero" : "card_icon_hero",
    "icon_base" : "",
    "main_text" : "main_text",
    "talent_level" : "text_stacks",
    "pickrate_panel" : "Pickrate_panel",
    "pickrate_text" : "Pickrate_text",
    "card_open" : "card_open",
    "card_close" : "card_close",
    "card_opened" : "card_opened",
    "cd_panel" : "talent_cd",
    "cd_panel_text" : "talent_cd_text",
    "cd_panel_icon" : "talent_cd_icon",
    "basher_icon" : "basher_icon",
    "perma_text" : "text_perma"
}

const styles_small =
{
    "icon_skill" : "SmallIcon_spell",
    "icon_item" : "SmallIcon_item",
    "icon_hero" : "SmallIcon_hero",
    "icon_base" : "SmallIcon_base",
    "main_text" : "Small_main_text",
    "talent_level" : "Small_stack_text",
    "pickrate_panel" : "SmallPickrate_panel",
    "pickrate_text" : "SmallPickrate_text",
    "card_open" : "ChoiseSmallPanel_open",
    "card_close" : "ChoiseSmallPanel_close",
    "card_opened" : "",
    "cd_panel" : "ChoiseSmallTalenCd",
    "cd_panel_text" : "ChoiseSmallTalenCdText",
    "cd_panel_icon" : "ChoiseSmallTalenCdIcon",
    "basher_icon" : "ChoiseSmallBahser",
    "perma_text" : "ChoiseSmall_perma"
}


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
    GameEvents.Subscribe_custom('ReturnViewTalent', ReturnViewTalent)

    const hero = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID()))
    var sub_data = CustomNetTables.GetTableValue("sub_data", String(Game.GetLocalPlayerID()));

    if (sub_data) 
    {
        if (sub_data.full_talents) 
            full_talents = sub_data.full_talents

        if (sub_data.small_talents) 
            show_mode = sub_data.small_talents
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

var styles_table = styles_normal
if (show_mode == 1)
    styles_table = styles_small 

function OnShow(kv, change_view)
{
    if (!kv || kv == undefined)
        return

    last_data = kv

    var table = kv.choise
    var hasup = kv.hasup
    var stack = kv.mods
    var alert = kv.alert
    var after_legen = kv.after_legen
    var perma_info = kv.perma_info
    var global_rarity = kv.rarity
    var is_reward = kv.is_reward

    if (save_mode)
    {
        show_mode = save_mode
        save_mode = null
    }else if (global_rarity == "orange" && !change_view)
    {
        save_mode = show_mode
        show_mode = 0
    }

    styles_table = (show_mode == 1) ? styles_small : styles_normal

    can_refresh = kv.refresh

    $.DispatchEvent("DropInputFocus")

    Game.EmitSound("UI.Choise_show")

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

    let small_main = $("#ChoiseSmallMode")
    small_main.RemoveAndDeleteChildren()

    let small_panel
    let small_content

    if (show_mode == 1)
    {   
        let small_panel = $.CreatePanel("Panel", small_main, "ChoiseSmallPanel")
        small_panel.AddClass("ChoiseSmallPanel")
        small_panel.AddClass("ChoiseSmallPanel_open")

        current_small = small_panel

        let small_top = $.CreatePanel("Panel", small_panel, "ChoiseSmallTop")
        small_top.AddClass("ChoiseSmallTop")
        small_top.AddClass("ChoiseSmallTop_shadow")
        small_top.AddClass("ChoiseSmallTop_" + global_rarity)

        let header_text = $.CreatePanel("Label", small_top, "ChoiseSmallTop_header_text")
        header_text.AddClass("ChoiseSmallTop_header_text")
        header_text.AddClass("ChoiseSmallTop_header_text_" + global_rarity)
        header_text.text = $.Localize(is_reward == 1 ? "#ChoiseSmallHeaderReward" : "#ChoiseSmallHeader")

        small_content = $.CreatePanel("Panel", small_panel, "ChoiseSmallContent")
    }

    for (var i = 1; i <= max; i++) 
    {
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

        let short_epic ="#epic_disc_" + table[i]
        let short_loc = $.Localize(short_epic)
        
        let talent_cd = Game.GetTalentValue(name, "talent_cd")
        let is_basher = Game.GetTalentValue(name, "is_basher")

        use_short_table[i] = ((rarity == "orange" || (rarity == "purple" && short_loc != short_epic)) && full_talents == 0) ? 1 : 0

        if (Game.spells_by_number[hero] && Game.spells_by_number[hero][skill_number])
        {
            skill_name = Game.spells_by_number[hero][skill_number]["name"]
            base_icon_name = Game.spells_by_number[hero][skill_number]["skill_icon"]
        }

        if (rarity == "orange" || (table_name != hero && table_name != "general" && table_name !="broodmother_spiders"))
            max_level = 0

        let card = $.GetContextPanel().FindChildTraverse("card" + String(i))
        card.RemoveAndDeleteChildren()

        let icon_parent = card
        let text_parent = card
        let card_body 

        if (show_mode == 1)
        {
            card = $.CreatePanel("Panel", small_content, "SmallCardPanel" + i)
            card.AddClass("SmallCardPanel")

            card_body = $.CreatePanel("Panel", card, "SmallBodyanel" + i)
            card_body.AddClass("SmallBodyanel")
            card_body.AddClass("SmallBodyanel_" + rarity)

            icon_parent = $.CreatePanel("Panel", card_body, "SmallIcon_parent")
            let vertical = $.CreatePanel("Panel", card_body, "SmallText_vertical" + i)
            vertical.AddClass("SmallText_vertical")

            text_parent = $.CreatePanel("Panel", vertical, "SmallText_parent")
        }else
        {
            card.AddClass(styles_table["card_opened"])

            card_body = $.CreatePanel("Panel", card, "card_body_main_" + i)
            card_body.AddClass("card_body")

            if (use_short_table[i] == 1)
            {
                let card_info = $.CreatePanel("Panel", card_body, "card_info_" + i)
                card_info.AddClass("card_info")

                let card_info_panel = $.CreatePanel("Panel", card_info, "")
                card_info_panel.AddClass("card_info_panel")

                let card_info_text = $.CreatePanel("Label", card_info_panel, "")
                card_info_text.AddClass("card_info_text")
                card_info_text.text = $.Localize("#card_info_text")
                card_info_text.AddClass("card_info_text_" + rarity)

                let card_info_icon = $.CreatePanel("Panel", card_info_panel, "")
                card_info_icon.AddClass("card_info_icon")
            }
        }

        let icon = $.CreatePanel("Panel", icon_parent, "")
        icon.AddClass(styles_table["icon_base"])

        let stacks = $.CreatePanel("Label", card_body, "")
        stacks.AddClass(styles_table["talent_level"])

        if (show_mode == 1)
            icon.AddClass("SmallIcon_base_" + rarity)

        let text = $.CreatePanel("Label", text_parent, "text" + i)
        text.AddClass(styles_table["main_text"])

        let short_label = $.CreatePanel("Label", text_parent, "short_text" + i)
        short_label.AddClass(styles_table["main_text"])

        text.html = true
        short_label.html = true

        let ability_icon = $.CreatePanel("DOTAAbilityImage", icon, "ability_icon")
        ability_icon.AddClass("card_hidden")

        if (perma_info && perma_info[i] && perma_info[i].stack !== -1)
        {
            let parent = (show_mode == 1) ? $("#SmallText_vertical" + i) : card

            let perma = $.CreatePanel("Label", parent, "perma" + i)
            perma.AddClass(styles_table["perma_text"])

            SetPermaInfo(perma, perma_info[i].stack, perma_info[i].max) 
        }

        let basher_icon
        if (is_basher != undefined)
        {
            let parent = (show_mode == 1) ? icon_parent : card_body

            basher_icon = $.CreatePanel("Panel", parent, "")
            basher_icon.AddClass(styles_table["basher_icon"])

            let text = $.Localize("#tooltip_talent_basher")
            
            basher_icon.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTextTooltip', basher_icon, text) });
            
            basher_icon.SetPanelEvent('onmouseout', function() {
            $.DispatchEvent('DOTAHideTextTooltip', basher_icon); });
            basher_icon.RemoveClass("talent_effects_icon_hidden")
        }

        if (talent_cd != undefined)
        {
            let parent = (show_mode == 1) ? $("#SmallText_vertical" + i) : card_body

            let cd_panel = $.CreatePanel("Panel", parent, "talent_cd" + i)
            cd_panel.AddClass(styles_table["cd_panel"])

            let text = $.Localize("#talent_cd")
            
            cd_panel.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTextTooltip', cd_panel, text) });
            
            cd_panel.SetPanelEvent('onmouseout', function() {
            $.DispatchEvent('DOTAHideTextTooltip', cd_panel); });

            let cd_text = $.CreatePanel("Label", cd_panel, "talent_cd")
            cd_text.AddClass(styles_table["cd_panel_text"])
            cd_text.text = Game.ShowTalentValues("*talent_cd*", name, stack[i] + 1, false, false)

            let talent_cd_icon = $.CreatePanel("Panel", cd_panel, "")
            talent_cd_icon.AddClass(styles_table["cd_panel_icon"])
        }

        if (complexity && alert == 1 && show_mode == 0)
        {
            let complexity_block = $.CreatePanel("Panel", card, "complexity_block" + i)
            complexity_block.AddClass("complexity_block")

            let complexity_text = $.CreatePanel("Label", complexity_block, "")
            complexity_text.AddClass("complexity_block_text")
            complexity_text.text = $.Localize("#talent_complexity")

            let complexity_levels = $.CreatePanel("Panel", complexity_block, "complexity_levels" + i)
            complexity_levels.AddClass("complexity_levels")

            for (var j = 1; j <= 3; j++)
            {
                level = $.CreatePanel("Panel", complexity_levels, "")
                level.AddClass("complexity_level")

                if (j > complexity)
                    level.AddClass("complexity_level_disable")
            } 
        }
      
        if (skill_change != undefined && show_mode == 0)
        {
            let skill_change_icon = $.CreatePanel("Panel", card_body, "")
            skill_change_icon.AddClass("skill_change_icon")
            skill_change_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero + '/' + skill_change + '.png")';
            skill_change_icon.style.backgroundSize = 'contain';

            let change_text = $.Localize("#" + hero + "_" + skill_change)

            skill_change_icon.SetPanelEvent('onmouseover', function() {
            $.DispatchEvent('DOTAShowTextTooltip', skill_change_icon, change_text) });
            
            skill_change_icon.SetPanelEvent('onmouseout', function() {
            $.DispatchEvent('DOTAHideTextTooltip', skill_change_icon); });

            skill_change_icon.RemoveClass("talent_effects_icon_hidden")
        }
        
        if (use_new_system && skill_number == 0 && table_name == hero)
        {
            icon.AddClass(styles_table["icon_hero"]) 
                panel = rarity + "_hero"  

            if (basher_icon && show_mode == 1)
                basher_icon.AddClass("ChoiseSmallBahser_hero")

            icon.style.backgroundImage = 'url( "file://{images}/heroes/' + Game.GetHeroImage(Game.GetLocalPlayerID(), hero) + '.png" );'
            icon.style.backgroundSize = 'contain';

        }else
        {
            if (table_name != hero && table_name != "broodmother_spiders" && talent_data["alt_panel"] == undefined)
            {
                panel = rarity + "_item"
                icon_name = "items/" + talent_data["skill_icon"]
                icon.AddClass(styles_table["icon_item"])
            }else
            {
                icon.AddClass(styles_table["icon_skill"])    
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

        icon.style.backgroundRepeat = "no-repeat";

        if (show_mode == 0)
        {
            card_body.style.backgroundImage = 'url("file://{images}/custom_game/' + panel + '.png")';
            card_body.style.backgroundSize = "contain";
            card_body.AddClass("card_blur_" + rarity)
        }

        pick_rate_table[i] = -1

        if (Game.pickrate_talents[hero] && Game.pickrate_talents[hero][Game.local_chosen_build])
            pick_rate_table[i] = (Game.pickrate_talents[hero][Game.local_chosen_build][name]*100).toFixed(0)

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

        if (max_level !== 0)
            SetLevelInfo(stacks, rarity == "blue", stack[i], max_level)

        SetAltDown(i)

        let card_number = i
        card_body.SetPanelEvent("onactivate", function() 
        {   
            DeleteAll()
            GameEvents.SendCustomGameEventToServer_custom("activate_choise", { chosen: card_number })
        })
    }


    if (show_mode == 1)
    {
        for (let i in use_short_table)
        {
            if (use_short_table[i] == 1)
            {
                let small_top = $("#ChoiseSmallTop")

                let card_info = $.CreatePanel("Panel", small_top, "card_info_" + i)
                card_info.AddClass("ChoiseSmallCardInfo")

                let card_info_panel = $.CreatePanel("Panel", card_info, "")
                card_info_panel.AddClass("card_info_panel")

                let card_info_text = $.CreatePanel("Label", card_info_panel, "")
                card_info_text.AddClass("card_info_text")
                card_info_text.AddClass("ChoiseSmallTop_header_text_" + global_rarity)
                card_info_text.text = $.Localize("#card_info_text")

                let card_info_icon = $.CreatePanel("Panel", card_info_panel, "")
                card_info_icon.AddClass("card_info_icon")

                let header = $("#ChoiseSmallTop_header_text")
                header.AddClass("ChoiseSmallTop_header_left")
                break
            }
        }
    }


    var ClosePanel = $("#ClosePanel")
    if (ClosePanel)
        ClosePanel.DeleteAsync(0)

    var ClosePanelSmall

    if (show_mode == 0)
    {
        ClosePanel = $.CreatePanel("Panel", $.GetContextPanel(), "ClosePanel")
        ClosePanel.AddClass("ClosePanel")
        ClosePanel.AddClass("ClosePanel_open")

        current_close = ClosePanel
        $.Schedule(0.4, function()
        {
            if (current_close == ClosePanel)
                ClosePanel.RemoveClass("ClosePanel_open")
        })
    }else
    {
        ClosePanelSmall = $.CreatePanel("Panel", small_content, "ClosePanelSmall")
        ClosePanelSmall.AddClass("ClosePanelSmall")
    }

    if (can_refresh == 1) 
    {
        let parent = show_mode == 1 ? ClosePanelSmall : ClosePanel

        let refresh = $.CreatePanel("Panel", parent, "refresh")
        refresh.AddClass("ButtonStyle")
        refresh.AddClass("ButtonStyle_refresh")
        refresh.AddClass("SmallRefreshBlur")

        let label = $.CreatePanel("Label", refresh, "SmallRefresh_text")
        label.AddClass("ButtonText")
        label.AddClass("ButtonText_refresh")
        label.text = $.Localize("#refresh")

        refresh.SetPanelEvent("onactivate", function() 
        {
            refresh_choise(after_legen)
        })
    }   

    var CloseButton = $.CreatePanel("Panel", show_mode == 1 ? ClosePanelSmall : ClosePanel, "close")
    CloseButton.AddClass("ButtonStyle")
    CloseButton.AddClass("ButtonStyle_close")
    CloseButton.AddClass("ButtonBlurClose")

    var CloseText = $.CreatePanel("Label", CloseButton, "close_text")
    CloseText.AddClass("ButtonText")
    CloseText.AddClass("ButtonText_close")
    CloseText.text = $.Localize(show_mode == 1 ? "#choise_mode_big" : "#choise_mode_small")

    CloseButton.SetPanelEvent("onactivate", function() 
    {
        change_mode()
    })


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
        let main = show_mode == 1 ? $("#SmallCardPanel" + id) : $("#card" + id)

        let pick_rate_panel = $.CreatePanel("Panel", main, "Pickrate_panel" + id)
        pick_rate_panel.AddClass(styles_table["pickrate_panel"])
        pick_rate_panel.AddClass("card_hidden")

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
            let pick_rate_text = $.CreatePanel("Label", pick_rate_panel, "")
            pick_rate_text.AddClass(styles_table["pickrate_text"])
            pick_rate_text.text = pickrate + "%"
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
    let text = $.GetContextPanel().FindChildTraverse("text" + i)

    if (!text || text == undefined)
        return

    let card_info = $.GetContextPanel().FindChildTraverse("card_info_" + i)
    let short_label = $.GetContextPanel().FindChildTraverse("short_text" + i)
    let perma = $("#perma" + i)
    let talent_cd = $("#talent_cd" + i)

    let use_short = use_short_table[i] == 1 && !GameUI.IsAltDown()

    if (talent_cd)
        talent_cd.SetHasClass("panel_collapse", use_short)

    if (perma)
        perma.SetHasClass("panel_collapse", use_short)

    short_label.SetHasClass("panel_collapse", !use_short)
    text.SetHasClass("panel_collapse", use_short)

    if (card_info)
        card_info.SetHasClass("panel_collapse", !use_short)
}


function change_mode()
{
    DeleteAll()
    hide_all()

    GameEvents.SendCustomGameEventToServer_custom("ChangeSettings", {type : 8, override : show_mode == 1 ? 0 : 1})
}

function ReturnViewTalent(kv)
{   
    show_mode = kv.state
    OnShow(last_data, true)
}

function hide_all(card_number) 
{
    ChoiseOpened = false
    Game.EmitSound("UI.Talent_chose")
    $.DispatchEvent("DropInputFocus")

    if (show_mode == 1)
    {
        let timer = 0.5
        let main = $("#ChoiseSmallPanel")
        main.RemoveClass("ChoiseSmallPanel_open")

        let top = $("#ChoiseSmallTop")
        top.RemoveClass("ChoiseSmallTop_shadow")
        top.AddClass("ChoiseSmallPanel_close")

        let close_panel = $("#ClosePanelSmall")
        if (close_panel)
        {   
            close_panel.AddClass(card_number == undefined ? "ClosePanel_close" : "ChoiseSmallPanel_close")
        }

        for (var i = 1; i <= max; i++) 
        {
            let panel = $("#SmallCardPanel" + i)
            if (panel && panel != undefined)
            {
                let body = $("#SmallBodyanel" + i)
                DeleteChoise(body)
                if (i != card_number)
                {
                    panel.AddClass("ChoiseSmallPanel_close")
                }else
                {
                    panel.AddClass("ChoiseSmallPanel_close_selected")
                }
            }
        }

        main.DeleteAsync(timer)
        return
    }

    var ClosePanel = $("#ClosePanel");
    ClosePanel.AddClass("ClosePanel_close")
    ClosePanel.DeleteAsync(0.4)

    for (var i = 1; i <= max; i++) 
    {
        let main = $.GetContextPanel().FindChildTraverse("card" + i)
        let body = $.GetContextPanel().FindChildTraverse("card_body_main_" + i)

        main.RemoveClass(styles_table["card_opened"])
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


}

function DeleteAll()
{
    for (var i = 1; i <= 4; i++) 
    {
        let card = $("#card" + i)
        if (card)
            DeleteChoise(card)
    
        let small_card = $("#SmallBodyanel" + i)
        if (small_card)
            DeleteChoise(small_card)
    }

    let refresh = $("#refresh")
    let close = $("#close")

    if (refresh)
        DeleteChoise(refresh)

    if (close)
        DeleteChoise(close)
}


function refresh_choise(after_legen) 
{
    DeleteAll()
    hide_all()
    $.Schedule(0.3, function() 
    {
        GameEvents.SendCustomGameEventToServer_custom("refresh_sphere", {global_choise, after_legen})
    })
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
