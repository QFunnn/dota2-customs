--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



var color_table =
{
    "blue" : ["#163e80"],
    "purple" : ["#571b87"],
    "legendary" : ["#c46610"],
}


function UpdateTooltip()
{

    $("#TooltipBlock").RemoveAndDeleteChildren()
    let talent_text = $.GetContextPanel().GetAttributeString("talent_text", "")
    let name = $.GetContextPanel().GetAttributeString("name", "")
    let lvl = GetBoolean($.GetContextPanel().GetAttributeString("lvl", ""))
    let all_levels = GetBoolean($.GetContextPanel().GetAttributeString("all_levels", ""))
    let rarity = $.GetContextPanel().GetAttributeString("rarity", "")
    let max_level = $.GetContextPanel().GetAttributeString("max_level", "")
    let player_id = Number($.GetContextPanel().GetAttributeString("player_id", ""))
    let hero_name = $.GetContextPanel().GetAttributeString("hero_name", "")
    let is_scepter = $.GetContextPanel().GetAttributeString("is_scepter", "")
    let skill_change = $.GetContextPanel().GetAttributeString("skill_change", "")

    let legendary = rarity == "legendary"

    let text = Game.ShowTalentValues(talent_text, name, lvl, all_levels, legendary)

    let main = $("#TooltipBlock")
    let skill_panel = $("#TooltipBlock2")

    if (skill_change != "undefined")
    {
        skill_panel.RemoveClass("TooltipBlock_collapse")
        main.AddClass("TooltipBlock_margin")

        let skill_text = $("#SkillChangeText")
        skill_text.text = $.Localize("#" + hero_name + "_" + skill_change + "_short")

        let skill_icon = $("#SkillChangeIcon")
        skill_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero_name + '/' + skill_change + '.png")';
        skill_icon.style.backgroundSize = 'contain';
    }else
    {
        skill_panel.AddClass("TooltipBlock_collapse")
        main.RemoveClass("TooltipBlock_margin")
    }

    main.RemoveClass("TooltipBlock_blue")
    main.RemoveClass("TooltipBlock_purple")
    main.RemoveClass("TooltipBlock_legendary")
    main.AddClass("TooltipBlock_" + rarity)

    let header = $.CreatePanel("Panel", main, "")
    header.AddClass("tooltip_header")
    header.AddClass("tooltip_header_" + rarity)

    let header_text = $.CreatePanel("Label", header, "")
    header_text.AddClass("tooltip_header_text")
    header_text.AddClass("tooltip_header_text_" + rarity)
    header_text.text = $.Localize("#tooltip_text_" + rarity)

    let text_lvl = lvl
    if (text_lvl == undefined)
    {
        text_lvl = 0
    }

    let header_text_level = $.CreatePanel("Label", header, "")
    header_text_level.AddClass("tooltip_header_lvl")
    header_text_level.AddClass("tooltip_header_lvl_" + rarity)
    header_text_level.text = text_lvl + "/" + max_level

    if (is_scepter && is_scepter == "true")
    {
        header_text.text = $.Localize("#tooltip_text_scepter")  
    }

    let line = $.CreatePanel("Panel", main, "")
    line.AddClass("line")

    let info_text = $.CreatePanel("Label", line, "")
    info_text.AddClass("info_text")
    info_text.html = true
    info_text.text = text

    let is_breakable = Game.GetTalentValue(name, "is_breakable")
    let is_purgable = Game.GetTalentValue(name, "is_purgable")
    let is_through_bkb = Game.GetTalentValue(name, "is_through_bkb")
    let is_root_disabled = Game.GetTalentValue(name, "is_root_disabled")
    let is_purgable_self = Game.GetTalentValue(name, "is_purgable_self")
    let is_blockable = Game.GetTalentValue(name, "is_blockable")
    let is_basher = Game.GetTalentValue(name, "is_basher")

    let is_perma =  player_id == Game.GetLocalPlayerID() ? Game.GetTalentValue(name, "is_perma") : 0 

    let bottom_border = $.CreatePanel("Panel", main, "bottom_panel")
    bottom_border.AddClass("bottom_border")
    bottom_border.AddClass("bottom_border_" + rarity)
    bottom_border.AddClass("bottom_panel_collapse")

    let bottom_panel = $.CreatePanel("Panel", main, "bottom_panel")
    bottom_panel.AddClass("bottom_panel")
    bottom_panel.AddClass("bottom_panel_collapse")

    let alt_panel = $.CreatePanel("Panel", bottom_panel, "alt_panel")
    alt_panel.AddClass("alt_panel")

    let talent_cd = Game.GetTalentValue(name, "talent_cd")
    if (talent_cd != undefined)
    {
        let cd_panel = $.CreatePanel("Panel", alt_panel, "")
        cd_panel.AddClass("cd_panel")

        let cd_icon = $.CreatePanel("Panel", cd_panel, "")
        cd_icon.AddClass("cd_panel_image")

        let cd_timer = $.CreatePanel("Label", cd_panel, "")
        cd_timer.AddClass("cd_timer")
        cd_timer.html = true
        cd_timer.text = Game.ShowTalentValues("*talent_cd*", name, lvl, all_levels, legendary)
    }

    let alt_panel_child = $.CreatePanel("Panel", alt_panel, "")
    alt_panel_child.AddClass("bottom_panel_child")

    let alt_block = $.CreatePanel("Panel", alt_panel_child, "")
    alt_block.AddClass("alt_block")
    alt_block.AddClass("bottom_panel_collapse")

    let alt_text = $.CreatePanel("Label", alt_block, "")
    alt_text.AddClass("alt_block_text")

    let alt_image = $.CreatePanel("Panel", alt_block, "")
    alt_image.AddClass("alt_panel_image")

    let content_panel = $.CreatePanel("Panel", bottom_panel, "content_panel")
    content_panel.AddClass("content_panel")

    if (GameUI.IsAltDown())
    {
        alt_panel.AddClass("bottom_panel_collapse")
    }else
        content_panel.AddClass("bottom_panel_collapse")

    let button_text = 0

    let detail_text = $.Localize(talent_text + "_info")
    let damage_type = Game.GetTalentValue(name, "damage_type")

    if (detail_text != talent_text + "_info" || damage_type != undefined)
    {
        let info_text_panel = $.CreatePanel("Panel", content_panel, "")
        info_text_panel.AddClass("info_text_panel")
        let text = ""
        if (damage_type != undefined)
            text = $.Localize("#damage_type_info") + $.Localize("#damage_type_info_" + damage_type)

        if (detail_text != talent_text + "_info" )
        {
            if (damage_type != undefined)
                text = text + "<br><br>"
            text = text + Game.ShowTalentValues(talent_text + "_info", name, lvl, all_levels, legendary, true)
        }

        let info_text_label = $.CreatePanel("Label", info_text_panel, "")
        info_text_label.AddClass("info_text_label")
        info_text_label.html = true
        info_text_label.text = text

        button_text = 1
    }

    if (is_breakable == 1 || is_purgable == 1 || is_through_bkb == 1 || is_root_disabled == 1 || is_purgable_self == 1 || is_blockable == 1 || is_basher == 1 || is_perma == 1)
    {
        button_text = 1

        bottom_panel.RemoveClass("bottom_panel_collapse")

        let status_panel = $.CreatePanel("Panel", content_panel, "")
        status_panel.AddClass("status_panel")

        if (is_perma == 1)
        {
            let skill_icon = Game.GetTalentValue(name, "skill_icon")
            let perma_current = 0
            let perma_max = Game.GetTalentValue(name, "max")

            if (player_id != undefined)
            {
                let mod_name = Game.GetTalentValue(name, "mod_name")
                let mod_max = Game.GetTalentValue(name, "max")
                let hero = Players.GetPlayerHeroEntityIndex(player_id)
                if (mod_name != undefined)
                {
                    let mod = HasModifier(hero, mod_name)
                    if (mod != "None")
                        perma_current = Buffs.GetStackCount(hero, mod)
                }
            }

            let bottom_panel_perma = $.CreatePanel("Panel", status_panel, "")
            bottom_panel_perma.AddClass("bottom_panel_child")

            let bottom_panel_perma_icon = $.CreatePanel("Panel", bottom_panel_perma, "")
            bottom_panel_perma_icon.AddClass("bottom_panel_icon")
            bottom_panel_perma_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero_name + '/' + skill_icon + '.png")';
            bottom_panel_perma_icon.style.backgroundSize = 'contain';

            if (perma_current >= perma_max)
                bottom_panel_perma_icon.AddClass("bottom_panel_icon_complete")

            let bottom_panel_perma_text = $.CreatePanel("Label", bottom_panel_perma, "")
            bottom_panel_perma_text.AddClass("bottom_panel_text")
            bottom_panel_perma_text.text = $.Localize("#perma_progress") + perma_current + '/' + perma_max
        }

        if (is_basher == 1)
        {
            let bottom_panel_basher = $.CreatePanel("Panel", status_panel, "")
            bottom_panel_basher.AddClass("bottom_panel_child")

            let bottom_panel_basher_icon = $.CreatePanel("Panel", bottom_panel_basher, "")
            bottom_panel_basher_icon.AddClass("bottom_panel_icon")
            bottom_panel_basher_icon.AddClass("bottom_panel_basher_icon")

            let bottom_panel_basher_text = $.CreatePanel("Label", bottom_panel_basher, "")
            bottom_panel_basher_text.AddClass("bottom_panel_text")
            bottom_panel_basher_text.text = $.Localize("#tooltip_talent_basher")
        }
        if (is_breakable == 1)
        {
            let bottom_panel_breakable = $.CreatePanel("Panel", status_panel, "")
            bottom_panel_breakable.AddClass("bottom_panel_child")

            let bottom_panel_breakable_icon = $.CreatePanel("Panel", bottom_panel_breakable, "")
            bottom_panel_breakable_icon.AddClass("bottom_panel_icon")
            bottom_panel_breakable_icon.AddClass("bottom_panel_breakable_icon")

            let bottom_panel_breakable_text = $.CreatePanel("Label", bottom_panel_breakable, "")
            bottom_panel_breakable_text.AddClass("bottom_panel_text")
            bottom_panel_breakable_text.text = $.Localize("#tooltip_talent_breakable")
        }
        if (is_purgable == 1)
        {
            let bottom_panel_dispell = $.CreatePanel("Panel", status_panel, "")
            bottom_panel_dispell.AddClass("bottom_panel_child")

            let bottom_panel_dispell_icon = $.CreatePanel("Panel", bottom_panel_dispell, "")
            bottom_panel_dispell_icon.AddClass("bottom_panel_icon")
            bottom_panel_dispell_icon.AddClass("bottom_panel_purgable_icon")

            let bottom_panel_dispell_text = $.CreatePanel("Label", bottom_panel_dispell, "")
            bottom_panel_dispell_text.AddClass("bottom_panel_text")
            bottom_panel_dispell_text.text = $.Localize("#tooltip_talent_purgable")
        }
        if (is_through_bkb == 1)
        {
            let bottom_panel_bkb = $.CreatePanel("Panel", status_panel, "")
            bottom_panel_bkb.AddClass("bottom_panel_child")

            let bottom_panel_bkb_icon = $.CreatePanel("Panel", bottom_panel_bkb, "")
            bottom_panel_bkb_icon.AddClass("bottom_panel_icon")
            bottom_panel_bkb_icon.AddClass("bottom_panel_bkb_icon")

            let bottom_panel_bkb_text = $.CreatePanel("Label", bottom_panel_bkb, "")
            bottom_panel_bkb_text.AddClass("bottom_panel_text")
            bottom_panel_bkb_text.text = $.Localize("#tooltip_talent_through_bkb")
        }
        if (is_blockable == 1)
        {
            let bottom_panel_block = $.CreatePanel("Panel", status_panel, "")
            bottom_panel_block.AddClass("bottom_panel_child")

            let bottom_panel_block_icon = $.CreatePanel("Panel", bottom_panel_block, "")
            bottom_panel_block_icon.AddClass("bottom_panel_icon")
            bottom_panel_block_icon.AddClass("bottom_panel_block_icon")

            let bottom_panel_block_text = $.CreatePanel("Label", bottom_panel_block, "")
            bottom_panel_block_text.AddClass("bottom_panel_text")
            bottom_panel_block_text.text = $.Localize("#tooltip_talent_block")
        }
        if (is_root_disabled == 1)
        {
            let bottom_panel_root = $.CreatePanel("Panel", status_panel, "")
            bottom_panel_root.AddClass("bottom_panel_child")

            let bottom_panel_root_icon = $.CreatePanel("Panel", bottom_panel_root, "")
            bottom_panel_root_icon.AddClass("bottom_panel_icon")
            bottom_panel_root_icon.AddClass("bottom_panel_root_icon")

            let bottom_panel_root_text = $.CreatePanel("Label", bottom_panel_root, "")
            bottom_panel_root_text.AddClass("bottom_panel_text")
            bottom_panel_root_text.text = $.Localize("#tooltip_talent_root")
        }
        if (is_purgable_self == 1)
        {
            let bottom_panel_purge_self = $.CreatePanel("Panel", status_panel, "")
            bottom_panel_purge_self.AddClass("bottom_panel_child")

            let bottom_panel_purge_self_icon = $.CreatePanel("Panel", bottom_panel_purge_self, "")
            bottom_panel_purge_self_icon.AddClass("bottom_panel_icon")
            bottom_panel_purge_self_icon.AddClass("bottom_panel_purge_self_icon")

            let bottom_panel_purge_self_text = $.CreatePanel("Label", bottom_panel_purge_self, "")
            bottom_panel_purge_self_text.AddClass("bottom_panel_text")
            bottom_panel_purge_self_text.text = $.Localize("#tooltip_talent_purge_self")
        }
    }


    if (Game.pickrate_talents[hero_name])
    {
        button_text = button_text == 1 ? 2 : 3

        let pickrates_label = $.CreatePanel("Panel", content_panel, "")
        pickrates_label.AddClass("pickrates_label")

        let pickrates_label_header = $.CreatePanel("Panel", pickrates_label, "")
        pickrates_label_header.AddClass("pickrates_label_header")
        pickrates_label_header.AddClass("tooltip_header_" + rarity)

        let pickrates_label_text = $.CreatePanel("Label", pickrates_label_header, "")
        pickrates_label_text.AddClass("pickrates_label_text")
        pickrates_label_text.text = $.Localize("#pickrate_header")

        let no_sub_pickrates = [25, 15, 75, 35]

        let pickrates_panel = $.CreatePanel("Panel", pickrates_label, "")
        pickrates_panel.AddClass("pickrates_panel")

        let pickrates_panel_skills = $.CreatePanel("Panel", pickrates_panel, "")
        pickrates_panel_skills.AddClass("pickrates_panel_skills")

        if (!Game.Subscribed)
        {
            pickrates_panel_skills.AddClass("pickrates_panel_blur")

            pickrates_panel_nosub = $.CreatePanel("Panel", pickrates_panel, "")
            pickrates_panel_nosub.AddClass("pickrates_panel_nosub")

            let pickrates_panel_nosub_text = $.CreatePanel("Label", pickrates_panel_nosub, "")
            pickrates_panel_nosub_text.AddClass("pickrates_panel_nosub_text")
            pickrates_panel_nosub_text.html = true
            pickrates_panel_nosub_text.text = $.Localize("#pickrate_no_sub")
        }

        let pickrates = {}

        if (Game.spells_by_number[hero_name])
        {
            for (id in Game.spells_by_number[hero_name])
            {
                let data = Game.spells_by_number[hero_name][id]
                pickrates[data["skill_icon"]] = -1
            }
        }

        let count = 0
        for (skill_name in Game.pickrate_talents[hero_name])
        {
            let data = Game.pickrate_talents[hero_name][skill_name]
            if (data[name])
            {
                let percent = Game.Subscribed ? Number((data[name]*100).toFixed(0)) : no_sub_pickrates[count]
                count++

                if (pickrates[skill_name])
                   pickrates[skill_name] = percent
            }else
                if (pickrates[skill_name])
                    pickrates[skill_name] = 0
        }

        for (skill_name in pickrates)
        {
            let pickrate = pickrates[skill_name]

            let pickrates_panel_child = $.CreatePanel("Panel", pickrates_panel_skills, "")
            pickrates_panel_child.AddClass("bottom_panel_child")

            let pickrates_panel_child_icon = $.CreatePanel("Panel", pickrates_panel_child, "")
            pickrates_panel_child_icon.AddClass("bottom_panel_icon")
            pickrates_panel_child_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + hero_name + '/' + skill_name + '.png")';
            pickrates_panel_child_icon.style.backgroundSize = 'contain';

            let pickrates_panel_child_bar = $.CreatePanel("Label", pickrates_panel_child, "")
            pickrates_panel_child_bar.AddClass("bottom_panel_bar")

            let pickrates_panel_child_filler = $.CreatePanel("Label", pickrates_panel_child_bar, "")
            pickrates_panel_child_filler.AddClass("bottom_panel_filler")
            pickrates_panel_child_filler.AddClass("bottom_panel_filler_" + rarity)
            pickrates_panel_child_filler.style.width = pickrate*0.99 + "%"

            let pickrates_panel_child_bar_text = $.CreatePanel("Label", pickrates_panel_child_bar, "")
            pickrates_panel_child_bar_text.AddClass("bottom_panel_bar_text")
            pickrates_panel_child_bar_text.text = pickrate + "%"
        } 
    }

    if (button_text != 0 || talent_cd != undefined)
    {
        bottom_panel.RemoveClass("bottom_panel_collapse")
        bottom_border.RemoveClass("bottom_panel_collapse")

        if (button_text != 0)
        {
            alt_block.RemoveClass("bottom_panel_collapse")
            content_panel.can_alt = true
            let alt_button_text = ""
            if (button_text == 1)
            {
                alt_button_text = $.Localize("#details_show")
            }else if (button_text == 2)
            {
                alt_button_text = $.Localize("#pickrate_show")
            }else if (button_text == 3)
            {
                alt_button_text = $.Localize("#pickrate_header")
            }
            alt_text.text = alt_button_text
        }
    }

    let parent = main.GetParent().GetParent().GetParent();

    let set_color = (name) => {
        parent.FindChildTraverse(name).style.washColor = color_table[rarity];
    };
    set_color("TopArrow");
    set_color("RightArrow");
    set_color("BottomArrow");
    set_color("LeftArrow");
    main.arrow_color_updated = true;

    $.Schedule(0.1, CheckTooltipAlt)
}


function CheckTooltipAlt()
{
    if (Game.CustomTooltipOpened == true)
    {   
        let content_panel = $.GetContextPanel().FindChildTraverse("content_panel")
        let alt_panel = $.GetContextPanel().FindChildTraverse("alt_panel")

        if (content_panel.can_alt == true)
        {
            if (content_panel)
                content_panel.SetHasClass("bottom_panel_collapse", !GameUI.IsAltDown())
            
            if (alt_panel)
                alt_panel.SetHasClass("bottom_panel_collapse", GameUI.IsAltDown())
        }

        $.Schedule(0.1, CheckTooltipAlt)
    }
}


function GetBoolean(text)
{
    if (text == "true")
        return true
    if (text == "false")
        return false
    if (text == "undefined")
        return undefined
    return text
}


function GetTextSpellBlock(id, name)
{
    let text = ""
    var players_info = CustomNetTables.GetTableValue("skills_table", String(id))
    if (players_info)
    {
        if (players_info.skills_table[name])
        {
            let modifier = name
            let mult = (players_info.skills_table)[modifier]
            text = text + "<font color='gold'>" + GetPlusLabel(GetSpellNumber(modifier, mult)) + GetSpellNumber(modifier, mult) + "</font>" + GetSpellInfo(modifier)
        }
    }
    return text
}

function FindImage(name)
{
    for (let i = 0; i <= Object.keys(skills_table_cnt.skills_table).length; i++) 
    {
        if (skills_table_cnt.skills_table[i] && skills_table_cnt.skills_table[i][1] == name)
        {
            return skills_table_cnt.skills_table[i][2]
        }
    }
    return ""
}

function GetPlusLabel(num)
{
    if (num > 0)
    {
        return "+"
    }
    return ""
}

function GetSpellInfo(modifier)
{
    let info = skills_table_cnt.skills_table
    for (var i = 0; i <= Object.keys(info).length; i++) 
    {
        if (info[i] && info[i][1] == modifier)
        {
            return $.Localize("#"+info[i][1]+"_desc")
        }
    }
}

function GetSpellNumber(modifier, mult)
{
    let info = skills_table_cnt.skill_number
    return info[modifier] * mult
}
function HasModifier(unit, modifier) 
{
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) 
    {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier)
        {
            return Entities.GetBuff(unit, i)
        }
    }
   return "None"
}