--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements")

if (parentHUDElements)
{
  $.GetContextPanel().SetParent(parentHUDElements)
}


function pa_hunt_think(kv)
{
  let main = $.GetContextPanel().FindChildTraverse("PaHunt_Panel")
  let hero_icon = $.GetContextPanel().FindChildTraverse("PaHunt_Icon")
  let gold_row = $.GetContextPanel().FindChildTraverse("PaHunt_gold_row")
  let reward_row = $.GetContextPanel().FindChildTraverse("PaHunt_reward_row")
  let timer = $.GetContextPanel().FindChildTraverse("PaHunt_timer")

  if (main.BHasClass("PaHunt_Panel_hidden") || main.BHasClass("PaHunt_anim_close"))
  {
    main.RemoveClass("PaHunt_Panel_hidden")
    main.RemoveClass("PaHunt_anim_close")
    main.AddClass("PaHunt_anim_open")

    hero_icon.style.backgroundImage = 'url( "file://{images}/heroes/' + Game.GetHeroImage(kv.player_id, String(kv.hero)) + '.png" );'
    hero_icon.style.backgroundSize = "contain"
    hero_icon.style.backgroundRepeat = "no-repeat"

    let reward_icon = $.GetContextPanel().FindChildTraverse("PaHunt_reward_icon")
    reward_icon.abilityname = "custom_phantom_assassin_coup_de_grace"
  }

  if (kv.delay > 0)
  {
    hero_icon.AddClass("PaHunt_prepare")
    gold_row.AddClass("PaHunt_hidden")
    reward_row.AddClass("PaHunt_hidden")

    timer.text = $.Localize("#Hunt_preparation") + String(kv.delay)
    return
  }

  hero_icon.RemoveClass("PaHunt_prepare")
  gold_row.RemoveClass("PaHunt_hidden")

  var sec_n = kv.timer - 60*Math.trunc(kv.timer/60)
  var sec = String(sec_n)

  if (sec_n < 10)
  {
    sec = '0' + sec
  }

  timer.text = $.Localize("#Hunt_time") + String(Math.trunc(kv.timer/60)) + ':' + sec

  let gold = $.GetContextPanel().FindChildTraverse("PaHunt_gold")
  gold.text = String(kv.gold)

  if (kv.damage <= 0)
  {
    reward_row.AddClass("PaHunt_hidden")
    return
  }

  reward_row.RemoveClass("PaHunt_hidden")

  let reward = $.GetContextPanel().FindChildTraverse("PaHunt_reward")
  reward.text = '+' + String(kv.damage) + '%'

  if (kv.magic == 1)
  {
    reward.RemoveClass("PaHunt_reward_crit")
    reward.AddClass("PaHunt_reward_magic")
  }else
  {
    reward.RemoveClass("PaHunt_reward_magic")
    reward.AddClass("PaHunt_reward_crit")
  }
}


function pa_hunt_end(kv)
{
  let main = $.GetContextPanel().FindChildTraverse("PaHunt_Panel")

  if (main.BHasClass("PaHunt_Panel_hidden")) return

  main.RemoveClass("PaHunt_anim_open")
  main.AddClass("PaHunt_anim_close")

  $.Schedule(0.29, function()
  {
    if (!main.BHasClass("PaHunt_anim_close")) return

    main.AddClass("PaHunt_Panel_hidden")
  })
}


function init()
{
  GameEvents.Subscribe_custom('pa_hunt_think', pa_hunt_think)
  GameEvents.Subscribe_custom('pa_hunt_end', pa_hunt_end)
}

init()