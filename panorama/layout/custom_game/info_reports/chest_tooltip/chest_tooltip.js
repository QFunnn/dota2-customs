--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]



var color_table =
{
    "poor" : ["#888"],
    "rich" : ["#be7a32"],
}


function UpdateTooltip()
{
    let type = $.GetContextPanel().GetAttributeString("type", "")
    let id = $.GetContextPanel().GetAttributeString("id", "")

    let content = GameUI.CustomUIConfig().GetPairChestInfo(type, id)

    let main = $("#TooltipBlock")
    $("#TooltipBlock").RemoveAndDeleteChildren()

    main.SetHasClass("TooltipBlock_rich", type == "rich")
    main.SetHasClass("TooltipBlock_poor", type == "poor")

    let parent = main.GetParent().GetParent().GetParent();

    let set_color = (name) => {
        parent.FindChildTraverse(name).style.washColor = color_table[type];
    };
    set_color("TopArrow");
    set_color("RightArrow");
    set_color("BottomArrow");
    set_color("LeftArrow");

    let content_panel = $.CreatePanel("Panel", main, "")
    content_panel.AddClass("ChestTooltip_Content")

    for (i in content.chest_items)
    {
        let table = content.chest_items[i]
        if (!table)
            continue

        let item_main = $.CreatePanel("Panel", content_panel, "")
        item_main.AddClass("ChestTooltip_Item")

        let item_icon = $.CreatePanel("Panel", item_main, "")
        item_icon.AddClass("ChestTooltip_Icon")
        item_icon.AddClass("ChestTooltip_Icon_" + table.rare)

        item_icon.style.backgroundImage = 'url("' + table.item_icon + '")'

        if (table.drop_type == "category_tip")
        {
            item_icon.style.backgroundSize = "59.4% 90%"
            item_icon.style.backgroundRepeat = "no-repeat"
            item_icon.style["background-position"] = "50%"
        }else
        {
            item_icon.style.backgroundSize = "100%"
        }

        if (table.chance > 0)
        {
            let chance_text = $.CreatePanel("Label", item_main, "")
            chance_text.AddClass("ChestTooltip_Chance")
            chance_text.text = table.chance + "%"
        }

        if (table.drop_type.startsWith("item_"))
        {
            let effect_icon = $.CreatePanel("Panel", item_main, "")
            effect_icon.AddClass("ChestTooltip_Effect")

            let name = table.drop_type.replace(/^item_/, "");

            effect_icon.style.backgroundImage = 'url( "file://{images}/custom_game/shop/effects/section/' + name + '.png" );'
            effect_icon.style.backgroundSize = 'contain';
            effect_icon.style.backgroundRepeat = 'no-repeat'
        }

        if (table.drop_type.startsWith("npc_"))
        {
            let name = Game.GetHeroImage(Game.GetLocalPlayerID(), table.drop_type)

            let hero_icon = $.CreatePanel("Panel", item_main, "")
            hero_icon.AddClass("ChestTooltip_Hero")

            hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/icons/' + name + '.png" );'
            hero_icon.style.backgroundSize = 'contain';
            hero_icon.style.backgroundRepeat = 'no-repeat'
        }

        if (table.drop_type == "category_tip")
        {
            let tip_icon = $.CreatePanel("Panel", item_main, "")
            tip_icon.AddClass("ChestTooltip_Tip")

            tip_icon.style.backgroundImage = 'url( "file://{images}/custom_game/tips/tip_0.png" );'
            tip_icon.style.backgroundSize = '145%';
            tip_icon.style.backgroundRepeat = 'no-repeat'
            tip_icon.style["background-position"] = "50%"
        }

        if (table.is_sound == 1)
        {
            let text = $.Localize("#" + table.item_name)

            let label = $.CreatePanel("Label", item_icon, "")
            label.AddClass("ChestTooltip_Voice")
            label.text = text
        }

    }

}