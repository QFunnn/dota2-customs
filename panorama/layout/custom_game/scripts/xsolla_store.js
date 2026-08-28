--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


var XSOLLA_STORE_PRODUCTS = [
    ["2", "coins", "1000"],
    ["5", "coins", "6000"],
    ["6", "coins", "25000"],
    ["9", "coins", "135000"],
    ["10", "coins", "280000"],
    ["3", "plus", "30"],
    ["11", "plus", "90"],
    ["12", "plus", "360"],
    ["4", "battlepass", ""],
]

var xsolla_order_pending = false
var xsolla_events_ready = false
var xsolla_store_category = null

function XsollaInitEvents()
{
    if (xsolla_events_ready)
    {
        return
    }
    if (!GameEvents.Subscribe_custom)
    {
        $.Schedule(0.2, XsollaInitEvents)
        return
    }
    xsolla_events_ready = true
    GameEvents.Subscribe_custom("xsolla_order_created", XsollaOrderCreated)
}

function XsollaOrderCreated(data)
{
    if (!xsolla_order_pending)
    {
        return
    }
    xsolla_order_pending = false
    if (typeof LoadingClose === "function")
    {
        LoadingClose()
    }
    if (data && data.url)
    {
        var url = String(data.url)
        if (url.indexOf("https://secure.xsolla.com/") == 0 || url.indexOf("https://sandbox-secure.xsolla.com/") == 0)
        {
            $.DispatchEvent('ExternalBrowserGoToURL', url)
        }
    }
}

function XsollaOpenProducts(category)
{
    XsollaInitEvents()
    var list = $("#XsollaProductsList")
    list.RemoveAndDeleteChildren()
    var count = 0
    for (var i = 0; i < XSOLLA_STORE_PRODUCTS.length; i++)
    {
        if (!category || XSOLLA_STORE_PRODUCTS[i][1] == category)
        {
            XsollaCreateProductCard(list, XSOLLA_STORE_PRODUCTS[i])
            count++
        }
    }
    if (count == 0)
    {
        for (var i = 0; i < XSOLLA_STORE_PRODUCTS.length; i++)
        {
            XsollaCreateProductCard(list, XSOLLA_STORE_PRODUCTS[i])
            count++
        }
    }
    //list.style.width = (Math.min(count, 5) * 178) + "px"
    $("#XsollaProductsChoose").style.visibility = "visible"
}

function XsollaCloseProducts()
{
    $("#XsollaProductsChoose").style.visibility = "collapse"
}

function XsollaCreateProductCard(parent, product_info)
{
    var sku = product_info[0]
    var card = $.CreatePanel("Panel", parent, "")
    card.AddClass("XsollaProductCard")

    var icon = $.CreatePanel("Panel", card, "")
    icon.AddClass("XsollaProductIcon")
    if (product_info[1] == "coins")
    {
        icon.style.backgroundImage = 'url("file://{images}/custom_game/shop/wodacoin.png")'
    }
    else if (product_info[1] == "plus")
    {
        icon.style.backgroundImage = 'url("file://{images}/custom_game/shop/dp1.png")'
    }
    else
    {
        icon.style.backgroundImage = 'url("file://{images}/custom_game/shop/nydp8.png")'
    }
    icon.style.backgroundSize = "100%"

    var label = $.CreatePanel("Label", card, "")
    label.AddClass("XsollaProductLabel")
    if (product_info[1] == "coins")
    {
        label.text = product_info[2]
    }
    else if (product_info[1] == "plus")
    {
        label.text = $.Localize("#subscribe_plus_1") + " " + product_info[2]
    }
    else
    {
        label.text = $.Localize("#battle_pass_2")
    }

    card.SetPanelEvent("onactivate", function()
    {
        XsollaBuyProduct(sku)
    })
}

function XsollaBuyProduct(sku)
{
    if (!GameEvents.SendCustomGameEventToServer_custom)
    {
        return
    }
    xsolla_order_pending = true
    if (typeof LoadingCreated === "function")
    {
        LoadingCreated()
    }
    GameEvents.SendCustomGameEventToServer_custom("xsolla_create_order", {sku : String(sku)})
    XsollaCloseProducts()
}

XsollaInitEvents()