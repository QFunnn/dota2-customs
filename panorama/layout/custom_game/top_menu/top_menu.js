--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


$.GetContextPanel().SetParent(FindDotaHudElement("HUDElements"));

function OpenMenu(){
    if(GameUI.CustomUIConfig().ToggleMenu){
        GameUI.CustomUIConfig().ToggleMenu(true)
    }
}

function OpenWiki(){
    if(GameUI.CustomUIConfig().ToggleWiki){
        GameUI.CustomUIConfig().ToggleWiki(true)
    }
}

function OpenWiki2(){
    if(GameUI.CustomUIConfig().ToggleMenu){
        GameUI.CustomUIConfig().ToggleMenu(true)
    }

    if(GameUI.CustomUIConfig().OpenMenuPageSpecial){
        GameUI.CustomUIConfig().OpenMenuPageSpecial("Wiki")
    }
}

// function OpenSettings()
// {
//     FindDotaHudElement("page_setting").ToggleClass("Show");
//     GameEvents.SendCustomGameEventToAllClients("RefreshAbilityOrder", {}) 
// }

// function OpenLeaderboard()
// {
//     GameUI.CustomUIConfig().OpenLeaderboard()
// }

// function OpenProfileAndDonate(page_id)
// {
//     GameUI.CustomUIConfig().OpenMenu(page_id)
// }

// function OpenBannedAbilities()
// {
//     GameUI.CustomUIConfig().ToggleGameBans()
// }

// function UselessFunction()
// {
//     $.Schedule( 1, function()
//     {
//         UselessFunction()
//     })
//     let Donate_Button_1 = $("#Donate_Button_1")
//     let Donate_Button_2 = $("#Donate_Button_2")
//     if (IsAllowForThis())
//     {
//         if (Donate_Button_1)
//         {
//             Donate_Button_1.style.visibility = "visible"
//         }
//         if (Donate_Button_2)
//         {
//             Donate_Button_2.style.visibility = "visible"
//         }
//         return
//     }
//     if (Donate_Button_1)
//     {
//         Donate_Button_1.style.visibility = "collapse"
//     }
//     if (Donate_Button_2)
//     {
//         Donate_Button_2.style.visibility = "collapse"
//     }
// }

// UselessFunction()

// Обработка подсказок для элементов top menu
GameEvents.Subscribe("cha_hint_visible", function(params) {
    const hintMap = {
        "wiki": "#TopMenuIcon_Wiki",
        "settings": "#TopMenuIcon_Menu"
    }
    
    let iconSelector = hintMap[params.hint]
    if (iconSelector) {
        let icon = $(iconSelector)
        if (icon && icon.GetParent()) {
            let button = icon.GetParent()
            if (!GameUI.CustomUIConfig().HintOutlineParticles) {
                GameUI.CustomUIConfig().HintOutlineParticles = {}
            }
            // Используем глобальную функцию из hints.js с передачей контекста
            if (GameUI.CustomUIConfig().CreateHintParticle) {
                GameUI.CustomUIConfig().HintOutlineParticles[params.hint] = GameUI.CustomUIConfig().CreateHintParticle(button, $.GetContextPanel())
            }
        }
    }
})
