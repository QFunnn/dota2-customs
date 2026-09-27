--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var unique_panel_heroes =
{
    "npc_dota_hero_broodmother" : true,
    "npc_dota_hero_muerta" : true,
    "npc_dota_hero_invoker" : true,
    "npc_dota_hero_kunkka" : true,
}


Game.init_talent_panel = (panel, player_id, pick_hero) =>
{

    var LayerGeneral = panel
    LayerGeneral.style.backgroundSize = "contain";

    let pick_stage = pick_hero !== undefined

    if (player_id === undefined || player_id === null)
    {
        if (pick_stage)
            player_id = Game.GetLocalPlayerID()
        else
            player_id = Entities.GetPlayerOwnerID(Players.GetLocalPlayerPortraitUnit())
    }

    player_id = Number(player_id)

    var hero = pick_stage ? String(pick_hero) : Game.GetPlayerHero(player_id)

    if (!hero || !Game.talents_values[hero])
        return

    if (Game.IsNoTalentsHero(hero))
        return

    let use_new_system = false
    if (Game.new_talent_system[hero])
        use_new_system = true

    let entindex = Players.GetPlayerHeroEntityIndex(player_id)

    var UniqueTalents_Panel = LayerGeneral.FindChildTraverse("UniqueTalents_Panel")
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
        UniqueTalents_Content.RemoveAndDeleteChildren()
        UniqueTalents_Content.DeleteAsync(0)
    }

    if (!pick_stage && unique_panel_heroes[hero] == true)
    {
        if (hero == "npc_dota_hero_kunkka" && !Game.HasTalent(player_id, "modifier_kunkka_xmark_7"))
        {
        }else
        {
            UniqueTalents_Panel.RemoveClass("talents_panel_hidden")
            UniqueTalents_Panel.AddClass("unique_talents_start")
            $.Schedule( 0.2, function(){ 
                UniqueTalents_Panel.AddClass("UniqueTalents_Panel_open")
                UniqueTalents_Panel.RemoveClass("unique_talents_start")
            })
            CreateUniquePanel(UniqueTalents_Panel, hero, player_id, entindex)
        }
    }
    var LayerPurple_skill = []
    var LayerBlue_skill = []

    for (var i = 0; i <= 4; i++)
    {
        LayerPurple_skill[i] = LayerGeneral.FindChildTraverse("LayerPurple_skill_" + String(i))
        LayerBlue_skill[i] = LayerGeneral.FindChildTraverse("LayerBlue_skill_" + String(i))
    }

    LayerGray_Right.AddClass("talents_panel_hidden")

    if (use_new_system == true)
    {
        LayerHeroTalents.RemoveClass("talents_panel_hidden")
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
           LayerPlayer_Skills.RemoveClass("LayerPlayer_Skills_Normal")
           LayerPlayer_Skills.AddClass("LayerPlayer_Skills_PickStage")
        }else
        {
           LayerGray_Left.RemoveClass("talents_panel_hidden") 
           LayerPlayer_Skills.AddClass("LayerPlayer_Skills_Normal")
           LayerPlayer_Skills.RemoveClass("LayerPlayer_Skills_PickStage")
        }
    }


    let hero_index = Players.GetPlayerHeroEntityIndex(player_id)

    var player_table = CustomNetTables.GetTableValue("upgrades_player", String(player_id))

    if (use_new_system)
    {
        let icon = LayerGeneral.FindChildTraverse("hero_talent_hero")
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
    let purple = LayerGeneral.FindChildTraverse("talent_purple_card_4")
    let blue = LayerGeneral.FindChildTraverse("talent_blue_card_4")
    let LayerHeroTalents_Hero = LayerGeneral.FindChildTraverse("LayerHeroTalents_Skill_0")

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

            let skill_panel = LayerGeneral.FindChildTraverse("LayerHeroTalents_Skill_" + skill_number)


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

                    let build_type = data["build_type"]
                    let build_label = skill_panel.FindChildTraverse("talent_orange_build")
                    let show_build = (lvl !== undefined || pick_stage) && build_type !== undefined

                    orange_lvl.SetHasClass("talents_panel_hidden", show_build)
                    orange_content.SetHasClass("talent_orange_card_build_1", show_build && build_type == 1)
                    orange_content.SetHasClass("talent_orange_card_build_2", show_build && build_type == 2)
                    build_label.SetHasClass("talents_panel_hidden", !show_build)
                    build_label.SetHasClass("talent_orange_build_1", build_type == 1)
                    build_label.SetHasClass("talent_orange_build_2", build_type == 2)

                    if (build_type)
                        build_label.text = $.Localize("#talent_build_type_" + build_type)
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

                Game.MouseOverTalent(orange_content, '#upgrade_disc_' + name, name, lvl, false, "legendary", max_level, player_id, hero, false, skill_change)

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

                Game.MouseOverTalent(purple_content, "#upgrade_disc_" + name, name, lvl, true, "purple", max_level, player_id, hero, false, skill_change)

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

                Game.MouseOverTalent(blue_content, "#upgrade_disc_" + name, name, lvl, true, "blue", max_level, player_id, hero, false, skill_change)
                
                blue_fill.style.width = level_width + "%"
            }
        }
    }




    if (pick_stage == true)
        return

    var LayerGray_skill = []
    for (var i = 1; i <= 2; i++)
    {
        let panel = LayerGeneral.FindChildTraverse("LayerGray_skill_" + i)
        if (panel) panel.DeleteAsync(0)
    
        let parent = LayerGray_Left
        
        LayerGray_skill[i] = $.CreatePanel("Panel", parent, "LayerGray_skill_" + i)
        LayerGray_skill[i].AddClass("Gray_Skill")
    }


    var gray_amount = 0

    var gray_general_count = 0

    var number = 0
    var text = ''

    var gray_max = 6

    var general_gray_border = $.CreatePanel("Panel", LayerGray_skill[1], "general_gray_border")
    general_gray_border.AddClass("general_border")
    var general_gray_border = $.CreatePanel("Panel", LayerGray_skill[2], "general_gray_border")
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

    let general_order = Object.keys(Game.talents_values["general"])
    let general_names = general_order.slice().sort((a, b) => ((player_table.upgrades[b] || 0) - (player_table.upgrades[a] || 0)) || (general_order.indexOf(a) - general_order.indexOf(b)))

    for (const name of general_names)
    {
        let data = Game.talents_values["general"][name]
        let rarity = data["rarity"]
        let icon = data["skill_icon"]
        let max_level = Game.GetMaxLevel(data)

        let lvl = player_table.upgrades[name]
        if (lvl === undefined)
            continue

        if (rarity == "gray")
        {
            gray_general_count = gray_general_count + 1

            let parent = LayerGray_skill[2]

            if (gray_general_count <= gray_max) 
            {
                parent = LayerGray_skill[1]
            }

            let general_gray_card = $.CreatePanel("Panel", parent, "general_gray_card" + gray_general_count)
            general_gray_card.AddClass("general_card")

            Game.MouseOverTalent(general_gray_card, "#upgrade_disc_" + name, name, lvl, true, "gray", max_level, player_id, hero, false, undefined)

            let general_gray_shadow = $.CreatePanel("Panel", general_gray_card, "general_gray_shadow" + gray_general_count)
            general_gray_shadow.AddClass("general_shadow")

            let general_gray_image = $.CreatePanel("Panel", general_gray_shadow, "general_gray_image" + gray_general_count)
            general_gray_image.AddClass("general_image_gray")
            general_gray_image.SetHasClass("general_image_priority", player_table.priority == name)
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

function CreateUniquePanel(main, hero_name, player_id, entindex)
{
    var content = $.CreatePanel("Panel", main, "UniqueTalents_Content")
    content.AddClass("UniqueTalents_Content")

    var has_scepter = Entities.HasScepter(entindex)
    let scepter_table =
    {
        "npc_dota_hero_invoker": true,
        "npc_dota_hero_broodmother": true,
        "npc_dota_hero_muerta": true,
    }

    var right_panel_main = $.CreatePanel("Panel", content, "")
    right_panel_main.AddClass("UniqueTalents_Scepter_Main")

    if (scepter_table[hero_name])
    {
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

    if (hero_name == "npc_dota_hero_kunkka")
    {
        var header_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_Kunkka_Header")
        var header_texture = $.CreatePanel("Panel", header_panel, "UniqueTalents_Kunkka_HeaderTexture")
        var header_inner = $.CreatePanel("Panel", header_panel, "UniqueTalents_Kunkka_HeaderInner")
        var icon = $.CreatePanel("Panel", header_inner, "UniqueTalents_Kunkka_HeaderIcon")
        var text = $.CreatePanel("Label", header_inner, "UniqueTalents_Kunkka_HeaderText")
        text.text = $.Localize("#KunkkaHeaderText")

        var kunkka_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_Kunkka_Content")

        var legendary_row = $.CreatePanel("Panel", kunkka_panel, "KunkkaRow_legendary")
        legendary_row.AddClass("UniqueTalents_Kunkka_Row")

        var purple_row = $.CreatePanel("Panel", kunkka_panel, "KunkkaRow_purple")
        purple_row.AddClass("UniqueTalents_Kunkka_Row")

        var blue_row = $.CreatePanel("Panel", kunkka_panel, "KunkkaRow_blue")
        blue_row.AddClass("UniqueTalents_Kunkka_Row")

        let talent_table = Object.entries(Game.talents_values["kunkka_shop"])
        var player_table = CustomNetTables.GetTableValue("upgrades_player", String(player_id))

        talent_table.sort(([a], [b]) => {
            const numA = Number(a.split("_").pop())
            const numB = Number(b.split("_").pop())

            return numA - numB
        })
        talent_table = talent_table.map(([key, data]) => {
            data.name = key
            return data
        })

        for (const data of talent_table)
        {
            let rarity = data["rarity"]
            let mini_icon = data["mini_icon"]
            let name = data["name"]
            let max_lvl = data["max_level"]
            let lvl = (player_table == undefined || !player_table.upgrades[name]) ? 0 : player_table.upgrades[name]

            let row_content = kunkka_panel.FindChildTraverse("KunkkaRow_content_" + rarity)
            if (!row_content || row_content == undefined || row_content == null)
            {
                let row = kunkka_panel.FindChildTraverse("KunkkaRow_" + rarity)
                row_content = $.CreatePanel("Panel", row, "KunkkaRow_content_" + rarity)
                row_content.AddClass("KunkkaRow_items_content")
            }

            let item_back = $.CreatePanel("Panel", row_content, name)
            item_back.AddClass("UniqueTalents_Kunkka_item_back")
            item_back.SetHasClass("UniqueTalents_Kunkka_item_back_active", lvl > 0)
            item_back.SetHasClass("UniqueTalents_Kunkka_item_back_max", lvl >= max_lvl)
            
            let item_icon = $.CreatePanel("Panel", item_back, name + "_icon")
            item_icon.AddClass("UniqueTalents_Kunkka_item_icon")
            item_icon.SetHasClass("UniqueTalents_Kunkka_item_icon_not_active", lvl <= 0)

            item_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/npc_dota_hero_kunkka/' + mini_icon + '.png")';
            item_icon.style.backgroundSize = "contain";
            item_icon.style.backgroundRepeat = "no-repeat";

            var item_level_back = $.CreatePanel("Panel", item_back, "")
            item_level_back.AddClass("UniqueTalents_Kunkka_item_level")

            var item_level_fill = $.CreatePanel("Panel", item_level_back, name + "_level")
            item_level_fill.AddClass("UniqueTalents_Kunkka_level_fill")
            item_level_fill.SetHasClass("UniqueTalents_Kunkka_level_fill_max", lvl >= max_lvl)
            item_level_fill.style.width = (lvl/max_lvl)*27 + "px"

            Game.MouseOverTalent(item_back, '#upgrade_disc_' + name, name, lvl, true, rarity, max_lvl, player_id, hero_name, undefined, undefined, true)
        }
    }

    if (hero_name == "npc_dota_hero_invoker")
    {
        var invoker_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_Invoker_Container")

        let talent_table = Game.talents_values["invoker_spells"]
        Object.entries(talent_table).map(([key, data]) => (data["name"] = key, data["name_number"] = key[Object.keys(key).length - 1], data))

        talent_table = Object.values(talent_table)
        talent_table.sort((a, b) => (a["name_number"] - b["name_number"]))

        var player_table = CustomNetTables.GetTableValue("upgrades_player", String(player_id))

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
            Game.MouseOverTalent(talent_container, '#upgrade_disc_' + name, name, stack, true, rarity, max, player_id, hero_name, true)
        }
    }

    if (hero_name == "npc_dota_hero_muerta")
    {
        var muerta_panel = $.CreatePanel("Panel", right_panel_main, "UniqueTalents_Muerta_Container")

        let talent_table = Game.talents_values["muerta_quest"]
        Object.entries(talent_table).map(([key, data]) => (data["name"] = key, data["name_number"] = key[Object.keys(key).length - 1], data))

        talent_table = Object.values(talent_table)
        talent_table.sort((a, b) => (a["name_number"] - b["name_number"]))

        var player_table = CustomNetTables.GetTableValue("upgrades_player", String(player_id))
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

        var player_table = CustomNetTables.GetTableValue("upgrades_player", String(player_id))

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

            Game.MouseOverTalent(talent_panel, '#upgrade_disc_' + name, name, lvl, true, rarity, max_lvl, player_id, hero_name)
        }
    }
}