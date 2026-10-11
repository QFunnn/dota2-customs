--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


// Currency products: [sku, kind, amount, optional bundle artwork tier (1-5)].
var XSOLLA_STORE_PRODUCTS = [
    ["2", "coins", "1000", 1],
    ["5", "coins", "6000", 2],
    ["6", "coins", "25000", 3],
    ["9", "coins", "135000", 4],
    ["10", "coins", "280000", 5],
    ["14", "crystals", "100", 1],
    ["15", "crystals", "600", 2],
    ["16", "crystals", "2500", 3],
    ["17", "crystals", "13500", 4],
    ["18", "crystals", "28000", 5],
    ["3", "plus", "30"],
    ["11", "plus", "90"],
    ["12", "plus", "360"],
    ["13", "premium", "360"],
    ["4", "battlepass", ""],
]

var XSOLLA_PRODUCT_PRICES =
{
    "2":  {rub: 419,   usd: 4.99,   cny: 34},
    "5":  {rub: 2099,  usd: 24.99,  cny: 168},
    "6":  {rub: 8399,  usd: 99.99,  cny: 672},
    "9":  {rub: 42190, usd: 499.99, cny: 3359},
    "10": {rub: 84390, usd: 999.99, cny: 6717},
    "14": {rub: 419,   usd: 4.99,   cny: 34},
    "15": {rub: 2099,  usd: 24.99,  cny: 168},
    "16": {rub: 8399,  usd: 99.99,  cny: 672},
    "17": {rub: 42190, usd: 499.99, cny: 3359},
    "18": {rub: 84390, usd: 999.99, cny: 6717},
    "3":  {rub: 419,   usd: 4.99,   cny: 34},
    "11": {rub: 1190,  usd: 13.99,  cny: 94},
    "12": {rub: 4199,  usd: 49.99,  cny: 336},
    "13": {rub: 1499,  usd: 17.99,  cny: 121},
    "4":  {rub: 799,   usd: 9.99,   cny: 67},
}

function XsollaGetCurrency()
{
    var lang = String($.Language())
    if (lang == "russian") { return "rub" }
    if (lang == "schinese") { return "cny" }
    return "usd"
}

function XsollaFormatPrice(sku)
{
    var prices = XSOLLA_PRODUCT_PRICES[String(sku)]
    if (!prices) { return "" }
    var currency = XsollaGetCurrency()
    if (currency == "rub") { return prices.rub + " ₽" }
    if (currency == "cny") { return "¥" + prices.cny }
    return "$" + prices.usd.toFixed(2)
}

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
    var kind = product_info[1]
    var card = $.CreatePanel("Panel", parent, "")
    card.AddClass("XsollaCard")
    card.SetHasClass("Plus", kind == "plus")
    card.SetHasClass("Premium", kind == "premium")
    card.SetHasClass("Crystals", kind == "crystals")
    card.SetHasClass("Battlepass", kind == "battlepass")

    var icon = $.CreatePanel("Panel", card, "")
    icon.AddClass("XsollaCardIcon")
    var is_currency = kind == "coins" || kind == "crystals"
    icon.SetHasClass("XsollaCurrencyPack", is_currency)
    var icon_name = "nydp8"
    if (is_currency)
    {
        icon_name = kind == "coins" ? "wodacoin" : "wodacrystal"
        var pack_tier = Number(product_info[3]) || 0
        if (pack_tier >= 1 && pack_tier <= 5 && pack_tier == Math.floor(pack_tier))
        {
            icon_name = "xsolla_packs/" + kind + "_" + pack_tier
        }
    }
    else if (kind == "plus") { icon_name = "dp1" }
    else if (kind == "premium") { icon_name = "nydp1" }
    icon.style.backgroundImage = 'url("file://{images}/custom_game/shop/' + icon_name + '.png")'
    icon.style.backgroundSize = "100%"

    var title = $.CreatePanel("Label", card, "")
    title.AddClass("XsollaCardTitle")
    title.html = true
    if (kind == "coins" || kind == "crystals" || kind == "plus" || kind == "premium")
    {
        title.SetDialogVariable("n", String(product_info[2]))
        title.text = $.Localize("#xsolla_card_title_" + kind, title)
    }
    else
    {
        title.text = $.Localize("#battle_pass_2")
    }

    var buy = $.CreatePanel("Panel", card, "")
    buy.AddClass("XsollaCardBuy")

    var caption = $.CreatePanel("Label", buy, "")
    caption.AddClass("XsollaCardBuyCaption")
    caption.text = $.Localize("#button_buy")

    var price = $.CreatePanel("Label", buy, "")
    price.AddClass("XsollaCardPrice")
    price.text = XsollaFormatPrice(sku)

    buy.SetPanelEvent("onactivate", function()
    {
        XsollaBuyProduct(sku)
    })
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