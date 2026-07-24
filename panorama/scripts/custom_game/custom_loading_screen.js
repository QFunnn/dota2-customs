--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




var use_plus = 0
var use_social = 0
var use_tips = 0
var use_sale = 0
var use_video = 1
var use_sponsor = 0

function start()
{
//let support_proj = $.GetContextPanel().FindChildTraverse("support_proj")
//let dev_blog = $.GetContextPanel().FindChildTraverse("dev_blog")
//support_proj.AddClass("background")
//dev_blog.AddClass("background_hidden")

  GameEvents.Subscribe('get_payment_url', get_custom_loading_url)

  $.Schedule(2, function() {
    var chat = $.GetContextPanel().GetParent().FindChildTraverse("ChatMainPanel")
    if (chat)
    {
      chat.style.opacity = '0'
    }
  })


  var hittestBlocker = $.GetContextPanel().GetParent().FindChild("SidebarAndBattleCupLayoutContainer");

  if (hittestBlocker) {
      hittestBlocker.hittest = false;
      hittestBlocker.hittestchildren = false;
  }

  $.Schedule(10, function() {
  // Hide_supp_back()
  })
 
  var main = $.GetContextPanel().FindChildTraverse("show_dota_pass")
  var social = $.GetContextPanel().FindChildTraverse("social_info")
  var tips = $.GetContextPanel().FindChildTraverse("tips_panel")
  var video = $.GetContextPanel().FindChildTraverse("info_video_main")

  let str = $.Localize("#use_video")

  let override_video = 0
  let override_add = 0

  if (str == "1")
  {
    override_video = 1
  }else if (str == "2")
  {
    use_plus = 0
    use_video = 0
    use_tips = 0
    use_sponsor = 1
  } else if (str == "0")
  {
    override_add = 1
  }else 
  {
    override_video = 1
  }

  if (social)
  {
    social.style.opacity = String(use_social)
  }

  if (main)
  {
    main.style.opacity = String(use_plus)

    if (override_add == 1)
    {
      main.style.opacity = "1"
    }

    if (use_plus || override_add == 1)
    {
      InitPlusContent()
      social.style.opacity = 1
    }
  }

  if (tips)
  {
    tips.style.opacity = String(use_tips)
  }

  if (video)
  {
    video.style.opacity = String(use_video)

    if (override_video == 1)
    {
      video.style.opacity = "1"
    }
    if (use_video == 1 || override_video == 1)
    {
      InitVideoContent()
    }
  }


  var sponsor = $.GetContextPanel().FindChildTraverse("sponsor")
  if (sponsor)
  {
    sponsor.style.opacity = String(use_sponsor)
  }
}

function click_adds()
{
  $.DispatchEvent('DOTAShowCustomGamePage', 3583342376)
}

function get_custom_loading_url(kv)
{
  $.DispatchEvent("ExternalBrowserGoToURL", kv.url);
}



function shuffle(array) {
  array.sort(() => Math.random() - 0.5);
}


var current_video = 1
var max_video = 7
var video_timer = 0
var video_timer_max = 15
var info_array = [1, 2, 3, 4, 5, 6, 7]


function InitVideoContent()
{

  info_array = info_array.sort(() => Math.random() - 0.5)


  ChangeVideoContent(1)
  VideoTimer()

  var left_button = $.GetContextPanel().FindChildTraverse("info_video_controller_left")

  left_button.SetPanelEvent("onactivate", function() 
  {
    if (on_cd == false)
    {
      on_cd = true
      ChangeVideoContent(-1)
      Game.EmitSound("UI.Loading_pluss_slide");

      $.Schedule(change_cd, function() {
          on_cd = false
      })
    }

  });


  var right_button = $.GetContextPanel().FindChildTraverse("info_video_controller_right")

  right_button.SetPanelEvent("onactivate", function() 
  {

    if (on_cd == false)
    {
      on_cd = true
      ChangeVideoContent(1)
      Game.EmitSound("UI.Loading_pluss_slide");

      $.Schedule(change_cd, function() {
          on_cd = false
      })
    }

  });

}






function VideoTimer()
{

  video_timer = video_timer + 1

  let text_panel = $.GetContextPanel().FindChildTraverse("info_video_center_text")

  if (text_panel)
  {


    text_panel.text = $.Localize("#info_video_text" +  String(info_array[current_video - 1]))
  }
  
  if (video_timer == video_timer_max)
  {
    ChangeVideoContent(1)
  }

  $.Schedule(1, function() {
      VideoTimer()
  })
}



function ChangeVideoContent(change)
{

  video_timer = 0

  var center_panel = $.GetContextPanel().FindChildTraverse("info_video_media")

  var current_content = $.GetContextPanel().FindChildTraverse("VideoInfo" + String(current_video))

  var old_dot = $.GetContextPanel().FindChildTraverse("info_video_controller_dot_" + String(current_video))
  old_dot.RemoveClass("info_video_controller_dot_open")

  var show_style = 'plus_content_show_left'
  var hide_style = 'plus_content_hide_left'

  if (change < 0)
  {
    show_style = 'plus_content_show_right'
    hide_style = 'plus_content_hide_right'
  }

  if (current_content)
  {
    current_content.AddClass(hide_style)
  }

  $.Schedule(0.5, function() 
  { 
    if (current_content != undefined)
    {
     current_content.DeleteAsync(0)
    }
  })

  current_video = current_video + change 
  if (current_video > max_video)
  {
    current_video = 1
  }
  else 
  {
    if (current_video < 1)
    {
      current_video = max_video
    }
  }


  let new_video = $.CreatePanel("Panel", center_panel, "VideoInfo" + String(current_video))

  let text = "url('file://{images}/custom_game/info_video/" + String(info_array[current_video - 1]) + "_eng.png')"

  if ($.Localize("#lang") == "rus")
  {
    text = "url('file://{images}/custom_game/info_video/" + String(info_array[current_video - 1]) + ".png')"
  }


  new_video.style.backgroundImage = text
  new_video.style.backgroundSize = "contain";
  new_video.AddClass("info_current_video")
  new_video.AddClass(show_style)


  var new_dot = $.GetContextPanel().FindChildTraverse("info_video_controller_dot_" + String(current_video))
  new_dot.AddClass("info_video_controller_dot_open")

  $.Schedule(0.5, function() 
  {
     new_video.RemoveClass(show_style)
  })


}





let all_tips = []
let current_tip = 0
let timer_tip = 0
let tips_count = 0
let tips_timer_max = 10

function init_tips()
{


  var dis = $.GetContextPanel().FindChildTraverse("discord")
  var boosty = $.GetContextPanel().FindChildTraverse("boosty")
  var telegram = $.GetContextPanel().FindChildTraverse("telegram")
  var click = $.GetContextPanel().FindChildTraverse("click_boosty")

  var sponsor = $.GetContextPanel().FindChildTraverse("sponsor")

  var visible_sponsor = $.Localize('#show_sponsor')

  if ((sponsor) && (visible_sponsor == '1'))
  {
    sponsor.AddClass("sponsor_visible")
  }else 
  {
    dis.style.visibility = "visible";
   // boosty.style.visibility = "visible";
    //click.style.visibility = "visible";
    telegram.style.visibility = "visible";
  }

  var left = $.GetContextPanel().FindChildTraverse("tips_left")
  left.style.visibility = "visible";
  left.SetPanelEvent("onactivate", function() {

    Game.EmitSound("General.ButtonClick");
    change_tips_left()
  });


  var right = $.GetContextPanel().FindChildTraverse("tips_right")
  right.style.visibility = "visible";
  right.SetPanelEvent("onactivate", function() {

    Game.EmitSound("General.ButtonClick");
    change_tips_right()
  });

  let s = ''



  for (var i = 0; i < 99; i++) 
  {
    s = $.Localize("#load_tip_" + String(i))

    if (s[0] != '#')
    {
      tips_count = i + 1
    }
    else 
    {
      break
    }
  }

  for (var i = 0; i < tips_count; i++) 
  {
    all_tips[i] = i
  } 

  shuffle(all_tips)

  show_tip()

  $.Schedule(1, function() {
      change_tips_timer()
  })


}



function show_tip()
{

  timer_tip = 0

  let count_label = $.GetContextPanel().FindChildTraverse("tips_info_count")
  count_label.text = String(current_tip + 1) + '/' + String(tips_count)

  let text_label = $.GetContextPanel().FindChildTraverse("tips_info_text")
  text_label.html = true 
  text_label.text = $.Localize("#load_tip_" + String(all_tips[current_tip]))

  var font_size = $.Localize("#load_tip_font_"  + String(all_tips[current_tip])) + "px"

  text_label.style.fontSize = font_size

}



function change_tips_timer()
{
  timer_tip = timer_tip + 1
  if (timer_tip == tips_timer_max)
  {
    change_tips_right()
  }

  $.Schedule(1, function() {
      change_tips_timer()
  })
}



function change_tips_right()
{
  current_tip = current_tip + 1


  if (all_tips[current_tip] == undefined) 
  {
    current_tip = 0
  }
  show_tip()
}



function change_tips_left()
{
  current_tip = current_tip - 1



  if (all_tips[current_tip] == undefined) 
  {
    current_tip = tips_count - 1
  }
  show_tip()
}











function Hide_supp_back()
{
let support_proj = $.GetContextPanel().FindChildTraverse("support_proj")
let dev_blog = $.GetContextPanel().FindChildTraverse("dev_blog")

support_proj.RemoveClass("background")
support_proj.AddClass("background_hide")

dev_blog.RemoveClass("background_hidden")
dev_blog.AddClass("background_show")

$.Schedule(0.75, function() {
  support_proj.RemoveClass("background_hide")
  support_proj.AddClass("background_hidden")

  dev_blog.RemoveClass("background_show")
  dev_blog.AddClass("background")
})

  $.Schedule(10, function() {
    Show_supp_back()
  })

}




function Show_supp_back()
{
let support_proj = $.GetContextPanel().FindChildTraverse("support_proj")
let dev_blog = $.GetContextPanel().FindChildTraverse("dev_blog")

dev_blog.RemoveClass("background")
dev_blog.AddClass("background_hide")

support_proj.RemoveClass("background_hidden")
support_proj.AddClass("background_show")


$.Schedule(0.75, function() {
  dev_blog.RemoveClass("background_hide")
  dev_blog.AddClass("background_hidden")

  support_proj.RemoveClass("background_show")
  support_proj.AddClass("background")
})

  $.Schedule(10, function() {
    Hide_supp_back()
  })
}















function PatreonDown()
{

let dev_patreon = $.GetContextPanel().FindChildTraverse("dev_support_patreon")
let dev_boosty = $.GetContextPanel().FindChildTraverse("dev_support_boosty")

let patreon = $.GetContextPanel().FindChildTraverse("support_patreon")
let boosty = $.GetContextPanel().FindChildTraverse("support_boosty")

dev_patreon.RemoveClass("support_patreon")
dev_patreon.AddClass("support_patreon_mouse")

dev_boosty.RemoveClass("support_boosty")
dev_boosty.AddClass("support_boosty_mouse")

patreon.RemoveClass("support_patreon")
patreon.AddClass("support_patreon_mouse")

boosty.RemoveClass("support_boosty")
boosty.AddClass("support_boosty_mouse")

$.Schedule(1.5, function() {
  PatreonUp()
})

}
function PatreonUp()
{

let dev_patreon = $.GetContextPanel().FindChildTraverse("dev_support_patreon")
let dev_boosty = $.GetContextPanel().FindChildTraverse("dev_support_boosty")

let patreon = $.GetContextPanel().FindChildTraverse("support_patreon")
let boosty = $.GetContextPanel().FindChildTraverse("support_boosty")

dev_patreon.RemoveClass("support_patreon_mouse")
dev_patreon.AddClass("support_patreon")

dev_boosty.RemoveClass("support_boosty_mouse")
dev_boosty.AddClass("support_boosty")


patreon.RemoveClass("support_patreon_mouse")
patreon.AddClass("support_patreon")

boosty.RemoveClass("support_boosty_mouse")
boosty.AddClass("support_boosty")

$.Schedule(1.5, function() 
{
  PatreonDown()
})

}




var current_plus = 1
var plus_timer = 0
var plus_timer_max = 15
var plus_max = 10

var change_cd = 0.5
var on_cd = false


function check_id()
{
  if ($.Localize("#ActiveInfo") != 1)
  {
    return
  }
  Game.EmitSound("UI.Click");

  if (Game.GetLocalPlayerID() == -1)
  {

    $.DispatchEvent("ExternalBrowserGoToURL", "https://dota1x6.com/");
  }
  else 
  {
    GameEvents.SendCustomGameEventToServer_custom( "browser_subscribe", {item_name: "sub"});  
  }

}




function InitPlusContent()
{
  ChangePlusContent(0)

  PlusTimer()

  var sale = $.GetContextPanel().FindChildTraverse("InfoHeaderLabel_sale")

  if (sale)
  {
    sale.style.opacity = String(use_sale)
  }

  var left_button = $.GetContextPanel().FindChildTraverse("controller_left")

  left_button.SetPanelEvent("onactivate", function() {
    if (on_cd == false)
    {
      on_cd = true
      ChangePlusContent(-1)
      Game.EmitSound("UI.Loading_pluss_slide");

      $.Schedule(change_cd, function() {
          on_cd = false
      })
    }

  });


  var right_button = $.GetContextPanel().FindChildTraverse("controller_right")

  right_button.SetPanelEvent("onactivate", function() {

    if (on_cd == false)
    {
      on_cd = true
      ChangePlusContent(1)
      Game.EmitSound("UI.Loading_pluss_slide");

      $.Schedule(change_cd, function() {
          on_cd = false
      })
    }

  });
}


function PlusTimer()
{

  let button = $.GetContextPanel().FindChildTraverse("ButtonBuySubscribe")

  if (button)
  {
    if ($.Localize("#ActiveInfo") == 1)
    {
      button.RemoveClass("ButtonBuySubscribe_not")
      button.AddClass("ButtonBuySubscribe")
    }else 
    {

      button.RemoveClass("ButtonBuySubscribe")
      button.AddClass("ButtonBuySubscribe_not")
    }

  }

  plus_timer = plus_timer + 1

  let new_label =  $.GetContextPanel().FindChildTraverse("TextPass_" + String(current_plus))

  if (new_label)
  {

    new_label.html = true;
    new_label.text = $.Localize("#pass_" +  String(current_plus))

  }
  
  if (plus_timer == plus_timer_max)
  {
    ChangePlusContent(1)
  }

  $.Schedule(1, function() {
      PlusTimer()
  })
}



function ChangePlusContent(change)
{

  plus_timer = 0

  var slider = $.GetContextPanel().FindChildTraverse("slide_container")
  var current_content = $.GetContextPanel().FindChildTraverse("plus_content_" + String(current_plus))

  var old_dot = $.GetContextPanel().FindChildTraverse("controller_dot_" + String(current_plus))
  old_dot.RemoveClass("controller_dot_open")


  var show_style = 'plus_content_show_left'
  var hide_style = 'plus_content_hide_left'

  if (change < 0)
  {
    show_style = 'plus_content_show_right'
    hide_style = 'plus_content_hide_right'
  }


  current_content.AddClass(hide_style)
  $.Schedule(0.5, function() 
  { 
    if (current_content != undefined)
    {
     current_content.DeleteAsync(0)
    }
  })

  current_plus = current_plus + change 
  if (current_plus > plus_max)
  {
    current_plus = 1
  }
  else 
  {
    if (current_plus < 1)
    {
      current_plus = plus_max
    }
  }


  var new_content = $.CreatePanel("Panel", slider, "plus_content_" + String(current_plus));
  new_content.AddClass("pass_window_" + String(current_plus));

  new_content.AddClass(show_style);

  var text_style = 'Right'

  if (current_plus % 2 == 0)
  {
    text_style = 'Left'
  }

  var new_label = $.CreatePanel("Label", new_content, "TextPass_" + current_plus);
  new_label.AddClass("TextInfoPass" + text_style);
  new_label.html = true;
  new_label.text = $.Localize("#pass_" +  String(current_plus))

  var new_dot = $.GetContextPanel().FindChildTraverse("controller_dot_" + String(current_plus))
  new_dot.AddClass("controller_dot_open")

  $.Schedule(0.5, function() 
  {
     new_content.RemoveClass(show_style)
  })


}








start()