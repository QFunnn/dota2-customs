--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");
var DotaHud = $.GetContextPanel().GetParent().GetParent().GetParent()

if (parentHUDElements)
{
 var center_block = parentHUDElements.FindChildTraverse("center_block");
 $.GetContextPanel().SetParent(center_block);

}

function GetDotaHud()
{
  let hPanel = $.GetContextPanel();

  while ( hPanel && hPanel.id !== 'Hud')
  {
      hPanel = hPanel.GetParent();
  }

  if (!hPanel)
  {
      throw new Error('Could not find Hud root from panel with id: ' + $.GetContextPanel().id);
  }

  return hPanel;
}


var names =
[
  "Legion_Duel_Panel",
  "Pa_hunt_init_Panel",
  "Tb_reflection_init_Panel",
  "TalentUI_short_Panel",
]


for (var i = 0; i < Object.keys(names).length; i++) 
{
  let panel = $.GetContextPanel().FindChildTraverse(names[i])
  if (panel && panel != null && DotaHud)
  {
    panel.SetParent(DotaHud)
  }
}


CustomNetTables.SubscribeNetTableListener( "hero_portrait_levels", update_levels );
GameEvents.Subscribe("reconnect_hero_levels", reconnect_hero_levels)



const level_colors = ['#edb96e','#d5edf3','#feeb44',"#c4eaff",'#d1ce89','#d1ce89']
var level_init = false
var level_heroes = {}

function update_levels(table, key, data)
{
  if (table != "hero_portrait_levels") return
  if (key == "") return

  if (key == -1 || key == "-1" || key == "") return

  level_heroes[key] = data
}


function reconnect_hero_levels(kv)
{
  let hero = kv.hero
  update_levels("hero_portrait_levels", hero, CustomNetTables.GetTableValue("hero_portrait_levels", hero))
}



function check_level_timer()
{

  let hero_id = Players.GetLocalPlayerPortraitUnit()
  let hero = Entities.GetUnitName(hero_id)


  let level_data = level_heroes[hero]
  let level_icon = $.GetContextPanel().FindChildTraverse("level_icon_custom")
  let hero_label = $.GetContextPanel().GetParent().FindChildTraverse("UnitNameLabel");

  let dota_level = center_block.FindChildTraverse('unitbadge')

  if (dota_level)
  {
    dota_level.style.opacity = '0';
  }

  if (!level_icon)
  {
    level_icon =  $.CreatePanel("Panel", $.GetContextPanel(), "level_icon_custom")
    level_icon.AddClass("level_icon_custom")
  }  
  

  if ((level_data)&&(level_data.tier != undefined)&&(level_data.tier > -1))
  {
    hero_label.style.color = level_colors[level_data.tier];
    level_icon.style.backgroundImage = 'url("s2r://panorama/images/hud/portrait_hero_badge_frame_tier_' + String(level_data.tier + 1) + '_psd.vtex")';
    level_icon.style.opacity = "1";

  }
  else 
  {
    hero_label.style.color = 'white';
    level_icon.style.opacity = "0";
  }


  $.Schedule( 0.1, function()
  { 
    check_level_timer()
  })
  
}



function init()
{

  GameEvents.Subscribe_custom('pa_hunt_think', pa_hunt_think)
  GameEvents.Subscribe_custom('pa_hunt_end', pa_hunt_end)
  GameEvents.Subscribe_custom('pa_hunt_init', pa_hunt_init)
  GameEvents.Subscribe_custom('pa_hunt_init_end', pa_hunt_init_end)

  GameEvents.Subscribe_custom('tb_reflection_init', tb_reflection_init)
  GameEvents.Subscribe_custom('tb_reflection_init_end', tb_reflection_init_end)
  
  GameEvents.Subscribe_custom('legion_duel_init', legion_duel_init)
  GameEvents.Subscribe_custom('legion_duel_end', legion_duel_end)

  GameEvents.Subscribe_custom('lifestealer_infest', lifestealer_infest)

  GameEvents.Subscribe_custom('init_hero_level', init_hero_level)

  GameEvents.Subscribe_custom('invoker_hide_neutral', invoker_hide_neutral)

  GameEvents.Subscribe_custom('ogremagi_bloodlust', ogremagi_bloodlust)

  GameEvents.Subscribe_custom('talent_ui_long', talent_ui_long)
  GameEvents.Subscribe_custom('talent_ui_short', talent_ui_short)
}

var neutral_item_picker = null
var NeutralCraftTrinketList = null

function invoker_hide_neutral()
{
    let dotahud = GetDotaHud()
    if (!neutral_item_picker)
    {
      neutral_item_picker = dotahud.FindChildTraverse("neutral_item_picker")
      let TooltipContents = neutral_item_picker.GetChild(0)
      let Body = TooltipContents.GetChild(2)
      let first = Body.GetChild(0)
      let second = Body.GetChild(1)
      first.visible = false
      second.visible = false
    }
    InvokerAbuse()
}

function InvokerAbuse()
{
    if (!NeutralCraftTrinketList)
    {
        NeutralCraftTrinketList = neutral_item_picker.FindChildTraverse("NeutralCraftTrinketList")
    }
    if (NeutralCraftTrinketList && NeutralCraftTrinketList.GetChild(0))
    {
        $.DispatchEvent("Activated", NeutralCraftTrinketList.GetChild(0), "mouse");
    }
    let delay = 1
    if (neutral_item_picker.BHasClass("ShowPicker"))
    {
        delay = 0.1
    }
    $.Schedule(delay, function() 
    {
      InvokerAbuse()
    })
}

function init_hero_level(kv)
{
  check_level_timer()
}


var current_style = "Default"
var current_style_short = "Default"


var main_long = $.GetContextPanel().FindChildTraverse("TalentUI_long_Panel")
var filler_long = $.GetContextPanel().FindChildTraverse("TalentUI_long_Filler")
var number_long = $.GetContextPanel().FindChildTraverse("TalentUI_long_Number")
var bar_long = $.GetContextPanel().FindChildTraverse("TalentUI_long_Bar")
var icon_long = $.GetContextPanel().FindChildTraverse("TalentUI_long_Icon")
var icon_number_long = DotaHud.FindChildTraverse("TalentUI_long_Icon_Number")

function talent_ui_long(kv)
{
  let style = kv.style
  let hide = kv.hide
  let max_style = style + "_Max"

  if (hide == 1)
  {
    if (!main_long.BHasClass("TalentUI_long_Panel_hidden"))
    {
      main_long.AddClass("TalentUI_long_Panel_hidden")
    }

    filler_long.RemoveClass(max_style + "_Filler")
    icon_long.RemoveClass(max_style)
    bar_long.RemoveClass(max_style)
    filler_long.style.width = '0%'
    return
  }

  if (main_long.BHasClass("TalentUI_long_Panel_hidden"))
  {
    main_long.RemoveClass("TalentUI_long_Panel_hidden")
  }

  let max = kv.max
  let stack = Math.min(kv.stack, max)
  let no_min = kv.no_min
  let glow_style = style + "_Glow"
  let override_stack = kv.override_stack
  let hide_number = kv.hide_number
  let active = kv.active
  let use_zero = kv.use_zero
  let glow = kv.glow
  let stack_icon = kv.stack_icon

  if (current_style != style)
  {
    bar_long.RemoveClass(current_style + "_Bar")
    filler_long.RemoveClass(current_style + "_Filler")
    icon_long.RemoveClass(current_style + "_Icon")
    number_long.RemoveClass(current_style + "_Number")

    bar_long.AddClass(style + "_Bar")
    filler_long.AddClass(style + "_Filler")
    icon_long.AddClass(style + "_Icon")
    number_long.AddClass(style + "_Number")
    current_style = style
  }

  filler_long.style.width = String((stack/max) * 95)+'%'

  if (hide_number == 1)
  {
    number_long.text = ""
  }else
  {
    let num = stack
    if (override_stack != -1)
    {
      num = override_stack
    }

    if (use_zero == 1)
    {
      num = roundPlus(num, 1)
      if (num % 1 == 0)
      {
        number_long.text = String(num) + '.0'
      }else 
      {
        number_long.text = String(num)
      }
    }else
    {
      if (typeof(num) == "string")
      {
        number_long.text = num
      }else
      { 
        number_long.text = String(Math.trunc(num))
      } 
    } 
  }

  if (stack_icon != -1)
  {
    if (typeof(stack_icon) == "string")
    {
      icon_number_long.text = stack_icon
    }else
    { 
      icon_number_long.text = String(Math.trunc(stack_icon))
    }
  }else
  {
    icon_number_long.text = ""  
  }


  if (!bar_long.BHasClass("TalentUI_long_inactive") && no_min == 0 && stack <= 0)
  {  
    bar_long.AddClass("TalentUI_long_inactive")
    icon_long.AddClass("TalentUI_long_inactive")
    filler_long.AddClass("TalentUI_long_inactive")
  }
  if (bar_long.BHasClass("TalentUI_long_inactive") && (no_min == 1 || stack > 0))
  {  
    bar_long.RemoveClass("TalentUI_long_inactive")
    icon_long.RemoveClass("TalentUI_long_inactive")
    filler_long.RemoveClass("TalentUI_long_inactive")
  }

  if (glow == 1)
  {
    let add_style = glow_style
    if (active == 1)
      add_style = glow_style + "_Active"

    if (!bar_long.BHasClass(add_style))
    {  
      bar_long.AddClass(add_style)
      icon_long.AddClass(add_style)
    }
  }else
  {
    if (bar_long.BHasClass(glow_style) || bar_long.BHasClass(glow_style + "_Active"))
    {  
      bar_long.RemoveClass(glow_style)
      icon_long.RemoveClass(glow_style)
      bar_long.RemoveClass(glow_style + "_Active")
      icon_long.RemoveClass(glow_style + "_Active")
    }
  }

  if (active != -1)
  {
    if (active == 1)
    {
      if (!bar_long.BHasClass(style + "_Bar_Active"))
      {  
        bar_long.AddClass(style + "_Bar_Active")
        icon_long.AddClass(style + "_Icon_Active")
        filler_long.AddClass(style + "_Filler_Active")
        bar_long.RemoveClass(style + "_Bar")
        icon_long.RemoveClass(style + "_Icon")
        filler_long.RemoveClass(style + "_Filler")
      }
    }else
    {
      if (bar_long.BHasClass(style + "_Bar_Active"))
      {  
        bar_long.RemoveClass(style + "_Bar_Active")
        icon_long.RemoveClass(style + "_Icon_Active")
        filler_long.RemoveClass(style + "_Filler_Active")
        bar_long.AddClass(style + "_Bar")
        icon_long.AddClass(style + "_Icon")
        filler_long.AddClass(style + "_Filler")
      }
    }
    return
  }

  if (stack >= max)
  {
    if (!bar_long.BHasClass(max_style))
    {  
      bar_long.AddClass(max_style)
      icon_long.AddClass(max_style)
      filler_long.AddClass(style + "_Max_Filler")
    }
  }else
  {
    if (bar_long.BHasClass(max_style))
    {  
      bar_long.RemoveClass(max_style)
      icon_long.RemoveClass(max_style)
      filler_long.RemoveClass(style + "_Max_Filler")
    }
  }
}




var main_short = DotaHud.FindChildTraverse("TalentUI_short_Panel")
var filler_short = DotaHud.FindChildTraverse("TalentUI_short_Filler")
var number_short = DotaHud.FindChildTraverse("TalentUI_short_Number")
var bar_short = DotaHud.FindChildTraverse("TalentUI_short_Bar")
var icon_short = DotaHud.FindChildTraverse("TalentUI_short_Icon")
var icon_number_short = DotaHud.FindChildTraverse("TalentUI_short_Icon_Number")
var ability_icon_short = DotaHud.FindChildTraverse("TalentUI_short_Ability")
var top_text_short = DotaHud.FindChildTraverse("TalentUI_short_TopText")


function talent_ui_short(kv)
{
  let max_time = kv.max_time
  let time = Math.min(kv.time, max_time)
  let stack = kv.stack
  let style = kv.style
  let hide = kv.hide
  let hide_full = kv.hide_full
  let active = kv.active
  let use_zero = kv.use_zero
  let stack_icon = kv.stack_icon
  let dots = kv.dots
  let override_ability = kv.override_ability
  let text = kv.top_text
  let stack_icon_zero = kv.stack_icon_zero

  if (hide == 1)  
  {
    if (!main_short.BHasClass("TalentUI_short_Panel_hidden"))
    {
      main_short.AddClass("TalentUI_short_Panel_hidden")
    }

    if (hide_full == 1)
    {
      filler_short.style.width = '100%'
    }
    if (hide_full == 0)
    {
      filler_short.style.width = '0%'
    }
    return
  }

  if (main_short.BHasClass("TalentUI_short_Panel_hidden"))
  {
    main_short.RemoveClass("TalentUI_short_Panel_hidden")
  }

  if (current_style_short != style)
  {
    bar_short.RemoveClass(current_style_short + "_Bar")
    filler_short.RemoveClass(current_style_short + "_Filler")
    icon_short.RemoveClass(current_style_short + "_Icon")

    bar_short.RemoveClass(current_style_short + "_Bar_Active")
    filler_short.RemoveClass(current_style_short + "_Filler_Active")
    icon_short.RemoveClass(current_style_short + "_Icon_Active")

    if (dots <= 0)
    {
      for (var i = 1; i <= 5; i++) 
      {
        let dot_panel = main_short.FindChildTraverse("TalentUI_short_Dot_" + String(Math.trunc(i)))
        if (dot_panel && dot_panel != null)
        {
          dot_panel.AddClass("TalentUI_short_Panel_hidden")
        }
      }
    }else
    {
      let margin = 100/dots
      for (var i = 1; i < dots; i++) 
      {
        let dot_panel = main_short.FindChildTraverse("TalentUI_short_Dot_" + String(Math.trunc(i)))
        if (dot_panel && dot_panel != null)
        {
          dot_panel.RemoveClass("TalentUI_short_Panel_hidden")
          dot_panel.RemoveClass(current_style_short + "_Dot")
          dot_panel.AddClass(style + "_Dot")
          dot_panel.style.marginLeft = String(margin*i) + "%"
        }
      }
    }

    bar_short.AddClass(style + "_Bar")
    filler_short.AddClass(style + "_Filler")
    icon_short.AddClass(style + "_Icon")
    current_style_short = style
  }

  if (text != -1)
  {
    if (top_text_short.BHasClass("TalentUI_short_Panel_hidden"))
    {
      top_text_short.RemoveClass("TalentUI_short_Panel_hidden")
      top_text_short.text = $.Localize("#" + text)
    }
  }else
  {
    top_text_short.text = ""
    top_text_short.AddClass("TalentUI_short_Panel_hidden")
  }

  if (override_ability != -1)
  {
    ability_icon_short.RemoveClass("TalentUI_short_Panel_hidden")
    ability_icon_short.abilityname = String(override_ability)
  }else
  {
    if (!ability_icon_short.BHasClass("TalentUI_short_Panel_hidden"))
    {
      ability_icon_short.AddClass("TalentUI_short_Panel_hidden")
    }
  }

  if (filler_short.BHasClass("TalentUI_short_Panel_hidden"))
  {
    filler_short.RemoveClass("TalentUI_short_Panel_hidden")
  }

  filler_short.style.width = String((time/max_time) * 97)+'%'

  if (stack != -1)
  {
    if (use_zero == 1)
    {
      let num = roundPlus(stack, 1)
      if (num % 1 == 0)
      {
        number_short.text = String(num) + '.0'
      }else 
      {
        number_short.text = String(num)
      }
    }else
    {
      if (typeof(stack) == "string")
      {
        number_short.text = stack
      }else
      { 
        number_short.text = String(Math.trunc(stack))
      }
    } 
  }else
  {
    number_short.text = ""
  }

  if (stack_icon != -1)
  {
    if (stack_icon_zero == 1)
    {
      let num = roundPlus(stack_icon, 1)

      if (icon_number_short.BHasClass("TalentUI_short_Icon_Number_normal"))
      {
        icon_number_short.RemoveClass("TalentUI_short_Icon_Number_normal")
        icon_number_short.AddClass("TalentUI_short_Icon_Number_zero")
      }

      if (num % 1 == 0)
      {
        icon_number_short.text = String(num) + '.0'
      }else 
      {
        icon_number_short.text = String(num)
      }
    }else
    {
      if (icon_number_short.BHasClass("TalentUI_short_Icon_Number_zero"))
      {
        icon_number_short.RemoveClass("TalentUI_short_Icon_Number_zero")
        icon_number_short.AddClass("TalentUI_short_Icon_Number_normal")
      }
      
      if (typeof(stack_icon) == "string")
      {
        icon_number_short.text = stack_icon
      }else
      { 
        icon_number_short.text = String(Math.trunc(stack_icon))
      }
    } 
  }else
  {
    icon_number_short.text = ""  
  }

  if (active == 1)
  {
    if (!bar_short.BHasClass(style + "_Bar_Active"))
    {  
      bar_short.AddClass(style + "_Bar_Active")
      icon_short.AddClass(style + "_Icon_Active")
      filler_short.AddClass(style + "_Filler_Active")
    }
  }else
  {
    if (bar_short.BHasClass(style + "_Bar_Active"))
    {  
      bar_short.RemoveClass(style + "_Bar_Active")
      icon_short.RemoveClass(style + "_Icon_Active")
      filler_short.RemoveClass(style + "_Filler_Active")
    }
  }
}





function pa_hunt_think(kv)
{


  let main = $.GetContextPanel().FindChildTraverse("PA_Hunt_Panel")
  if (main.BHasClass("PA_Hunt_Panel_hidden"))
  {
    main.RemoveClass("PA_Hunt_Panel_hidden")
    main.AddClass("PA_Hunt_Panel")
  }


  let hero_icon = $.GetContextPanel().FindChildTraverse("PA_Hunt_Icon")
  hero_icon.style.backgroundImage = "url('file://{images}/heroes/" + kv.hero + ".png')"
  hero_icon.style.backgroundSize = "contain";

  var text = ''
  var min = String( Math.trunc(kv.timer/60 ))
  var sec_n =  kv.timer - 60*Math.trunc(kv.timer/60)  
  var sec = String(sec_n)
  if (sec_n < 10) 
  {
    sec = '0' + sec

  }

  text = min  + ':' + sec



  let timer = $.GetContextPanel().FindChildTraverse("PA_Hunt_gold_timer")
  timer.text = text

}


function pa_hunt_end(kv)
{


  let main = $.GetContextPanel().FindChildTraverse("PA_Hunt_Panel")
  
  if (main.BHasClass("PA_Hunt_Panel"))
  {
    main.RemoveClass("PA_Hunt_Panel")
    main.AddClass("PA_Hunt_Panel_hidden")
  }
}






function roundPlus(x, n) { //x - число, n - количество знаков

  if (isNaN(x) || isNaN(n)) return false;

  var m = Math.pow(10, n);

  return Math.round(x * m) / m;

}





function legion_duel_init(kv)
{
  let main = DotaHud.FindChildTraverse("Legion_Duel_Panel")

  if (main.BHasClass("Legion_Duel_Panel_show") || main.BHasClass("Legion_Duel_Panel_visible") || main.BHasClass("Legion_Duel_Panel_hide"))
  {
    return
  }else 
  {
    main.RemoveClass("Legion_Duel_Panel_hidden")
    main.RemoveClass("Legion_Duel_Panel_hide")
    main.AddClass("Legion_Duel_Panel_show")
    main.AddClass("Legion_Duel_Panel_visible")

    $.Schedule( 0.3, function()
    { 
      main.RemoveClass("Legion_Duel_Panel_show")
    })
  }

  Game.EmitSound("Lc.Duel_target_start")

  let hero_1 = main.FindChildTraverse("Legion_Duel_hero_1")
  let hero_2 = main.FindChildTraverse("Legion_Duel_hero_2")


  hero_1.style.backgroundImage =  'url( "file://{images}/heroes/' + kv.hero_1 + '.png")'
  hero_1.style.backgroundSize = '100%'

  hero_2.style.backgroundImage =  'url( "file://{images}/heroes/' + kv.hero_2 + '.png")'
  hero_2.style.backgroundSize = '100%'


  hero_1.SetPanelEvent("onactivate", function() 
  {
    if ( !main.BHasClass("Legion_Duel_Panel_show") && !main.BHasClass("Legion_Duel_Panel_hide"))
    {
      Game.EmitSound("UI.Click")
      GameEvents.SendCustomGameEventToServer_custom("LcDuelPick", {pick : 1}); 
    }
  });


  hero_2.SetPanelEvent("onactivate", function() 
  {
    if ( !main.BHasClass("Legion_Duel_Panel_show") && !main.BHasClass("Legion_Duel_Panel_hide"))
    {
      Game.EmitSound("UI.Click")
      GameEvents.SendCustomGameEventToServer_custom("LcDuelPick", {pick : 2}); 
    }
  });

}





function legion_duel_end(kv)
{
  let main = DotaHud.FindChildTraverse("Legion_Duel_Panel")

  if (main.BHasClass("Legion_Duel_Panel_hidden") || main.BHasClass("Legion_Duel_Panel_show") || main.BHasClass("Legion_Duel_Panel_hide"))
  {
    return
  }else 
  {
    main.RemoveClass("Legion_Duel_Panel_visible")
    main.RemoveClass("Legion_Duel_Panel_show")
    main.AddClass("Legion_Duel_Panel_hide")
    main.AddClass("Legion_Duel_Panel_hidden")

    $.Schedule( 0.3, function()
    { 
      main.RemoveClass("Legion_Duel_Panel_hide")
    })
  }


}





function pa_hunt_init(data)
{

  let main = DotaHud.FindChildTraverse("Pa_hunt_init_Panel")

  if (main.BHasClass("Pa_hunt_init_Panel_show") || main.BHasClass("Pa_hunt_init_Panel_visible") || main.BHasClass("Pa_hunt_init_Panel_hide"))
  {
    return
  }else 
  {
    main.RemoveClass("Pa_hunt_init_Panel_hidden")
    main.RemoveClass("Pa_hunt_init_Panel_hide")
    main.AddClass("Pa_hunt_init_Panel_show")
    main.AddClass("Pa_hunt_init_Panel_visible")

    $.Schedule( 0.3, function()
    { 
      main.RemoveClass("Pa_hunt_init_Panel_show")
    })
  }

  Game.EmitSound("Lc.Duel_target_start")


  for (var i = 1; i <= Object.keys(data).length; i++)  
  {
    let icon = main.FindChildTraverse("Pa_hunt_init_hero_" + String(i))
    if (icon)
    {
      icon.SetPanelEvent("onactivate", function() 
      {

      });

      if (data[i] && data[i]["target"])
      {
        let name = data[i]["target"]
        let red = data[i]["killed"]
        icon.style.backgroundImage =  'url( "file://{images}/heroes/' + name + '.png")'
        icon.style.backgroundSize = '100%'
        
        if (red == 1)
        {
          let killed = icon.FindChildTraverse("Pa_hunt_init_hero_killed_overlay_" + String(i))
          if (icon)
          {
            killed.AddClass("Pa_hunt_init_hero_killed_overlay_show")
          }else 
          {
            killed.RemoveClass("Pa_hunt_init_hero_killed_overlay_show")
          }
          icon.AddClass("Pa_hunt_init_hero_killed")
        }else 
        {
          pa_hunt_set_event(icon, i)
          icon.RemoveClass("Pa_hunt_init_hero_killed")
        }
      }
    }
  }
}

function pa_hunt_set_event(panel, i)
{
  let main = DotaHud.FindChildTraverse("Pa_hunt_init_Panel")
  panel.SetPanelEvent("onactivate", function() 
  {
    if ( !main.BHasClass("Pa_hunt_init_Panel_show") && !main.BHasClass("Pa_hunt_init_Panel_hide"))
    {
      Game.EmitSound("UI.Click")
      GameEvents.SendCustomGameEventToServer_custom("PaHuntPick", {pick : i}); 
    }
  });
}


function pa_hunt_init_end(kv)
{
  let main = DotaHud.FindChildTraverse("Pa_hunt_init_Panel")

  if (main.BHasClass("Pa_hunt_init_Panel_hidden") || main.BHasClass("Pa_hunt_init_Panel_show") || main.BHasClass("Pa_hunt_init_Panel_hide"))
  {
    return
  }else 
  {
    main.RemoveClass("Pa_hunt_init_Panel_visible")
    main.RemoveClass("Pa_hunt_init_Panel_show")
    main.AddClass("Pa_hunt_init_Panel_hide")
    main.AddClass("Pa_hunt_init_Panel_hidden")

    $.Schedule( 0.3, function()
    { 
      main.RemoveClass("Pa_hunt_init_Panel_hide")
    })
  }
}








function tb_reflection_init(data)
{

let main = DotaHud.FindChildTraverse("Tb_reflection_init_Panel")

if (main.BHasClass("Tb_reflection_init_Panel_show") || main.BHasClass("Tb_reflection_init_Panel_visible") || main.BHasClass("Tb_reflection_init_Panel_hide"))
{
  return
}else 
{
  main.RemoveClass("Tb_reflection_init_Panel_hidden")
  main.RemoveClass("Tb_reflection_init_Panel_hide")
  main.AddClass("Tb_reflection_init_Panel_show")
  main.AddClass("Tb_reflection_init_Panel_visible")

  $.Schedule( 0.3, function()
  { 
    main.RemoveClass("Tb_reflection_init_Panel_show")
  })
}

for (var i = 1; i <= 10; i++)  
{
  let icon = main.FindChildTraverse("Tb_reflection_init_hero_" + String(i))
  if (icon)
  {
    icon.SetPanelEvent("onactivate", function() 
    {

    });
    if (data[i])
    {
      if (data["lifestealer_legendary"])
      {
        let name = data[i]
        icon.style.visibility = "visible"
        icon.style.backgroundImage =  "url('file://{images}/custom_game/icons/mini/npc_dota_hero_life_stealer/" + name + ".png')"
        icon.style.backgroundSize = '100%'
      }else
      {
        let name = data[i]["target"]
        icon.style.visibility = "visible"
        icon.style.backgroundImage =  'url( "file://{images}/heroes/' + name + '.png")'
        icon.style.backgroundSize = '100%'
      }
      tb_reflection_set_event(icon, i)
    }else
    {
      icon.style.visibility = "collapse"
    } 
  }else
  {
    break
  }
}

}

function tb_reflection_set_event(panel, i)
{
  let main = DotaHud.FindChildTraverse("Tb_reflection_init_Panel")
  panel.SetPanelEvent("onactivate", function() 
  {
    if ( !main.BHasClass("Tb_reflection_init_Panel_show") && !main.BHasClass("Tb_reflection_init_Panel_hide"))
    {
      Game.EmitSound("UI.Click")
      GameEvents.SendCustomGameEventToServer_custom("TbReflectionPick", {pick : i}); 
    }
  });
}


function tb_reflection_init_end(kv)
{
  let main = DotaHud.FindChildTraverse("Tb_reflection_init_Panel")

  if (main.BHasClass("Tb_reflection_init_Panel_hidden") || main.BHasClass("Tb_reflection_init_Panel_show") || main.BHasClass("Tb_reflection_init_Panel_hide"))
  {
    return
  }else 
  {
    main.RemoveClass("Tb_reflection_init_Panel_visible")
    main.RemoveClass("Tb_reflection_init_Panel_show")
    main.AddClass("Tb_reflection_init_Panel_hide")
    main.AddClass("Tb_reflection_init_Panel_hidden")

    $.Schedule( 0.3, function()
    { 
      main.RemoveClass("Tb_reflection_init_Panel_hide")
    })
  }
}




var lifestealer_init = false

function lifestealer_infest(kv)
{
  let LifestealerMain = $("#LifestealerInfest_Panel")
  if (lifestealer_init == false)
  {
    lifestealer_init = true
    LifestealerMain.SetPanelEvent('onmouseover', function() 
    {
      $.DispatchEvent('DOTAShowTextTooltip', LifestealerMain, $.Localize("#lifestealer_infest_tooltip")) 
    });

    LifestealerMain.SetPanelEvent('onmouseout', function() 
    {
      $.DispatchEvent('DOTAHideTextTooltip', LifestealerMain);
    });
  }
  let hide = kv.hide

  LifestealerMain.SetHasClass("LifestealerInfest_Panel_hidden", hide == 1)
  if (hide == 1)
    return

  let RageIcon = $("#LifestealerInfest_Panel_Rage")
  let WoundsIcon = $("#LifestealerInfest_Panel_Wounds")
  let RageCd = $("#LifestealerInfest_Cd_Rage")
  let WoundsCd = $("#LifestealerInfest_Cd_Wounds")

  let rage_cd = kv.rage_cd
  let wounds_cd = kv.wounds_cd
  let rage_active = kv.rage_active
  let wounds_active = kv.wounds_active

  RageIcon.SetHasClass("LifestealerInfest_Panel_Icon_Blur", (rage_active == 1 || rage_cd > 0))
  WoundsIcon.SetHasClass("LifestealerInfest_Panel_Icon_Blur", (wounds_active == 1 || wounds_cd > 0))
  RageIcon.GetParent().SetHasClass("LifestealerInfest_Panel_Icon_Active", rage_active == 1)
  WoundsIcon.GetParent().SetHasClass("LifestealerInfest_Panel_Icon_Active", wounds_active == 1)

  RageCd.text = rage_cd > 0 ? Math.ceil(rage_cd) : ""
  WoundsCd.text = wounds_cd > 0 ? Math.ceil(wounds_cd) : ""
}


var ogremagi_init = false

function ogremagi_bloodlust(kv)
{
  let Main = $("#OgreMagiBloodlust_Panel")
  let Buff_1 = $("#OgreMagiBloodlust_Buff_1")
  let Buff_2 = $("#OgreMagiBloodlust_Buff_2")
  let Buff_3 = $("#OgreMagiBloodlust_Buff_3")
  let Buff_4 = $("#OgreMagiBloodlust_Buff_4")
  let Text = $("#OgreMagiBloodlust_Timer_Text")
  let Timer_Panel = $("#OgreMagiBloodlust_Timer")
  let Icons = $("#OgreMagiBloodlust_Icons")

  if (ogremagi_init == false)
  {
    ogremagi_init = true

    OgreText(Buff_1, $.Localize("#DOTA_Tooltip_modifier_ogre_magi_bloodlust_custom_legendary_1_Description"))
    OgreText(Buff_2, $.Localize("#DOTA_Tooltip_modifier_ogre_magi_bloodlust_custom_legendary_2_Description"))
    OgreText(Buff_3, $.Localize("#DOTA_Tooltip_modifier_ogre_magi_bloodlust_custom_legendary_3_Description"))
    OgreText(Buff_4, $.Localize("#DOTA_Tooltip_modifier_ogre_magi_bloodlust_custom_legendary_4_Description"))
  }

  Main.SetHasClass("OgreMagiBloodlust_Panel_hidden", false)
  let timer = kv.timer
  let active = timer > 0
  let is_reroll = kv.is_reroll == 1

  Buff_1.SetHasClass("OgreMagiBloodlust_Buff_inactive", kv.buff_1 == 0)
  Buff_2.SetHasClass("OgreMagiBloodlust_Buff_inactive", kv.buff_2 == 0)
  Buff_3.SetHasClass("OgreMagiBloodlust_Buff_inactive", kv.buff_3 == 0)
  Buff_4.SetHasClass("OgreMagiBloodlust_Buff_inactive", kv.buff_4 == 0)

  if (!active)
  {
    timer = ""
  }else if (is_reroll)
  {
    timer = roundPlus(timer, 1)
    if (timer % 1 == 0)
    {
      timer = String(timer) + '.0'
    }else 
    {
      timer = String(timer)
    }
  }else
  {
    timer = Math.trunc(timer)
  }
  Text.SetHasClass("OgreMagiBloodlust_Timer_Text_reroll", is_reroll)
  Timer_Panel.SetHasClass("OgreMagiBloodlust_Buff_inactive", (is_reroll || !active))
  Icons.SetHasClass("OgreMagiBloodlust_Icons_border", (!is_reroll && active))
  Timer_Panel.SetHasClass("OgreMagiBloodlust_Icons_border", (!is_reroll && active))
  Text.text = timer
}

function OgreText(panel, text)
{
    panel.SetPanelEvent('onmouseover', function() {
        $.DispatchEvent('DOTAShowTextTooltip', panel, Game.ShowTalentValues(text, "modifier_ogremagi_bloodlust_7", 1, false, false)); });
        
    panel.SetPanelEvent('onmouseout', function() {
        $.DispatchEvent('DOTAHideTextTooltip', panel);
    });       
}

function HasModifier(unit, modifier) {
    for (var i = 0; i < Entities.GetNumBuffs(unit); i++) {
        if (Buffs.GetName(unit, Entities.GetBuff(unit, i)) == modifier){
            return Entities.GetBuff(unit, i)
        }
    }
  return false
}


init()
