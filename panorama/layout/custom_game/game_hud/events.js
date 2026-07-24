--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameEvents.Subscribe("game_event_update_wave_count", EventUpdateGameWave)
function EventUpdateGameWave(data)
{
    $("#CurrentWaveLabel").text = $.Localize("#levelup_wave") + data.current_wave+"/"+data.max_wave
}

GameEvents.Subscribe("game_event_update_wave_timer", EventUpdateGameTimer)
function EventUpdateGameTimer(data)
{
    $("#CurrentTimeLabel").text = ConvertTimeMinutes(data.time)
}

GameEvents.Subscribe("game_event_update_difficulty", EventUpdateDifficulty)
function EventUpdateDifficulty(data)
{
    $("#CurrentDifficultLabel").text = $.Localize("#levelup_difficulty") + data.current_difficulty
}

GameEvents.Subscribe("game_event_sync_item_slots", EventUpdateItemsList)
function EventUpdateItemsList(data)
{
    UPDATE_PLAYER_ITEMS = true
}

GameEvents.Subscribe("game_event_update_player_abilities", EventUpdatePlayerAbilities)
function EventUpdatePlayerAbilities(data)
{
    UPDATE_PLAYER_ABILITIES = true
}

GameEvents.Subscribe("game_event_update_player_currency", EventUpdatePlayerCurrency)
function EventUpdatePlayerCurrency(data)
{
    $("#CurrencyGold").text = Math.floor(data.gold)
    $("#CurrencyWood").text = Math.floor(data.wood)
    $("#CurrencyWeapon").text = Math.floor(data.kills)
}

GameEvents.Subscribe("game_event_update_player_stats", EventUpdatePlayerStats)
function EventUpdatePlayerStats(data)
{
    $("#BaseStatsLabelDamage").text = Math.floor(data.damage)
    $("#BaseStatsLabelArmor").text = Math.floor(data.base_armor)
    $("#BaseStatsLabelSpeed").text = Math.floor(data.movement_speed)
    $("#BaseStatsLabelStr").text = Math.floor(data.base_strength)
    $("#BaseStatsLabelAgi").text =  Math.floor(data.base_agility)
    $("#BaseStatsLabelInt").text = Math.floor(data.base_intellect)

    ApplyStatFormat($("#AddStatsLabelDamage"), Math.floor(data.bonus_damage)) 
    ApplyStatFormat($("#AddStatsLabelArmor"), Math.floor(data.armor)) 
    ApplyStatFormat($("#AddStatsLabelStr"), Math.floor(data.strength)) 
    ApplyStatFormat($("#AddStatsLabelAgi"), Math.floor(data.agility)) 
    ApplyStatFormat($("#AddStatsLabelInt"), Math.floor(data.intellect)) 
}

GameEvents.Subscribe("game_event_update_upgrade_list", EventUpdateUpgradesList)
function EventUpdateUpgradesList(data)
{
    OpenUpgradePanel(data)
}

GameEvents.Subscribe("game_event_update_card_list", EventUpdateCardList)
function EventUpdateCardList(data)
{
    OpenCardPanel(data)
}

GameEvents.Subscribe("game_event_animate_card_to_stash", EventCardAnimateToStash)
function EventCardAnimateToStash(data)
{
    let m = Game.GetScreenHeight() / 1080   
    let card_place = data.card_place
    let ChooseCardBaseImageAnimateStash = $.CreatePanel("Image", $.GetContextPanel(), "")
    ChooseCardBaseImageAnimateStash.hittest = false
    let delay_move = 0.1
    let delay_opacity = 0.4
    let delay_destroy = 1.2
    let centerX = (Game.GetScreenWidth()  / 2) / m;
    let centerY = (Game.GetScreenHeight() / 2) / m;
    ChooseCardBaseImageAnimateStash.style.x = centerX + "px"
    ChooseCardBaseImageAnimateStash.style.y = centerY + "px"
    if (data.is_faster)
    {
        ChooseCardBaseImageAnimateStash.AddClass("ChooseCardBaseImageAnimateStashFaster")
    }
    else
    {
        ChooseCardBaseImageAnimateStash.AddClass("ChooseCardBaseImageAnimateStash")
    }
    ChooseCardBaseImageAnimateStash.DeleteAsync(delay_destroy)
    ChooseCardBaseImageAnimateStash.SetImage("file://{images}/card_list/" + data.card_image + ".png")
    let target_panel = $("#CardStashPanel_"+card_place)
    target_panel_pos_x = (target_panel.GetPositionWithinWindow().x / m)
    target_panel_pos_y = (target_panel.GetPositionWithinWindow().y / m)
    let offsetX = 0 //-100;
    let offsetY = 0 //-240;
    $.Schedule(delay_move, function()
    {
        ChooseCardBaseImageAnimateStash.style.x = target_panel_pos_x + offsetX + "px";
        ChooseCardBaseImageAnimateStash.style.y = target_panel_pos_y + offsetY + "px";
    })
    $.Schedule(delay_opacity, function()
    {
        ChooseCardBaseImageAnimateStash.style.opacity = "0"
    })
}

GameEvents.Subscribe("game_event_update_card_stash", EventUpdateCardStash)
function EventUpdateCardStash(data)
{
    UpdateCardStashList(data)
}

GameEvents.Subscribe("game_event_update_card_inventory", EventUpdateCardInventory)
function EventUpdateCardInventory(data)
{
    UpdateCardInventoryList(data)
}

GameEvents.Subscribe("game_event_animate_card_stash_fade", EventStashFadeOut)
function EventStashFadeOut(data)
{
    let target_panel = $("#CardStashPanel_"+data.card_place)
    if (target_panel && target_panel.GetChild(0))
    {
        target_panel.GetChild(0).SetHasClass("FadeAnimate", true)
    }
}

GameEvents.Subscribe("game_event_update_player_ability_cost", EventUpdateAbilityCost)

function EventUpdateAbilityCost(data)
{
    if (AbilitiesList)
    {
        for (let ability_name of Object.keys(data))
        {
            let ability_cost_data = data[ability_name]
            let ability_panel = AbilitiesList.FindChildTraverse("AbilityData_"+ability_name)
            if (ability_panel)
            {
                let CostAbilityLabel = ability_panel.FindChildTraverse("CostAbilityLabel")
                if (CostAbilityLabel)
                {
                    CostAbilityLabel.text = ability_cost_data[1]
                }
            }
        }
    }
}