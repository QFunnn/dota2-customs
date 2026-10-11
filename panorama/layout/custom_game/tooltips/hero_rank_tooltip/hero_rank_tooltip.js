--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


var HERO_RANK_TOOLTIP_THRESHOLDS = [1, 6, 12, 18, 25, 30]
var HERO_RANK_TOOLTIP_DAMAGE_PER_RANK = 5
var HERO_RANK_TOOLTIP_ATTR_PER_LEVEL = 1

function GetHeroRankTooltipAttribute(name)
{
    return $.GetContextPanel().GetAttributeString(name, "")
}

function GetHeroRankTooltipRank(level)
{
    var rank = 0
    for (var i = 0; i < HERO_RANK_TOOLTIP_THRESHOLDS.length; i++)
    {
        if (level >= HERO_RANK_TOOLTIP_THRESHOLDS[i]) { rank = i + 1 }
    }
    return rank
}

var HERO_RANK_TOOLTIP_TIERS = {BronzeTier: 1, SilverTier: 2, GoldTier: 3, PlatinumTier: 4, MasterTier: 5, GrandmasterTier: 6}

function GetHeroRankTooltipPhrases(hero_name)
{
    var result = {}
    if (!hero_name || typeof WODA_HEROES_ID === "undefined") { return result }
    var hero_id = WODA_HEROES_ID[hero_name]
    if (!hero_id) { return result }
    var sounds = null
    if (typeof Game.GetCustomTable === "function")
    {
        sounds = Game.GetCustomTable("hero_sounds_all", String(hero_id))
    }
    if (!sounds)
    {
        var tables = GameUI.CustomUIConfig().CUSTOM_TABLES
        sounds = tables && tables["hero_sounds_all"] ? tables["hero_sounds_all"][String(hero_id)] : null
    }
    if (!sounds) { return result }
    var list = []
    for (var id in sounds)
    {
        var data = sounds[id]
        if (!data || !data["label"]) { continue }
        list.push({rank: HERO_RANK_TOOLTIP_TIERS[data["unlock_hero_badge_tier"]] || 1, order: Number(data["message_id"]) || 0, label: data["label"]})
    }
    list.sort(function(a, b) { return a.order - b.order })
    for (var i = 0; i < list.length; i++)
    {
        if (!result[list[i].rank]) { result[list[i].rank] = [] }
        result[list[i].rank].push($.Localize(list[i].label))
    }
    return result
}

function UpdateHeroRankTooltip()
{
    var level = Number(GetHeroRankTooltipAttribute("level")) || 0
    var max_level = Number(GetHeroRankTooltipAttribute("max")) || 30
    var rank = GetHeroRankTooltipRank(level)

    var icon = $("#HeroRankTooltipIcon")
    icon.style.backgroundImage = 'url("file://{images}/custom_game/hero_rank/rank_' + rank + '.png")'
    icon.style.backgroundSize = "100%"
    $("#HeroRankTooltipIconLevel").text = level > 0 ? String(level) : ""
    $("#HeroRankTooltipTitle").text = $.Localize("#level_bonus_rank_" + rank)
    var level_label = $("#HeroRankTooltipLevel")
    level_label.SetDialogVariableInt("level", level)
    level_label.SetDialogVariableInt("max", max_level)
    level_label.text = $.Localize("#hero_rank_tt_level", level_label)

    var attr = $("#HeroRankTooltipAttr")
    attr.SetDialogVariableInt("attr", level * HERO_RANK_TOOLTIP_ATTR_PER_LEVEL)
    attr.text = $.Localize("#hero_rank_tt_attr", attr)
    attr.SetHasClass("Inactive", level <= 0)

    var damage = $("#HeroRankTooltipDamage")
    damage.SetDialogVariableInt("damage", rank * HERO_RANK_TOOLTIP_DAMAGE_PER_RANK)
    damage.text = $.Localize("#hero_rank_tt_damage", damage)
    damage.SetHasClass("Inactive", rank <= 0)

    var coin = $("#HeroRankTooltipCoin")
    coin.visible = rank >= HERO_RANK_TOOLTIP_THRESHOLDS.length

    var bonus_section = $("#HeroRankTooltipBonusSection")
    if (bonus_section)
    {
        bonus_section.visible = level > 0
    }

    var hero_name = GetHeroRankTooltipAttribute("hero")
    var phrases_by_rank = GetHeroRankTooltipPhrases(hero_name)

    var ranks = $("#HeroRankTooltipRanks")
    ranks.RemoveAndDeleteChildren()
    for (var r = 1; r <= HERO_RANK_TOOLTIP_THRESHOLDS.length; r++)
    {
        var row = $.CreatePanel("Panel", ranks, "")
        row.AddClass("HeroRankTooltipRankRow")
        row.SetHasClass("Current", r == rank)
        row.SetHasClass("Reached", r <= rank)

        var head = $.CreatePanel("Panel", row, "")
        head.AddClass("HeroRankTooltipRankHead")
        var row_icon = $.CreatePanel("Panel", head, "")
        row_icon.AddClass("HeroRankTooltipRankIcon")
        row_icon.style.backgroundImage = 'url("file://{images}/custom_game/hero_rank/rank_' + r + '.png")'
        row_icon.style.backgroundSize = "100%"
        var row_name = $.CreatePanel("Label", head, "")
        row_name.AddClass("HeroRankTooltipRankName")
        row_name.text = $.Localize("#level_bonus_rank_" + r)
        var row_level = $.CreatePanel("Label", head, "")
        row_level.AddClass("HeroRankTooltipRankLevel")
        row_level.SetDialogVariableInt("level", HERO_RANK_TOOLTIP_THRESHOLDS[r - 1])
        row_level.text = $.Localize("#hero_rank_tt_rank_from", row_level)

        var unlocks = []
        var damage_line = {key: "#hero_rank_tt_damage_short", vars: {damage: r * HERO_RANK_TOOLTIP_DAMAGE_PER_RANK}}
        unlocks.push(damage_line)
        if (r == HERO_RANK_TOOLTIP_THRESHOLDS.length)
        {
            unlocks.push({key: "#hero_rank_tt_coin_short", vars: {}})
        }
        var phrases = phrases_by_rank[r] || []
        for (var p = 0; p < phrases.length; p++)
        {
            unlocks.push({key: "#hero_rank_tt_phrase", vars: {}, strings: {phrase: phrases[p]}, phrase: true})
        }
        for (var u = 0; u < unlocks.length; u++)
        {
            var line = null
            if (unlocks[u].phrase)
            {
                var phrase_row = $.CreatePanel("Panel", row, "")
                phrase_row.AddClass("HeroRankTooltipPhraseRow")
                var phrase_icon = $.CreatePanel("Panel", phrase_row, "")
                phrase_icon.AddClass("HeroRankTooltipPhraseIcon")
                line = $.CreatePanel("Label", phrase_row, "")
                line.AddClass("HeroRankTooltipRankUnlock")
                line.AddClass("Phrase")
            }
            else
            {
                line = $.CreatePanel("Label", row, "")
                line.AddClass("HeroRankTooltipRankUnlock")
            }
            for (var name in unlocks[u].vars)
            {
                line.SetDialogVariableInt(name, unlocks[u].vars[name])
            }
            if (unlocks[u].strings)
            {
                for (var sname in unlocks[u].strings)
                {
                    line.SetDialogVariable(sname, unlocks[u].strings[sname])
                }
            }
            line.text = $.Localize(unlocks[u].key, line)
        }
    }
}