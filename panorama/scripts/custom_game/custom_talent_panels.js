--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
  "PickUI_Panel",
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


const level_colors = ['#edb96e','#d5edf3','#feeb44',"#c4eaff",'#d1ce89','#d1ce89']

function check_level_timer()
{

  let hero_id = Players.GetLocalPlayerPortraitUnit()
  let hero = Entities.GetUnitName(hero_id)


  let tier = Game.GetPlayerTier(Entities.GetPlayerOwnerID(hero_id))
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
  

  if (tier != undefined && tier > -1)
  {
    hero_label.style.color = level_colors[tier];
    level_icon.style.backgroundImage = 'url("s2r://panorama/images/hud/portrait_hero_badge_frame_tier_' + String(tier + 1) + '_psd.vtex")';
    level_icon.style.opacity = "1";

  }
  else 
  {
    hero_label.style.color = 'white';
    level_icon.style.opacity = "0";
  }
}



function init()
{

  GameEvents.Subscribe_custom('pick_ui', pick_ui)

  GameEvents.Subscribe_custom('lifestealer_infest', lifestealer_infest)

  GameEvents.Subscribe_custom('init_hero_level', init_hero_level)
  GameEvents.Subscribe_custom('player_heroes', init_hero_level)
  GameEvents.Subscribe('dota_player_update_selected_unit', init_hero_level)
  GameEvents.Subscribe('dota_player_update_query_unit', init_hero_level)

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
  $.Schedule(0, check_level_timer)
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
  let glow = kv.glow
  let glow_style_short = style + "_Glow"

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

  if (glow == 1)
  {
    let add_style = glow_style_short
    if (active == 1)
      add_style = glow_style_short + "_Active"

    if (!bar_short.BHasClass(add_style))
    {
      bar_short.AddClass(add_style)
      icon_short.AddClass(add_style)
    }
  }else
  {
    if (bar_short.BHasClass(glow_style_short) || bar_short.BHasClass(glow_style_short + "_Active"))
    {
      bar_short.RemoveClass(glow_style_short)
      icon_short.RemoveClass(glow_style_short)
      bar_short.RemoveClass(glow_style_short + "_Active")
      icon_short.RemoveClass(glow_style_short + "_Active")
    }
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





function roundPlus(x, n) { //x - число, n - количество знаков

  if (isNaN(x) || isNaN(n)) return false;

  var m = Math.pow(10, n);

  return Math.round(x * m) / m;

}





function pick_ui(data)
{
  let main = DotaHud.FindChildTraverse("PickUI_Panel")

  if (data.hide == 1)
  {
    pick_ui_hide(main)
    return
  }

  pick_ui_show(main)

  let text = main.FindChildTraverse("PickUI_text")
  text.text = $.Localize(data.text)

  for (var i = 1; i <= 10; i++)
  {
    let slot = main.FindChildTraverse("PickUI_target_" + String(i))
    if (!slot)
      break

    let target = data.targets ? data.targets[i] : null

    if (!target)
    {
      slot.style.visibility = "collapse"
      continue
    }

    slot.style.visibility = "visible"

    let icon = main.FindChildTraverse("PickUI_target_icon_" + String(i))
    icon.style.backgroundImage = 'url("' + target.image + '")'
    icon.style.backgroundSize = '100%'

    let killed = main.FindChildTraverse("PickUI_target_killed_" + String(i))
    let gold = main.FindChildTraverse("PickUI_target_gold_" + String(i))
    let gold_number = main.FindChildTraverse("PickUI_target_gold_number_" + String(i))

    if (target.gold > 0 && target.killed != 1)
    {
      gold.RemoveClass("PickUI_target_gold_hidden")
      gold_number.text = String(target.gold)
    }else
    {
      gold.AddClass("PickUI_target_gold_hidden")
    }

    if (target.killed == 1)
    {
      icon.AddClass("PickUI_target_icon_killed")
      killed.AddClass("PickUI_target_killed_show")
      icon.SetPanelEvent("onactivate", function() {});
    }else
    {
      icon.RemoveClass("PickUI_target_icon_killed")
      killed.RemoveClass("PickUI_target_killed_show")
      pick_ui_set_event(main, icon, i)
    }
  }
}


function pick_ui_show(main)
{
  if (main.BHasClass("PickUI_Panel_show") || main.BHasClass("PickUI_Panel_visible"))
    return

  main.RemoveClass("PickUI_Panel_hidden")
  main.RemoveClass("PickUI_Panel_hide")
  main.AddClass("PickUI_Panel_show")
  main.AddClass("PickUI_Panel_visible")

  Game.EmitSound("Lc.Duel_target_start")

  $.Schedule( 0.3, function()
  {
    main.RemoveClass("PickUI_Panel_show")
  })
}


function pick_ui_hide(main)
{
  if (main.BHasClass("PickUI_Panel_hidden"))
    return

  main.RemoveClass("PickUI_Panel_visible")
  main.RemoveClass("PickUI_Panel_show")
  main.AddClass("PickUI_Panel_hide")
  main.AddClass("PickUI_Panel_hidden")

  $.Schedule( 0.3, function()
  {
    main.RemoveClass("PickUI_Panel_hide")
  })
}


function pick_ui_set_event(main, panel, i)
{
  panel.SetPanelEvent("onactivate", function()
  {
    if ( !main.BHasClass("PickUI_Panel_show") && !main.BHasClass("PickUI_Panel_hide"))
    {
      Game.EmitSound("UI.Click")
      GameEvents.SendCustomGameEventToServer_custom("CustomPick", {pick : i});
    }
  });
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
