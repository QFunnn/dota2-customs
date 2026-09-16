--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().FindChild("HUDElements");

if (parentHUDElements)
    $.GetContextPanel().SetParent(parentHUDElements);

var current_angle = 0
var target_angle = 0
var speed = 1
var current_schedule
var on_cd = false
var close_cd = 0.4
var is_active = false
var current_gold = 0


function Init()
{
    GameEvents.Subscribe_custom("UpdateKunkkaPanel", UpdateKunkkaPanel)
    GameEvents.Subscribe_custom("UpdateKunkkaShop", update_shop)
    GameEvents.Subscribe_custom("StartKunkkaPanel", StartKunkkaPanel)
    CustomNetTables.SubscribeNetTableListener("upgrades_player", update_upgrades_player)
    GameEvents.SendCustomGameEventToServer_custom("RequestKunkkaPanel", {})
}


function change_state(is_start)
{
  if (on_cd == true)
    return

  on_cd = true

  let main = $("#KunkkaPanel_parent")
  let panel = $("#KunkkaPanel_main")
  let close = $("#KunkkaPanel_close")
  let shop = $("#KunkkaPanel_Shop")
  let sound = "Kunkka.UI_open"

  if (!shop.BHasClass("panel_hidden"))
  {
    change_shop(true)
  }

  if (panel.BHasClass("panel_hidden"))
  {
    if (is_start)
        sound = "Kunkka.UI_start"

    main.RemoveClass("KunkkaPanel_anim_close")
    main.AddClass("KunkkaPanel_anim_open")
    panel.RemoveClass("panel_hidden")
    close.AddClass("panel_hidden")
  }else
  {
    sound = "Kunkka.UI_close"
    main.AddClass("KunkkaPanel_anim_close")
    main.RemoveClass("KunkkaPanel_anim_open")
    $.Schedule(0.29, function() {
        panel.AddClass("panel_hidden")
        close.RemoveClass("panel_hidden")
    })
  }

  Game.EmitSound(sound);

  $.Schedule(close_cd, function() {
      on_cd = false
  })
}

var shop_opened = false
var shop_init = false
var shop_delay = false

function change_shop(forced)
{
  if (on_cd == true && !forced)
    return

  on_cd = true

  let shop = $("#KunkkaPanel_Shop")
  let text = $("#KunkkaPanel_button_text")
  let sound = "Kunkka.UI_open_shop"
  let localize = "#open_chest"

  if (!shop_opened)
  {

    shop_opened = true
    localize = "#close_text"

    shop.RemoveClass("KunkkaPanel_shop_close")
    shop.AddClass("KunkkaPanel_shop_open")
    shop.RemoveClass("panel_hidden")

    if (!shop_init)
    {
        shop_init = true
        $.RegisterEventHandler("InputFocusLost", shop, function() 
        {
            if (shop_delay)
                return

            shop_delay = true
            $.Schedule(0.1, function()
            {
                shop_delay = false
            })

            for (let child of shop.FindChildrenWithClassTraverse("KunkkaPanel_shop_item_back"))
            {
                if (child.BHasKeyFocus())
                {
                    shop.SetFocus()
                    return
                }
            }

            if (shop_opened && !on_cd)
                change_shop()
        });
    }

    update_shop()

    $.Schedule(0.39, function() {
        shop.AddClass("KunkkaPanel_shop_opened")
        shop.SetAcceptsFocus(true)
        shop.SetFocus()
    })
  }else
  {
    shop_opened = false
    sound = "Kunkka.UI_close_shop"
    shop.AddClass("KunkkaPanel_shop_close")
    shop.RemoveClass("KunkkaPanel_shop_open")
    shop.RemoveClass("KunkkaPanel_shop_opened")

    shop.SetAcceptsFocus(false)

    $.Schedule(0.39, function() {
        shop.AddClass("panel_hidden")
    })
  }

  text.text = $.Localize(localize)
  Game.EmitSound(sound);

  $.Schedule(close_cd, function() {
      on_cd = false
  })
}



function StartKunkkaPanel()
{
    is_active = true

    let parent = $("#KunkkaPanel_parent")
    let close = $("#KunkkaPanel_close")

    if (parent.BHasClass("panel_hidden"))
        parent.RemoveClass("panel_hidden")

    if (close.BHasClass("panel_hidden"))
        close.RemoveClass("panel_hidden")

    init_shop()
    change_state(true)
}

function formatDistance(distance) {
    if (distance >= 1000) {
        return (Math.round(distance / 100) / 10).toFixed(1) + "k";
    }

    return Math.round(distance / 50) * 50;
}

function UpdateKunkkaPanel(data)
{
    let angle = data.angle

    let text = $("#KunkkaPanel_distance_text")
    text.text = formatDistance(data.distance)

    angle = (270 - angle) % 360

    if (target_angle != angle)
    {
        target_angle = angle
        if (current_schedule !== null) {
            $.CancelScheduled(current_schedule);
            current_schedule = null;
        }
        update_arrow()
    }
}


function update_arrow()
{
    let arrow = $("#KunkkaPanel_arrow");

    let diff = ((target_angle - current_angle + 540) % 360) - 180;

    if (Math.abs(diff) <= 0.5)
    {
        current_angle = target_angle;
    }else
    {
        // Скорость в процентах от оставшегося угла
        let percent = 0.08;
        interval = 0.01;

        current_angle += diff * percent;

        // Нормализуем угол
        current_angle = (current_angle + 360) % 360;
        current_schedule = $.Schedule(0.01, update_arrow);
    }
    arrow.style.transform = `rotateZ(${current_angle + 180}deg)`;
}

function GetCost(data)
{
    if (!data["cost"])
        return

    let bonus = 0
    let level = Game.HasTalent("npc_dota_hero_kunkka", "modifier_kunkka_shop_7", true)
    if (level)
        bonus = Game.GetTalentValue("modifier_kunkka_shop_7", "gold")[level]/100

    return Math.floor(data["cost"] * (1 + bonus))
}


function init_shop()
{
    let talent_table = Object.entries(Game.talents_values["kunkka_shop"])

    talent_table.sort(([a], [b]) => {
        const numA = Number(a.split("_").pop())
        const numB = Number(b.split("_").pop())

        return numA - numB
    })

    talent_table = talent_table.map(([key, data]) => {
        data.name = key
        return data
    })

    for (const data of talent_table)
    {
        let rarity = data["rarity"]
        let mini_icon = data["mini_icon"]
        let name = data["name"]

        let panel = $("#KunkkaPanel_shop_content_" + rarity)
        let cost_text = $("#KunkkaPanel_shop_cost_text_" + rarity)
        let content = $("#KunkkaPanel_shop_items_content_" + rarity)

        let item = $.CreatePanel("Panel", content, "")
        item.AddClass("KunkkaPanel_shop_item")

        let item_back = $.CreatePanel("Panel", item, name)
        item_back.AddClass("KunkkaPanel_shop_item_back")
        
        let item_icon = $.CreatePanel("Panel", item_back, name + "_icon")
        item_icon.AddClass("KunkkaPanel_shop_item_icon")

        item_icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/npc_dota_hero_kunkka/' + mini_icon + '.png")';
        item_icon.style.backgroundSize = "contain";
        item_icon.style.backgroundRepeat = "no-repeat";

        var item_level_back = $.CreatePanel("Panel", item_back, "")
        item_level_back.AddClass("KunkkaPanel_shop_item_level")

        var item_level_fill = $.CreatePanel("Panel", item_level_back, name + "_level")
        item_level_fill.AddClass("KunkkaPanel_shop_item_level_fill") 
        item_level_fill.style.width = "0%"
    }
}



function update_upgrades_player(table, key, data)
{
    if (!is_active || !shop_opened) return
    if (table != "upgrades_player") return

    var hero_ent = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())
    if (!hero_ent || hero_ent == -1) return

    if (key != String(Game.GetLocalPlayerID())) return

    update_shop()
}


function update_shop(data)
{
    if (data)
    {
        let gold = $("#KunkkaPanel_gold_text")
        current_gold = data.gold
        gold.text = current_gold || 0
    }

    let shop = $("#KunkkaPanel_Shop")
    if (shop.BHasClass("panel_hidden"))
        return

    let player_id = Game.GetLocalPlayerID()
    var hero_ent = Players.GetPlayerHeroEntityIndex(player_id)
    var hero = Entities.GetUnitName(hero_ent)
    let talent_table = Object.entries(Game.talents_values["kunkka_shop"])
    var player_table = CustomNetTables.GetTableValue("upgrades_player", String(player_id))

    talent_table = talent_table.map(([key, data]) => {
        data.name = key
        return data
    })

    for (const data of talent_table)
    {
        let rarity = data["rarity"]
        let name = data["name"]
        let max_lvl = data["max_level"]
        let cost = GetCost(data)
        let lvl = (player_table == undefined || !player_table.upgrades[name]) ? 0 : player_table.upgrades[name]

        let parent = $("#" + name)
        let icon = parent.FindChildTraverse(name + "_icon")
        let level = parent.FindChildTraverse(name + "_level")
        let cost_panel = $("#KunkkaPanel_shop_cost_back_" + rarity)
        let cost_text = $("#KunkkaPanel_shop_cost_text_" + rarity)
        let panel = $("#KunkkaPanel_shop_content_" + rarity)

        cost_text.text = cost

        let can_buy = cost <= current_gold && lvl < max_lvl
        let not_active = lvl <= 0 && !can_buy

        cost_panel.SetHasClass("KunkkaPanel_shop_no_gold", cost > current_gold)
        icon.SetHasClass("KunkkaPanel_shop_no_gold", not_active)
        parent.SetHasClass("KunkkaPanel_shop_can_buy", can_buy)
        parent.SetHasClass("KunkkaPanel_shop_has_item", !can_buy && lvl > 0)
        level.SetHasClass("KunkkaPanel_shop_item_level_fill_can_buy", can_buy)
        panel.SetHasClass("KunkkaPanel_shop_content_row_can_buy", cost <= current_gold)

        if (can_buy)
        {
            parent.SetPanelEvent("onactivate", function() 
            {   
                Game.EmitSound("Kunkka.UI_buy");
                Game.EmitSound("Kunkka.UI_buy2");

                if (rarity == "legendary")
                    Game.EmitSound("Kunkka.UI_buy_legendary");

                GameEvents.SendCustomGameEventToServer_custom("kunkka_shop_buy", {name : name})
            })
        }else
            parent.SetPanelEvent("onactivate", function() {})

        level.style.width = (lvl/max_lvl)*88 + "%"
        Game.MouseOverTalent(parent, '#upgrade_disc_' + name, name, lvl, true, rarity, max_lvl, player_id, hero, undefined, undefined, true)
    }
}


Init()