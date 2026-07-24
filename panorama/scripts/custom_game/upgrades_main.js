--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Game.isopened = false
Game.cd = false

let cooldown = 0.4

function Upgrades_Click(new_hero) 
{
    let alt_hero
    if (new_hero)
        alt_hero = String(new_hero)

    var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
    if (!parentHUDElements)
        parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().GetParent().GetParent().GetParent().GetParent().FindChild("HUDElements");

    var Button = parentHUDElements.FindChildTraverse("Upgrades_Button");

    let LayerGeneral = parentHUDElements.FindChildTraverse("LayerGeneral")
    if (!LayerGeneral)
    {
        let talents_panel = $.CreatePanel("Panel", parentHUDElements, "talents_panel")
        talents_panel.BLoadLayout( "file://{resources}/layout/custom_game/talents_panel/talents_panel.xml", false, false );
        LayerGeneral = parentHUDElements.FindChildTraverse("LayerGeneral")
        LayerGeneral.AddClass("LayerGeneral_Game")
    }

    if (Game.cd == true)
        return 

    Game.cd = true

    if (Game.isopened === false) 
    {
        Game.isopened = true
        Game.EmitSound("UI.Talent_show")

        if (!LayerGeneral.init) 
        {
            LayerGeneral.init = true
            $.RegisterEventHandler("InputFocusLost", LayerGeneral, function() 
            {
                if ((Game.isopened === true) && (Game.cd === false))
                {
                    Game.EmitSound("UI.Talent_hide")
                    Upgrades_Click()
                }
            });
        }

    
        Button.RemoveClass("ButtonClose");
        Button.AddClass("ButtonOpen");
        LayerGeneral.RemoveClass("LayerGeneralClose");
        LayerGeneral.AddClass("LayerGeneralOpen");
        LayerGeneral.style.visibility = "visible";
        
        Game.init_talent_panel(LayerGeneral, alt_hero)

        $.Schedule(cooldown, function() 
        {
            Game.cd = false
            LayerGeneral.SetAcceptsFocus(true)
            LayerGeneral.SetFocus()
        })
    } else 
    {
        Game.EmitSound("UI.Talent_hide")
        Game.isopened = false

        LayerGeneral.SetAcceptsFocus(false)

        LayerGeneral.RemoveClass("LayerGeneralOpen");
        LayerGeneral.AddClass("LayerGeneralClose");
        Button.RemoveClass("ButtonOpen");
        Button.AddClass("ButtonClose");
        
        $.Schedule(cooldown, function() {
            LayerGeneral.style.visibility = "collapse";
            Game.cd = false
        })
        
    }
}


Game.Upgrades = Upgrades_Click