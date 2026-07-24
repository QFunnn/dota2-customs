--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const FooterStatsMenu = $("#FooterStatsMenu")
const FooterStatPanels = $("#FooterStatPanels")

function FormatDetailPrecisionValue(value)
{
    if (typeof FormatPrecisionValue === "function")
    {
        return FormatPrecisionValue(value)
    }

    const number_value = Number(value)
    if (!isFinite(number_value))
    {
        return value
    }

    let rounded_value = Math.round((number_value + Number.EPSILON) * 10000) / 10000
    if (Math.abs(rounded_value) < 0.0001)
    {
        rounded_value = 0
    }

    if (Number.isInteger(rounded_value))
    {
        return String(rounded_value)
    }

    return rounded_value.toFixed(4).replace(/\.?0+$/, "")
}

const footer_values_data =
{
    StatsFooterOthersList1:
    {
        1:
        [
            ["attack_distance"],
            ["attack_damage_pct", true],
            ["str_pct", true],
            ["agi_pct", true],
            ["int_pct", true],
            ["all_attributes_pct", true],
            ["attack_speed"],
        ],
        2:
        [
            ["attack_range_pct", true],
            [],
            ["str_coefficient", true],
            ["agi_coefficient", true],
            ["int_coefficient", true],
            ["all_attributes_coefficient", true],
            ["movement_speed"],
        ],
    },
    StatsFooterOthersList2:
    {
        1:
        [
            ["armor_pct", true],
            ["health_pct", true],
            ["health_coefficient", true],
            ["health_regen"],
            ["mana_regen"],
            ["outgoing_damage_pct", true],
            ["evasion", true],
        ],
        2:
        [
            ["armor_penetration_pct", true],
            [],
            [],
            ["health_regen_pct", true],
            ["mana_regen_pct", true],
            ["incoming_damage_pct", true],
            ["incoming_damage_pct_plus", true],
        ],
    },
    StatsFooterOthersList3:
    {
        1:
        [
            ["fixed_physical_damage"],
            ["fixed_magical_damage"],
            ["physical_damage_pct", true],
            ["physical_damage_coefficient", true],
            ["final_physical_crit_damage_pct", true],
            ["damage_amplification", true],
            ["final_damage_pct", true],
            ["damage_increase", true],
        ],
        2:
        [
            ["fixed_physical_damage_pct", true],
            ["fixed_magical_damage_pct", true],
            ["magical_damage_pct", true],
            ["magical_damage_coefficient", true],
            ["final_magical_crit_damage_pct", true],
            ["damage_coefficient_1", true],
            ["damage_coefficient_2", true],
            ["damage_coefficient_3", true],
            ["final_damage_coefficient", true],
        ],
    },
    StatsFooterOthersList4:
    {
        1:
        [
            ["cooldown_reduction", true],
            ["gold_per_sec"],
            ["wood_per_sec"],
            ["kills_per_sec"],
            ["xp_per_sec"],
            ["str_per_sec"],
            ["agi_per_sec"],
            ["int_per_sec"],
            ["all_attributes_per_sec"],
            ["damage_per_sec"],
            ["health_per_sec"],
        ],
        2:
        [
            ["chest_reward_gold_pct", true],
            ["gold_gain_pct", true],
            ["gold_per_sec_pct", true],
            ["wood_per_sec_pct", true],
            ["kills_per_sec_pct", true],
            ["xp_per_sec_pct", true],
            ["str_per_kill"],
            ["agi_per_kill"],
            ["int_per_kill"],
            ["all_attributes_per_kill"],
            ["damage_per_kill"],
            ["health_per_kill"],
        ],
    },
}

function InitDetailWindow()
{
    for (let panel_id in footer_values_data)
    {
        let stat_data = footer_values_data[panel_id]
        let panel_child = FooterStatPanels.FindChildTraverse(panel_id)
        if (panel_child)
        {
            for (let column_id in stat_data)
            {
                let column = panel_child.FindChildTraverse("Column"+column_id)
                if (!column)
                {
                    column = $.CreatePanel("Panel", panel_child, "Column"+column_id)
                    column.AddClass("StatsFooterOthersColumn")
                }
                let stat_list = stat_data[column_id]
                for (let stat_data_full of stat_list)
                {
                    let StatsFooterOthersBlock = $.CreatePanel("Panel", column, "")
                    StatsFooterOthersBlock.AddClass("StatsFooterOthersBlock")
                    if (stat_data_full[0])
                    {
                        let StatsFooterOthersBlockKey = $.CreatePanel("Label", StatsFooterOthersBlock, "")
                        StatsFooterOthersBlockKey.AddClass("StatsFooterOthersBlockKey")
                        StatsFooterOthersBlockKey.text = $.Localize("#levelup_detail_info_"+stat_data_full[0])

                        let StatsFooterOthersBlockValue = $.CreatePanel("Label", StatsFooterOthersBlock, stat_data_full[0])
                        StatsFooterOthersBlockValue.AddClass("StatsFooterOthersBlockValue")
                        StatsFooterOthersBlockValue.text = "0"
                        if (stat_data_full[1] || IsLevelUpPercentStatName(stat_data_full[0]))
                        {
                            StatsFooterOthersBlockValue.is_pct = true
                            StatsFooterOthersBlockValue.text = "0%"
                        }
                    }
                    else
                    {
                        StatsFooterOthersBlock.style.opacity = "0"
                    }
                }
            }
        }
    }
}

function ChangeStatMenu(button_id, panel_id)
{
    for (let child of FooterStatsMenu.Children())
    {
        child.SetHasClass("ActiveBlockMenu", child.id == button_id)
    }
    for (let child of FooterStatPanels.Children())
    {
        child.visible = child.id == panel_id
    }
}

Game.SubscribeCustomTableListener("detail_player_stats", (table, key, data, old) => 
{
    if (key == String(Game.GetLocalPlayerID()))
    {
        $.Schedule(0, function()
        {
            const MainPanelValue_1 = $("#MainPanelValue_1")
            const MainPanelValue_2 = $("#MainPanelValue_2")
            const MainPanelValue_3 = $("#MainPanelValue_3")
            const MainPanelValue_4 = $("#MainPanelValue_4")
            const MainPanelValue_5 = $("#MainPanelValue_5")
            const MainPanelValue_6 = $("#MainPanelValue_6")
            const MainPanelValue_7 = $("#MainPanelValue_7")
            const MainPanelValue_8 = $("#MainPanelValue_8")
            const MainPanelValue_9 = $("#MainPanelValue_9")
            const MainPanelValue_10 = $("#MainPanelValue_10")
            const MainPanelValue_11 = $("#MainPanelValue_11")
            const MainPanelValue_12 = $("#MainPanelValue_12")
            const MainPanelValue_13 = $("#MainPanelValue_13")
            const MainPanelValue_14 = $("#MainPanelValue_14")
            const MainPanelValue_15 = $("#MainPanelValue_15")
            const MainPanelValue_16 = $("#MainPanelValue_16")
            const MainPanelValue_17 = $("#MainPanelValue_17")
            const MainPanelValue_18 = $("#MainPanelValue_18")
            const MainPanelValue_19 = $("#MainPanelValue_19")

            if (MainPanelValue_1) MainPanelValue_1.text = $.Localize("#levelup_detail_info_current_level") + " " + ((data.current_level) || 0)
            if (MainPanelValue_2) MainPanelValue_2.text = Math.floor(data.extra_attack_projectiles) || 0
            if (MainPanelValue_3) MainPanelValue_3.text = Math.floor(data.bounce_count) || 0
            if (MainPanelValue_4) MainPanelValue_4.text = Math.floor(data.consumed_cards) || 0
            if (MainPanelValue_5) MainPanelValue_5.text = Math.floor((data.extra_projectile_damage_pct) || 0) + "%"
            if (MainPanelValue_6) MainPanelValue_6.text = Math.floor((data.bounce_damage_pct) || 0) + "%"
            if (MainPanelValue_7) MainPanelValue_7.text = Math.floor(data.consumed_heroes) || 0
            if (MainPanelValue_8) MainPanelValue_8.text = FormatDetailPrecisionValue(data.gold_per_sec || 0)
            if (MainPanelValue_9) MainPanelValue_9.text = FormatDetailPrecisionValue(data.wood_per_sec || 0)
            if (MainPanelValue_10) MainPanelValue_10.text = FormatDetailPrecisionValue(data.kills_per_sec || 0)
            if (MainPanelValue_11) MainPanelValue_11.text = String(Math.floor(data.base_strength || 0)) + "+" + String(Math.floor(data.strength || 0))
            if (MainPanelValue_12) MainPanelValue_12.text = String(Math.floor(data.base_agility || 0)) + "+" + String(Math.floor(data.agility || 0))
            if (MainPanelValue_13) MainPanelValue_13.text = String(Math.floor(data.base_intellect || 0)) + "+" + String(Math.floor(data.intellect || 0))
            if (MainPanelValue_14) MainPanelValue_14.text = Math.floor((data.attack_speed_pct) || 0) + "%"
            if (MainPanelValue_15) MainPanelValue_15.text = ((data.attack_interval_time) || 0).toFixed(1)
            if (MainPanelValue_16) MainPanelValue_16.text = Math.floor((data.chance_phys_critical) || 0) + "%"
            if (MainPanelValue_17) MainPanelValue_17.text = Math.floor((data.phys_critical_damage) || 0) + "%"
            if (MainPanelValue_18) MainPanelValue_18.text = Math.floor((data.chance_magic_critical) || 0) + "%"
            if (MainPanelValue_19) MainPanelValue_19.text = Math.floor((data.magic_critical_damage) || 0) + "%"

            let ValuesPanels = $.GetContextPanel().FindChildrenWithClassTraverse("StatsFooterOthersBlockValue")
            for (let panel_label of ValuesPanels)
            {
                let stat_name = panel_label.id
                if (stat_name && typeof(data[stat_name]) != "undefined")
                {
                    panel_label.text = ApplyNumberFormat(data[stat_name]) + (panel_label.is_pct ? "%" : "")
                }
            }
        })
    }
});

InitDetailWindow()