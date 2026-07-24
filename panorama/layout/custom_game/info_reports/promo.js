--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function shop_new_promo(kv)
{
    let data = PLAYER_SERVER_DATA
    let lang = $.Localize("#lang")
    if (lang != "rus")
    {
        return
    }
    
    if (!data?.total_games || data.total_games < max_games && lang !== "rus") 
    {
        return;
    }
    let main = $.GetContextPanel().FindChildTraverse("new_promo_alert")
    let icon = $.GetContextPanel().FindChildTraverse("new_promo_alert_icon")
    let body = $.GetContextPanel().FindChildTraverse("new_promo_alert_body")
    let arrow = $.GetContextPanel().FindChildTraverse("new_promo_alert_arrow")
    let text_top = $.GetContextPanel().FindChildTraverse("new_promo_alert_top_text")
    let text_bot = $.GetContextPanel().FindChildTraverse("new_promo_alert_bot_text")
    if (icon)
    {
        icon.style.opacity = 1
    }
    body.AddClass("new_promo_alert_body_blue")
    arrow.AddClass("new_promo_alert_arrow_blue")
    text_top.text = $.Localize("#new_promo_alert")
    text_bot.text = $.Localize("#new_promo_alert_reward")
    main.RemoveClass("new_promo_alert_hidden")
    main.AddClass("new_promo_alert")
    $.Schedule(12, function ()
    {
        main.AddClass("new_promo_alert_hidden")
        main.RemoveClass("new_promo_alert")
    })
}

function shop_global_sale(kv)
{
    let data = PLAYER_SERVER_DATA
    let lang = $.Localize("#lang")
    if (!data?.total_games || data.total_games < max_games && lang !== "rus") 
    {
        return;
    }
    let main = $.GetContextPanel().FindChildTraverse("new_promo_alert")
    let icon = $.GetContextPanel().FindChildTraverse("new_promo_alert_icon")
    let body = $.GetContextPanel().FindChildTraverse("new_promo_alert_body")
    let arrow = $.GetContextPanel().FindChildTraverse("new_promo_alert_arrow")
    let text_top = $.GetContextPanel().FindChildTraverse("new_promo_alert_top_text")
    let text_bot = $.GetContextPanel().FindChildTraverse("new_promo_alert_bot_text")
    active_sale_global = 1
    if (icon)
    {
        icon.style.opacity = 0
    }
    body.AddClass("new_promo_alert_body_orange")
    arrow.AddClass("new_promo_alert_arrow_orange")
    text_top.text = $.Localize("#global_sale_top")
    text_bot.text = $.Localize("#global_sale_bot")
    main.RemoveClass("new_promo_alert_hidden")
    main.AddClass("new_promo_alert")
    $.Schedule(12, function ()
    {
        main.AddClass("new_promo_alert_hidden")
        main.RemoveClass("new_promo_alert")
    })
}

function answer_promo_code(data)
{
    let result = data.status
    let ru_text = data.ru
    let eng_text = data.eng
    let lang = $.Localize("#lang")
    let name = data.name
    let amount = data.amount

    if ((name != "") && (amount != 0))
    {
        ru_text = $.Localize("#promo_active_" + name) + String(amount)
        if (name == "dota_plus" || name == "no_active_sub_dota_plus")
        {
            ru_text = ru_text + $.Localize("#promo_active_dota_plus_2")
        }
        eng_text = ru_text
    }

    let entry = $.GetContextPanel().FindChildTraverse("PromoEntry")
    let status = $.GetContextPanel().FindChildTraverse("promo_text_status")
    if (status)
    {
        if (lang == "rus")
        {
            status.text = ru_text
        }
        else 
        {
            status.text = eng_text
        }
        if (result == 0)
        {
            status.AddClass("promo_text_status_yes")
            Game.EmitSound("UI.Promo_active")
            if (entry)
            {
                entry.text = ""
            }
        }else 
        {
            status.AddClass("promo_text_status_no")
            Game.EmitSound("UI.Promo_fail")
        }
    }
}

function OpenPromoWindow()
{
    let main = $.GetContextPanel().FindChildTraverse("window_shop")

    Game.EmitSound("UI.Shop_Buy_start")

    let blur_panel = $.GetContextPanel().FindChildTraverse("shop_window_blur")
    blur_panel.RemoveClass("shop_window_blur_hidden")
    blur_panel.AddClass("shop_window_blur")

    let currency_panel_buying = $.CreatePanel("Panel", main, "currency_panel_buying")
    currency_panel_buying.AddClass("promo_panel")
    currency_panel_buying.hittest = true
    currency_panel_buying.SetPanelEvent("onactivate", function() {})

    let promo_content = $.CreatePanel("Panel", currency_panel_buying, "")
    promo_content.AddClass("promo_panel_content")

    let telegram_content = $.CreatePanel("Panel", currency_panel_buying, "")
    telegram_content.AddClass("telegram_content")

    let telegram_icon = $.CreatePanel("Panel", telegram_content, "")
    telegram_icon.AddClass("telegram_icon")

    let telegram_text = $.CreatePanel("Label", telegram_content, "")
    telegram_text.AddClass("promo_telegram_text")
    telegram_text.text = $.Localize("#promo_telegram_text")

    let closebuy = $.CreatePanel("Panel", currency_panel_buying, "")
    closebuy.AddClass("closebuy")
  
    telegram_content.SetPanelEvent("onactivate", function() 
    {  
        $.DispatchEvent("ExternalBrowserGoToURL", 'https://t.me/Dota1x6');
    })

    telegram_text.SetPanelEvent("onactivate", function() 
    {  
        $.DispatchEvent("ExternalBrowserGoToURL", 'https://t.me/Dota1x6');
    })

    blur_panel.SetPanelEvent("onactivate", function() 
    {   
        if (currency_panel_buying)
        {
            currency_panel_buying.RemoveClass("promo_panel")
            currency_panel_buying.AddClass("promo_panel_hide")
            $.Schedule( 0.35, function()
            {
                currency_panel_buying.DeleteAsync(0)
            })
            Game.EmitSound("UI.Shop_Category_Open")
            blur_panel.AddClass("shop_window_blur_hidden")
            blur_panel.RemoveClass("shop_window_blur")
        }
    });

    closebuy.SetPanelEvent("onactivate", function() 
    {   
        if (currency_panel_buying)
        {
            currency_panel_buying.RemoveClass("promo_panel")
            currency_panel_buying.AddClass("promo_panel_hide")
            $.Schedule( 0.35, function()
            {
                currency_panel_buying.DeleteAsync(0)
            })
            Game.EmitSound("UI.Shop_Category_Open")
            blur_panel.AddClass("shop_window_blur_hidden")
            blur_panel.RemoveClass("shop_window_blur")
        }
    });

    let label_header = $.CreatePanel("Label", promo_content, "")
    label_header.AddClass("promo_panel_header")
    label_header.text = $.Localize("#promo_button_header")

    let promo_entry_and_button = $.CreatePanel("Panel", promo_content, "");
    promo_entry_and_button.AddClass("promo_entry_and_button")

    let text_entry = $.CreatePanel(`TextEntry`, promo_entry_and_button, "PromoEntry", {});
    text_entry.AddClass("promo_text_entry")

    let promo_button = $.CreatePanel("Panel", promo_entry_and_button, "");
    promo_button.AddClass("promo_button")

    let promo_button_text = $.CreatePanel("Label", promo_button, "")
    promo_button_text.AddClass("promo_button_text")
    promo_button_text.text = $.Localize("#promo_button_active")

    let promo_text_status = $.CreatePanel("Label", promo_content, "promo_text_status")
    promo_text_status.AddClass("promo_text_status")

    promo_button.SetPanelEvent("onactivate", function() 
    {   
        Game.EmitSound("UI.Click")
        let entry = $.GetContextPanel().FindChildTraverse("PromoEntry")
        let status = $.GetContextPanel().FindChildTraverse("promo_text_status")
        if (promo_text_status)
        {
            status.RemoveClass("promo_text_status_yes")
            status.RemoveClass("promo_text_status_no")
            status.text = ""
        }
        if (entry)
        {   
            let text = (entry.text).toUpperCase();
            GameEvents.SendCustomGameEventToServer_custom( "send_promo_code", {text : text});
        }
    });
}