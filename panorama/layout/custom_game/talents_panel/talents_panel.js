--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var unique_panel_heroes =
{
    "npc_dota_hero_broodmother" : true,
    "npc_dota_hero_muerta" : true,
    "npc_dota_hero_invoker" : true,
}


Game.init_talent_panel = (panel, hero_alt, pick_stage) =>
{

    var LayerGeneral = panel
    LayerGeneral.style.backgroundSize = "contain";

    hero_alt = String(hero_alt)
    if (hero_alt == "undefined") 
    {
        var hero_ent = Players.GetLocalPlayerPortraitUnit();
        var hero = Entities.GetUnitName(hero_ent)
    } else 
    {
        var hero = hero_alt
    }

    let use_new_system = false
    if (Game.new_talent_system[hero])
        use_new_system = true

    let entindex = 0
    var players_heroes = CustomNetTables.GetTableValue("hero_portrait_levels", hero)
    var player_id = Game.GetLocalPlayerID()

    if (players_heroes)
    {
        player_id = players_heroes["id"]
        entindex = players_heroes["entindex"]
    }
    player_id = Number(player_id)

    var UniqueTalents_Panel = $("#UniqueTalents_Panel")
    var LayerGray_Left = LayerGeneral.FindChildTraverse("LayerGray_left")
    var LayerPlayer_Skills = LayerGeneral.FindChildTraverse("LayerPlayer_Skills")
    var LayerGray_Right = LayerGeneral.FindChildTraverse("LayerGray_Right")
    var LayerOrange = LayerGeneral.FindChildTraverse("LayerOrange")
    var LayerPurple = LayerGeneral.FindChildTraverse("LayerPurple")
    var LayerBlue = LayerGeneral.FindChildTraverse("LayerBlue")

    let LayerHeroTalents = LayerGeneral.FindChildTraverse("LayerHeroTalents")

    UniqueTalents_Panel.AddClass("talents_panel_hidden")
    UniqueTalents_Panel.RemoveClass("UniqueTalents_Panel_open")
    var UniqueTalents_Content = UniqueTalents_Panel.FindChildTraverse("UniqueTalents_Content")
    if (UniqueTalents_Content)
    {
        UniqueTalents_Content.DeleteAsync(0)
    }

    if (pick_stage == undefined && unique_panel_heroes[hero] == true)
    {
        UniqueTalents_Panel.RemoveClass("talents_panel_hidden")
        UniqueTalents_Panel.AddClass("unique_talents_start")
        $.Schedule( 0.2, function(){ 
            UniqueTalents_Panel.AddClass("UniqueTalents_Panel_open")
            UniqueTalents_Panel.RemoveClass("unique_talents_start")
        })
        CreateUniquePanel(hero, player_id, entindex)
    }
    var LayerPurple_skill = []
    var LayerBlue_skill = []

    for (var i = 0; i <= 4; i++)
    {
        LayerPurple_skill[i] = LayerGeneral.FindChildTraverse("LayerPurple_skill_" + String(i))
        LayerBlue_skill[i] = LayerGeneral.FindChildTraverse("LayerBlue_skill_" + String(i))
    }

    if (use_new_system == true)
    {
        LayerHeroTalents.RemoveClass("talents_panel_hidden")
        LayerGray_Right.AddClass("talents_panel_hidden") 
        LayerPlayer_Skills.AddClass("talents_panel_hidden")

        if (pick_stage == true)
        {
           LayerGray_Left.AddClass("talents_panel_hidden") 
        }else
        {
           LayerGray_Left.RemoveClass("talents_panel_hidden") 
        }
    }else
    {
        LayerHeroTalents.AddClass("talents_panel_hidden")
        LayerPlayer_Skills.RemoveClass("talents_panel_hidden")

        if (pick_stage == true)
        {
           LayerGray_Left.AddClass("talents_panel_hidden") 
           LayerGray_Right.AddClass("talents_panel_hidden") 
           LayerPlayer_Skills.RemoveClass("LayerPlayer_Skills_Normal")
           LayerPlayer_Skills.AddClass("LayerPlayer_Skills_PickStage")
        }else
        {
           LayerGray_Left.RemoveClass("talents_panel_hidden") 
           LayerGray_Right.RemoveClass("talents_panel_hidden")
           LayerPlayer_Skills.AddClass("LayerPlayer_Skills_Normal")
           LayerPlayer_Skills.RemoveClass("LayerPlayer_Skills_PickStage")
        }
    }


    let hero_index = Players.GetPlayerHeroEntityIndex(player_id)

    var player_table = CustomNetTables.GetTableValue("upgrades_player", hero)
    let common_bonus = 0
    if (player_table && player_table.common_bonus)
    {
        common_bonus = player_table.common_bonus/100
    }

    if (use_new_system)
    {
        let icon = $.GetContextPanel().FindChildTraverse("hero_talent_hero")
        icon.style.backgroundImage = 'url( "file://{images}/heroes/' + Game.GetHeroImage(player_id, hero) + '.png" );'
        icon.style.backgroundSize = 'contain';
        icon.style.backgroundRepeat = 'no-repeat'

        MouseOver(icon.GetParent(), $.Localize("#new_talent_system"))
    }

    var legendary_count = 1
    var purple_count = 1
    var blue_count = 1
    var icon_buffer = ''

    let talent_table = Game.talents_values[hero]

    let max = Object.keys(talent_table).length
    let purple = $.GetContextPanel().FindChildTraverse("talent_purple_card_4")
    let blue = $.GetContextPanel().FindChildTraverse("talent_blue_card_4")
    let LayerHeroTalents_Hero = $.GetContextPanel().FindChildTraverse("LayerHeroTalents_Skill_0")

    if (max == 26)
    {
        purple.AddClass("talents_panel_hidden")
        blue.AddClass("talents_panel_hidden")
        LayerHeroTalents.RemoveClass("LayerHeroTalents")
        LayerHeroTalents.AddClass("LayerHeroTalents_small")
        LayerHeroTalents_Hero.RemoveClass("LayerHeroTalents_Hero")
        LayerHeroTalents_Hero.AddClass("LayerHeroTalents_Hero_small")
    }else
    {
        purple.RemoveClass("talents_panel_hidden")
        blue.RemoveClass("talents_panel_hidden")
        LayerHeroTalents.AddClass("LayerHeroTalents")
        LayerHeroTalents.RemoveClass("LayerHeroTalents_small")
        LayerHeroTalents_Hero.AddClass("LayerHeroTalents_Hero")
        LayerHeroTalents_Hero.RemoveClass("LayerHeroTalents_Hero_small")
    }

    Object.entries(talent_table).map(([key, data]) => (data["name"] = key, data["name_number"] = key[Object.keys(key).length - 1], data))

    talent_table = Object.values(talent_table)
    talent_table.sort((a, b) => (a["skill_number"] - b["skill_number"]))

    var skills_array = {}

    for (const index in talent_table)
    {
        let number = talent_table[index]["skill_number"]
        let name_number = talent_table[index]["name_number"]

        if (name_number == "y")  name_number = "7"
        if (!skills_array[number]) skills_array[number] = []   

        talent_table[index]["name_number"] = Number(name_number)

        skills_array[number].push(talent_table[index])
    }

    for (const skill in skills_array)
    {
        skills_array[skill].sort((a, b) => (a["name_number"] - b["name_number"]))
        
        let new_purple_count = 0
        let new_blue_count = 0

        for (const data of skills_array[skill])
        {
            let mini_icon = data["mini_icon"]
            let rarity = data["rarity"]
            let name = data["name"]
            let skill_number = data["skill_number"]
            let max_level = Game.GetMaxLevel(data)
            let skill_name = null
            let skill_change = data["skill_change"]

            if (Game.spells_by_number[hero] && Game.spells_by_number[hero][skill_number])  
                skill_name = Game.spells_by_number[hero][skill_number]["name"]

            let lvl = undefined

            if (player_table !== undefined)
                lvl = player_table.upgrades[name]

            let skill_panel = $.GetContextPanel().FindChildTraverse("LayerHeroTalents_Skill_" + skill_number)


            if (rarity == "orange") 
            {
                let orange_card = LayerOrange.FindChildTraverse("orange_card_" + String(legendary_count))
                let orange_content = orange_card.FindChildTraverse("orange_content_" + String(legendary_count))
                let orange_icon = orange_card.FindChildTraverse("orange_icon_" + String(legendary_count))
                let orange_lvl = orange_card.FindChildTraverse("orange_lvl_" + String(legendary_count))
                legendary_count++

                if (use_new_system && skill_panel)
                {
                    orange_content = skill_panel.FindChildTraverse("talent_orange_card")
                    orange_icon = skill_panel.FindChildTraverse("talent_orange_icon")
                    orange_lvl = skill_panel.FindChildTraverse("talent_orange_lvl")
                }
        
                orange_content.RemoveClass("orange_content_anim");

                let ability = Entities.GetAbilityByName(hero_index, skill_name)

                if (ability)
                    orange_icon.contextEntityIndex =  ability
                orange_icon.abilityname = skill_name

               // orange_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero + '/' + mini_icon + '.png")';
               // orange_icon.style.backgroundSize = "contain";
              //  orange_icon.style.backgroundRepeat = "no-repeat";

                icon_buffer = 'olevel_0'
                if (pick_stage == true)
                    lvl = 1

                if (lvl !== undefined) 
                {
                    icon_buffer = 'orange_lvl_1'
                    orange_icon.style.washColor = "none";
                    orange_icon.style.saturation = "1";
                    orange_content.AddClass("orange_content_anim");
                }else
                {
                    orange_icon.style.washColor = "#666666";
                    orange_icon.style.saturation = "0.1";
                }

                orange_lvl.style.backgroundImage = 'url("file://{images}/custom_game/' + icon_buffer + '.png")';
                orange_lvl.style.backgroundSize = "100%";
                orange_lvl.style.backgroundRepeat = "no-repeat";

                MouseOverTalent(orange_content, '#upgrade_disc_' + name, name, lvl, false, "legendary", max_level, player_id, hero, false, skill_change)

            }
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            if (rarity == "purple") 
            {
                let purple_card = LayerPurple.FindChildTraverse("purple_card_" + String(purple_count))
                let purple_content = LayerPurple.FindChildTraverse("purple_content_" + String(purple_count))
                let purple_icon = LayerPurple.FindChildTraverse("purple_icon_" + String(purple_count))
                let purple_lvl = LayerPurple.FindChildTraverse("purple_lvl_" + String(purple_count))

                if (use_new_system && skill_panel)
                {
                    new_purple_count++

                    purple_content = skill_panel.FindChildTraverse("talent_purple_card_" + new_purple_count)
                    purple_icon = skill_panel.FindChildTraverse("talent_purple_icon_" + new_purple_count)
                    purple_lvl = skill_panel.FindChildTraverse("talent_purple_level_" + new_purple_count)
                }
        
                let purple_fill = purple_lvl.FindChildTraverse("purple_lvl_fill_" + String(purple_count))
                if (!purple_fill)
                {
                    purple_fill = $.CreatePanel("Panel", purple_lvl, "purple_lvl_fill_" + String(purple_count))
                    purple_fill.AddClass("TalentLevel_purple")
                }
                let level_width = 0

                if (purple_content == undefined)
                    continue

                if (purple_count == 4 && use_new_system && max == 26)
                    purple_count++

                purple_count++

                purple_content.RemoveClass("card_content_purple_anim");
                purple_content.style.backgroundSize = "contain";

                purple_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero + '/' + mini_icon + '.png")';
                purple_icon.style.backgroundSize = "contain";
                purple_icon.style.backgroundRepeat = "no-repeat";

                if (pick_stage == true)
                    lvl = max_level

                if (lvl !== undefined) 
                {
                    level_width = (lvl/max_level)*100
                    purple_icon.style.washColor = "none";
                    purple_icon.style.saturation = "1";

                    if (lvl == max_level) 
                    {
                        purple_content.AddClass("card_content_purple_anim");
                    }
                }else
                {
                    purple_icon.style.washColor = "#666666";
                    purple_icon.style.saturation = "0.1";
                }

                MouseOverTalent(purple_content, "#upgrade_disc_" + name, name, lvl, true, "purple", max_level, player_id, hero, false, skill_change)

                purple_fill.style.width = level_width + "%"
            }


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            if (rarity == "blue") 
            {
                let blue_card = LayerBlue.FindChildTraverse("blue_card_" + String(blue_count))
                let blue_content = LayerBlue.FindChildTraverse("blue_content_"+ String(blue_count))
                let blue_icon = LayerBlue.FindChildTraverse("blue_icon_" + String(blue_count))
                let blue_lvl = LayerBlue.FindChildTraverse("blue_lvl_" + String(blue_count))

                if (use_new_system && skill_panel)
                {
                    new_blue_count++

                    blue_content = skill_panel.FindChildTraverse("talent_blue_card_" + new_blue_count)
                    blue_icon = skill_panel.FindChildTraverse("talent_blue_icon_" + new_blue_count)
                    blue_lvl = skill_panel.FindChildTraverse("talent_blue_level_" + new_blue_count)
                }

                let blue_fill = blue_lvl.FindChildTraverse("blue_lvl_fill_" + String(blue_count))
                if (!blue_fill)
                {
                    blue_fill = $.CreatePanel("Panel", blue_lvl, "blue_lvl_fill_" + String(blue_count))
                    blue_fill.AddClass("TalentLevel_blue")
                }

                let level_width = 0

                if (blue_content == undefined)
                    continue

                if (blue_count == 4 && use_new_system && max == 26)
                    blue_count++

                blue_count++

                blue_content.RemoveClass("card_content_blue_anim");

                blue_content.style.backgroundSize = "contain";

                blue_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero + '/' + mini_icon + '.png")';
                blue_icon.style.backgroundSize = "contain";
                blue_icon.style.backgroundRepeat = "no-repeat";

                if (pick_stage == true)
                    lvl = max_level

                if (lvl !== undefined) 
                {
                    level_width = (lvl/max_level)*100

                    blue_icon.style.washColor = "none";
                    blue_icon.style.saturation = "1";

                    if (lvl == max_level) {
                        blue_content.AddClass("card_content_blue_anim");
                    }
                }else
                {    
                    blue_icon.style.washColor = "#666666";
                    blue_icon.style.saturation = "0.1";
                }

                MouseOverTalent(blue_content, "#upgrade_disc_" + name, name, lvl, true, "blue", max_level, player_id, hero, false, skill_change)
                
                blue_fill.style.width = level_width + "%"
            }
        }
    }




    if (pick_stage == true)
        return

    var LayerGray_skill = []
    for (var i = 1; i <= 4; i++)
    {
        let panel = $.GetContextPanel().FindChildTraverse("LayerGray_skill_" + i)
        if (panel) panel.DeleteAsync(0)
    
        let parent = LayerGray_Left
        if (i >= 3) parent = LayerGray_Right
        
        LayerGray_skill[i] = $.CreatePanel("Panel", parent, "LayerGray_skill_" + i)
        LayerGray_skill[i].AddClass("Gray_Skill")
    }


    var purple_amount = 0
    var blue_amount = 0
    var gray_amount = 0

    var gray_general_count = 0
    var purple_general_count = 0
    var blue_general_count = 0

    var number = 0
    var text = ''

    var gray_max = 6

    var general_gray_border = $.CreatePanel("Panel", LayerGray_skill[1], "general_gray_border")
    general_gray_border.AddClass("general_border")
    var general_gray_border = $.CreatePanel("Panel", LayerGray_skill[2], "general_gray_border")
    general_gray_border.AddClass("general_border")

    var general_gray_border = $.CreatePanel("Panel", LayerGray_skill[3], "general_gray_border")
    general_gray_border.AddClass("general_border")
    var general_gray_border = $.CreatePanel("Panel", LayerGray_skill[4], "general_gray_border")
    general_gray_border.AddClass("general_border")

    if (!player_table)
        return

    for (const name in Game.talents_values["general"])
    {
        let data = Game.talents_values["general"][name]
        let rarity = data["rarity"]

        if (player_table["upgrades"][name])
        {
            if (rarity == "purple")
                purple_amount = purple_amount + 1
            if (rarity == "blue")
                blue_amount = blue_amount + 1
            if (rarity == "gray")
                gray_amount = gray_amount + 1
        }
    }

    if (gray_amount > 12)
        gray_max = Math.ceil(gray_amount / 2)


    for (const name in Game.talents_values["general"]) 
    {
        let data = Game.talents_values["general"][name]
        let rarity = data["rarity"]
        let icon = data["skill_icon"]
        let max_level = Game.GetMaxLevel(data)

        let lvl = player_table.upgrades[name]
        if (lvl === undefined)
            continue

        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        if (use_new_system == false)
        {
            if (rarity == "purple") 
            {
                purple_general_count = purple_general_count + 1

                let general_purple_card = $.CreatePanel("Panel", LayerGray_skill[4], "general_purple_card" + purple_general_count)
                general_purple_card.AddClass("general_card")

                let general_purple_shadow = $.CreatePanel("Panel", general_purple_card, "general_purple_shadow" + purple_general_count)
                general_purple_shadow.AddClass("general_shadow")

                let general_purple_image = $.CreatePanel("Panel", general_purple_shadow, "general_purple_image" + purple_general_count)
                general_purple_image.AddClass("general_image_purple")
                general_purple_image.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/general/' + icon + '.png")';
                general_purple_image.style.backgroundSize = "contain";
                general_purple_image.style.backgroundRepeat = "no-repeat";

                let general_purple_color = $.CreatePanel("Panel", general_purple_shadow, "general_purple_color" + purple_general_count)
                general_purple_color.AddClass("general_color")
                general_purple_color.style.washColor = "#a619ff";

                let general_purple_stack = $.CreatePanel("Label", general_purple_shadow, "general_purple_stack" + purple_general_count)
                general_purple_stack.AddClass("general_stack")

                MouseOverTalent(general_purple_card, "#upgrade_disc_" + name, name, lvl, true, "purple", max_level, player_id, hero, false, undefined)

                if (lvl > 1)
                    general_purple_stack.text = String(lvl)

                if (purple_amount > 6) 
                {
                    number = 0
                    number = (96 / purple_amount)

                    text = String(number) + '%'
                    general_purple_card.style.height = text

                    number = number * 5.1468
                    text = String(number) + '%'
                    general_purple_card.style.width = text

                    number = (100 - number) / 2
                    text = String(number) + '%'
                    general_purple_card.style.marginLeft = text
                    general_purple_stack.style.fontSize = '22px'
                }
            }

            if (rarity == "blue")
            {
                blue_general_count = blue_general_count + 1

                let general_blue_card = $.CreatePanel("Panel", LayerGray_skill[3], "general_blue_card" + blue_general_count)
                general_blue_card.AddClass("general_card")

                let general_blue_shadow = $.CreatePanel("Panel", general_blue_card, "general_blue_shadow" + blue_general_count)
                general_blue_shadow.AddClass("general_shadow")

                let general_blue_image = $.CreatePanel("Panel", general_blue_shadow, "general_blue_image" + blue_general_count)
                general_blue_image.AddClass("general_image_blue")
                general_blue_image.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/general/' + icon + '.png")';
                general_blue_image.style.backgroundSize = "contain";
                general_blue_image.style.backgroundRepeat = "no-repeat";

                let general_blue_color = $.CreatePanel("Panel", general_blue_shadow, "general_blue_color" + blue_general_count)
                general_blue_color.AddClass("general_color")
                general_blue_color.style.washColor = "#1a99e8";

                let general_blue_stack = $.CreatePanel("Label", general_blue_shadow, "general_blue_stack" + blue_general_count)
                general_blue_stack.AddClass("general_stack")

                MouseOverTalent(general_blue_card, "#upgrade_disc_" + name, name, lvl, true, "blue", max_level, player_id, hero, false, undefined)

                if (lvl > 1) {
                    general_blue_stack.text = String(lvl)
                }

                if (blue_amount > 6) 
                {
                    number = 0
                    number = (96 / blue_amount)

                    text = String(number) + '%'
                    general_blue_card.style.height = text

                    number = number * 5.1468
                    text = String(number) + '%'
                    general_blue_card.style.width = text

                    number = (100 - number) / 2
                    text = String(number) + '%'
                    general_blue_card.style.marginLeft = text

                    general_blue_stack.style.fontSize = '22px'
                }
            }

        }


        if (rarity == "gray")
        {
            let gray_bonus = data["general_bonus"]
            gray_general_count = gray_general_count + 1

            let parent = LayerGray_skill[2]

            if (gray_general_count <= gray_max) 
            {
                parent = LayerGray_skill[1]
            }

            let general_gray_card = $.CreatePanel("Panel", parent, "general_gray_card" + gray_general_count)
            general_gray_card.AddClass("general_card")

            var value = '+' + String(Math.trunc(lvl * gray_bonus * (1 + common_bonus))) + $.Localize('#talent_disc_' + name)
            MouseOver(general_gray_card, value)

            let general_gray_shadow = $.CreatePanel("Panel", general_gray_card, "general_gray_shadow" + gray_general_count)
            general_gray_shadow.AddClass("general_shadow")

            let general_gray_image = $.CreatePanel("Panel", general_gray_shadow, "general_gray_image" + gray_general_count)
            general_gray_image.AddClass("general_image_gray")
            general_gray_image.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/general/' + icon + '.png")';
            general_gray_image.style.backgroundSize = "contain";
            general_gray_image.style.backgroundRepeat = "no-repeat";

            let general_gray_color = $.CreatePanel("Panel", general_gray_shadow, "general_gray_color" + gray_general_count)
            general_gray_color.AddClass("general_color")
            general_gray_color.style.washColor = "#e9e9e9";

            let general_gray_stack = $.CreatePanel("Label", general_gray_shadow, "general_gray_stack" + gray_general_count)
            general_gray_stack.AddClass("general_stack")

            if (lvl > 9)
            {
                general_gray_stack.style.marginLeft = "0px"
                general_gray_stack.text = String(lvl)
            }
            else if (lvl > 1)
                general_gray_stack.text = String(lvl)

            if (gray_amount > 12) 
            {
                number = 0
                number = (96 / Math.ceil(gray_amount / 2))

                text = String(number) + '%'
                general_gray_card.style.height = text

                number = number * 5.1468
                text = String(number) + '%'
                general_gray_card.style.width = text

                number = (100 - number) / 2
                text = String(number) + '%'
                general_gray_card.style.marginLeft = text

                general_gray_stack.style.fontSize = '22px'
            }
        }
    }
}


function MouseOver(panel, text) {
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, text)
    });

    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });
}

function MouseOverTalent(panel, talent_text, name, lvl, all_levels, rarity, max_level, player_id, hero, is_scepter, skill_change) 
{
    panel.SetPanelEvent("onmouseover", () => 
    {
        Game.CustomTooltipOpened = true

        $.DispatchEvent(
            "UIShowCustomLayoutParametersTooltip",
            panel,
            "skill_tooltip",
            "file://{resources}/layout/custom_game/custom_tooltip.xml",
            "talent_text=" + talent_text + "&name=" + name + "&lvl=" + lvl + "&all_levels=" + all_levels + "&rarity=" + rarity + "&max_level=" + max_level + "&player_id=" + player_id + "&hero_name=" + hero + "&is_scepter=" + is_scepter + "&skill_change=" + skill_change,
        );
    });
    panel.SetPanelEvent("onmouseout", () => 
    {
        Game.CustomTooltipOpened = false
        $.DispatchEvent("UIHideCustomLayoutTooltip", panel, "skill_tooltip");
    });

}


function CreateUniquePanel(hero_name, player_id, entindex)
{
    var main = $("#UniqueTalents_Panel")
    var content = $.CreatePanel("Panel", main, "UniqueTalents_Content")
    content.AddClass("UniqueTalents_Content")

    var has_scepter = Entities.HasScepter(entindex)
    let scepter_table =
    {
        "npc_dota_hero_invoker": true,
        "npc_dota_hero_broodmother": true,
        "npc_dota_hero_muerta": true,
    }

    var right_panel_main

    if (scepter_table[hero_name])
    {
        right_panel_main = $.CreatePanel("Panel", content, "")
        right_panel_main.AddClass("UniqueTalents_Scepter_Main")

        var scepter_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_ScepterPanel")
        var scepter_texture = $.CreatePanel("Panel", scepter_panel, "UniqueTalents_ScepterTexture")
        var scepter_icon = $.CreatePanel("Panel", scepter_panel, "UniqueTalents_ScepterIcon")
        var scepter_text = $.CreatePanel("Label", scepter_panel, "UniqueTalents_ScepterText")
        scepter_text.text = "Aghanim's Scepter"

        if (!has_scepter)
        {
            scepter_icon.AddClass("UniqueTalents_ScepterIconOff")
        }else
        {   
            scepter_icon.AddClass("UniqueTalents_ScepterIconOn")
        }
    }

    if (hero_name == "npc_dota_hero_invoker")
    {
        var invoker_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_Invoker_Container")

        let talent_table = Game.talents_values["invoker_spells"]
        Object.entries(talent_table).map(([key, data]) => (data["name"] = key, data["name_number"] = key[Object.keys(key).length - 1], data))

        talent_table = Object.values(talent_table)
        talent_table.sort((a, b) => (a["name_number"] - b["name_number"]))

        var player_table = CustomNetTables.GetTableValue("upgrades_player", hero_name)

        for (const data of talent_table)
        {           
            let rarity = data["rarity"]
            let mini_icon = data["mini_icon"]
            let max = data["max"]
            let name = data["name"]
            let max_lvl = data["max_level"]
            let name_number = data["name_number"]
            let percent = 0

            let talent_container = $.CreatePanel("Panel", invoker_panel, "")
            talent_container.AddClass("UniqueTalents_Invoker_TalentContainer")
            talent_container.AddClass("UniqueTalents_Invoker_TalentContainer_" + mini_icon)

            let talent_icon = $.CreatePanel("Panel", talent_container, "")
            talent_icon.AddClass("UniqueTalents_Invoker_TalentIcon")
            talent_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/skills/' + mini_icon + '.png")';
            talent_icon.style.backgroundSize = "contain";
            talent_icon.style.backgroundRepeat = "no-repeat";

            let progress_bar = $.CreatePanel("Panel", talent_container, "")
            progress_bar.AddClass("UniqueTalents_Invoker_TalentProgressBar")

            let progress_filler = $.CreatePanel("Panel", progress_bar, "")
            progress_filler.AddClass("UniqueTalents_Invoker_TalentProgressFiller")
            progress_filler.AddClass("UniqueTalents_Invoker_TalentProgressFiller_" + mini_icon)

            let percent_number = $.CreatePanel("Label", progress_bar, "")
            percent_number.AddClass("UniqueTalents_Invoker_Number")

            let stack = 0
            
            if (player_table !== undefined && player_table.upgrades && player_table.upgrades[name + "_count"])
            {
                stack = player_table.upgrades[name + "_count"]
                percent = Math.trunc((stack/max)*100)
            }

            if (player_table && player_table.upgrades[name] && has_scepter)
            {
                talent_container.AddClass("UniqueTalents_Invoker_TalentContainerActive_" + mini_icon)
            }else
            {
                talent_icon.style.washColor = "#666666";
                talent_icon.style.saturation = "0.1";
            }

            percent_number.text = percent + "%"
            progress_filler.style.width = percent + "%"
            MouseOverTalent(talent_container, '#upgrade_disc_' + name, name, stack, true, rarity, max, player_id, hero_name, true)
        }
    }

    if (hero_name == "npc_dota_hero_muerta")
    {
        var muerta_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_Muerta_Container")

        let talent_table = Game.talents_values["muerta_quest"]
        Object.entries(talent_table).map(([key, data]) => (data["name"] = key, data["name_number"] = key[Object.keys(key).length - 1], data))

        talent_table = Object.values(talent_table)
        talent_table.sort((a, b) => (a["name_number"] - b["name_number"]))

        var player_table = CustomNetTables.GetTableValue("upgrades_player", hero_name)
        var last_complete = has_scepter

        for (const data of talent_table)
        {           
            let item_name = data["item"]
            let name = data["name"]
            let max = data["max"]
            let stack = 0
            let percent = 0
            let full_style = "UniqueTalents_Muerta_TalentContainer_Active"

            let talent_container = $.CreatePanel("Panel", muerta_panel, "")
            talent_container.AddClass("UniqueTalents_Muerta_TalentContainer")

            var item = $.CreatePanel("DOTAItemImage", talent_container, item_name)
            item.AddClass("UniqueTalents_Muerta_TalentIcon")
            item.itemname = item_name

            let progress_bar = $.CreatePanel("Panel", talent_container, "")
            progress_bar.AddClass("UniqueTalents_Muerta_TalentProgressBar")

            let progress_filler = $.CreatePanel("Panel", progress_bar, "")
            progress_filler.AddClass("UniqueTalents_Muerta_TalentProgressFiller")

            let percent_number = $.CreatePanel("Label", progress_bar, "")
            percent_number.AddClass("UniqueTalents_Muerta_Number")

            let show_color = false

            if (player_table !== undefined && player_table.upgrades && player_table.upgrades[name + "_data"])
            {
                stack = player_table.upgrades[name + "_data"]
                percent = Math.trunc((stack/max)*100)
            }

            percent_number.text = stack + "/" + max
            progress_filler.style.width = percent + "%"

            if (max == 1)
            {
                full_style = "UniqueTalents_Muerta_TalentContainer_ActiveFull"
            }

            if (!last_complete || (stack >= max && max > 1))
            {   
                item.style.washColor = "#666666";
                item.style.saturation = "0.1";
            }else
                talent_container.AddClass(full_style)


            last_complete = stack >= max
        }
    }

    if (hero_name == "npc_dota_hero_broodmother")
    {
        var epic_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_Broodmother_Epic")
        var blue_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_Broodmother_Blue")

        let talent_table = Game.talents_values["broodmother_spiders"]
        Object.entries(talent_table).map(([key, data]) => (data["name"] = key, data["name_number"] = key[Object.keys(key).length - 1], data))

        talent_table = Object.values(talent_table)
        talent_table.sort((a, b) => (a["name_number"] - b["name_number"]))

        var player_table = CustomNetTables.GetTableValue("upgrades_player", hero_name)

        for (const data of talent_table)
        {
            let rarity = data["rarity"]
            let mini_icon = data["mini_icon"]
            let name = data["name"]
            let max_lvl = data["max_level"]
            let lvl
            
            if (player_table !== undefined)
                lvl = player_table.upgrades[name]

            let parent_panel
            let blur_style
            let fill_style
            let active_style

            if (rarity == "purple")
            {
                parent_panel = epic_panel
                blur_style = "talent_purple_card"
                fill_style = "UniqueTalents_TalentLevelFillPurple"
                active_style = "card_content_purple_anim"
            }
            if (rarity == "blue")
            {
                parent_panel = blue_panel
                blur_style = "talent_blue_card"
                fill_style = "UniqueTalents_TalentLevelFillBlue"
                active_style = "card_content_blue_anim"
            }

            var talent_panel = $.CreatePanel("Panel", parent_panel, "")
            talent_panel.AddClass("UniqueTalents_Broodmother_Talent")
            talent_panel.AddClass(blur_style)

            var talent_icon = $.CreatePanel("Panel", talent_panel, "")
            talent_icon.AddClass("UniqueTalents_Broodmother_TalentIcon")
            talent_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/npc_dota_hero_broodmother/' + mini_icon + '.png")';
            talent_icon.style.backgroundSize = "contain";
            talent_icon.style.backgroundRepeat = "no-repeat";

            var talent_level_back = $.CreatePanel("Panel", talent_panel, "")
            talent_level_back.AddClass("UniqueTalents_Broodmother_TalentLevelBack")

            var talent_level_fill = $.CreatePanel("Panel", talent_level_back, "")
            talent_level_fill.AddClass("UniqueTalents_Broodmother_TalentLevelFill") 
            let width = "0%"
            if (lvl != undefined && max_lvl != undefined)
                width = (lvl/max_lvl)*100 + "%"

            talent_level_fill.style.width = width
            talent_level_fill.AddClass(fill_style)

            if (lvl !== undefined) 
            {
                talent_icon.style.washColor = "none";
                talent_icon.style.saturation = "1";
                if (lvl >= max_lvl)
                    talent_panel.AddClass(active_style)
            }else
            {
                talent_icon.style.washColor = "#666666";
                talent_icon.style.saturation = "0.1";
            }

            MouseOverTalent(talent_panel, '#upgrade_disc_' + name, name, lvl, true, rarity, max_lvl, player_id, hero_name)
        }
    }
}